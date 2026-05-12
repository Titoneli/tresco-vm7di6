-- =============================================================================
-- ViVan — Scripts Supabase
-- Migração backend API → Supabase direto
-- Executar no SQL Editor do Supabase na ordem indicada
-- =============================================================================


-- =============================================================================
-- PASSO 0 — DIAGNÓSTICO (executar primeiro, não altera nada)
-- Confirma que as colunas das tabelas são camelCase (com aspas nos RPCs)
-- =============================================================================

SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name IN (
  'vivan_passageiros',
  'vivan_contratos',
  'vivan_mensalidades',
  'vivan_responsaveis',
  'vivan_despesas',
  'vivan_presencas',
  'vivan_contratos_historico'
)
ORDER BY table_name, ordinal_position;

-- Se as colunas forem snake_case (ex: id_motorista em vez de idMotorista),
-- remover as aspas duplas de todos os RPCs abaixo e ajustar os nomes.


-- =============================================================================
-- PASSO 1 — SEQUENCE para numContrato
-- Garante numContrato atômico e sem colisão (substitui MAX()+1 do backend antigo)
-- =============================================================================

CREATE SEQUENCE IF NOT EXISTS vivan_num_contrato_seq START WITH 1;

-- Ajusta o valor inicial para não colidir com contratos já existentes:
SELECT setval(
  'vivan_num_contrato_seq',
  COALESCE((SELECT MAX("numContrato"::int) FROM vivan_contratos), 0) + 1
);


-- =============================================================================
-- PASSO 2 — RPCs (SECURITY DEFINER — validam idMotorista internamente)
-- Executar cada bloco separadamente se preferir; ou tudo de uma vez.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 2.1  vivan_next_num_contrato
-- Helper: retorna próximo numContrato da sequence sem expor a sequence ao cliente
-- Usado em: gerar_contrato_m, contrato_detalhe_m (criação de contrato)
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_next_num_contrato()
RETURNS int
LANGUAGE sql
SECURITY DEFINER
AS $$
  SELECT nextval('vivan_num_contrato_seq')::int;
$$;


-- -----------------------------------------------------------------------------
-- 2.2  vivan_criar_passageiro_completo
-- Criação atômica: passageiro + responsável + contrato + mensalidades
-- Substitui: POST /passageiros + /responsaveis + /contratos + /ativar
-- Usado em: passageiro_form_m (wizard de criação)
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_criar_passageiro_completo(
  p_motorista_id   int,
  p_nome           text,
  p_escola_id      int,
  p_turno          text,
  p_resp_nome      text,
  p_resp_cpf       text,
  p_resp_wpp       text,
  p_valor          numeric,
  p_dia_venc       int,
  p_dt_inicio      date,
  p_dt_termino     date
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_passageiro_id  int;
  v_responsavel_id int;
  v_contrato_id    int;
  v_mes            date;
BEGIN
  -- 1. Passageiro
  INSERT INTO vivan_passageiros ("nomePassageiro", "idMotorista", "idEscola", "domTurno")
  VALUES (p_nome, p_motorista_id, p_escola_id, p_turno)
  RETURNING "idPassageiro" INTO v_passageiro_id;

  -- 2. Responsável (opcional)
  IF p_resp_nome IS NOT NULL AND p_resp_nome <> '' THEN
    INSERT INTO vivan_responsaveis (
      "idPassageiro", "nomeResponsavel", "cpfResponsavel", "whatsAppResponsavel"
    )
    VALUES (v_passageiro_id, p_resp_nome, p_resp_cpf, p_resp_wpp)
    RETURNING "idResponsavel" INTO v_responsavel_id;
  END IF;

  -- 3. Contrato + mensalidades (só se houver valor mensal)
  IF p_valor IS NOT NULL AND p_valor > 0 THEN
    INSERT INTO vivan_contratos (
      "numContrato", "idMotorista", "idPassageiro", "idResponsavel",
      "valMensal", "diaVencimento", "dtInicio", "dtTermino",
      status, "domFormaPagamento", "domCondicaoPagamento",
      "percentualMulta", "percentualJurosDia"
    )
    VALUES (
      nextval('vivan_num_contrato_seq'),
      p_motorista_id, v_passageiro_id, v_responsavel_id,
      p_valor, p_dia_venc, p_dt_inicio, p_dt_termino,
      'ATIVO', 'OUTROS', 'Mensal', 2.0, 0.0333
    )
    RETURNING "idContrato" INTO v_contrato_id;

    v_mes := date_trunc('month', p_dt_inicio);
    WHILE v_mes <= date_trunc('month', p_dt_termino) LOOP
      INSERT INTO vivan_mensalidades (
        "idContrato", "idPassageiro", "idMotorista",
        "mesReferencia", "dtVencimento", "valOriginal", status
      )
      VALUES (
        v_contrato_id, v_passageiro_id, p_motorista_id,
        to_char(v_mes, 'MM/YYYY'),
        (date_trunc('month', v_mes) + (p_dia_venc - 1) * interval '1 day')::date,
        p_valor, 'PENDENTE'
      );
      v_mes := v_mes + interval '1 month';
    END LOOP;
  END IF;

  RETURN json_build_object(
    'idPassageiro',  v_passageiro_id,
    'idResponsavel', v_responsavel_id,
    'idContrato',    v_contrato_id
  );
END;
$$;


-- -----------------------------------------------------------------------------
-- 2.3  vivan_ativar_contrato
-- Ativa contrato (RASCUNHO ou SUSPENSO → ATIVO) e gera mensalidades faltantes
-- Substitui: POST /contratos/:id/ativar  e  POST /contratos/:id/reativar
-- Usado em: gerar_contrato_m, contrato_detalhe_m
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_ativar_contrato(
  p_contrato_id  int,
  p_motorista_id int
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_contrato   record;
  v_dia_venc   int;
  v_dt_termino date;
  v_mes        date;
BEGIN
  SELECT * INTO v_contrato
  FROM vivan_contratos
  WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Contrato não encontrado ou sem permissão';
  END IF;

  UPDATE vivan_contratos
  SET status = 'ATIVO'
  WHERE "idContrato" = p_contrato_id;

  v_dia_venc   := COALESCE(v_contrato."diaVencimento", 5);
  v_dt_termino := COALESCE(
    v_contrato."dtTermino",
    make_date(EXTRACT(YEAR FROM CURRENT_DATE)::int, 12, 31)
  );

  -- Gera apenas os meses ainda sem mensalidade
  v_mes := date_trunc('month', v_contrato."dtInicio");
  WHILE v_mes <= date_trunc('month', v_dt_termino) LOOP
    INSERT INTO vivan_mensalidades (
      "idContrato", "idPassageiro", "idMotorista",
      "mesReferencia", "dtVencimento", "valOriginal", status
    )
    SELECT
      p_contrato_id,
      v_contrato."idPassageiro",
      p_motorista_id,
      to_char(v_mes, 'MM/YYYY'),
      (date_trunc('month', v_mes) + (v_dia_venc - 1) * interval '1 day')::date,
      v_contrato."valMensal",
      'PENDENTE'
    WHERE NOT EXISTS (
      SELECT 1 FROM vivan_mensalidades
      WHERE "idContrato" = p_contrato_id
        AND "mesReferencia" = to_char(v_mes, 'MM/YYYY')
    );
    v_mes := v_mes + interval '1 month';
  END LOOP;

  RETURN json_build_object('idContrato', p_contrato_id, 'status', 'ATIVO');
END;
$$;


-- -----------------------------------------------------------------------------
-- 2.4  vivan_renovar_mensalidades
-- Cria mensalidades faltantes do mês atual até dezembro do ano corrente
-- Substitui: GET /contratos + loop POST /mensalidades
-- Usado em: renovar_mensalidades_m
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_renovar_mensalidades(
  p_contrato_id   int,
  p_passageiro_id int,
  p_motorista_id  int
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_contrato record;
  v_mes      date;
  v_criadas  int := 0;
BEGIN
  SELECT * INTO v_contrato
  FROM vivan_contratos
  WHERE "idContrato" = p_contrato_id
    AND "idMotorista" = p_motorista_id
    AND status = 'ATIVO';

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Contrato ativo não encontrado';
  END IF;

  v_mes := date_trunc('month', CURRENT_DATE);
  WHILE EXTRACT(YEAR FROM v_mes) = EXTRACT(YEAR FROM CURRENT_DATE) LOOP
    INSERT INTO vivan_mensalidades (
      "idContrato", "idPassageiro", "idMotorista",
      "mesReferencia", "dtVencimento", "valOriginal", status
    )
    SELECT
      p_contrato_id, p_passageiro_id, p_motorista_id,
      to_char(v_mes, 'MM/YYYY'),
      (date_trunc('month', v_mes) + (v_contrato."diaVencimento" - 1) * interval '1 day')::date,
      v_contrato."valMensal",
      'PENDENTE'
    WHERE NOT EXISTS (
      SELECT 1 FROM vivan_mensalidades
      WHERE "idContrato" = p_contrato_id
        AND "mesReferencia" = to_char(v_mes, 'MM/YYYY')
    );
    IF FOUND THEN v_criadas := v_criadas + 1; END IF;
    v_mes := v_mes + interval '1 month';
  END LOOP;

  RETURN json_build_object('criadas', v_criadas);
END;
$$;


-- -----------------------------------------------------------------------------
-- 2.5  vivan_suspender_contrato
-- ATIVO → SUSPENSO com motivo
-- Substitui: POST /contratos/:id/suspender
-- Usado em: contrato_detalhe_m
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_suspender_contrato(
  p_contrato_id  int,
  p_motorista_id int,
  p_motivo       text
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE vivan_contratos
  SET status = 'SUSPENSO', "motivoSuspensao" = p_motivo
  WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Contrato não encontrado ou sem permissão';
  END IF;

  RETURN json_build_object('idContrato', p_contrato_id, 'status', 'SUSPENSO');
END;
$$;


-- -----------------------------------------------------------------------------
-- 2.6  vivan_cancelar_contrato
-- ATIVO/SUSPENSO → CANCELADO com motivo
-- Substitui: POST /contratos/:id/cancelar
-- Usado em: contrato_detalhe_m
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_cancelar_contrato(
  p_contrato_id  int,
  p_motorista_id int,
  p_motivo       text
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE vivan_contratos
  SET status = 'CANCELADO', "motivoCancelamento" = p_motivo
  WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Contrato não encontrado ou sem permissão';
  END IF;

  RETURN json_build_object('idContrato', p_contrato_id, 'status', 'CANCELADO');
END;
$$;


-- -----------------------------------------------------------------------------
-- 2.7  vivan_deletar_contrato
-- Apaga contrato e suas mensalidades em cascata (sem FK cascade configurado)
-- Substitui: DELETE /contratos/:id
-- Usado em: contrato_detalhe_m
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_deletar_contrato(
  p_contrato_id  int,
  p_motorista_id int
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM vivan_contratos
    WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id
  ) THEN
    RAISE EXCEPTION 'Contrato não encontrado ou sem permissão';
  END IF;

  DELETE FROM vivan_mensalidades WHERE "idContrato" = p_contrato_id;
  DELETE FROM vivan_contratos    WHERE "idContrato" = p_contrato_id;
END;
$$;


-- -----------------------------------------------------------------------------
-- 2.8  vivan_deletar_passageiro
-- Apaga passageiro e todos os registros dependentes em cascata
-- Substitui: DELETE /passageiros/:id
-- Usado em: passageiro_form_m (modo edição)
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_deletar_passageiro(
  p_passageiro_id int,
  p_motorista_id  int
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM vivan_passageiros
    WHERE "idPassageiro" = p_passageiro_id AND "idMotorista" = p_motorista_id
  ) THEN
    RAISE EXCEPTION 'Passageiro não encontrado ou sem permissão';
  END IF;

  DELETE FROM vivan_mensalidades WHERE "idPassageiro" = p_passageiro_id;
  DELETE FROM vivan_contratos    WHERE "idPassageiro" = p_passageiro_id;
  DELETE FROM vivan_responsaveis WHERE "idPassageiro" = p_passageiro_id;
  DELETE FROM vivan_passageiros  WHERE "idPassageiro" = p_passageiro_id;
END;
$$;


-- -----------------------------------------------------------------------------
-- 2.9  vivan_dashboard_motorista_resumo
-- Agrega dados de um motorista para um mês de referência
-- Substitui: GET /dashboard/resumo?motorista=X&mes=MM/YYYY
-- Usado em: dashboard_motorista_via_van_m
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION vivan_dashboard_motorista_resumo(
  p_motorista_id   int,
  p_mes_referencia text
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_total_pass    int;
  v_pass_ativos   int;
  v_total_contr   int;
  v_contr_ativos  int;
  v_pendentes     int;
  v_atrasadas     int;
  v_a_receber     numeric;
  v_recebido      numeric;
  v_abonado       numeric;
  v_inadimp       numeric;
  v_despesas      numeric;
BEGIN
  SELECT COUNT(*)
  INTO v_total_pass
  FROM vivan_passageiros
  WHERE "idMotorista" = p_motorista_id;

  SELECT COUNT(DISTINCT "idPassageiro")
  INTO v_pass_ativos
  FROM vivan_contratos
  WHERE "idMotorista" = p_motorista_id AND status = 'ATIVO';

  SELECT COUNT(*), COUNT(*) FILTER (WHERE status = 'ATIVO')
  INTO v_total_contr, v_contr_ativos
  FROM vivan_contratos
  WHERE "idMotorista" = p_motorista_id;

  SELECT
    COUNT(*)           FILTER (WHERE status = 'PENDENTE'),
    COUNT(*)           FILTER (WHERE status = 'ATRASADO'),
    COALESCE(SUM("valOriginal") FILTER (WHERE status IN ('PENDENTE', 'ATRASADO')), 0),
    COALESCE(SUM("valPago")     FILTER (WHERE status IN ('PAGO', 'PAGO_ATRASO')), 0),
    COALESCE(SUM("valOriginal") FILTER (WHERE status = 'ABONADO'), 0),
    COALESCE(SUM("valOriginal") FILTER (WHERE status = 'ATRASADO'), 0)
  INTO v_pendentes, v_atrasadas, v_a_receber, v_recebido, v_abonado, v_inadimp
  FROM vivan_mensalidades
  WHERE "idMotorista" = p_motorista_id
    AND "mesReferencia" = p_mes_referencia;

  SELECT COALESCE(SUM(valor), 0)
  INTO v_despesas
  FROM vivan_despesas
  WHERE "idMotorista" = p_motorista_id
    AND "mesReferencia" = p_mes_referencia;

  RETURN json_build_object(
    'mesReferencia',         p_mes_referencia,
    'totalPassageiros',      v_total_pass,
    'passageirosAtivos',     v_pass_ativos,
    'totalContratos',        v_total_contr,
    'contratosAtivos',       v_contr_ativos,
    'mensalidadesPendentes', v_pendentes,
    'mensalidadesAtrasadas', v_atrasadas,
    'totalAReceber',         v_a_receber,
    'totalRecebido',         v_recebido,
    'totalAbonado',          v_abonado,
    'totalInadimplente',     v_inadimp,
    'totalDespesas',         v_despesas
  );
END;
$$;


-- =============================================================================
-- PASSO 3 — (OPCIONAL) Atualização automática de status ATRASADO via pg_cron
-- Verificar disponibilidade primeiro:
--   SELECT * FROM pg_available_extensions WHERE name = 'pg_cron';
-- Se não disponível no plano atual, o Flutter calcula o status client-side.
-- =============================================================================

-- Habilitar extensão (requer permissão de superusuário — disponível no Supabase):
-- CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Agendar job diário à meia-noite:
-- SELECT cron.schedule(
--   'vivan-atualizar-atrasadas',
--   '0 0 * * *',
--   $$
--     UPDATE vivan_mensalidades
--     SET status = 'ATRASADO'
--     WHERE status = 'PENDENTE'
--       AND "dtVencimento" < CURRENT_DATE;
--   $$
-- );


-- =============================================================================
-- PASSO 4 — (OPCIONAL) Tabela vivan_presencas
-- Executar apenas se a tabela ainda não existir no Supabase.
-- Verificar primeiro: SELECT to_regclass('public.vivan_presencas');
-- Retorno NULL = tabela não existe e deve ser criada.
-- =============================================================================

-- CREATE TABLE IF NOT EXISTS vivan_presencas (
--   "idPresenca"   bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--   "idMotorista"  int    NOT NULL,
--   "idPassageiro" int    NOT NULL,
--   "idContrato"   int,
--   "dtPresenca"   date   NOT NULL,
--   "tipoPresenca" text   NOT NULL DEFAULT 'P',  -- 'P' = presente, 'F' = falta
--   "domTurno"     text,
--   "justificativa" text,
--   "latRegistro"  numeric(10, 7),
--   "lngRegistro"  numeric(10, 7),
--   "createdAt"    timestamptz NOT NULL DEFAULT now(),
--   UNIQUE ("idMotorista", "idPassageiro", "dtPresenca")
-- );


-- =============================================================================
-- PASSO 5 — VERIFICAÇÃO FINAL
-- Confirmar que todas as funções foram criadas com sucesso:
-- =============================================================================

SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN (
    'vivan_next_num_contrato',
    'vivan_criar_passageiro_completo',
    'vivan_ativar_contrato',
    'vivan_renovar_mensalidades',
    'vivan_suspender_contrato',
    'vivan_cancelar_contrato',
    'vivan_deletar_contrato',
    'vivan_deletar_passageiro',
    'vivan_dashboard_motorista_resumo'
  )
ORDER BY routine_name;

-- Esperado: 9 linhas, uma para cada função acima.
