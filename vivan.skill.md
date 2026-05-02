# Skill — Dashboard Gestão de Passageiros

## Resumo do Projeto

Implementação do módulo **Gestão de Passageiros** no app Tresco (Flutter/FlutterFlow), substituindo a tela antiga `DashboardMotoristaViaVanM` por uma nova `DashboardPassageirosMWidget` com navegação, resumo e estrutura de abas.

---

## 1. Problemas Resolvidos

### 1.1 Erro de Deploy — FormatException UTF-8 (offset 77434)

- **Causa:** Arquivos binários (`.DS_Store`, fontes `.ttf`, PDFs, `node_modules`) rastreados no Git.
- **Solução:**
  - Removidos `temp/`, `.DS_Store`, `build/`, `node_modules/` do tracking Git.
  - `.gitignore` atualizado com:
    ```
    temp/
    **/.DS_Store
    **/node_modules/
    *.zip
    build/
    .flutter-plugins-dependencies
    .vscode/file_map.json
    ```

### 1.2 Erro de Build — `device_info_plus 12.4.0` (`isiOSAppOnVision`)

- **Causa:** `device_info_plus 12.4.0` usa API `NSProcessInfo.isiOSAppOnVision` indisponível no SDK do Codemagic.
- **Solução:** Adicionado `dependency_overrides` no `pubspec.yaml`:
  ```yaml
  dependency_overrides:
    device_info_plus: 12.3.0
  ```

### 1.3 Menu "Gestão de Passageiros" apontando para tela antiga

- **Causa:** Arquivos `dashboard_passageiros_m_widget.dart` e `dashboard_passageiros_m_model.dart` estavam com 0 bytes desde o commit original.
- **Solução:** Arquivos recriados com conteúdo completo (detalhes abaixo).

---

## 2. Arquivos Criados / Modificados

### 2.1 Criados

| Arquivo | Linhas | Descrição |
|---------|--------|-----------|
| `lib/dashboard_passageiros_m/dashboard_passageiros_m_model.dart` | 21 | Model com `paginaAtiva`, `isLoading`, `PageController`, `unfocusNode` |
| `lib/dashboard_passageiros_m/dashboard_passageiros_m_widget.dart` | 326 | Widget completo do dashboard |

### 2.2 Modificados

| Arquivo | Alteração |
|---------|-----------|
| `lib/index.dart` | Adicionado export do `DashboardPassageirosMWidget` |
| `lib/flutter_flow/nav/nav.dart` | Adicionada `FFRoute` para `DashboardPassageirosMWidget` |
| `lib/login/login_widget.dart` | 4 referências de `DashboardMotoristaViaVanMWidget.routeName` → `DashboardPassageirosMWidget.routeName` |
| `lib/dashboard_associado_m/dashboard_associado_m_widget.dart` | Redirect atualizado para `DashboardPassageirosMWidget.routeName`; remoção de `Expanded` em `SingleChildScrollView` |
| `pubspec.yaml` | `device_info_plus: 12.3.0` em `dependency_overrides` |
| `.gitignore` | Adicionados padrões para temp, DS_Store, node_modules, zip, build |

---

## 3. Estrutura do DashboardPassageirosMWidget

- **Rota:** `dashboardPassageirosM` / `/dashPassageirosM`
- **Auth Guard:** Verifica `FFAppState().idEmpresa`
- **Layout:** `Scaffold` com `PageView` (5 páginas) + bottom navigation

### Componentes

| Componente | Descrição |
|------------|-----------|
| `_buildTopBar` | Logo Tresco + ícones de ajuda e notificações |
| `_buildHomePage` | Saudação + Card "Resumo Geral" (3 itens) + Card "Mensalidades em Aberto" |
| `_buildBottomNav` | 5 abas: Início, Passageiros, Financeiro, Veículos, Mais |
| `_buildResumoItem` | Item individual do resumo (ícone, label, valor) |
| `_buildPlaceholderPage` | Placeholder "Em breve" para abas 1-4 |
| `_buildNavItem` | Item individual da barra de navegação |

### Dados do Resumo Geral

| Item | Ícone | Fonte futura |
|------|-------|-------------|
| Passageiros Ativos | Icons.people | `VivanService.getPassageiros()` |
| Escolas Cadastradas | Icons.school | `VivanService` (a implementar) |
| Mensalidades Abertas | Icons.attach_money | `VivanService.getMensalidades()` |

---

## 4. Infraestrutura Existente (ViVan Module)

### Modelos (`lib/vivan/models/vivan_models.dart` — 727 linhas)

- `VivanPassageiro`, `VivanResponsavel`, `VivanContrato`
- `VivanMensalidade`, `VivanDespesa`, `VivanPresenca`
- `VivanDashboardResumo`

### Serviço (`lib/vivan/services/vivan_service.dart` — 360 linhas)

- CRUD para passageiros, responsáveis, contratos, mensalidades
- Integração com Supabase

### Locator (`lib/vivan/core/vivan_locator.dart`)

- Singleton: `VivanLocator.service` e `VivanLocator.client`

---

## 5. Pendências / Próximos Passos

### Prioridade Alta

- [ ] **Integrar dados reais** — Resumo Geral mostra `'0'` hardcoded; conectar com `VivanService`
- [ ] **Implementar abas do PageView** — Abas 1-4 são placeholders "Em breve"
  - Aba 1: Lista de Passageiros (CRUD)
  - Aba 2: Financeiro (mensalidades, pagamentos)
  - Aba 3: Veículos (lista, documentos)
  - Aba 4: Mais (configurações, perfil)

### Prioridade Média

- [ ] **Tela de Notificações** — Ícone presente no top bar, sem ação
- [ ] **Tela de Ajuda/FAQ** — Ícone presente no top bar, sem ação
- [ ] **Bottom sheet "Informar Pagamento"** — Para mensalidades em aberto
- [ ] **Tela de Recibo** — Visualização/download de comprovantes
- [ ] **Compartilhar via WhatsApp/PDF** — Boletos e recibos

### Prioridade Baixa

- [ ] **Item no menu sidebar** — `menu_side_bar_expandido_widget.dart` ainda não tem entrada "Gestão de Passageiros"
- [ ] **Testes unitários/widget** — Cobertura para model e widget

---

## 6. Configuração Técnica

| Item | Valor |
|------|-------|
| Repositório | `https://github.com/Titoneli/tresco-vm7di6.git` |
| Branches | `develop` (dev), `main` (deploy) |
| Deploy | FlutterFlow → Codemagic (a partir do `main`) |
| Tema | Primary `#2F8D2F`, fontes Inter / Inter Tight |
| Backend | Supabase |
| Último commit | `9d67d2e` — feat: implementar DashboardPassageirosMWidget |

---

## 7. Histórico de Commits Relevantes

1. **Limpeza Git** — Remoção de `temp/`, `.DS_Store`, `build/`, `node_modules/` do tracking
2. **Fix device_info_plus** — Pin `12.3.0` em `dependency_overrides`
3. **9d67d2e** — Implementação completa do `DashboardPassageirosMWidget` (5 arquivos, 355 inserções)
