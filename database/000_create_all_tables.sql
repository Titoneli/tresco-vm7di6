-- ============================================================================
-- ViVan — Script completo de criação de tabelas
-- Data: 2026-04-29
-- Banco: PostgreSQL
-- Convenção: camelCase entre aspas, bigserial PK, timestamps com default now()
-- ============================================================================

-- 1. ESCOLAS
CREATE TABLE IF NOT EXISTS public.vivan_escolas (
  "idEscola"    bigserial NOT NULL,
  "idMotorista" bigint NOT NULL,
  "nomeEscola"  text NOT NULL,
  "dtCriacao"   timestamp WITHOUT TIME ZONE DEFAULT now(),
  "dtAlteracao" timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_escolas_pkey PRIMARY KEY ("idEscola")
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_escolas_motorista
  ON public.vivan_escolas USING btree ("idMotorista") TABLESPACE pg_default;

-- 2. PASSAGEIROS
CREATE TABLE IF NOT EXISTS public.vivan_passageiros (
  "idPassageiro"          bigserial NOT NULL,
  "idMotorista"           bigint NOT NULL,
  "nomePassageiro"        text NOT NULL,
  "cpfPassageiro"         text,
  "rgPassageiro"          text,
  "dtNascimento"          date,
  "whatsAppPassageiro"    text,
  "telPassageiro"         text,
  "emailPassageiro"       text,
  "cepPassageiro"         text,
  "endPassageiro"         text NOT NULL DEFAULT '',
  "numPassageiro"         text,
  "compPassageiro"        text,
  "bairroPassageiro"      text,
  "cidadePassageiro"      text,
  "ufPassageiro"          text,
  "latPassageiro"         double precision,
  "lngPassageiro"         double precision,
  "urlFoto"               text,
  "idEscola"              bigint,
  "domTurno"              text,
  "domSerie"              text,
  "idTurma"               bigint,
  "horarioEntrada"        text,
  "horarioSaida"          text,
  "periodoLetivo"         text,
  "necessidadesEspeciais" text,
  observacoes             text,
  ativo                   boolean NOT NULL DEFAULT true,
  "dtCriacao"             timestamp WITHOUT TIME ZONE DEFAULT now(),
  "dtAlteracao"           timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_passageiros_pkey PRIMARY KEY ("idPassageiro")
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_passageiros_motorista
  ON public.vivan_passageiros USING btree ("idMotorista") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_passageiros_escola
  ON public.vivan_passageiros USING btree ("idEscola") TABLESPACE pg_default;

-- 3. RESPONSÁVEIS
CREATE TABLE IF NOT EXISTS public.vivan_responsaveis (
  "idResponsavel"       bigserial NOT NULL,
  "idPassageiro"        bigint NOT NULL,
  "nomeResponsavel"     text NOT NULL,
  "cpfResponsavel"      text NOT NULL,
  "rgResponsavel"       text,
  parentesco            text NOT NULL,
  "telResponsavel"      text,
  "whatsAppResponsavel" text NOT NULL,
  "emailResponsavel"    text NOT NULL,
  "endResponsavel"      text,
  "cnhResponsavel"      text,
  profissao             text,
  "estadoCivil"         text,
  principal             boolean NOT NULL DEFAULT true,
  ativo                 boolean NOT NULL DEFAULT true,
  "dtCriacao"           timestamp WITHOUT TIME ZONE DEFAULT now(),
  "dtAlteracao"         timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_responsaveis_pkey PRIMARY KEY ("idResponsavel")
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_responsaveis_passageiro
  ON public.vivan_responsaveis USING btree ("idPassageiro") TABLESPACE pg_default;

-- 4. CONTRATOS
CREATE TABLE IF NOT EXISTS public.vivan_contratos (
  "idContrato"               bigserial NOT NULL,
  "numContrato"              text,
  "idMotorista"              bigint NOT NULL,
  "idPassageiro"             bigint NOT NULL,
  "idResponsavel"            bigint,
  "idEscola"                 bigint,
  "idVeiculo"                bigint,
  "domTurno"                 text,
  "dtInicio"                 date,
  "dtTermino"                date,
  "valMensal"                numeric(10,2),
  "diaVencimento"            integer,
  "domFormaPagamento"        text,
  "domCondicaoPagamento"     text,
  "percentualDesconto"       numeric(5,2),
  "percentualMulta"          numeric(5,2),
  "percentualJurosDia"       numeric(5,4),
  "clausulasAdicionais"      jsonb,
  status                     text NOT NULL DEFAULT 'RASCUNHO',
  "motivoCancelamento"       text,
  "motivoSuspensao"          text,
  observacoes                text,
  "dtCriacao"                timestamp WITHOUT TIME ZONE DEFAULT now(),
  "dtAlteracao"              timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_contratos_pkey PRIMARY KEY ("idContrato")
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_contratos_motorista
  ON public.vivan_contratos USING btree ("idMotorista") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_contratos_passageiro
  ON public.vivan_contratos USING btree ("idPassageiro") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_contratos_status
  ON public.vivan_contratos USING btree (status) TABLESPACE pg_default;

-- 5. MENSALIDADES
CREATE TABLE IF NOT EXISTS public.vivan_mensalidades (
  "idMensalidade"       bigserial NOT NULL,
  "idContrato"          bigint,
  "idPassageiro"        bigint,
  "idResponsavel"       bigint,
  "idMotorista"         bigint NOT NULL,
  "mesReferencia"       text,
  "dtVencimento"        date,
  "valOriginal"         numeric(10,2),
  "valDesconto"         numeric(10,2),
  "valMulta"            numeric(10,2),
  "valJuros"            numeric(10,2),
  "valPago"             numeric(10,2),
  "dtPagamento"         date,
  "formaPagamento"      text,
  status                text NOT NULL DEFAULT 'AGUARDANDO',
  "asaasPixQrCode"      text,
  "asaasPixCopiaECola"  text,
  "asaasInvoiceUrl"     text,
  "asaasBankSlipUrl"    text,
  "comprovanteUrl"      text,
  "motivoAbono"         text,
  observacoes           text,
  "dtCriacao"           timestamp WITHOUT TIME ZONE DEFAULT now(),
  "dtAlteracao"         timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_mensalidades_pkey PRIMARY KEY ("idMensalidade")
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_mensalidades_motorista
  ON public.vivan_mensalidades USING btree ("idMotorista") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_mensalidades_mesref
  ON public.vivan_mensalidades USING btree ("mesReferencia") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_mensalidades_status
  ON public.vivan_mensalidades USING btree (status) TABLESPACE pg_default;

-- 6. DESPESAS / LANÇAMENTOS
CREATE TABLE IF NOT EXISTS public.vivan_despesas (
  "idDespesa"        bigserial NOT NULL,
  "idMotorista"      bigint NOT NULL,
  "idVeiculo"        bigint,
  categoria          text NOT NULL,
  descricao          text NOT NULL,
  valor              numeric(10,2) NOT NULL,
  "dtDespesa"        date NOT NULL,
  "dtVencimento"     date,
  pago               boolean DEFAULT false,
  "dtPagamento"      date,
  "comprovanteUrl"   text,
  "mesReferencia"    text,
  observacoes        text,
  "tipoLancamento"   text NOT NULL DEFAULT 'DESPESA',
  recorrente         boolean NOT NULL DEFAULT false,
  "diaVencimento"    integer,
  "mesInicial"       text,
  "mesFinal"         text,
  "dtCriacao"        timestamp WITHOUT TIME ZONE DEFAULT now(),
  "dtAlteracao"      timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_despesas_pkey PRIMARY KEY ("idDespesa"),
  CONSTRAINT chk_tipo_lancamento CHECK ("tipoLancamento" IN ('DESPESA', 'ENTRADA')),
  CONSTRAINT chk_dia_vencimento CHECK ("diaVencimento" IS NULL OR ("diaVencimento" >= 1 AND "diaVencimento" <= 31))
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_despesas_motorista
  ON public.vivan_despesas USING btree ("idMotorista") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_despesas_data
  ON public.vivan_despesas USING btree ("dtDespesa") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_despesas_categoria
  ON public.vivan_despesas USING btree (categoria) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_despesas_mesref
  ON public.vivan_despesas USING btree ("mesReferencia") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_despesas_tipo
  ON public.vivan_despesas USING btree ("tipoLancamento") TABLESPACE pg_default;

-- 7. PRESENÇAS
CREATE TABLE IF NOT EXISTS public.vivan_presencas (
  "idPresenca"     bigserial NOT NULL,
  "idContrato"     bigint,
  "idPassageiro"   bigint,
  "idMotorista"    bigint NOT NULL,
  "dtPresenca"     date,
  "domTurno"       text,
  "tipoPresenca"   text NOT NULL DEFAULT 'P',
  justificativa    text,
  "latRegistro"    double precision,
  "lngRegistro"    double precision,
  "dtCriacao"      timestamp WITHOUT TIME ZONE DEFAULT now(),
  "dtAlteracao"    timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_presencas_pkey PRIMARY KEY ("idPresenca")
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_presencas_motorista
  ON public.vivan_presencas USING btree ("idMotorista") TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_vivan_presencas_data
  ON public.vivan_presencas USING btree ("dtPresenca") TABLESPACE pg_default;

-- 8. CONTRATO HISTÓRICO
CREATE TABLE IF NOT EXISTS public.vivan_contrato_historico (
  "idHistorico"    bigserial NOT NULL,
  "idContrato"     bigint NOT NULL,
  "tipoAlteracao"  text,
  "statusAnterior" text,
  "statusNovo"     text,
  usuario          text,
  descricao        text,
  "dtAlteracao"    timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_contrato_historico_pkey PRIMARY KEY ("idHistorico")
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vivan_contrato_historico_contrato
  ON public.vivan_contrato_historico USING btree ("idContrato") TABLESPACE pg_default;
