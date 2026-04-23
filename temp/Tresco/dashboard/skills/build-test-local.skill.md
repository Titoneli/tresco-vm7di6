# 🧪 Skill: Build & Test Local - Dashboard TopBrasil

## 🎯 Objetivo

Garantir que toda alteração seja validada localmente antes de commit e deploy.

Essa etapa é OBRIGATÓRIA.

---

# ⚠️ Regra Absoluta

Nenhuma tarefa está concluída sem:

- Build do frontend
- Reinício do backend
- Teste visual no navegador

---

# 🏗️ Processo Completo

## 1️⃣ Build do Frontend

```bash
cd frontend
npx vite build
cp -r dist/* ../public/
cd ..
```

---

## 2️⃣ Reiniciar Backend

```bash
npm run dev
```

---

## 3️⃣ Teste Manual

Abrir no navegador:

```
http://localhost:3000
```

Verificar:

- Layout correto
- Sem erros no console (F12)
- API respondendo
- Filtros funcionando
- Paginação funcionando
- Exportação funcionando
- ModuleHeader renderizando corretamente
- Nenhuma quebra visual

---

# 🔍 Verificações Técnicas

- TypeScript sem erros
- Nenhum console.error
- Nenhum warning crítico
- Queries funcionando
- Variáveis de ambiente corretas

---

# 🚫 Erros Comuns

- Esquecer de copiar dist para /public
- Testar apenas frontend em modo dev
- Não reiniciar backend
- Confiar apenas no código
- Não validar exportação

---

# 📋 Checklist Final

- [ ] Frontend buildado
- [ ] Dist copiado para /public
- [ ] Backend reiniciado
- [ ] Testado em navegador
- [ ] Console limpo
- [ ] Funcionalidade validada
- [ ] Commit pronto para envio

---

# 🔥 Regra de Ouro

Se não testou no navegador, não está pronto.

Código não validado ≠ código pronto.