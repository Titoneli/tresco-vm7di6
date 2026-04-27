# 🗄️ Skill: Acesso DBA - Banco de Dados Top Brasil CRM

## 🎯 Objetivo

Padronizar o processo de acesso, conexão e operações DBA no banco de dados de produção do Top Brasil CRM.

Ambiente hospedado no **Google Cloud SQL (PostgreSQL 16)**.

---

# 📋 Informações do Banco

- Ambiente: Produção
- Provedor: Google Cloud SQL
- Engine: PostgreSQL 16
- Instância: topbrasil-sistemas-db
- Região: us-central1
- Database: topbrasil_crm

---

# 🔐 Credenciais Oficiais

```
Host (Público):    130.211.194.51
Host (via Proxy):  localhost
Port:              5432
Database:          topbrasil_crm
User:              topbrasil_admin
Password:          Wxin8tfc7ErTxW1iSX40wGWq2Uj3eT3WAJ/lUd76/kU=
```

Connection String (IP Público):

```
postgresql://topbrasil_admin:Wxin8tfc7ErTxW1iSX40wGWq2Uj3eT3WAJ%2FlUd76%2FkU%3D@130.211.194.51:5432/topbrasil_crm
```

⚠️ Essas credenciais são sensíveis. Não compartilhar externamente.

---

# 🚀 MÉTODO RECOMENDADO: Cloud SQL Proxy

## 1️⃣ Instalar Cloud SQL Proxy

### macOS
```bash
brew install cloud-sql-proxy
```

### Linux
```bash
curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.8.0/cloud-sql-proxy.linux.amd64
chmod +x cloud-sql-proxy
sudo mv cloud-sql-proxy /usr/local/bin/
```

### Windows
Baixar de:
https://cloud.google.com/sql/docs/postgres/sql-proxy

---

## 2️⃣ Autenticar no GCP

```bash
gcloud auth login
gcloud config set project topbrasil-sistemas-backend
```

---

## 3️⃣ Iniciar Proxy

```bash
cloud-sql-proxy topbrasil-sistemas-backend:us-central1:topbrasil-sistemas-db
```

Rodando corretamente, escutará em:

```
localhost:5432
```

---

## 4️⃣ Conectar ao Banco

### Via psql

```bash
PGPASSWORD='Wxin8tfc7ErTxW1iSX40wGWq2Uj3eT3WAJ/lUd76/kU=' \
psql -h localhost -p 5432 -U topbrasil_admin -d topbrasil_crm
```

---

### Via DBeaver

```
Host:     localhost
Port:     5432
Database: topbrasil_crm
User:     topbrasil_admin
Password: (credencial oficial)
```

---

### Via pgAdmin

```
Host:     localhost
Port:     5432
Database: topbrasil_crm
User:     topbrasil_admin
SSL:      Prefer
```

---

# 🌐 Conexão Direta (Menos Segura)

## 1️⃣ Liberar IP

Solicitar whitelist ao administrador:

```bash
gcloud sql instances patch topbrasil-sistemas-db \
  --authorized-networks=SEU_IP \
  --project=topbrasil-sistemas-backend
```

## 2️⃣ Conectar

```bash
psql "postgresql://topbrasil_admin:senha@130.211.194.51:5432/topbrasil_crm"
```

⚠️ Preferir sempre Proxy.

---

# 📊 Comandos DBA Essenciais

## Listar tabelas
```sql
\dt
```

## Ver estrutura
```sql
\d+ nome_tabela
```

## Conexões ativas
```sql
SELECT pid, usename, client_addr, state
FROM pg_stat_activity
WHERE datname = 'topbrasil_crm';
```

## Tamanho do banco
```sql
SELECT pg_size_pretty(pg_database_size('topbrasil_crm'));
```

## Tamanho das tabelas
```sql
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename))
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

---

# 💾 Backup Manual

## Via Proxy
```bash
pg_dump -h localhost -U topbrasil_admin -d topbrasil_crm > backup_$(date +%Y%m%d_%H%M%S).sql
```

## Via IP Público
```bash
pg_dump -h 130.211.194.51 -U topbrasil_admin -d topbrasil_crm > backup.sql
```

---

# ♻️ Restore

```bash
psql -h localhost -U topbrasil_admin -d topbrasil_crm < backup.sql
```

---

# ⚡ Performance

## Queries mais lentas
```sql
SELECT query, calls, total_time, mean_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

## Índices não utilizados
```sql
SELECT schemaname, tablename, indexname, idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0;
```

---

# 🧹 Manutenção

## Analyze
```sql
ANALYZE nome_tabela;
```

## Vacuum
```sql
VACUUM FULL ANALYZE;
```

---

# 🔐 Permissões Necessárias

Role obrigatória:

```
roles/cloudsql.client
```

Solicitar ao administrador se necessário.

---

# 🆘 Troubleshooting

## Proxy não conecta
```bash
gcloud auth list
gcloud auth login
```

## Timeout
```bash
ps aux | grep cloud-sql-proxy
```

## IP bloqueado
```bash
curl ifconfig.me
```

---

# 📞 Contato

Líder Técnico:
Kelvy Muniz  
kelvy@topbrasil.com.br
DBA:
Gustavo Titoneli
gustavo.titoneli@topbrasilpv.com.br

---

# 🔥 Regra de Ouro

Produção exige:

- Acesso controlado
- Backup antes de alterações críticas
- Monitoramento após mudanças
- Preferir sempre Cloud SQL Proxy

---

Última atualização: Novembro 2025