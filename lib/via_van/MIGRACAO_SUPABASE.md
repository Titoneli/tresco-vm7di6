# Plano: Migração Backend ViVan → Supabase Direto (Incremental)

## Context
A API ViVan usa conta de serviço compartilhada (idMotorista=398) — todos os registros criados
ficam com o motorista errado e exigem patches Supabase após cada escrita. A solução definitiva
é eliminar a camada da API e usar o Supabase diretamente, com RPCs PostgreSQL para lógica
complexa. Asaas será abandonado (pagamentos continuam manuais). Migração incremental: tela por tela.

---

## Decisões de arquitetura

### RLS (Row Level Security)
Auth é via FlutterFlow/ViVan — não há Supabase Auth UUID disponível, então `auth.uid()` não
funciona em RLS policies. **Estratégia:** segurança em camadas de aplicação:
1. Todas as RPCs usam `SECURITY DEFINER` e recebem `p_motorista_id` explícito — validam
   ownership internamente antes de qualquer escrita.
2. Todas as queries SELECT diretas incluem `.eq('idMotorista', FFAppState().idUsuario)` —
   nunca omitir esse filtro.
3. RLS não será habilitado por ora (exigiria reestruturar auth). Risco aceitável: a anon key
   já está embutida no binário do app; o isolamento real é feito pelo filtro idMotorista.

### Status PENDENTE → ATRASADO
Criar cron job via **pg_cron** no Supabase (SQL Editor → Extensions → habilitar `pg_cron`):
```sql
-- Rodar diariamente à meia-noite
SELECT cron.schedule(
  'atualizar-mensalidades-atrasadas',
  '0 0 * * *',
  $$
  UPDATE vivan_mensalidades
  SET status = 'ATRASADO'
  WHERE status = 'PENDENTE'
    AND "dtVencimento" < CURRENT_DATE;
  $$
);
```
Enquanto o cron não roda (durante a migração), o Flutter pode exibir status calculado:
`isAtrasado = status == 'ATRASADO' || (status == 'PENDENTE' && dtVencimento < hoje)`

### numContrato — PostgreSQL SEQUENCE
```sql
CREATE SEQUENCE IF NOT EXISTS vivan_num_contrato_seq START 1;
```
Usado dentro da RPC `vivan_ativar_contrato` e no INSERT direto de contratos:
```sql
numContrato = nextval('vivan_num_contrato_seq')
```
Atômico, sem race condition. Criar a sequence antes de criar os RPCs.

---

## Tabelas Supabase confirmadas
- `vivan_passageiros` — id, nome, idMotorista, domTurno, idEscola, dtNascimento, cpf, endereço...
- `vivan_escolas` — idEscola, nomeEscola, idMotorista
- `vivan_contratos` — idContrato, idMotorista, idPassageiro, idResponsavel, valMensal, diaVencimento, dtInicio, dtTermino, status, percentuais...
- `vivan_mensalidades` — idMensalidade, idContrato, idPassageiro, idMotorista, mesReferencia, dtVencimento, valOriginal, valPago, status, formaPagamento...
- `vivan_responsaveis` — a confirmar schema (provavelmente: idResponsavel, idPassageiro, nomeResponsavel, cpfResponsavel, whatsAppResponsavel...)
- `vivan_despesas` — a confirmar schema (provavelmente: idDespesa, idMotorista, tipoLancamento, categoria, descricao, valor, mesReferencia, dtVencimento...)

---

## Arquivos a remover ao final (após migração completa)
- `lib/via_van/_vivan_http.dart` — wrapper HTTP da API (substituído por Supabase)
- `lib/vivan/vivan_api_client.dart` — cliente HTTP com cookie auth
- `lib/vivan/services/vivan_service.dart` — camada de serviço tipada
- `lib/vivan/vivan.dart` — barrel (ajustar para exportar só models)

## Arquivos a manter
- `lib/vivan/models/vivan_models.dart` — modelos de dados (reutilizados no frontend)

---

## Fase 1 — Reads simples: passageiro_detalhe_m + contratos_lista_m + mensalidades_tab

### 1a. `lib/via_van/passageiro_detalhe_m/passageiro_detalhe_m_model.dart`
Substituir:
- `GET /passageiros/{id}` → `SELECT * FROM vivan_passageiros WHERE idPassageiro=id AND idMotorista=user`
  com JOIN `vivan_escolas` para `nomeEscola`
- `GET /passageiros/{id}/responsaveis` → `SELECT * FROM vivan_responsaveis WHERE idPassageiro=id`
- `GET /contratos` (com filtro client-side) → `SELECT * FROM vivan_contratos WHERE idPassageiro=id AND idMotorista=user`

### 1b. `lib/via_van/contratos_lista_m/contratos_lista_m_model.dart`
Substituir:
- `GET /contratos?motorista=X&passageiro=Y` + filtro client-side
  → `SELECT * FROM vivan_contratos WHERE idMotorista=user AND idPassageiro=passageiro`

### 1c. `lib/via_van/mensalidades_tab/mensalidades_tab_model.dart`
Substituir:
- `GET /mensalidades?motorista=X&mesReferencia=MM/YYYY&limit=200`
  → `SELECT * FROM vivan_mensalidades WHERE idMotorista=user AND mesReferencia=filtro`
  (filtros de busca e status continuam client-side no Flutter — ok para volume pequeno)

---

## Fase 2 — Writes simples: financeiro_tab + form edit + pagamento manual

### 2a. `lib/via_van/financeiro_tab/financeiro_tab_model.dart`
Substituir:
- `GET /despesas` → `SELECT * FROM vivan_despesas WHERE idMotorista=user AND mesReferencia=filtro`
- `GET /mensalidades` → igual à Fase 1c
- `POST /despesas` → `INSERT INTO vivan_despesas (...) VALUES (...)`
  (lançamentos recorrentes: loop de INSERT no Dart, sem RPC — volume pequeno)
- `PUT /despesas/{id}` → `UPDATE vivan_despesas SET ... WHERE idDespesa=id AND idMotorista=user`
- `DELETE /despesas/{id}` → `DELETE FROM vivan_despesas WHERE idDespesa=id AND idMotorista=user`

### 2b. `lib/via_van/passageiro_form_m/passageiro_form_m_model.dart` — modo edição
Substituir:
- **`carregar(id)`** (leitura inicial no edit mode):
  - `GET /passageiros/{id}` → `SELECT p.*, e."nomeEscola" FROM vivan_passageiros p LEFT JOIN vivan_escolas e ON e."idEscola"=p."idEscola" WHERE p."idPassageiro"=id AND p."idMotorista"=user`
  - `GET /passageiros/{id}/responsaveis` → `SELECT * FROM vivan_responsaveis WHERE "idPassageiro"=id LIMIT 1`
- `PUT /passageiros/{id}` → `UPDATE vivan_passageiros SET ... WHERE idPassageiro=id`
- `PUT /passageiros/{id}/responsaveis/{respId}` → `UPDATE vivan_responsaveis SET ... WHERE idResponsavel=id`
- `DELETE /passageiros/{id}` → RPC `vivan_deletar_passageiro` (não pode ser DELETE simples —
  o backend hoje faz CASCADE; no Supabase precisamos deletar na ordem: mensalidades → contratos → responsaveis → passageiro)

```sql
CREATE OR REPLACE FUNCTION vivan_deletar_passageiro(
  p_passageiro_id int, p_motorista_id int
) RETURNS void LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM vivan_passageiros
                 WHERE "idPassageiro" = p_passageiro_id AND "idMotorista" = p_motorista_id)
  THEN RAISE EXCEPTION 'Passageiro não encontrado ou sem permissão'; END IF;
  DELETE FROM vivan_mensalidades WHERE "idPassageiro" = p_passageiro_id;
  DELETE FROM vivan_contratos    WHERE "idPassageiro" = p_passageiro_id;
  DELETE FROM vivan_responsaveis WHERE "idPassageiro" = p_passageiro_id;
  DELETE FROM vivan_passageiros  WHERE "idPassageiro" = p_passageiro_id;
END; $$;
```

### 2c. `lib/via_van/mensalidades_tab/mensalidades_tab_widget.dart` — pagamento manual
Substituir `POST /mensalidades/{id}/pagamento-manual` → UPDATE direto:
```sql
UPDATE vivan_mensalidades
SET "valPago" = X, "formaPagamento" = Y, "dtPagamento" = Z,
    status = CASE WHEN Z::date <= "dtVencimento" THEN 'PAGO' ELSE 'PAGO_ATRASO' END
WHERE "idMensalidade" = id AND "idMotorista" = user
```

---

## Fase 3 — RPCs para lógica complexa

### RPCs a criar no Supabase (SQL Editor):

#### `vivan_criar_passageiro_completo`
```sql
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
) RETURNS json LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_passageiro_id  int;
  v_responsavel_id int;
  v_contrato_id    int;
  v_mes            date;
BEGIN
  -- 1. Insere passageiro
  INSERT INTO vivan_passageiros ("nomePassageiro", "idMotorista", "idEscola", "domTurno")
  VALUES (p_nome, p_motorista_id, p_escola_id, p_turno)
  RETURNING "idPassageiro" INTO v_passageiro_id;

  -- 2. Insere responsável
  IF p_resp_nome IS NOT NULL AND p_resp_nome != '' THEN
    INSERT INTO vivan_responsaveis ("idPassageiro", "nomeResponsavel", "cpfResponsavel", "whatsAppResponsavel")
    VALUES (v_passageiro_id, p_resp_nome, p_resp_cpf, p_resp_wpp)
    RETURNING "idResponsavel" INTO v_responsavel_id;
  END IF;

  -- 3. Insere contrato (status ATIVO direto — sem precisar chamar /ativar)
  IF p_valor IS NOT NULL AND p_valor > 0 THEN
    INSERT INTO vivan_contratos (
      "numContrato", "idMotorista", "idPassageiro", "idResponsavel", "valMensal", "diaVencimento",
      "dtInicio", "dtTermino", status, "domFormaPagamento", "domCondicaoPagamento",
      "percentualMulta", "percentualJurosDia"
    ) VALUES (
      nextval('vivan_num_contrato_seq'),
      p_motorista_id, v_passageiro_id, v_responsavel_id, p_valor, p_dia_venc,
      p_dt_inicio, p_dt_termino, 'ATIVO', 'OUTROS', 'Mensal', 2.0, 0.0333
    ) RETURNING "idContrato" INTO v_contrato_id;

    -- 4. Gera mensalidades mês a mês
    v_mes := date_trunc('month', p_dt_inicio);
    WHILE v_mes <= date_trunc('month', p_dt_termino) LOOP
      INSERT INTO vivan_mensalidades (
        "idContrato", "idPassageiro", "idMotorista", "mesReferencia", "dtVencimento", "valOriginal", status
      ) VALUES (
        v_contrato_id, v_passageiro_id, p_motorista_id,
        to_char(v_mes, 'MM/YYYY'),
        (date_trunc('month', v_mes) + (p_dia_venc - 1) * interval '1 day')::date,
        p_valor, 'PENDENTE'
      );
      v_mes := v_mes + interval '1 month';
    END LOOP;
  END IF;

  RETURN json_build_object(
    'idPassageiro', v_passageiro_id,
    'idResponsavel', v_responsavel_id,
    'idContrato', v_contrato_id
  );
END;
$$;
```

#### `vivan_ativar_contrato`
```sql
CREATE OR REPLACE FUNCTION vivan_ativar_contrato(
  p_contrato_id   int,
  p_motorista_id  int
) RETURNS json LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_contrato      record;  -- record em vez de %ROWTYPE para evitar problemas de casing de colunas
  v_dia_venc      int;
  v_dt_termino    date;
  v_mes           date;
BEGIN
  SELECT * INTO v_contrato FROM vivan_contratos
  WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Contrato não encontrado ou sem permissão';
  END IF;

  UPDATE vivan_contratos SET status = 'ATIVO' WHERE "idContrato" = p_contrato_id;

  -- NULL-safe: defaults para evitar quebra se campos não preenchidos
  v_dia_venc   := COALESCE(v_contrato."diaVencimento", 5);
  v_dt_termino := COALESCE(v_contrato."dtTermino",
                    make_date(EXTRACT(YEAR FROM CURRENT_DATE)::int, 12, 31));

  -- Gera mensalidades apenas para meses ainda não existentes
  v_mes := date_trunc('month', v_contrato."dtInicio");
  WHILE v_mes <= date_trunc('month', v_dt_termino) LOOP
    INSERT INTO vivan_mensalidades (
      "idContrato", "idPassageiro", "idMotorista", "mesReferencia", "dtVencimento", "valOriginal", status
    )
    SELECT p_contrato_id, v_contrato."idPassageiro", p_motorista_id,
           to_char(v_mes, 'MM/YYYY'),
           (date_trunc('month', v_mes) + (v_dia_venc - 1) * interval '1 day')::date,
           v_contrato."valMensal", 'PENDENTE'
    WHERE NOT EXISTS (
      SELECT 1 FROM vivan_mensalidades
      WHERE "idContrato" = p_contrato_id AND "mesReferencia" = to_char(v_mes, 'MM/YYYY')
    );
    v_mes := v_mes + interval '1 month';
  END LOOP;

  RETURN json_build_object('idContrato', p_contrato_id, 'status', 'ATIVO');
END;
$$;
```

#### `vivan_renovar_mensalidades`
```sql
CREATE OR REPLACE FUNCTION vivan_renovar_mensalidades(
  p_contrato_id   int,
  p_passageiro_id int,
  p_motorista_id  int
) RETURNS json LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_contrato   record;
  v_mes        date;
  v_criadas    int := 0;
BEGIN
  SELECT * INTO v_contrato FROM vivan_contratos
  WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id AND status = 'ATIVO';

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Contrato ativo não encontrado';
  END IF;

  v_mes := date_trunc('month', CURRENT_DATE);
  -- Loop até dezembro do ano atual
  WHILE EXTRACT(YEAR FROM v_mes) = EXTRACT(YEAR FROM CURRENT_DATE) LOOP
    INSERT INTO vivan_mensalidades (
      "idContrato", "idPassageiro", "idMotorista", "mesReferencia", "dtVencimento", "valOriginal", status
    )
    SELECT p_contrato_id, p_passageiro_id, p_motorista_id,
           to_char(v_mes, 'MM/YYYY'),
           (date_trunc('month', v_mes) + (v_contrato."diaVencimento" - 1) * interval '1 day')::date,
           v_contrato."valMensal", 'PENDENTE'
    WHERE NOT EXISTS (
      SELECT 1 FROM vivan_mensalidades
      WHERE "idContrato" = p_contrato_id AND "mesReferencia" = to_char(v_mes, 'MM/YYYY')
    );
    IF FOUND THEN v_criadas := v_criadas + 1; END IF;
    v_mes := v_mes + interval '1 month';
  END LOOP;

  RETURN json_build_object('criadas', v_criadas);
END;
$$;
```

#### `vivan_next_num_contrato`
```sql
CREATE OR REPLACE FUNCTION vivan_next_num_contrato() RETURNS int
LANGUAGE sql SECURITY DEFINER AS $$
  SELECT nextval('vivan_num_contrato_seq')::int
$$;
```

### 3a. `lib/via_van/passageiro_form_m/passageiro_form_m_model.dart` — modo criação
Substituir o fluxo POST /passageiros + /responsaveis + /contratos + /ativar
por uma única chamada RPC:
```dart
final result = await SupaFlow.client
    .rpc('vivan_criar_passageiro_completo', params: { ... })
    .single();
```

**Caso escola nova (escolaId == null, escolaNome preenchido):**
Antes de chamar a RPC, criar a escola via INSERT direto e obter o idEscola:
```dart
if (escolaId == null && escolaNome?.isNotEmpty == true) {
  final row = await SupaFlow.client
      .from('vivan_escolas')
      .insert({'nomeEscola': escolaNome, 'idMotorista': idMotorista})
      .select('idEscola')
      .single();
  escolaId = row['idEscola'] as int;
}
// Então chama a RPC com escolaId resolvido
```

### 3b. `lib/via_van/gerar_contrato_m/gerar_contrato_m_widget.dart`
Substituir POST /contratos + /ativar + patches Supabase por chamadas diretas:
```dart
// Obter próximo numContrato via RPC helper
final numContrato = await SupaFlow.client
    .rpc('vivan_next_num_contrato')
    .single();

// INSERT do contrato como RASCUNHO
final row = await SupaFlow.client
    .from('vivan_contratos')
    .insert({
      'numContrato': numContrato,
      'idMotorista': idMotorista,
      'idPassageiro': passageiroId,
      // ... demais campos
      'status': 'RASCUNHO',
    })
    .select('idContrato')
    .single();
final contratoId = row['idContrato'] as int;

// Ativar via RPC (gera mensalidades automaticamente)
await SupaFlow.client.rpc('vivan_ativar_contrato',
    params: {'p_contrato_id': contratoId, 'p_motorista_id': idMotorista});
```

### 3c. `lib/via_van/renovar_mensalidades_m/renovar_mensalidades_m_widget.dart`
Substituir GET /contratos + GET /mensalidades + loop POST /mensalidades + UPDATE Supabase
por dois passos (o widget não tem idContrato disponível — só passageiroId):
```dart
// Passo 1: buscar contrato ativo (SELECT direto)
final rows = await SupaFlow.client
    .from('vivan_contratos')
    .select('idContrato')
    .eq('idPassageiro', passageiroId)
    .eq('idMotorista', idMotorista)
    .eq('status', 'ATIVO')
    .limit(1);
if (rows.isEmpty) { /* exibe dialog sem contrato */ return; }
final contratoId = rows.first['idContrato'] as int;

// Passo 2: chamar RPC que faz toda a lógica de renovação
final result = await SupaFlow.client.rpc('vivan_renovar_mensalidades', params: {
  'p_contrato_id': contratoId,
  'p_passageiro_id': passageiroId,
  'p_motorista_id': idMotorista,
});
final criadas = (result as Map)['criadas'] as int;
```

---

## Fase 4 — Telas não cobertas nas fases anteriores

### 4a. `lib/via_van/contrato_detalhe_m/contrato_detalhe_m_model.dart`
Substituir:
- `createContrato(data)` → `INSERT INTO vivan_contratos (...) RETURNING idContrato`
  (usar `vivan_next_num_contrato()` para numContrato)
- `getContrato(id)` → `SELECT * FROM vivan_contratos WHERE "idContrato"=id AND "idMotorista"=user`
  com JOIN `vivan_passageiros` para nome do passageiro
- `getContratoHistorico(id)` → `SELECT * FROM vivan_contratos_historico WHERE "idContrato"=id`
  (verificar se tabela existe; se não, remover seção da UI)
- `ativarContrato(id)` → RPC `vivan_ativar_contrato` (cobre RASCUNHO→ATIVO)
- `reativarContrato(id)` → mesma RPC `vivan_ativar_contrato` (cobre SUSPENSO→ATIVO)
- `suspenderContrato(id, motivo)` → RPC `vivan_suspender_contrato`
- `cancelarContrato(id, motivo)` → RPC `vivan_cancelar_contrato`
- `deleteContrato(id)` → RPC `vivan_deletar_contrato`
- `enviarParaAssinatura(id)` → **remover botão da UI** (sem Asaas; PENDENTE_ASSINATURA não tem utilidade)

#### RPCs adicionais:
```sql
CREATE OR REPLACE FUNCTION vivan_deletar_contrato(
  p_contrato_id int, p_motorista_id int
) RETURNS void LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM vivan_contratos
                 WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id)
  THEN RAISE EXCEPTION 'Contrato não encontrado ou sem permissão'; END IF;
  DELETE FROM vivan_mensalidades WHERE "idContrato" = p_contrato_id;
  DELETE FROM vivan_contratos    WHERE "idContrato" = p_contrato_id;
END; $$;

CREATE OR REPLACE FUNCTION vivan_suspender_contrato(
  p_contrato_id int, p_motorista_id int, p_motivo text
) RETURNS json LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE vivan_contratos
  SET status = 'SUSPENSO', "motivoSuspensao" = p_motivo
  WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id;
  IF NOT FOUND THEN RAISE EXCEPTION 'Contrato não encontrado ou sem permissão'; END IF;
  RETURN json_build_object('idContrato', p_contrato_id, 'status', 'SUSPENSO');
END; $$;

CREATE OR REPLACE FUNCTION vivan_cancelar_contrato(
  p_contrato_id int, p_motorista_id int, p_motivo text
) RETURNS json LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE vivan_contratos
  SET status = 'CANCELADO', "motivoCancelamento" = p_motivo
  WHERE "idContrato" = p_contrato_id AND "idMotorista" = p_motorista_id;
  IF NOT FOUND THEN RAISE EXCEPTION 'Contrato não encontrado ou sem permissão'; END IF;
  RETURN json_build_object('idContrato', p_contrato_id, 'status', 'CANCELADO');
END; $$;
```

### 4b. `lib/via_van/clausulas_contrato_m/clausulas_contrato_m_widget.dart`
Substituir:
- `PUT /contratos/{id}` (atualizar valMensal + diaVencimento)
  → `UPDATE vivan_contratos SET "valMensal"=X, "diaVencimento"=Y WHERE "idContrato"=id AND "idMotorista"=user`

**Observação crítica:** As cláusulas do contrato são armazenadas LOCALMENTE em `SharedPreferences`
(`clausulas_contrato_v1`). O PDF também é gerado e salvo localmente. A assinatura do motorista
é armazenada em arquivo PNG no dispositivo. Nenhum desses artefatos precisa de migração para
Supabase — funcionam 100% offline. Manter como está.

### 4c. `lib/via_van/gestao_mensalidades_m/gestao_mensalidades_m_widget.dart`
Substituir:
- `getMensalidades(...)` → `SELECT * FROM vivan_mensalidades WHERE "idMotorista"=user AND "idPassageiro"=id`
- `PUT /mensalidades/{id}` (atualizar valOriginal/desconto)
  → `UPDATE vivan_mensalidades SET "valOriginal"=X WHERE "idMensalidade"=id AND "idMotorista"=user`

### 4d. `lib/via_van/extrato_passageiro_m/extrato_passageiro_m_widget.dart`
Substituir:
- `getMensalidades(...)` → `SELECT * FROM vivan_mensalidades WHERE "idMotorista"=user AND "idPassageiro"=id ORDER BY "mesReferencia"`
- `pagamentoManual(...)` → UPDATE direto (igual à Fase 2c)

### 4e. `lib/via_van/financeiro_m/financeiro_m_model.dart`
Substituir:
- `getMensalidades(...)` + `getDespesas(...)` → SELECT direto (igual Fase 2a)
- `pagamentoManual(...)` → UPDATE direto (igual Fase 2c)
- `abonarMensalidade(idMensalidade, motivo)` → UPDATE direto:
  `UPDATE vivan_mensalidades SET status='ABONADO', "motivoAbono"=motivo WHERE "idMensalidade"=id AND "idMotorista"=user`
- `cancelarAbono(idMensalidade)` → UPDATE direto:
  `UPDATE vivan_mensalidades SET status='PENDENTE', "motivoAbono"=null WHERE "idMensalidade"=id AND status='ABONADO' AND "idMotorista"=user`
- `deleteDespesa(id)` → DELETE direto (igual Fase 2a)
- **`gerarPix(idMensalidade)`** → **remover da UI** (Asaas abandonado)
  Esconder botão PIX/boleto de toda a UI de mensalidades.

### 4f. `lib/via_van/presenca_m/presenca_m_model.dart`
Verificar se tabela `vivan_presencas` existe no Supabase.
- Se existir: substituir `getPresencas(filtro)` por SELECT direto e `enviarPresencasLote(registros)` por INSERT em lote
- Se não existir: manter VivanHttp temporariamente ou criar tabela

### 4g. `lib/via_van/dashboard_motorista_via_van_m/dashboard_motorista_via_van_m_model.dart`
Substituir:
- `getDashboardResumo(motoristaId, mesRef)` → criar RPC `vivan_dashboard_motorista_resumo(p_motorista_id, p_mes_referencia)`
  que agrega: `passageirosAtivos`, `contratosAtivos`, `mensalidadesPendentes`, `mensalidadesAtrasadas`,
  `totalAReceber`, `totalRecebido`, `totalAbonado`, `totalInadimplente`, `totalDespesas`
- `getCapacidade(motoristaId)` → verificar tabela no Supabase (`vivan_veiculos` ou `vivan_motoristas`);
  se não existir, remover da UI temporariamente

**Nota:** `dashboard_motorista_via_van_m` é a tela de dashboard de UM motorista específico
(recebe `motoristaId` como parâmetro), diferente de `dashboard_passageiros_m` que é o dashboard
do motorista logado. A RPC `vivan_dashboard_home` já existente cobre o segundo caso.

#### SQL: `vivan_dashboard_motorista_resumo`
```sql
CREATE OR REPLACE FUNCTION vivan_dashboard_motorista_resumo(
  p_motorista_id   int,
  p_mes_referencia text
) RETURNS json LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_total_pass   int;  v_pass_ativos  int;
  v_total_contr  int;  v_contr_ativos int;
  v_pendentes    int;  v_atrasadas    int;
  v_a_receber    numeric; v_recebido  numeric;
  v_abonado      numeric; v_inadimp   numeric;
  v_despesas     numeric;
BEGIN
  SELECT COUNT(*) INTO v_total_pass
  FROM vivan_passageiros WHERE idMotorista = p_motorista_id;

  SELECT COUNT(DISTINCT idPassageiro) INTO v_pass_ativos
  FROM vivan_contratos WHERE idMotorista = p_motorista_id AND status = 'ATIVO';

  SELECT COUNT(*), COUNT(*) FILTER (WHERE status = 'ATIVO')
  INTO v_total_contr, v_contr_ativos
  FROM vivan_contratos WHERE idMotorista = p_motorista_id;

  SELECT
    COUNT(*) FILTER (WHERE status = 'PENDENTE'),
    COUNT(*) FILTER (WHERE status = 'ATRASADO'),
    COALESCE(SUM(valOriginal) FILTER (WHERE status IN ('PENDENTE','ATRASADO')), 0),
    COALESCE(SUM(valPago)     FILTER (WHERE status IN ('PAGO','PAGO_ATRASO')), 0),
    COALESCE(SUM(valOriginal) FILTER (WHERE status = 'ABONADO'), 0),
    COALESCE(SUM(valOriginal) FILTER (WHERE status = 'ATRASADO'), 0)
  INTO v_pendentes, v_atrasadas, v_a_receber, v_recebido, v_abonado, v_inadimp
  FROM vivan_mensalidades
  WHERE idMotorista = p_motorista_id AND mesReferencia = p_mes_referencia;

  SELECT COALESCE(SUM(valor), 0) INTO v_despesas
  FROM vivan_despesas
  WHERE idMotorista = p_motorista_id AND mesReferencia = p_mes_referencia;

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
```

---

## Telas FORA DO ESCOPO (já usam Supabase via FlutterFlow — não precisam migrar)
- `bts_via_van_assinante_adicionar/editar_m` → usa `UsuarioTable` (FlutterFlow gerado) ✓
- `bts_via_van_motorista_adicionar/editar_m` → usa `UsuarioTable` (FlutterFlow gerado) ✓
- `dashboard_resp_via_van_m` → usa `EscolaTable` + `RetdadosalunosTable` (FlutterFlow) ✓

---

## Pré-condição: verificar schemas reais antes de implementar

### 1. Verificar nomes de colunas (crítico para RPCs)
```sql
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name IN (
  'vivan_passageiros','vivan_contratos','vivan_mensalidades',
  'vivan_responsaveis','vivan_despesas','vivan_presencas','vivan_contratos_historico'
)
ORDER BY table_name, ordinal_position;
```
**Se colunas são camelCase com aspas** (ex: `"idMotorista"`): usar aspas em todo SQL dos RPCs.
**Se colunas são snake_case** (ex: `id_motorista`): ajustar todos os RPCs e queries do Flutter.

### 2. Verificar existência de pg_cron
```sql
SELECT * FROM pg_available_extensions WHERE name = 'pg_cron';
```
Se não disponível (plano Free), usar apenas a lógica client-side para status ATRASADO.

### 3. Criar sequence antes das RPCs
```sql
-- Inicializa a partir do maior numContrato já existente
CREATE SEQUENCE IF NOT EXISTS vivan_num_contrato_seq
  START WITH 1;

-- Após criar, ajustar para o valor correto:
SELECT setval('vivan_num_contrato_seq',
  COALESCE((SELECT MAX("numContrato") FROM vivan_contratos), 0) + 1);
```

---

## Ordem de execução recomendada (por impacto/risco)
1. Verificar schemas (pré-condição)
2. Criar sequence `vivan_num_contrato_seq`
3. Criar todas as RPCs no Supabase SQL Editor
4. Fase 1: reads passageiro_detalhe + contratos + mensalidades
5. Fase 2: writes simples (despesas, edit passageiro, pagamento)
6. Fase 4a-e: contrato_detalhe, cláusulas, gestão mensalidades, extrato, financeiro_m
7. Fase 3: wizard de criação (mais complexo, risco maior)
8. Fase 4f-g: presença + dashboard_motorista (depende de verificação de tabelas)
9. Remover `_vivan_http.dart`, `vivan_api_client.dart`, `vivan_service.dart`

---

## Inventário completo: 39 endpoints × cobertura no plano

| Endpoint | Migração |
|---|---|
| POST `/auth/login` | Removido com `_vivan_http.dart` |
| GET `/dashboard/resumo` | RPC `vivan_dashboard_motorista_resumo` (Fase 4g) |
| GET `/dashboard/capacidade` | Verificar tabela (Fase 4g) |
| GET `/passageiros` | Supabase direto ✓ (já migrado) |
| GET `/passageiros/{id}` | SELECT direto (Fase 1a) |
| POST `/passageiros` | RPC `vivan_criar_passageiro_completo` (Fase 3a) |
| PUT `/passageiros/{id}` | UPDATE direto (Fase 2b) |
| DELETE `/passageiros/{id}` | RPC `vivan_deletar_passageiro` (Fase 2b) |
| GET `/escolas` | Supabase direto ✓ (já migrado) |
| POST `/escolas` | INSERT direto (coberto na Fase 3a) |
| GET `/passageiros/{id}/responsaveis` | SELECT direto (Fase 1a) |
| POST `/passageiros/{id}/responsaveis` | INSERT direto (Fase 3a) |
| PUT `/passageiros/{id}/responsaveis/{id}` | UPDATE direto (Fase 2b) |
| DELETE `/passageiros/{id}/responsaveis/{id}` | DELETE direto (coberto na Fase 2b) |
| GET `/contratos` | SELECT direto (Fase 1b) |
| GET `/contratos/{id}` | SELECT direto (Fase 4a) |
| POST `/contratos` | INSERT direto (Fases 3b e 4a) |
| PUT `/contratos/{id}` | UPDATE direto (Fase 4b) |
| DELETE `/contratos/{id}` | RPC `vivan_deletar_contrato` (Fase 4a) |
| POST `/contratos/{id}/enviar-assinatura` | Remover botão da UI (Fase 4a) |
| POST `/contratos/{id}/ativar` | RPC `vivan_ativar_contrato` (Fase 3b) |
| POST `/contratos/{id}/reativar` | Mesma RPC `vivan_ativar_contrato` (Fase 4a) |
| POST `/contratos/{id}/suspender` | RPC `vivan_suspender_contrato` (Fase 4a) |
| POST `/contratos/{id}/cancelar` | RPC `vivan_cancelar_contrato` (Fase 4a) |
| GET `/contratos/{id}/historico` | SELECT `vivan_contratos_historico` — verificar tabela (Fase 4a) |
| GET `/mensalidades` | SELECT direto (Fase 1c) |
| POST `/mensalidades` | INSERT direto (Fase 3c) |
| PUT `/mensalidades/{id}` | UPDATE direto (Fase 4c) |
| POST `/mensalidades/{id}/pagamento-manual` | UPDATE direto (Fase 2c) |
| POST `/mensalidades/{id}/abonar` | UPDATE direto (Fase 4e) |
| POST `/mensalidades/{id}/cancelar-abono` | UPDATE direto (Fase 4e) |
| POST `/mensalidades/{id}/gerar-pix` | Remover da UI — Asaas abandonado (Fase 4e) |
| GET `/despesas` | SELECT direto (Fase 2a) |
| POST `/despesas` | INSERT direto (Fase 2a) |
| PUT `/despesas/{id}` | UPDATE direto (Fase 2a) |
| DELETE `/despesas/{id}` | DELETE direto (Fase 2a) |
| GET `/presencas` | SELECT direto — verificar tabela (Fase 4f) |
| POST `/presencas` | INSERT direto — verificar tabela (Fase 4f) |
| POST `/presencas/lote` | INSERT em lote — verificar tabela (Fase 4f) |

**RPCs a criar (9 total):**
1. `vivan_criar_passageiro_completo` — wizard criação (passageiro + responsável + contrato + mensalidades)
2. `vivan_ativar_contrato` — ativa contrato e gera mensalidades (RASCUNHO/SUSPENSO → ATIVO)
3. `vivan_renovar_mensalidades` — cria mensalidades faltantes até dezembro do ano corrente
4. `vivan_deletar_passageiro` — cascade: mensalidades → contratos → responsáveis → passageiro
5. `vivan_deletar_contrato` — cascade: mensalidades → contrato
6. `vivan_suspender_contrato` — ATIVO → SUSPENSO com motivo
7. `vivan_cancelar_contrato` — ATIVO → CANCELADO com motivo
8. `vivan_dashboard_motorista_resumo` — agregações por motorista e mês
9. `vivan_next_num_contrato` — helper: retorna nextval da sequence (evita expor sequence ao cliente)

**Sequence a criar:** `vivan_num_contrato_seq` (inicializada com MAX existente + 1)

---

## Verificação por fase
- **Fases 1-2:** Abrir cada tela migrada, confirmar carregamento e escrita sem erros
- **Fase 4:** Abonar mensalidade, suspender/cancelar contrato, editar cláusulas — confirmar que salva
- **Fase 3:** Wizard de criação completo — confirmar idMotorista correto em todos os registros, sem patches pós-fato
- **Final:** `grep -r "VivanHttp\|VivanLocator" lib/` deve retornar zero resultados
- **Final:** Confirmar que `_vivan_http.dart` não é mais importado em nenhum arquivo
