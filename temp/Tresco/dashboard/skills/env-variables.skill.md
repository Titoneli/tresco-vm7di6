# 🔐 Skill: Variáveis de Ambiente - Dashboard TopBrasil

## 🎯 Objetivo

Padronizar o uso, alteração e validação de variáveis de ambiente no projeto.

A aplicação roda em:

- Node.js (backend)
- React + Vite (frontend)
- Docker
- Google Cloud Run

---

# ⚠️ Regras Absolutas

1. ❌ Nunca commitar `.env`
2. ❌ Nunca expor credenciais no repositório
3. ✅ Variáveis sensíveis devem estar apenas no Cloud Run
4. ✅ Sempre fazer novo deploy canary após alterar variáveis
5. ✅ Validar localmente antes do deploy

---

# 📁 Arquivos Envolvidos

### Backend
`.env` (apenas local)

### Frontend
Usar variáveis prefixadas com:

```
VITE_
```

Exemplo:
```
VITE_API_URL=http://localhost:3000
```

---

# 🧱 Variáveis Oficiais do Projeto

```
DB_HOST=
DB_PORT=5432
DB_NAME=
DB_USER=
DB_PASSWORD=
PORT=3000
NODE_ENV=development
JWT_SECRET=
API_URL=
ACCOUNT=
PASSWORD=
```

⚠️ Credenciais reais estão em:
```
.github/ACESSO-DBA.md
```

---

# 🐳 No Docker

As variáveis são injetadas via:

- Configuração do serviço no Cloud Run
- Não usar `.env` dentro da imagem final

---

# ☁️ Alterando Variáveis no Cloud Run

## Processo Correto:

1. Acessar Google Cloud Run
2. Editar serviço
3. Alterar variável necessária
4. Salvar nova revisão
5. Executar novo deploy canary
6. Monitorar

⚠️ Toda alteração gera nova revisão.

---

# 🧪 Validação Local

Após alterar `.env` localmente:

```bash
cd frontend
npx vite build
cp -r dist/* ../public/
cd ..
npm run dev
```

Testar:
```
http://localhost:3000
```

---

# 🚫 Erros Comuns

- Esquecer prefixo `VITE_` no frontend
- Usar variável backend no frontend
- Alterar variável em produção sem deploy
- Comitar `.env`
- Divergência entre ambiente local e produção

---

# 🔍 Debug de Problemas

Se API não conectar:

- Verificar DB_HOST
- Verificar porta
- Testar conexão manualmente
- Conferir logs do Cloud Run

Se JWT falhar:

- Verificar JWT_SECRET
- Confirmar se não mudou entre revisões

---

# 📋 Checklist Seguro

- [ ] Variável alterada corretamente
- [ ] Não foi commitada
- [ ] Testado localmente
- [ ] Novo deploy canary realizado
- [ ] Monitorado após deploy

---

# 🔥 Regra de Ouro

Variável alterada = nova revisão.

Nunca alterar produção sem controle.