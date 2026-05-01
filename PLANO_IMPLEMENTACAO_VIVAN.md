# Plano de Implementação — Módulo ViVan (Motorista)

> Última atualização: 29/04/2026

---

## 📋 Visão Geral

O módulo ViVan é o sistema de gestão para motoristas de transporte escolar. O dashboard motorista possui **5 abas** navegáveis por bottom nav:

| # | Aba | Ícone | Status |
|---|-----|-------|--------|
| 0 | Rotas | route | ✅ Existente |
| 1 | Passageiros | usersLight | ✅ Existente |
| 2 | Mensalidades | currencyCircleDollar | ✅ Implementado |
| 3 | Financeiro | (chart/balance) | ✅ Implementado |
| 4 | Opções | gear | ✅ Existente |

---

## ✅ Itens Concluídos

### 1. Fix API Cast Error
- **Arquivo**: `lib/vivan/core/vivan_api_client.dart`
- **Problema**: `type 'ApiCallResponse' is not a subtype of 'Map<String, dynamic>'`
- **Solução**: Métodos retornam `Future<dynamic>` extraindo `response.jsonBody`
- **Bônus**: Auto-login com `_ensureToken()` usando credenciais do `FFAppState`

### 2. Modelo VivanDespesa — Novos Campos
- **Arquivo**: `lib/vivan/models/vivan_models.dart`
- **Campos adicionados**: `tipoLancamento`, `recorrente`, `diaVencimento`, `mesInicial`, `mesFinal`
- **fromJson/toJson**: Atualizados

### 3. Migração SQL
- **Arquivo**: `database/001_alter_vivan_despesas_lancamentos.sql`
- **Colunas**: tipoLancamento (DESPESA|ENTRADA), recorrente (bool), diaVencimento (1-31), mesInicial, mesFinal
- **Constraints**: `chk_tipo_lancamento`, `chk_dia_vencimento`
- **⚠️ PENDENTE**: Executar no banco de produção

### 4. Formulário de Passageiro (Correções)
- **Arquivos**: `lib/via_van/passageiro_form_m/passageiro_form_m_model.dart` + `_widget.dart`
- **Fix modo edição**: Usa `updateResponsavel`/`updateContrato` quando IDs já existem (não duplica)
- **Design alinhado**: FlutterFlowTheme, FFButtonWidget, borderRadius 8
- **Header dinâmico**: "Editar Passageiro" vs "Cadastrar Passageiro"
- **Feedback**: SnackBar de sucesso após salvar

### 5. Tab Mensalidades
- **Arquivos**: `lib/via_van/mensalidades_tab/` (model + widget)
- **Features implementadas**:
  - Navegação por mês (tabs horizontais)
  - Campo de busca por nome
  - Card resumo (valor acumulado, pagas, a vencer, em atraso)
  - Lista de mensalidades com badge de status
  - Bottom sheet "Pagou" (formas de pagamento: PIX, Dinheiro, Cartão Crédito, Cartão Débito, Transferência, Boleto)
  - Botão "Lembrete" → abre WhatsApp com mensagem pré-formatada
  - Bottom sheet de filtros (Ano Base, Status, Período)
  - Método público `showFilters()` para acesso externo

### 6. Tab Financeiro
- **Arquivos**: `lib/via_van/financeiro_tab/` (model + widget)
- **Features implementadas**:
  - Navegação por mês (tabs horizontais)
  - Card resumo (mensalidades recebidas, a receber, outras entradas, despesas, saldo)
  - Lista de lançamentos (despesas + entradas)
  - Bottom sheet "Adicionar Lançamento":
    - Toggle Despesa / Entrada
    - Grid 3×2 de categorias com ícones
    - Campo valor em R$
    - Toggle Única / Recorrente
    - Pickers condicionais (dia vencimento, mês inicial, mês final) para recorrente
    - Campo descrição
    - Botão Salvar (loop de criação para recorrente)
  - Bottom sheet de filtros (Ano Base)

### 7. Integração no Dashboard
- **Arquivo**: `lib/via_van/dashboard_motorista_via_van_m/dashboard_motorista_via_van_m_widget.dart`
- **Mudanças**: 
  - Imports adicionados (MensalidadesTabWidget, FinanceiroTabWidget)
  - PageView children[2] = MensalidadesTabWidget()
  - PageView children[3] = FinanceiroTabWidget()
  - 5º botão de nav adicionado (FFIcons.kgear, index 4)

---

## 🔲 Itens Pendentes / Próximos Passos

### P1 — Executar Migration no Banco
- [ ] Rodar `database/001_alter_vivan_despesas_lancamentos.sql` no PostgreSQL de produção
- [ ] Verificar que constraints foram criadas corretamente

### P2 — Ajustes de UX nas Tabs
- [ ] Mensalidades: Adicionar pull-to-refresh
- [ ] Financeiro: Exibir ícone da categoria na lista de lançamentos
- [ ] Financeiro: Swipe-to-delete em lançamentos
- [ ] Financeiro: Editar lançamento existente (bottom sheet pré-preenchido)

### P3 — Geração de Cobrança PIX (Asaas)
- [ ] Botão "Gerar PIX" por mensalidade (serviço `gerarPix()` já existe)
- [ ] Exibir QR code ou link de pagamento
- [ ] Status automático quando pago via PIX

### P4 — Abono de Mensalidade
- [ ] Bottom sheet "Abonar" com campo motivo (serviço `abonarMensalidade()` já existe)
- [ ] Badge visual de "Abonado" na lista
- [ ] Opção de cancelar abono (`cancelarAbono()`)

### P5 — Relatórios / Exportação
- [ ] Resumo mensal exportável (PDF ou CSV)
- [ ] Histórico de pagamentos por passageiro

### P6 — Dashboard Responsável (resp)
- [ ] O dashboard `dashboard_resp_via_van_m` existe mas NÃO foi modificado
- [ ] Avaliar se deve ter visão de mensalidades do responsável

### P7 — Testes
- [ ] Testes unitários nos models (VivanDespesa, VivanMensalidade)
- [ ] Testes de widget nos tabs
- [ ] Teste de integração do fluxo "Adicionar Lançamento"

---

## 🏗️ Arquitetura Atual

```
lib/vivan/
├── core/
│   ├── vivan_api_client.dart    ← HTTP client (auto-login)
│   └── vivan_config.dart        ← URLs, prefixos
├── models/
│   └── vivan_models.dart        ← Todos os models (Passageiro, Mensalidade, Despesa, etc.)
├── services/
│   └── vivan_service.dart       ← Todas as chamadas de API
└── vivan.dart                   ← Barrel exports

lib/via_van/
├── dashboard_motorista_via_van_m/  ← Dashboard com 5-tab bottom nav
├── passageiro_form_m/              ← Form 3 steps (wizard)
├── mensalidades_tab/               ← Tab de mensalidades
├── financeiro_tab/                 ← Tab financeiro
└── ...

database/
├── 000_create_all_tables.sql       ← Schema completo de referência
└── 001_alter_vivan_despesas_lancamentos.sql  ← Migration pendente
```

---

## 🎨 Padrões de Design

| Item | Padrão |
|------|--------|
| Cor primária | `FlutterFlowTheme.of(context).primary` (#2F8D2F verde) |
| Botões | `FFButtonWidget` + `FFButtonOptions` |
| Border radius | `8.0` (constante `_r`) |
| Font | `GoogleFonts.inter` |
| Elevation | `0` |
| Cards escuros | `Color(0xFF2D3748)` ou `Color(0xFF4A5568)` |
| Cor erro | `FlutterFlowTheme.of(context).error` (#FF5963) |
| Cor sucesso | `FlutterFlowTheme.of(context).success` (#249689) |

---

## 📡 Endpoints API (Backend TypeScript)

Base: `app.coopertransmig.com.br/api/vivan`

| Método | Endpoint | Uso |
|--------|----------|-----|
| GET | /mensalidades | Listar mensalidades (filtros: motorista, mesReferencia, status) |
| POST | /mensalidades/:id/pagamento-manual | Registrar pagamento |
| POST | /mensalidades/:id/abonar | Abonar mensalidade |
| POST | /mensalidades/:id/cancelar-abono | Cancelar abono |
| POST | /mensalidades/:id/gerar-pix | Gerar cobrança PIX |
| GET | /despesas | Listar despesas/entradas (filtros: motorista, mesReferencia, categoria) |
| POST | /despesas | Criar despesa/entrada |
| PUT | /despesas/:id | Atualizar |
| DELETE | /despesas/:id | Excluir |

---

## 📌 Commits Realizados

1. `feat(vivan): implementar tabs Mensalidades e Financeiro + correções` — c69896f
2. `chore: mover skill file para pasta skills/` — b695cec
3. `feat(vivan): auto-login com credenciais do FFAppState quando token ausente` — 3863190
