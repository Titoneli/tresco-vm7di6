-- ============================================================================
-- Migration: Adicionar campos de lançamento à tabela vivan_despesas
-- Data: 2026-04-29
-- Descrição: Suporte a Despesas E Entradas, com recorrência
-- ============================================================================

-- 1. Tipo do lançamento (DESPESA ou ENTRADA)
ALTER TABLE public.vivan_despesas
  ADD COLUMN IF NOT EXISTS "tipoLancamento" text NOT NULL DEFAULT 'DESPESA';

-- 2. Flag de recorrência
ALTER TABLE public.vivan_despesas
  ADD COLUMN IF NOT EXISTS "recorrente" boolean NOT NULL DEFAULT false;

-- 3. Dia de vencimento (1-31) para lançamentos recorrentes
ALTER TABLE public.vivan_despesas
  ADD COLUMN IF NOT EXISTS "diaVencimento" integer NULL;

-- 4. Mês inicial da recorrência (formato 'YYYY-MM')
ALTER TABLE public.vivan_despesas
  ADD COLUMN IF NOT EXISTS "mesInicial" text NULL;

-- 5. Mês final da recorrência (formato 'YYYY-MM')
ALTER TABLE public.vivan_despesas
  ADD COLUMN IF NOT EXISTS "mesFinal" text NULL;

-- Index para filtrar por tipo (DESPESA / ENTRADA)
CREATE INDEX IF NOT EXISTS idx_vivan_despesas_tipo
  ON public.vivan_despesas USING btree ("tipoLancamento")
  TABLESPACE pg_default;

-- Constraint para validar valores permitidos
ALTER TABLE public.vivan_despesas
  DROP CONSTRAINT IF EXISTS chk_tipo_lancamento;
ALTER TABLE public.vivan_despesas
  ADD CONSTRAINT chk_tipo_lancamento
  CHECK ("tipoLancamento" IN ('DESPESA', 'ENTRADA'));

-- Constraint para validar dia de vencimento
ALTER TABLE public.vivan_despesas
  DROP CONSTRAINT IF EXISTS chk_dia_vencimento;
ALTER TABLE public.vivan_despesas
  ADD CONSTRAINT chk_dia_vencimento
  CHECK ("diaVencimento" IS NULL OR ("diaVencimento" >= 1 AND "diaVencimento" <= 31));
