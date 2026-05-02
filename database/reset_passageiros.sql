-- ============================================================================
-- Reset: Excluir todos os passageiros e dados relacionados
-- ⚠️  ATENÇÃO: Esta operação é IRREVERSÍVEL. Faça backup antes de executar.
-- ============================================================================
-- Ordem de deleção respeita as FKs:
--   vivan_contrato_historico → vivan_presencas → vivan_mensalidades
--   → vivan_contratos → vivan_responsaveis → vivan_passageiros

BEGIN;

-- 1. Histórico de contratos
DELETE FROM public.vivan_contrato_historico
WHERE "idContrato" IN (
  SELECT "idContrato" FROM public.vivan_contratos
);

-- 2. Presenças
DELETE FROM public.vivan_presencas
WHERE "idPassageiro" IN (
  SELECT "idPassageiro" FROM public.vivan_passageiros
);

-- 3. Mensalidades
DELETE FROM public.vivan_mensalidades
WHERE "idPassageiro" IN (
  SELECT "idPassageiro" FROM public.vivan_passageiros
);

-- 4. Contratos
DELETE FROM public.vivan_contratos
WHERE "idPassageiro" IN (
  SELECT "idPassageiro" FROM public.vivan_passageiros
);

-- 5. Responsáveis
DELETE FROM public.vivan_responsaveis
WHERE "idPassageiro" IN (
  SELECT "idPassageiro" FROM public.vivan_passageiros
);

-- 6. Passageiros (por último)
DELETE FROM public.vivan_passageiros;

-- 7. Resetar sequences para IDs voltarem a 1
ALTER SEQUENCE IF EXISTS public."vivan_passageiros_idPassageiro_seq" RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public."vivan_responsaveis_idResponsavel_seq" RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public."vivan_contratos_idContrato_seq" RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public."vivan_mensalidades_idMensalidade_seq" RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public."vivan_presencas_idPresenca_seq" RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public."vivan_contrato_historico_idHistorico_seq" RESTART WITH 1;

COMMIT;
