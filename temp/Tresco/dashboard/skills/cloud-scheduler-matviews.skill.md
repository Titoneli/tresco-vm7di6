# ⏰ Skill: Cloud Scheduler - Refresh Materialized Views

## 🎯 Objetivo

Automatizar o refresh das **Materialized Views** do PostgreSQL usando **Cloud Scheduler** + **Cloud Functions** no GCP, executando a cada **10 minutos**.

---

# 📋 Visão Geral da Arquitetura

```
┌─────────────────┐     ┌──────────────────────┐     ┌─────────────────┐
│  Cloud Scheduler │────▶│  Cloud Function       │────▶│  PostgreSQL     │
│  (*/10 * * * *)  │ POST│  refreshMatViews      │ SQL │  Cloud SQL      │
│  OIDC Auth       │     │  Node.js 20           │     │  topbrasil_crm  │
└─────────────────┘     └──────────────────────┘     └─────────────────┘
                               │
                               ▼
                    refresh_all_materialized_views_safe()
                         ou fallback individual
```

### Fluxo
1. **Cloud Scheduler** dispara POST HTTP a cada 10 minutos
2. **Cloud Function** recebe a requisição
3. Tenta usar a **SQL function** `refresh_all_materialized_views_safe()` 
4. Se não existir, faz **refresh individual** de cada view em `pg_matviews`
5. Retorna JSON com status detalhado de cada view

---

# 📁 Arquivos do Projeto

| Arquivo | Descrição |
|---------|-----------|
| `cloud-functions/refresh-materialized-views/index.js` | Cloud Function (entry point) |
| `cloud-functions/refresh-materialized-views/package.json` | Dependências (pg) |
| `database/refresh_all_materialized_views_safe.sql` | SQL Function no PostgreSQL |
| `scripts/deploy-cloud-scheduler-matviews.sh` | Script de deploy automatizado |

---

# ⚠️ Regras Absolutas

1. ✅ Sempre testar a SQL function no banco **antes** de fazer deploy
2. ✅ Sempre usar `--gen2` para Cloud Functions (2ª geração)
3. ✅ Sempre definir `DB_PASS` via variável de ambiente (nunca hardcoded)
4. ❌ Nunca commitar credenciais no script de deploy
5. ✅ Monitorar logs após o deploy para confirmar execução
6. ✅ Usar timezone `America/Sao_Paulo` no scheduler

---

# 🚀 Deploy Completo (Passo a Passo)

## 1️⃣ Pré-requisito: Criar a SQL Function no Banco

```bash
# Conectar no banco
psql "postgresql://topbrasil_admin:SENHA@130.211.194.51:5432/topbrasil_crm"

# Executar o script SQL
\i database/refresh_all_materialized_views_safe.sql

# Testar
SELECT * FROM refresh_all_materialized_views_safe();
```

Resultado esperado:
```
      view_name                          | status  | elapsed_ms
-----------------------------------------+---------+-----------
 mv_os_abertas_por_cidade                | success |       523
 mv_veiculos_com_diferenca_valor_fech... | success |      1205
 mv_veiculos_sem_fechamento_mes_atual    | success |      3456
```

## 2️⃣ Deploy via Script Automatizado

```bash
# Definir senha do banco (obrigatório)
export DB_PASS='Wxin8tfc7ErTxW1iSX40wGWq2Uj3eT3WAJ/lUd76/kU='

# Executar deploy
./scripts/deploy-cloud-scheduler-matviews.sh
```

O script automaticamente:
- Habilita APIs necessárias (Cloud Functions, Cloud Scheduler, Cloud Build)
- Faz deploy da Cloud Function com variáveis de ambiente
- Cria ou atualiza o Cloud Scheduler Job
- Executa um teste manual

## 3️⃣ Deploy Manual (se necessário)

### Deploy da Cloud Function

```bash
gcloud functions deploy refreshMatViews \
  --gen2 \
  --runtime nodejs20 \
  --region us-central1 \
  --project dashboard-boletos-dup \
  --source cloud-functions/refresh-materialized-views \
  --entry-point refreshMatViews \
  --trigger-http \
  --allow-unauthenticated \
  --memory 256MB \
  --timeout 120s \
  --set-env-vars "DB_HOST=130.211.194.51,DB_USER=topbrasil_admin,DB_PASS=SENHA,DB_NAME=topbrasil_crm,DB_PORT=5432"
```

### Obter URL da Function

```bash
FUNCTION_URL=$(gcloud functions describe refreshMatViews \
  --gen2 \
  --region us-central1 \
  --project dashboard-boletos-dup \
  --format="value(serviceConfig.uri)")

echo $FUNCTION_URL
```

### Criar Cloud Scheduler Job

```bash
gcloud scheduler jobs create http refresh-materialized-views \
  --location us-central1 \
  --project dashboard-boletos-dup \
  --schedule "*/10 * * * *" \
  --uri "$FUNCTION_URL" \
  --http-method POST \
  --oidc-service-account-email dashboard-boletos-dup@appspot.gserviceaccount.com \
  --time-zone "America/Sao_Paulo" \
  --attempt-deadline 180s
```

---

# 🔧 Comandos de Operação

## Monitoramento

```bash
# Ver logs da Cloud Function (últimas 20 entradas)
gcloud functions logs read refreshMatViews --region=us-central1 --limit=20

# Ver status do scheduler job
gcloud scheduler jobs describe refresh-materialized-views --location=us-central1

# Listar execuções recentes
gcloud scheduler jobs list --location=us-central1
```

## Execução Manual

```bash
# Forçar execução via Cloud Scheduler
gcloud scheduler jobs run refresh-materialized-views --location=us-central1

# Testar diretamente via curl
curl -X POST "$FUNCTION_URL" -H "Content-Type: application/json"
```

## Pausar / Retomar

```bash
# Pausar (não deleta, apenas para de executar)
gcloud scheduler jobs pause refresh-materialized-views --location=us-central1

# Retomar
gcloud scheduler jobs resume refresh-materialized-views --location=us-central1
```

## Alterar Frequência

```bash
# Mudar para a cada 5 minutos
gcloud scheduler jobs update http refresh-materialized-views \
  --location=us-central1 \
  --schedule="*/5 * * * *"

# Mudar para a cada 30 minutos
gcloud scheduler jobs update http refresh-materialized-views \
  --location=us-central1 \
  --schedule="*/30 * * * *"
```

## Remover Tudo

```bash
# Deletar scheduler job
gcloud scheduler jobs delete refresh-materialized-views --location=us-central1

# Deletar cloud function
gcloud functions delete refreshMatViews --region=us-central1 --gen2
```

---

# 📊 Materialized Views Conhecidas

| View | Descrição | Tempo Estimado |
|------|-----------|----------------|
| `mv_veiculos_sem_fechamento_mes_atual` | Veículos sem boleto no mês atual | ~3-5s |
| `mv_veiculos_com_diferenca_valor_fechamento` | Veículos com diferença de valor | ~1-2s |
| `mv_os_abertas_por_cidade` | OS abertas agrupadas por cidade | ~0.5s |

### Refresh Manual (via SQL)

```sql
-- Refresh individual
REFRESH MATERIALIZED VIEW mv_veiculos_sem_fechamento_mes_atual;

-- Refresh via function (todas de uma vez)
SELECT * FROM refresh_all_materialized_views_safe();
```

---

# 🔍 Troubleshooting

## Cloud Function retorna 500

1. **Verificar logs:** `gcloud functions logs read refreshMatViews --limit=10`
2. **Verificar conectividade:** A function precisa acessar o IP público do Cloud SQL
3. **Verificar credenciais:** As env vars DB_HOST, DB_USER, DB_PASS, DB_NAME estão corretas?
4. **SSL:** A function usa `ssl: { rejectUnauthorized: false }` por padrão

## Cloud Scheduler não executa

1. **Verificar status:** `gcloud scheduler jobs describe refresh-materialized-views --location=us-central1`
2. **Verificar se está pausado:** Estado deve ser `ENABLED`
3. **Service Account:** Precisa ter permissão `roles/cloudfunctions.invoker`

## Timeout na function

1. Aumentar timeout: `--timeout 300s` (máximo 540s para gen2)
2. Aumentar memória: `--memory 512MB`
3. Verificar se alguma view está muito pesada: executar `SELECT * FROM refresh_all_materialized_views_safe();` manualmente

## Views sem dados após refresh

1. Verificar se a view está retornando dados: `SELECT COUNT(*) FROM mv_nome_da_view;`
2. Verificar se as tabelas source têm dados
3. Executar `REFRESH MATERIALIZED VIEW mv_nome;` manualmente para ver erros

---

# 💰 Custos Estimados (GCP)

| Recurso | Estimativa Mensal |
|---------|-------------------|
| Cloud Scheduler | Grátis (até 3 jobs) |
| Cloud Functions (gen2) | ~$0.50 (144 execuções/dia × 5s × 256MB) |
| Outbound traffic | Incluído no free tier |
| **Total** | **~$0.50/mês** |

---

# 📝 Histórico

| Data | Descrição |
|------|-----------|
| 18/02/2026 | Implementação inicial: Cloud Function + Scheduler + SQL Function |
