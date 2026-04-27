# 🎨 Skill: Interface & Style - Dashboard TopBrasil

## 🎯 Objetivo

Definir todas as regras oficiais de UI/UX do Dashboard TopBrasil.

Este documento é o **manual oficial de design** do projeto. Todo componente visual, estilo, cor, espaçamento, layout e interação devem seguir obrigatoriamente o que está definido aqui.

⚠️ Nenhuma alteração visual será considerada concluída se não seguir estas regras.

---

# 🔐 REGRAS ABSOLUTAS

1. ✅ Sempre usar variáveis CSS do Design System (`var(--*)`)
2. ✅ Sempre usar escala de espaçamento baseada em 4px
3. ✅ Sempre usar cores por setor definidas neste documento
4. ✅ Sempre usar o componente `ModuleHeader` em todo módulo
5. ✅ Sempre usar `font-family: var(--font-body)` ou `var(--font-heading)`
6. ✅ Sempre validar visualmente no navegador antes de concluir
7. ❌ Nunca usar estilos inline em componentes React
8. ❌ Nunca usar cores hardcoded — usar variáveis CSS
9. ❌ Nunca usar espaçamentos fora da escala 4px
10. ❌ Nunca criar headers de módulo personalizados — usar `ModuleHeader`
11. ❌ Nunca usar `!important` salvo em overrides mobile justificados
12. ❌ Nunca usar `px` soltos — referenciar variáveis de spacing
13. ❌ Nunca commitar alteração visual sem build + teste local

---

# 🎨 Sistema de Cores

## Cores por Setor

Cada setor possui identidade visual própria. Respeitar SEMPRE.

### 🟠 Setor Processos — Laranja

| Token | Valor | Uso |
|-------|-------|-----|
| `--primary-orange` | `#F26522` | Cor primária, botões, links, destaques |
| `--primary-orange-hover` | `#E05A1A` | Estado hover de elementos laranja |
| `--primary-orange-light` | `#FFF4EE` | Backgrounds leves, badges, seleção ativa |

### 🟢 Setor Rastreamento — Teal

| Token | Valor | Uso |
|-------|-------|-----|
| `--primary-teal` | `#14B8A6` | Cor primária, botões, links, destaques |
| `--primary-teal-hover` | `#0D9488` | Estado hover de elementos teal |
| `--primary-teal-light` | `#F0FDFA` | Backgrounds leves, badges, seleção ativa |

### 🔵 Setor Integração — Azul

| Token | Valor | Uso |
|-------|-------|-----|
| `--primary-blue` | `#0EA5E9` | Cor primária, botões, links, destaques |
| `--primary-blue-hover` | `#0284C7` | Estado hover de elementos azul |
| `--primary-blue-light` | `#F0F9FF` | Backgrounds leves, badges, seleção ativa |

### Cores Secundárias

| Token | Valor | Uso |
|-------|-------|-----|
| `--secondary-purple` | `#2D2A6E` | Destaques secundários, ícones |
| `--secondary-purple-light` | `#4A47A3` | Variantes leves de purple |

---

## Cores de Status

| Token | Valor | Uso |
|-------|-------|-----|
| `--status-pending` | `#F26522` | Pendente |
| `--status-accepted` | `#22C55E` | Aceito / Aprovado / Sucesso |
| `--status-approved` | `#22C55E` | Aprovado |
| `--status-in-approval` | `#EAB308` | Em aprovação / Warning |
| `--status-finalized` | `#6B7280` | Finalizado / Inativo |
| `--status-alert` | `#EF4444` | Alerta / Erro / Crítico |

---

## Cores Neutras

| Token | Valor | Uso |
|-------|-------|-----|
| `--gray-50` | `#F9FAFB` | Background hover em linhas de tabela |
| `--gray-100` | `#F3F4F6` | Background de inputs, containers secundários |
| `--gray-200` | `#E5E7EB` | Bordas leves |
| `--gray-300` | `#D1D5DB` | Bordas médias, disabled |
| `--gray-400` | `#9CA3AF` | Placeholders, ícones inativos |
| `--gray-500` | `#6B7280` | Texto secundário, subtítulos |
| `--gray-600` | `#4B5563` | Texto complementar |
| `--gray-700` | `#374151` | Texto padrão em tabelas |
| `--gray-800` | `#1F2937` | Títulos secundários |
| `--gray-900` | `#111827` | Texto principal, headings |

---

## Backgrounds

| Token | Valor | Uso |
|-------|-------|-----|
| `--bg-primary` | `#FFFFFF` | Cards, modais, tabelas |
| `--bg-secondary` | `#F9FAFB` | Background da página |
| `--bg-tertiary` | `#F3F4F6` | Áreas de destaque leve |

---

## Sombras

| Token | Valor | Uso |
|-------|-------|-----|
| `--shadow-sm` | `0 1px 2px 0 rgb(0 0 0 / 0.05)` | Cards, tabelas |
| `--shadow-md` | `0 4px 6px -1px rgb(0 0 0 / 0.1)` | Cards em hover, dropdowns |
| `--shadow-lg` | `0 10px 15px -3px rgb(0 0 0 / 0.1)` | Modais, overlays |

---

## Border Radius

| Token | Valor | Uso |
|-------|-------|-----|
| `--radius-sm` | `4px` | Badges, tags pequenas |
| `--radius-md` | `8px` | Inputs, botões, dropdowns |
| `--radius-lg` | `12px` | Cards, containers, modais |
| `--radius-xl` | `16px` | Containers grandes |
| `--radius-full` | `9999px` | Avatares, badges circulares |

---

# 📏 Escala de Espaçamento

O projeto usa escala baseada em **múltiplos de 4px**. Usar EXCLUSIVAMENTE variáveis CSS.

| Token | Valor | Uso típico |
|-------|-------|------------|
| `--space-0` | `0` | Reset |
| `--space-px` | `1px` | Bordas finas |
| `--space-0-5` | `2px` | Micro espaçamento |
| `--space-1` | `4px` | Gap mínimo entre ícone e texto |
| `--space-2` | `8px` | Padding interno de badges |
| `--space-3` | `12px` | Padding de células de tabela, gaps |
| `--space-4` | `16px` | Padding padrão de cards, containers |
| `--space-5` | `20px` | Padding médio de botões |
| `--space-6` | `24px` | Padding de páginas, seções |
| `--space-8` | `32px` | Margem entre seções |
| `--space-10` | `40px` | Espaçamento grande |
| `--space-12` | `48px` | Loading states, empty states |
| `--space-16` | `64px` | Padding vertical de empty states |
| `--space-20` | `80px` | Padding de loading fullpage |
| `--space-24` | `96px` | Padding de coming soon |

### Regra de Uso

```css
/* ✅ CORRETO */
padding: var(--space-4);
gap: var(--space-3);
margin-bottom: var(--space-8);

/* ❌ ERRADO */
padding: 15px;
gap: 10px;
margin-bottom: 30px;
```

---

# 🔤 Tipografia

## Famílias de Fonte

| Token | Fonte | Uso |
|-------|-------|-----|
| `--font-heading` | `'Space Grotesk'` | Títulos de página (uso pontual) |
| `--font-body` | `'Inter'` | Todo o restante: corpo, tabelas, botões, labels |

### Regra: A fonte padrão é `Inter`. Use `Space Grotesk` APENAS para títulos de alto nível quando necessário.

## Escala Tipográfica

| Elemento | Tamanho | Peso | Cor | Contexto |
|----------|---------|------|-----|----------|
| Título de página | `18px` | `600` | `--gray-800` | `.page-title` |
| Título de card/seção | `18px` | `600` | `--gray-900` | `.chart-title`, `.table-title` |
| Texto de tabela (corpo) | `14px` | `400` | `--gray-700` | `td` |
| Cabeçalho de tabela | `12px` | `600` | `--gray-600` | `th`, uppercase, letter-spacing 0.5px |
| Labels de filtros | `14px` | `500` | `--gray-600` | `.filter-dropdown`, `.btn-filter` |
| Subtítulos | `13px` | `400` | `--gray-500` | `.chart-subtitle`, `.table-count` |
| Badges | `12px` | `500` | contextual | `.badge-status` |
| Texto pequeno / micro | `11px–12px` | `400–500` | `--gray-500` | Legendas, tooltips |
| Valor de indicador | `32px` | `700` | `--gray-900` | `.indicator-value` |
| Título de indicador | `13px` | `500` | `--gray-600` | `.indicator-title` |

### Regra Geral

```css
/* Headings */
font-family: var(--font-body);
font-weight: 600;
letter-spacing: -0.02em;

/* Body */
font-family: var(--font-body);
line-height: 1.5;
```

---

# 🧱 Layout

## Estrutura da Página

```
┌──────────────────────────────────────────────────────┐
│  Top Header (sticky, z-index: 100)                   │
├──────────────────────────────────────────────────────┤
│  Sub Navigation — Módulos (sticky, z-index: 99)      │
├──────────────────────────────────────────────────────┤
│  Filters Bar (data-setor driven)                     │
├──────────────────────────────────────────────────────┤
│  ModuleHeader (métricas, paginação, exportação)      │
├──────────────────────────────────────────────────────┤
│  Indicators Grid (cards de indicadores)              │
├──────────────────────────────────────────────────────┤
│  Charts (gráficos)                                   │
├──────────────────────────────────────────────────────┤
│  Data Table (tabela de dados)                        │
└──────────────────────────────────────────────────────┘
```

## Regras de Layout

| Propriedade | Valor | Token |
|-------------|-------|-------|
| Padding da página | `12px` | `--space-3` |
| Padding de headers/bars | `12px 24px` | `--space-3` `--space-6` |
| Gap padrão entre cards | `8px` | `--space-2` |
| Gap entre seções | `12px` | `--space-3` |
| Max-width do conteúdo | `100%` (full width) | — |
| Background da página | `#F9FAFB` | `--bg-secondary` |

## Grid de Indicadores

```css
.indicators-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);  /* Desktop */
  gap: var(--space-2);
}
```

### Breakpoints responsivos:

| Breakpoint | Colunas |
|------------|---------|
| `> 1400px` | 5 colunas |
| `≤ 1400px` | 4 colunas |
| `≤ 1200px` | 3 colunas |
| `≤ 992px` | 2 colunas |
| `≤ 768px` | 2 colunas (compacto) |

---

# 📊 Tabelas

## Estrutura Obrigatória

```
┌─────────────────────────────────────────┐
│ table-container (bg-primary, rounded)   │
│  ┌───────────────────────────────────┐  │
│  │ table-header (título + count)     │  │
│  ├───────────────────────────────────┤  │
│  │ thead (bg: gray-50, uppercase)    │  │
│  ├───────────────────────────────────┤  │
│  │ tbody (hover: gray-50)            │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

## Especificações

| Propriedade | Valor |
|-------------|-------|
| Background do container | `var(--bg-primary)` |
| Border radius | `var(--radius-lg)` — `12px` |
| Border | `1px solid var(--gray-200)` |
| Shadow | `var(--shadow-sm)` |
| Padding do container | `var(--space-3)` |
| **Cabeçalho (th)** | |
| Background | `var(--gray-50)` |
| Padding | `var(--space-3) var(--space-4)` |
| Font size | `12px` |
| Font weight | `600` |
| Text transform | `uppercase` |
| Letter spacing | `0.5px` |
| Cor | `var(--gray-600)` |
| **Células (td)** | |
| Padding | `var(--space-4)` |
| Font size | `14px` |
| Cor | `var(--gray-700)` |
| Border bottom | `1px solid var(--gray-100)` |
| **Hover de linha** | |
| Background | `var(--gray-50)` |

## Regras de Tabelas

- ✅ Paginação é OBRIGATÓRIA em toda tabela com mais de 25 registros
- ✅ Usar `border-collapse: collapse`
- ✅ Última linha sem border-bottom
- ✅ Overflow horizontal em mobile (`overflow-x: auto`)
- ❌ Nunca usar tabelas sem container `.table-container`

---

# 🔘 Botões

## Variantes

### Primary

```css
.btn-primary {
  background: var(--primary-orange);        /* adapta por setor */
  color: white;
  padding: var(--space-3) var(--space-5);
  border-radius: var(--radius-md);
  font-size: 14px;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: all 0.2s;
}
.btn-primary:hover {
  background: var(--primary-orange-hover);
}
.btn-primary:disabled {
  background: var(--gray-300);
  cursor: not-allowed;
}
```

### Secondary / Filter

```css
.btn-filter {
  background: var(--bg-primary);
  border: 1px solid var(--gray-200);
  color: var(--gray-700);
  padding: var(--space-2) var(--space-4);
  border-radius: var(--radius-md);
  font-size: 14px;
  font-weight: 500;
}
.btn-filter:hover {
  border-color: var(--gray-300);
  background: var(--gray-50);
}
```

### Danger (Alerta / Exclusão)

```css
background: #DC2626;
color: white;
/* Hover: */ background: #B91C1C;
```

### Ghost (Transparente)

```css
background: transparent;
border: none;
color: var(--gray-600);
/* Hover: */ background: var(--gray-100); color: var(--gray-900);
```

## Regras de Botões

- ✅ Sempre ter `transition: all 0.2s`
- ✅ Sempre ter estado `:hover`
- ✅ Sempre ter estado `:disabled` quando aplicável
- ✅ Usar `display: flex; align-items: center; gap: var(--space-2)` com ícones
- ✅ Adaptar cor primária do botão ao setor ativo via `data-setor`
- ❌ Nunca usar botão sem feedback visual de hover

---

# 🪟 Modais

## Estrutura Obrigatória

```
┌─────────────────────────────────────────────────┐
│  Overlay (rgba(0,0,0,0.5), z-index: 1000)      │
│  ┌───────────────────────────────────────────┐  │
│  │  Modal Container                          │  │
│  │  ┌─────────────────────────────────────┐  │  │
│  │  │  Header (título + botão fechar)     │  │  │
│  │  ├─────────────────────────────────────┤  │  │
│  │  │  Body (conteúdo scrollável)         │  │  │
│  │  ├─────────────────────────────────────┤  │  │
│  │  │  Footer (botões de ação)            │  │  │
│  │  └─────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

## Especificações

| Propriedade | Valor |
|-------------|-------|
| Overlay background | `rgba(0, 0, 0, 0.5)` |
| Overlay z-index | `1000` |
| Max-width do modal | `800px` (padrão), `1200px` (grande) |
| Border radius | `var(--radius-lg)` |
| Shadow | `var(--shadow-lg)` |
| Background | `var(--bg-primary)` |
| Header padding | `var(--space-4) var(--space-6)` |
| Header border-bottom | `1px solid var(--gray-200)` |
| Body padding | `var(--space-6)` |
| Body max-height | `70vh` com `overflow-y: auto` |
| Footer padding | `var(--space-4) var(--space-6)` |
| Footer border-top | `1px solid var(--gray-200)` |
| Footer alignment | `display: flex; justify-content: flex-end; gap: var(--space-3)` |

## Regras de Modais

- ✅ Sempre ter botão de fechar no header (ícone X)
- ✅ Sempre fechar ao clicar no overlay
- ✅ Sempre ter transição de abertura/fechamento
- ✅ Footer com botões alinhados à direita
- ✅ Scrollável no body quando conteúdo exceder altura
- ❌ Nunca abrir modal sem overlay escuro
- ❌ Nunca criar modal sem header e footer padronizados

---

# 📇 Cards de Indicadores

## Estrutura

```
┌────────────────────────────────────────┐
│  indicator-card                         │
│                              [icon ●]   │
│  Título (13px, gray-600)               │
│  Valor (32px, bold, gray-900)          │
│  Subtítulo (12px, gray-500)            │
│  [Trend Badge] [Sparkline]             │
└────────────────────────────────────────┘
```

## Especificações

| Propriedade | Valor |
|-------------|-------|
| Background | `var(--bg-primary)` |
| Border | `1px solid var(--gray-200)` |
| Border radius | `var(--radius-lg)` |
| Padding | `var(--space-4)` |
| Shadow | `var(--shadow-sm)` |
| Hover shadow | `var(--shadow-md)` |
| Hover transform | `translateY(-2px)` |
| Transition | `all 0.2s ease` |

## Variantes de Cor (Ícone)

| Classe | Background ícone | Cor ícone |
|--------|------------------|-----------|
| `.orange` | `rgba(242, 101, 34, 0.12)` | `--primary-orange` |
| `.teal` | `rgba(20, 184, 166, 0.12)` | `--primary-teal` |
| `.purple` | `rgba(139, 92, 246, 0.12)` | `--secondary-purple` |
| `.green` | `rgba(34, 197, 94, 0.12)` | `#22C55E` |
| `.gray` | `rgba(107, 114, 128, 0.12)` | `#6B7280` |
| `.red` | `rgba(239, 68, 68, 0.12)` | `#EF4444` |

## Trend Badges

| Estado | Cor texto | Background |
|--------|-----------|------------|
| `.positive` | `#059669` | `rgba(16, 185, 129, 0.1)` |
| `.negative` | `#DC2626` | `rgba(239, 68, 68, 0.1)` |

---

# 🧩 ModuleHeader — Componente OBRIGATÓRIO

## Regra

**TODO módulo do dashboard DEVE usar o componente `ModuleHeader`.**

Nunca criar headers personalizados. Nunca duplicar lógica de métricas, paginação ou exportação fora do `ModuleHeader`.

## Import

```tsx
import { ModuleHeader, ModuleLoading, ModuleNoData, generateCountInfo } from './ModuleHeader';
```

## Uso Mínimo

```tsx
<ModuleHeader
    moduleId="nome-do-modulo"
    title="Título do Módulo"
    countInfo={{ start: 1, end: 50, total: 1000 }}
/>
```

## Uso Completo

```tsx
<ModuleHeader
    moduleId="boletos-duplicados"
    title="Boletos Duplicados"
    countInfo={generateCountInfo(pagination)}
    metrics={conferenciaMetrics}
    filtroAtivo={filtroConferencia}
    onFiltroChange={setFiltroConferencia}
    exportConfig={{
        moduleName: 'Boletos Duplicados',
        columns: exportColumns,
        data: dadosCompletos,      // ⚠️ DADOS COMPLETOS, não paginados!
        filename: 'boletos_duplicados',
        onExport: handleOpenExportModal
    }}
    pagination={pagination}
    onPageChange={handlePageChange}
    onLimitChange={handleLimitChange}
    searchConfig={{
        value: searchTerm,
        onChange: setSearchTerm,
        placeholder: 'Buscar...'
    }}
    legend={[
        { key: 'nunca', label: 'Nunca teve', color: 'never' },
        { key: 'critico', label: '>60 dias', color: 'critical' }
    ]}
/>
```

## Recursos Integrados

| Recurso | Incluído |
|---------|----------|
| Título + contador de registros | ✅ |
| Cards de métricas clicáveis | ✅ |
| Filtro por conferência | ✅ |
| Barra de progresso | ✅ |
| Exportação (Excel, CSV, PDF) | ✅ |
| Paginação server-side | ✅ |
| Busca | ✅ |
| Legenda com cores | ✅ |
| Métricas gerais expandíveis | ✅ |

## Documentação completa

Consultar: `.github/COMPONENTE-MODULE-HEADER.md`

---

# 📤 Sistema de Exportação

## Formatos Suportados

| Formato | Tecnologia |
|---------|------------|
| Excel (.xlsx) | SheetJS (nativo) |
| CSV | SheetJS |
| PDF | jsPDF + autoTable |

## Regras de Exportação

- ✅ Sempre usar dados **COMPLETOS** (não paginados) para exportação
- ✅ Para paginação server-side, buscar TODOS os dados antes de abrir o modal
- ✅ Integrar via prop `exportConfig` do `ModuleHeader`
- ✅ Mostrar loading durante fetch de dados completos
- ❌ Nunca exportar apenas a página atual

### Padrão para Módulos com Paginação Server-Side

```tsx
const handleExport = useCallback(async () => {
    setExportLoading(true);
    const response = await fetchAllData({ page: 1, limit: 100000 });
    handleOpenExportModal('Nome Módulo', columns, response.data, 'arquivo');
    setExportLoading(false);
}, []);
```

## Documentação completa

Consultar: `.github/SISTEMA-EXPORTACAO.md`

---

# 🔍 Filtros

## Estrutura

```
┌─────────────────────────────────────────────────────────┐
│ filters-bar (data-setor="processos|rastreamento|...")    │
│  ┌──────────┐ ┌──────────────────┐ ┌────────────┐      │
│  │ View Tabs│ │ Search Box       │ │ Date Inputs│      │
│  └──────────┘ └──────────────────┘ └────────────┘      │
│                                      ┌──────────┐      │
│                                      │ Btn Ação │      │
│                                      └──────────┘      │
└─────────────────────────────────────────────────────────┘
```

## Especificações

| Elemento | Specs |
|----------|-------|
| **Search Box** | min-width: 280px, border: 1px solid gray-200, radius: md, focus: setor color |
| **Date Inputs** | padding: space-2 space-3, border: 1px solid gray-200, focus: setor color |
| **View Tabs** | bg: gray-100, radius: lg, padding: space-1, active: setor color light bg |
| **Botões de filtro** | bg: white, border: gray-200, hover: gray-50 |

## Regra de Cor por Setor

A barra de filtros adapta automaticamente a cor de foco, seleção e botão primário com base no atributo `data-setor`:

```css
.filters-bar[data-setor="rastreamento"] .btn-primary {
  background: var(--primary-teal);
}
.filters-bar[data-setor="integracao"] .btn-primary {
  background: var(--primary-blue);
}
```

---

# 📄 Paginação

## Regras

- ✅ Obrigatória em tabelas com mais de 25 registros
- ✅ Usar `PaginationConfig` do `ModuleHeader`
- ✅ Opções padrão de limite: `[25, 50, 100, 200]`
- ✅ Sempre mostrar "X-Y de Z registros"
- ✅ Paginação server-side para datasets > 500 registros
- ✅ Resetar para página 1 ao mudar filtros

## Interface

```tsx
interface PaginationConfig {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
}
```

---

# 🏷️ Badges de Status

## Tipos

| Classe | Background | Cor | Uso |
|--------|------------|-----|-----|
| `.badge-status.pending` | `--primary-orange-light` | `--primary-orange` | Pendente |
| `.badge-status.accepted` | `rgba(34,197,94,0.1)` | `--status-accepted` | Aceito |
| `.badge-status.finalized` | `--gray-100` | `--gray-600` | Finalizado |

## Badges de Contagem

| Classe | Background | Uso |
|--------|------------|-----|
| `.badge-count` (default) | `--primary-orange` | Contagem padrão |
| `.badge-count.never` | `--gray-600` | Nunca teve |
| `.badge-count.critical` | `--status-alert` | Crítico |
| `.badge-count.warning` | `--status-in-approval` | Alerta |
| `.badge-count.success` | `--status-accepted` | OK / Sucesso |

## Badges Clicáveis

```css
.badge-count.badge-clickable {
  cursor: pointer;
  transition: transform 0.15s ease, box-shadow 0.15s ease;
}
.badge-count.badge-clickable:hover {
  transform: scale(1.1);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.25);
}
```

---

# 🧠 UX Enterprise — Estados Visuais

## Loading State

```
┌──────────────────────────────────┐
│       ┌────┐                     │
│       │ ⟳  │  spinner            │
│       └────┘                     │
│    "Carregando dados..."         │
└──────────────────────────────────┘
```

### Especificações

| Propriedade | Valor |
|-------------|-------|
| Spinner size | `48px` |
| Spinner border | `3px solid var(--gray-200)` |
| Spinner top-color | `var(--primary-orange)` — adapta por setor |
| Animação | `spin 0.8s linear infinite` |
| Texto | `14px`, `--gray-500` |
| Padding | `var(--space-20)` |

### Componente

Usar o `ModuleLoading` do `ModuleHeader`:

```tsx
import { ModuleLoading } from './ModuleHeader';

{isLoading && <ModuleLoading />}
```

---

## Empty State (Sem Dados)

```
┌──────────────────────────────────┐
│            📋                     │
│    "Nenhum dado encontrado"      │
│    "Tente ajustar os filtros"    │
└──────────────────────────────────┘
```

### Especificações

| Propriedade | Valor |
|-------------|-------|
| Ícone | `48px`, centralizado |
| Padding | `var(--space-16) var(--space-5)` |
| Cor do texto | `var(--gray-500)` |
| Alinhamento | `text-align: center` |

### Componente

Usar o `ModuleNoData` do `ModuleHeader`:

```tsx
import { ModuleNoData } from './ModuleHeader';

{!isLoading && data.length === 0 && <ModuleNoData />}
```

---

## Error State

```
┌──────────────────────────────────────────────────┐
│  ⚠️ Mensagem de erro          [Tentar novamente] │
└──────────────────────────────────────────────────┘
```

### Especificações

| Propriedade | Valor |
|-------------|-------|
| Background | `#FEF2F2` |
| Border | `1px solid #FECACA` |
| Padding | `var(--space-4) var(--space-5)` |
| Margin | `var(--space-6)` |
| Radius | `var(--radius-lg)` |
| Texto cor | `#DC2626` |
| Botão | bg `#DC2626`, cor white |

---

## Regras Obrigatórias de UX

1. ✅ **Feedback visual imediato** — toda ação do usuário deve ter resposta visual
2. ✅ **Loading states obrigatórios** — nunca deixar tela em branco durante fetch
3. ✅ **Empty states informativos** — sempre explicar por que não há dados
4. ✅ **Erros amigáveis** — nunca exibir stack trace ou erro técnico ao usuário
5. ✅ **Transições suaves** — usar `transition: all 0.2s` em interações
6. ✅ **Hover em elementos interativos** — todo clicável deve ter hover state
7. ✅ **Disabled state** — botões desabilitados devem ser visualmente distintos
8. ❌ **Nunca bloquear** o usuário sem feedback de loading
9. ❌ **Nunca remover** conteúdo sem confirmação quando destrutivo

---

# 📐 Responsividade

## Breakpoints Oficiais

| Breakpoint | Target | Comportamento |
|------------|--------|---------------|
| `> 1400px` | Desktop Grande | Layout completo, 5 colunas |
| `≤ 1400px` | Desktop | 4 colunas de indicadores |
| `≤ 1200px` | Desktop Médio | 3 colunas, search menor |
| `≤ 992px` | Tablet | 2 colunas, fontes reduzidas |
| `≤ 768px` | Mobile | Layout vertical, nav scroll horizontal |
| `≤ 576px` | Mobile Pequeno | Ultra compacto |

## Regras Mobile

- ✅ Grids colapsam para 2 colunas ou 1 coluna
- ✅ Tabelas ganham `overflow-x: auto` com scroll horizontal
- ✅ Input font-size mínimo `16px` no iOS (prevenir zoom)
- ✅ Sub-nav com scroll horizontal (não wrap)
- ✅ Botões ocupam `width: 100%`
- ✅ Filtros empilham verticalmente
- ❌ Nunca esconder informações críticas em mobile
- ❌ Nunca usar hover como único indicador em mobile

---

# 🖼️ Ícones

## Biblioteca Oficial

**Lucide React** — ícones de linha, consistentes.

```tsx
import { FileText, Car, Wrench, Settings } from 'lucide-react';
```

## Regras

- ✅ Tamanho padrão em navegação: `18px`
- ✅ Tamanho padrão em cards: `22px`
- ✅ Sempre usar `size` prop para controle
- ❌ Nunca usar emojis como ícones em componentes (apenas em docs)
- ❌ Nunca misturar bibliotecas de ícones

---

# 🚫 Proibições

| Proibição | Motivo |
|-----------|--------|
| Estilos inline (`style={{}}`) | Impossibilita manutenção e consistência |
| CSS hardcoded (`color: #F26522`) | Usar variáveis CSS |
| Espaçamentos fora da escala | Quebra o design system |
| Fontes não registradas | Apenas Inter e Space Grotesk |
| Headers personalizados | Usar `ModuleHeader` |
| `!important` sem justificativa | Apenas overrides mobile documentados |
| Componentes sem loading state | Obrigatório em todo fetch |
| Tabelas sem paginação | Obrigatório acima de 25 registros |
| Botões sem hover | Todo clicável precisa de feedback |
| Modais sem overlay | Padrão visual obrigatório |

---

# 📋 Checklist — Antes de Concluir Qualquer Tarefa Visual

- [ ] Seguiu o design system (cores, espaçamento, tipografia)
- [ ] Usou variáveis CSS em vez de valores hardcoded
- [ ] Usou `ModuleHeader` como header do módulo
- [ ] Implementou loading state
- [ ] Implementou empty state
- [ ] Implementou error state
- [ ] Botões têm hover e disabled states
- [ ] Tabelas têm paginação
- [ ] Cores seguem o setor correto (🟠🟢🔵)
- [ ] Layout é responsivo nos breakpoints principais
- [ ] Exportação usa dados completos (não paginados)
- [ ] Sem estilos inline
- [ ] Sem CSS hardcoded
- [ ] Frontend buildado (`npx vite build`)
- [ ] Dist copiado para `/public`
- [ ] Backend reiniciado
- [ ] Testado visualmente em `http://localhost:3000`
- [ ] Console do navegador limpo (sem errors)
- [ ] Funcionalidade validada manualmente

---

# 🔥 Regra de Ouro

> Se não está no Design System, não existe.
>
> Se não foi validado no navegador, não está pronto.
>
> Se não usa `ModuleHeader`, não é um módulo.

---

Fim da Skill de Interface & Style.
