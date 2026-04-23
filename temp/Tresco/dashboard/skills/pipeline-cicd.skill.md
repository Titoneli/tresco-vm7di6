# 🚀 Skill: Pipeline CI/CD - Dashboard TopBrasil

## 🎯 Objetivo

Padronizar fluxo completo de integração e entrega contínua do projeto.

Stack:

- GitHub
- Conventional Commits
- Docker
- Google Cloud Run
- Deploy Canary

---

# 🔁 Fluxo Oficial

```
Dev Local
   ↓
Build & Test Local
   ↓
Commit (Conventional)
   ↓
Push main
   ↓
Deploy Canary (10%)
   ↓
Monitoramento
   ↓
Promote ou Rollback
```

---

# 🧪 Etapa 1 — Desenvolvimento

```bash
npm run dev
cd frontend && npm run dev
```

Implementar alteração.

---

# 🧪 Etapa 2 — Build & Test Local (OBRIGATÓRIO)

```bash
cd frontend
npx vite build
cp -r dist/* ../public/
cd ..
npm run dev
```

Testar em:
```
http://localhost:3000
```

---

# 📝 Etapa 3 — Commit Padronizado

Formato:

```
<tipo>(<escopo>): descrição
```

Exemplo:

```bash
git add .
git commit -m "feat(processos): melhorar performance da consulta"
git push origin main
```

Tipos permitidos:

- feat
- fix
- refactor
- perf
- docs
- style
- chore
- test

---

# 🐳 Etapa 4 — Deploy Canary

```bash
./scripts/deploy-canary.sh
```

Entrega 10% do tráfego.

---

# 📊 Etapa 5 — Monitoramento

Verificar:

- Logs Cloud Run
- Erros 500
- Latência
- Consumo memória
- Falhas JWT
- Queries lentas
- Frontend quebrado

Aguardar 5–10 minutos.

---

# 🚀 Etapa 6 — Promoção

Se estável:

```bash
./scripts/promote-canary.sh
```

Direciona 100% do tráfego.

---

# 🛑 Se houver erro

```bash
./scripts/rollback.sh
```

Retorna para versão estável.

---

# 🔐 Segurança no Pipeline

- `.env` nunca versionado
- Secrets apenas no Cloud Run
- Sem credenciais no código
- Nunca deploy direto 100%

---

# 📦 Estrutura Recomendada (CI Futuro)

Caso automatizar:

- GitHub Actions
- Workflow para:
  - Lint
  - Build backend
  - Build frontend
  - Build Docker
  - Deploy Canary automático

---

# 📋 Checklist CI/CD Seguro

- [ ] Código testado localmente
- [ ] Frontend buildado
- [ ] Backend funcionando
- [ ] Commit padronizado
- [ ] Push realizado
- [ ] Deploy Canary executado
- [ ] Monitoramento realizado
- [ ] Promote ou Rollback executado

---

# 🔥 Regra de Ouro

Deploy seguro é processo, não comando.

Sem Canary, não é produção.