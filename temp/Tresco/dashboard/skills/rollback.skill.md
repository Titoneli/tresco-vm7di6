# 🛑 Skill: Rollback - Dashboard TopBrasil

## 🎯 Objetivo

Executar rollback imediato de uma release com problema no Google Cloud Run.

Essa skill deve ser usada quando o deploy Canary apresentar falhas críticas.

---

# 🚨 Quando Executar Rollback

Executar IMEDIATAMENTE se houver:

- Erros 500 frequentes
- Tela branca no frontend
- Falha de autenticação JWT
- Problemas de conexão com banco
- Timeout excessivo
- Consumo anormal de memória
- Queda de performance significativa
- Erros críticos nos logs do Cloud Run

⚠️ Não tentar corrigir em produção.
⚠️ Primeiro restaurar estabilidade.

---

# 🔄 Comando Oficial de Rollback

```bash
./scripts/rollback.sh
```

Esse comando:

- Remove o tráfego da nova revisão
- Restaura 100% do tráfego para a versão anterior estável
- Mantém histórico da revisão com problema

---

# 🔍 Pós-Rollback (OBRIGATÓRIO)

Após executar rollback:

1. Confirmar que aplicação voltou ao normal
2. Verificar logs da revisão com erro
3. Identificar causa raiz
4. Corrigir localmente
5. Testar localmente
6. Gerar novo commit
7. Realizar novo deploy Canary

---

# ❌ O que NÃO Fazer

- Não promover canary com erro
- Não aplicar hotfix direto em produção
- Não alterar variáveis direto sem controle
- Não ignorar logs

---

# 📋 Checklist Pós-Incidente

- [ ] Serviço restaurado
- [ ] Logs analisados
- [ ] Erro identificado
- [ ] Correção aplicada localmente
- [ ] Testado em http://localhost:3000
- [ ] Novo deploy canary realizado

---

# 🧠 Regra de Ouro

Estabilidade > Correção rápida

Rollback primeiro.
Corrigir depois.