# 🚀 Skill: Deploy - Dashboard TopBrasil

## 🎯 Objetivo

Esta skill é responsável por orientar QUALQUER deploy da aplicação Dashboard TopBrasil.

O deploy oficial e obrigatório é via **Google Cloud Run**, utilizando **Deploy Canary**.

⚠️ NUNCA realizar deploy sem antes realizar o **build-test-local.skill.md**.
⚠️ NUNCA realizar deploy direto com 100% do tráfego.

---

# 🔐 REGRAS ABSOLUTAS

1. ✅ Sempre solicitar autorizacao antes de efetuar o Deploy
2. ✅ Sempre utilizar Deploy Canary
3. ✅ Sempre fazer commit antes do deploy
4. ✅ Sempre buildar o frontend antes do commit
5. ❌ Nunca commitar `.env`
6. ❌ Nunca fazer deploy direto full traffic
7. ✅ Sempre monitorar logs antes de promover
8. ❌ NUNCA realizar deploy sem antes realizar o **build-test-local.skill.md**

---

# 🏗️ Fluxo Oficial de Deploy (CANARY)

## 1️⃣ Build do Frontend (OBRIGATÓRIO)

```bash
cd frontend
npm run build
cp -r dist/* ../public/
cd ..
```

---

## 2️⃣ Commit (OBRIGATÓRIO antes do deploy)

Seguir padrão Conventional Commits:

```bash
git add .
git commit -m "tipo(escopo): descrição"
git push origin main
```

Exemplo:
```bash
git commit -m "feat(dashboard): adicionar filtro por técnico"
```

---

## 3️⃣ Deploy Canary (10% do tráfego)

```bash
./scripts/deploy-canary.sh
```

Esse comando:

- Cria nova revisão no Cloud Run
- Direciona apenas 10% do tráfego
- Mantém versão anterior com 90%

---

## 4️⃣ Monitoramento (OBRIGATÓRIO)

Aguardar 5-10 minutos.

Verificar:

- Logs no Google Cloud
- Erros 500
- Consumo de memória
- Tempo de resposta
- Queries lentas
- Falhas de autenticação
- Problemas no frontend

Se houver erro crítico:

```bash
./scripts/rollback.sh
```

---

## 5️⃣ Promoção para 100%

Se tudo estiver estável:

```bash
./scripts/promote-canary.sh
```

Isso direciona 100% do tráfego para a nova revisão.

---

# 🔄 Fluxo Visual

```
deploy-canary.sh (10%)
        ↓
   Monitorar
        ↓
   ┌───────────────┐
   │ Está OK?      │
   └───────┬───────┘
           │
     Sim   │   Não
           │
           ↓
 promote-canary.sh
           ↓
         100%
           
Ou:

rollback.sh
```

---

# 🐳 Docker & Cloud Run

A aplicação utiliza:

- Docker para containerização
- Google Cloud Run como runtime
- Variáveis de ambiente via configuração do serviço

Não alterar Dockerfile sem necessidade.
Não alterar porta padrão configurada no Cloud Run.

---

# 🔐 Variáveis de Ambiente

As variáveis são configuradas no ambiente do Cloud Run.

Nunca commitar:

```
.env
```

Caso seja necessário alterar variável:

1. Atualizar no painel do Cloud Run
2. Fazer novo deploy canary
3. Monitorar novamente

---

# 🧪 Checklist Pré-Deploy

Antes de rodar o deploy:

- [ ] Frontend buildado
- [ ] Backend compilando sem erro
- [ ] Testado localmente em http://localhost:3000
- [ ] Nenhum console error no navegador
- [ ] Queries otimizadas
- [ ] Commit realizado
- [ ] Push realizado

---

# 🛑 Quando Fazer Rollback

Executar rollback IMEDIATAMENTE se houver:

- Erro 500 em rotas críticas
- Tela branca no frontend
- Falha de autenticação JWT
- Timeout excessivo
- Alto consumo de memória
- Erros de conexão com banco

Comando:

```bash
./scripts/rollback.sh
```

---

# 🧠 Boas Práticas

- Deploys pequenos são mais seguros
- Evitar deploy grande na sexta-feira
- Sempre monitorar após promover
- Sempre revisar histórico de commits antes do deploy
- Garantir que migrations SQL foram aplicadas corretamente

---

# 🔥 Regra de Ouro

Se não passou por:

build → commit → canary → monitoramento

O deploy está errado.

---

# 📌 Resumo Executivo

| Etapa | Obrigatório |
|--------|-------------|
| Build frontend | ✅ |
| Commit | ✅ |
| Canary (10%) | ✅ |
| Monitorar | ✅ |
| Promote | ✅ |
| Deploy direto 100% | ❌ |

---

Fim da Skill de Deploy.