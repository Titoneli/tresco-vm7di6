# 🏗️ Skill: Migração Modular — Dashboard TopBrasil

## 🎯 Objetivo

Migrar o frontend de um **God Component monolítico** (`Dashboard.tsx` — 4.477 linhas, 88 useState) para uma **arquitetura Feature-Based Modular** com lazy loading, hooks isolados e separação por setor/módulo.

A migração é **incremental**, fase por fase, sem quebrar funcionalidades existentes.

---

# 🔐 REGRAS ABSOLUTAS

1. ✅ Migrar **um módulo por vez** — nunca dois simultaneamente
2. ✅ Cada módulo migrado deve funcionar **idêntico** ao original antes de prosseguir
3. ✅ Cada fase = 1 commit isolado, testável, com deploy canary
4. ✅ Sempre buildar, reiniciar backend e testar visualmente após cada fase
5. ✅ Manter `Dashboard.tsx` original funcional até a fase final de remoção
6. ✅ Todo módulo DEVE usar `ModuleHeader` — sem exceção
7. ✅ Todo módulo DEVE ter seu próprio custom hook com TODA a lógica
8. ❌ Nunca migrar sem ter a fase anterior 100% validada
9. ❌ Nunca criar estados globais desnecessários — estados ficam no módulo
10. ❌ Nunca duplicar código — extrair para `shared/` se usado por 2+ módulos
11. ❌ Nunca fazer big-bang rewrite — sempre incremental

---

# 📊 Diagnóstico Atual (Ponto de Partida)

## Estado do `Dashboard.tsx`

| Métrica | Valor | Severidade |
|---------|-------|------------|
| Linhas de código | **4.477** | 🔴 Crítico |
| `useState` | **88** | 🔴 Crítico |
| `useEffect` | **17** | 🟡 Alto |
| `useCallback` | **26** | 🟡 Alto |
| `useMemo` | **14** | 🟡 Alto |
| `useRef` | **2** | 🟢 OK |
| Chamadas de API | **29** | 🟡 Alto |
| ViewModes (telas) | **8** | 🟡 Alto |
| Setores | **3** | — |
| Debounce patterns duplicados | **5** | 🟡 Dívida técnica |

## Inventário Completo de Arquivos Frontend

| Arquivo | Linhas | Papel |
|---------|--------|-------|
| `Dashboard.tsx` | 4.477 | God Component (PROBLEMA) |
| `InstalacoesVigicar.tsx` | 1.063 | Componente parcialmente isolado |
| `api.ts` (services) | 1.013 | Todas as chamadas API em 1 arquivo |
| `index.ts` (types) | 665 | Todos os tipos em 1 arquivo |
| `BoletoEnvioModal.tsx` | 560 | Modal de boletos por contador |
| `ExportModal.tsx` | 467 | Modal de exportação (Excel/CSV/PDF) |
| `ModuleHeader.tsx` | 433 | Header unificado ✅ |
| `ConferenciaTriagemModal.tsx` | 293 | Modal conferência triagem |
| `ConferenciaSGAPlataformaModal.tsx` | 232 | Modal conferência SGA |
| `ConferenciaVeiculoModal.tsx` | 216 | Modal conferência veículos |
| `ConferenciaModal.tsx` | 211 | Modal conferência boletos |
| `useBoletos.ts` (hooks) | 41 | Hook existente (não utilizado no Dashboard) |
| `App.tsx` | 13 | Router principal |
| **TOTAL** | **9.683** | — |

## ViewModes Mapeadas (8 telas em 1 componente)

| ViewMode | Setor | Descrição |
|----------|-------|-----------|
| `duplicados` | 🟠 Processos | Boletos Duplicados + conferência |
| `sem-boletos` | 🟠 Processos | Veículos sem Boletos + conferência |
| `triagem-pos-venda` | 🟠 Processos | TPV — Diferenças de valor |
| `programacao-envios` | 🟠 Processos | Programação de envios + comparativo |
| `ordens-servico` | 🟢 Rastreamento | OS por cidade + filtros avançados |
| `veiculos-rastreamento` | 🟢 Rastreamento | Situação SGA-Plataforma |
| `instalacoes-vigicar` | 🟢 Rastreamento | Instalações Vigicar (Monday.com) |
| `ordens-servico-integracao` | 🔵 Integração | OS integração consultores |

## Problemas Identificados

1. **Re-renders massivos** — Qualquer mudança de estado re-avalia 4.477 linhas de JSX + 88 estados + 14 useMemo + 26 useCallback
2. **Bundle monolítico** — Usuário carrega TODO o JS mesmo usando apenas 1 módulo
3. **5 debounce patterns idênticos** — Código duplicado (cidade, técnico, placa, códigoOS, FIPE)
4. **Impossível testar** — Não há como fazer teste unitário de 1 hook com 88 estados
5. **Conflitos de merge** — Qualquer alteração em qualquer módulo toca o mesmo arquivo
6. **Manutenção custosa** — Encontrar um bug exige navegar 4.477 linhas
7. **Sem code splitting** — Sem lazy loading, sem chunks por rota

---

# 🏛️ Arquitetura Alvo: Feature-Based Modular

## Estrutura de Diretórios Final

```
frontend/src/
├── app/                                 # Orquestração da aplicação
│   ├── App.tsx                          # Router principal com lazy loading
│   ├── layouts/
│   │   └── DashboardLayout.tsx          # Shell: top-header, sub-nav, setor switcher
│   └── providers/
│       ├── AppProvider.tsx              # Composição de todos os providers
│       └── ExportContext.tsx            # Modal de exportação global (único estado compartilhado)
│
├── shared/                              # Código compartilhado entre módulos
│   ├── components/
│   │   ├── ModuleHeader.tsx            # ✅ Já existe — mover para cá
│   │   ├── ExportModal.tsx             # ✅ Já existe — mover para cá
│   │   ├── IndicatorCard.tsx           # Extrair do Dashboard.tsx
│   │   ├── MiniSparkline.tsx           # Extrair do Dashboard.tsx
│   │   ├── Toast.tsx                   # Toast global (extrair do Dashboard.tsx)
│   │   └── ui/                         # Primitivos reutilizáveis
│   │       ├── Badge.tsx               # Badge genérico (status, count)
│   │       ├── Spinner.tsx             # Loading spinner
│   │       ├── EmptyState.tsx          # Estado vazio
│   │       └── ErrorState.tsx          # Estado de erro
│   ├── hooks/
│   │   ├── useDebounce.ts             # Hook genérico — substituir 5 duplicados
│   │   ├── usePagination.ts           # Lógica de paginação reutilizável
│   │   ├── useExport.ts              # Lógica de abertura/controle do export modal
│   │   └── useToast.ts               # Lógica do toast notification
│   ├── services/
│   │   └── httpClient.ts             # Instância Axios configurada (base URL, interceptors)
│   ├── types/
│   │   └── common.ts                  # Tipos compartilhados (Pagination, Metrics, etc.)
│   └── utils/
│       ├── formatters.ts              # formatDateBR, formatCurrency, formatNumber
│       └── constants.ts               # Cores por setor, limites, configurações
│
├── modules/                             # ⭐ UM DIRETÓRIO POR MÓDULO (feature)
│   │
│   ├── processos/                       # 🟠 SETOR PROCESSOS
│   │   ├── boletos-duplicados/
│   │   │   ├── index.ts               # Re-export público do módulo
│   │   │   ├── BoletosDuplicados.tsx   # Componente principal (UI)
│   │   │   ├── useBoletosDuplicados.ts # Hook com TODA a lógica e estados
│   │   │   ├── boletos.api.ts         # Chamadas API deste módulo
│   │   │   ├── boletos.types.ts       # Tipos exclusivos deste módulo
│   │   │   └── components/            # Sub-componentes exclusivos
│   │   │       └── ConferenciaModal.tsx
│   │   │
│   │   ├── veiculos-sem-boletos/
│   │   │   ├── index.ts
│   │   │   ├── VeiculosSemBoletos.tsx
│   │   │   ├── useVeiculosSemBoletos.ts
│   │   │   ├── veiculos.api.ts
│   │   │   ├── veiculos.types.ts
│   │   │   └── components/
│   │   │       └── ConferenciaVeiculoModal.tsx
│   │   │
│   │   ├── triagem-pos-venda/
│   │   │   ├── index.ts
│   │   │   ├── TriagemPosVenda.tsx
│   │   │   ├── useTriagemPosVenda.ts
│   │   │   ├── triagem.api.ts
│   │   │   ├── triagem.types.ts
│   │   │   └── components/
│   │   │       └── ConferenciaTriagemModal.tsx
│   │   │
│   │   └── programacao-envios/
│   │       ├── index.ts
│   │       ├── ProgramacaoEnvios.tsx
│   │       ├── useProgramacaoEnvios.ts
│   │       ├── envios.api.ts
│   │       ├── envios.types.ts
│   │       └── components/
│   │           └── BoletoEnvioModal.tsx
│   │
│   ├── rastreamento/                    # 🟢 SETOR RASTREAMENTO
│   │   ├── ordens-servico/
│   │   │   ├── index.ts
│   │   │   ├── OrdensServico.tsx
│   │   │   ├── useOrdensServico.ts
│   │   │   ├── ordens.api.ts
│   │   │   ├── ordens.types.ts
│   │   │   └── components/
│   │   │       └── PlacasExpandidas.tsx
│   │   │
│   │   ├── situacao-sga/
│   │   │   ├── index.ts
│   │   │   ├── SituacaoSGA.tsx
│   │   │   ├── useSituacaoSGA.ts
│   │   │   ├── sga.api.ts
│   │   │   ├── sga.types.ts
│   │   │   └── components/
│   │   │       └── ConferenciaSGAModal.tsx
│   │   │
│   │   └── instalacoes-vigicar/         # ✅ Já parcialmente isolado
│   │       ├── index.ts
│   │       ├── InstalacoesVigicar.tsx   # Mover de components/
│   │       ├── useInstalacoesVigicar.ts # Extrair lógica do componente
│   │       ├── vigicar.api.ts
│   │       ├── vigicar.types.ts
│   │       └── instalacoes-vigicar.css  # Mover de components/
│   │
│   └── integracao/                      # 🔵 SETOR INTEGRAÇÃO
│       └── consultores-os/
│           ├── index.ts
│           ├── ConsultoresOS.tsx
│           ├── useConsultoresOS.ts
│           ├── consultores.api.ts
│           └── consultores.types.ts
│
└── legacy/                              # Temporário durante migração
    └── Dashboard.tsx                   # God Component original (removido na fase final)
```

---

# 🧠 Padrões Arquiteturais

## Padrão 1: Custom Hook por Módulo

Cada módulo encapsula TODA sua lógica em um único hook customizado. O componente fica limpo, apenas renderizando UI.

```tsx
// modules/processos/boletos-duplicados/useBoletosDuplicados.ts
import { useState, useEffect, useCallback, useMemo } from 'react';
import { useDebounce } from '@/shared/hooks/useDebounce';
import { usePagination } from '@/shared/hooks/usePagination';
import { useExport } from '@/shared/hooks/useExport';
import * as api from './boletos.api';
import type { BoletoDetalhado, ConferenciaMetrics } from './boletos.types';
import type { FiltroConferencia } from '@/shared/types/common';

export function useBoletosDuplicados() {
    // --- Estados do módulo (apenas os necessários) ---
    const [dados, setDados] = useState<BoletoDetalhado[]>([]);
    const [allDados, setAllDados] = useState<BoletoDetalhado[]>([]);
    const [metrics, setMetrics] = useState<ConferenciaMetrics | null>(null);
    const [filtro, setFiltro] = useState<FiltroConferencia>('pendentes');
    const [showMetricasGerais, setShowMetricasGerais] = useState(false);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    // --- Hooks compartilhados ---
    const pagination = usePagination({ initialLimit: 50 });
    const searchTerm = useDebounce('', 500);

    // --- Conferência ---
    const [modalOpen, setModalOpen] = useState(false);
    const [selectedBoleto, setSelectedBoleto] = useState<BoletoDetalhado | null>(null);
    const [conferenciaLoading, setConferenciaLoading] = useState(false);

    // --- Data fetching ---
    const fetchDados = useCallback(async () => {
        setLoading(true);
        try {
            const response = await api.fetchBoletosDuplicadosDetalhados({
                filtro,
                page: pagination.page,
                limit: pagination.limit,
            });
            setDados(response.data);
            setMetrics(response.metrics);
            pagination.setTotal(response.total);
        } catch (err) {
            setError('Erro ao carregar boletos duplicados');
        } finally {
            setLoading(false);
        }
    }, [filtro, pagination.page, pagination.limit]);

    useEffect(() => { fetchDados(); }, [fetchDados]);

    // --- Conferir boleto ---
    const handleConferir = useCallback(async (boleto: BoletoDetalhado, dados: any) => {
        setConferenciaLoading(true);
        try {
            await api.conferirBoleto({ ...dados });
            setModalOpen(false);
            await fetchDados(); // Refresh após conferência
            return { type: 'success' as const, message: 'Boleto conferido!' };
        } catch {
            return { type: 'error' as const, message: 'Erro ao conferir' };
        } finally {
            setConferenciaLoading(false);
        }
    }, [fetchDados]);

    // --- Dados filtrados para exibição ---
    const dadosFiltrados = useMemo(() => {
        if (!searchTerm.value) return dados;
        return dados.filter(b =>
            b.placa?.toLowerCase().includes(searchTerm.value.toLowerCase())
        );
    }, [dados, searchTerm.value]);

    // --- API pública do hook ---
    return {
        // Dados
        dados: dadosFiltrados,
        allDados,
        metrics,
        loading,
        error,
        // Filtros
        filtro,
        setFiltro,
        showMetricasGerais,
        setShowMetricasGerais,
        searchTerm,
        // Paginação
        pagination,
        // Conferência
        modalOpen,
        setModalOpen,
        selectedBoleto,
        setSelectedBoleto,
        conferenciaLoading,
        handleConferir,
        // Ações
        refresh: fetchDados,
    };
}
```

---

## Padrão 2: Componente de Módulo Limpo (Apenas UI)

```tsx
// modules/processos/boletos-duplicados/BoletosDuplicados.tsx
import { ModuleHeader, ModuleLoading, ModuleNoData, generateCountInfo } from '@/shared/components/ModuleHeader';
import { useBoletosDuplicados } from './useBoletosDuplicados';
import { ConferenciaModal } from './components/ConferenciaModal';
import { boletosDuplicadosExportColumns } from './boletos.types';

export default function BoletosDuplicados() {
    const {
        dados, allDados, metrics, loading, error,
        filtro, setFiltro, showMetricasGerais, setShowMetricasGerais, searchTerm,
        pagination, modalOpen, setModalOpen, selectedBoleto, setSelectedBoleto,
        conferenciaLoading, handleConferir, refresh,
    } = useBoletosDuplicados();

    if (loading) return <ModuleLoading />;
    if (error) return <div className="error-message"><span>{error}</span><button onClick={refresh}>Tentar novamente</button></div>;

    return (
        <>
            <ModuleHeader
                moduleId="boletos-duplicados"
                title="Boletos Duplicados"
                countInfo={generateCountInfo(pagination)}
                metrics={metrics}
                filtroAtivo={filtro}
                onFiltroChange={setFiltro}
                exportConfig={{
                    moduleName: 'Boletos Duplicados',
                    columns: boletosDuplicadosExportColumns,
                    data: allDados,
                    filename: 'boletos_duplicados',
                    onExport: handleOpenExportModal,
                }}
                pagination={pagination}
                onPageChange={pagination.setPage}
                onLimitChange={pagination.setLimit}
                searchConfig={searchTerm}
            />

            {dados.length === 0 ? (
                <ModuleNoData />
            ) : (
                <table>{/* Renderização da tabela */}</table>
            )}

            {modalOpen && selectedBoleto && (
                <ConferenciaModal
                    boleto={selectedBoleto}
                    loading={conferenciaLoading}
                    onConferir={handleConferir}
                    onClose={() => setModalOpen(false)}
                />
            )}
        </>
    );
}
```

---

## Padrão 3: DashboardLayout (Shell Leve)

O shell principal controla APENAS navegação, setor e layout global. **~5 estados, ~100 linhas.**

```tsx
// app/layouts/DashboardLayout.tsx
import { Suspense, lazy, useState, useCallback } from 'react';
import { ModuleLoading } from '@/shared/components/ModuleHeader';
import { ExportProvider } from '@/app/providers/ExportContext';

// --- Lazy Loading dos Módulos ---
const BoletosDuplicados = lazy(() => import('@/modules/processos/boletos-duplicados'));
const VeiculosSemBoletos = lazy(() => import('@/modules/processos/veiculos-sem-boletos'));
const TriagemPosVenda = lazy(() => import('@/modules/processos/triagem-pos-venda'));
const ProgramacaoEnvios = lazy(() => import('@/modules/processos/programacao-envios'));
const OrdensServico = lazy(() => import('@/modules/rastreamento/ordens-servico'));
const SituacaoSGA = lazy(() => import('@/modules/rastreamento/situacao-sga'));
const InstalacoesVigicar = lazy(() => import('@/modules/rastreamento/instalacoes-vigicar'));
const ConsultoresOS = lazy(() => import('@/modules/integracao/consultores-os'));

type Setor = 'processos' | 'rastreamento' | 'integracao';

const MODULE_MAP: Record<Setor, { key: string; label: string; icon: JSX.Element; component: React.LazyExoticComponent<any> }[]> = {
    processos: [
        { key: 'boletos-duplicados', label: 'Boletos Duplicados', icon: <FileText />, component: BoletosDuplicados },
        { key: 'veiculos-sem-boletos', label: 'Veículos sem Boletos', icon: <Car />, component: VeiculosSemBoletos },
        { key: 'triagem-pos-venda', label: 'Triagem Pós-Venda', icon: <ClipboardCheck />, component: TriagemPosVenda },
        { key: 'programacao-envios', label: 'Programação Envios', icon: <Calendar />, component: ProgramacaoEnvios },
    ],
    rastreamento: [
        { key: 'ordens-servico', label: 'Ordens de Serviço', icon: <Wrench />, component: OrdensServico },
        { key: 'situacao-sga', label: 'Situação SGA-Plataforma', icon: <ClipboardCheck />, component: SituacaoSGA },
        { key: 'instalacoes-vigicar', label: 'Instalações Vigicar', icon: <Settings />, component: InstalacoesVigicar },
    ],
    integracao: [
        { key: 'consultores-os', label: 'Consultores', icon: <Wrench />, component: ConsultoresOS },
    ],
};

export function DashboardLayout() {
    const [setor, setSetor] = useState<Setor>('processos');
    const [moduloAtivo, setModuloAtivo] = useState('boletos-duplicados');
    const [activeTab, setActiveTab] = useState<'dashboard' | 'dados'>('dashboard');

    const handleSetorChange = useCallback((novoSetor: Setor) => {
        setSetor(novoSetor);
        setModuloAtivo(MODULE_MAP[novoSetor][0].key);
        setActiveTab('dashboard');
    }, []);

    const moduloConfig = MODULE_MAP[setor].find(m => m.key === moduloAtivo);
    const ActiveComponent = moduloConfig?.component;

    return (
        <ExportProvider>
            <div className="dashboard-container">
                {/* Top Header */}
                <header className="top-header">
                    <div className="top-header-left">
                        <TopBrasilLogo />
                        <SetorSwitcher setor={setor} onChange={handleSetorChange} />
                    </div>
                </header>

                {/* Sub Navigation */}
                <SubNav
                    setor={setor}
                    modulos={MODULE_MAP[setor]}
                    moduloAtivo={moduloAtivo}
                    onModuloChange={setModuloAtivo}
                    activeTab={activeTab}
                    onTabChange={setActiveTab}
                />

                {/* Conteúdo do Módulo (Lazy Loaded) */}
                <main className="dashboard-content">
                    <Suspense fallback={<ModuleLoading />}>
                        {ActiveComponent && <ActiveComponent activeTab={activeTab} />}
                    </Suspense>
                </main>
            </div>
        </ExportProvider>
    );
}
```

---

## Padrão 4: Hook useDebounce Genérico

Substitui os 5 debounce patterns duplicados (cidade, técnico, placa, códigoOS, FIPE):

```tsx
// shared/hooks/useDebounce.ts
import { useState, useEffect } from 'react';

export function useDebounce<T>(initialValue: T, delay = 500) {
    const [value, setValue] = useState<T>(initialValue);
    const [debouncedValue, setDebouncedValue] = useState<T>(initialValue);

    useEffect(() => {
        const timer = setTimeout(() => setDebouncedValue(value), delay);
        return () => clearTimeout(timer);
    }, [value, delay]);

    return { value, setValue, debouncedValue };
}
```

**Uso no módulo:**

```tsx
// Antes (Dashboard.tsx) — 5 estados + 5 useEffects = 30 linhas duplicadas
const [cidadeFilter, setCidadeFilter] = useState('');
const [debouncedCidadeFilter, setDebouncedCidadeFilter] = useState('');
useEffect(() => {
    const timer = setTimeout(() => setDebouncedCidadeFilter(cidadeFilter), 500);
    return () => clearTimeout(timer);
}, [cidadeFilter]);

// Depois — 1 linha por filtro
const cidadeFilter = useDebounce('', 500);
const tecnicoFilter = useDebounce('', 500);
const placaFilter = useDebounce('', 500);
// Uso: cidadeFilter.value (input) / cidadeFilter.debouncedValue (API)
```

---

## Padrão 5: Hook usePagination Genérico

```tsx
// shared/hooks/usePagination.ts
import { useState, useCallback, useMemo } from 'react';

interface UsePaginationOptions {
    initialPage?: number;
    initialLimit?: number;
}

export function usePagination({ initialPage = 1, initialLimit = 50 }: UsePaginationOptions = {}) {
    const [page, setPageState] = useState(initialPage);
    const [limit, setLimitState] = useState(initialLimit);
    const [total, setTotal] = useState(0);

    const totalPages = useMemo(() => Math.ceil(total / limit) || 1, [total, limit]);

    const setPage = useCallback((p: number) => setPageState(p), []);
    const setLimit = useCallback((l: number) => {
        setLimitState(l);
        setPageState(1); // Reset para página 1 ao mudar limite
    }, []);

    const resetPage = useCallback(() => setPageState(1), []);

    return { page, limit, total, totalPages, setPage, setLimit, setTotal, resetPage };
}
```

---

## Padrão 6: API por Módulo

Cada módulo tem seu próprio arquivo de API, importando o httpClient compartilhado:

```tsx
// shared/services/httpClient.ts
import axios from 'axios';

const isDev = import.meta.env?.DEV || false;
const API_BASE_URL = isDev ? 'http://localhost:3000/api' : '/api';

export const httpClient = axios.create({
    baseURL: API_BASE_URL,
    timeout: 30000,
});
```

```tsx
// modules/processos/boletos-duplicados/boletos.api.ts
import { httpClient } from '@/shared/services/httpClient';
import type { BoletoDetalhado, ConferirBoletoRequest } from './boletos.types';

export async function fetchBoletosDuplicadosDetalhados(params: {
    filtro: string;
    page: number;
    limit: number;
}) {
    const response = await httpClient.get('/boletos/duplicados/detalhados', { params });
    return response.data;
}

export async function conferirBoleto(data: ConferirBoletoRequest) {
    const response = await httpClient.post('/boletos/conferir', data);
    return response.data;
}

export async function reabrirConferencia(id: number) {
    const response = await httpClient.post(`/boletos/reabrir/${id}`);
    return response.data;
}
```

---

## Padrão 7: Tipos por Módulo + Tipos Compartilhados

```tsx
// shared/types/common.ts — Tipos usados por 2+ módulos
export type FiltroConferencia = 'todos' | 'pendentes' | 'conferidos';
export type Setor = 'processos' | 'rastreamento' | 'integracao';

export interface ConferenciaMetrics {
    total: number;
    pendentes: number;
    conferidos: number;
    percentualConferido: string;
}

export interface PaginationState {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
}
```

```tsx
// modules/processos/boletos-duplicados/boletos.types.ts — Tipos exclusivos
export interface BoletoDetalhado {
    id: number;
    placa: string;
    contador: string;
    // ... campos específicos
}

export interface ConferirBoletoRequest {
    boletoId: number;
    observacao?: string;
    // ...
}
```

---

## Padrão 8: Configuração de Path Aliases

```json
// tsconfig.json — adicionar paths
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@/shared/*": ["src/shared/*"],
      "@/modules/*": ["src/modules/*"],
      "@/app/*": ["src/app/*"]
    }
  }
}
```

```ts
// vite.config.ts — adicionar resolve aliases
import { defineConfig } from 'vite';
import path from 'path';

export default defineConfig({
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
});
```

---

# 📋 Plano de Migração — 8 Fases

## Mapeamento de Estados por Módulo

Antes de migrar, cada módulo precisa ter seus estados identificados:

### 🟠 Boletos Duplicados (~15 estados)

| Estado | Tipo |
|--------|------|
| `boletosDuplicadosDetalhados` | `BoletoDetalhado[]` |
| `allBoletosDuplicados` | `BoletoDetalhado[]` |
| `filtroConferencia` | `FiltroConferencia` |
| `showMetricasGerais` | `boolean` |
| `conferenciaModalOpen` | `boolean` |
| `selectedBoletoConferencia` | `BoletoDetalhado \| null` |
| `conferenciaLoading` | `boolean` |
| `boletosPagination` | `{ page, limit }` |
| `metrics` (parcial) | `Metrics` |
| `boletosPorDia` | `BoletoPorDia[]` |
| `duplicatedBoletos` | `BoletoDuplicado[]` |
| `toastMessage` | `Toast \| null` |
| `exportLoading` | `boolean` |

### 🟠 Veículos sem Boletos (~14 estados)

| Estado | Tipo |
|--------|------|
| `veiculosSemBoletosDetalhados` | `VeiculoSemBoletoDetalhado[]` |
| `veiculosSemBoletos` | `VeiculoSemBoleto[]` |
| `filtroConferenciaVeiculos` | `FiltroConferencia` |
| `conferenciaVeiculoModalOpen` | `boolean` |
| `selectedVeiculoConferencia` | `VeiculoSemBoletoDetalhado \| null` |
| `conferenciaVeiculoLoading` | `boolean` |
| `veiculosPagination` | `{ page, limit, total, totalPages }` |
| `veiculosLoadingPage` | `boolean` |
| `veiculosConferenciaMetrics` | `ConferenciaMetrics` |
| `searchTerm` (parcial) | `string` |
| `minDays` | `number` |
| `orderBy` | `string` |
| `categoryFilter` | `string` |

### 🟠 Triagem Pós-Venda (~6 estados)

| Estado | Tipo |
|--------|------|
| `triagemPosVenda` | `VeiculoDiferencaValor[]` |
| `triagemMetrics` | `TriagemPosVendaMetrics` |
| `filtroConferenciaTriagem` | `FiltroConferencia` |
| `conferenciaTriagemModalOpen` | `boolean` |
| `selectedTriagemConferencia` | `VeiculoDiferencaValor \| null` |
| `conferenciaTriagemLoading` | `boolean` |

### 🟠 Programação de Envios (~6 estados)

| Estado | Tipo |
|--------|------|
| `resumoEnvios` | `ResumoEnvios` |
| `enviosPorDia` | `EnvioPorDia[]` |
| `comparativoEnvios` | `ComparativoEnvioDia[]` |
| `boletoEnvioModalOpen` | `boolean` |
| `boletoEnvioModalData` | `object \| null` |

### 🟢 Ordens de Serviço (~22 estados)

| Estado | Tipo |
|--------|------|
| `ordensMetrics` | `OrdemServicoMetrics` |
| `ordensPorDia` | `OrdemServicoPorDia[]` |
| `ordensPorDiaConcluidas` | `OrdemServicoPorDia[]` |
| `ordensPorStatus` | `OrdemServicoPorStatus[]` |
| `osPorCidade` | `OSPorCidade[]` |
| `cidadeFilter` + debounced | `string` (x2) |
| `tecnicoFilter` + debounced | `string` (x2) |
| `placaFilter` + debounced | `string` (x2) |
| `codigoOsFilter` + debounced | `string` (x2) |
| `fipeRange` + debounced | `string` (x2) |
| `semTecnicoFilter` | `boolean` |
| `situacaoOsFilter` | `string` |
| `situacaoSgaFilter` | `string` |
| `situacaoSgrFilter` | `string` |
| `osOrderBy` | `OSOrderBy` |
| `osOrderDropdownOpen` | `boolean` |
| `expandedCidade` | `string \| null` |
| `placasDetalhes` | `PlacaDetalhe[]` |
| `loadingPlacas` | `boolean` |
| `osDateFilterActive` | `boolean` |
| `appliedDateFilter` | `object` |
| `instalacaoMondayModal` | `InstalacaoEnriquecida \| null` |
| `loadingInstalacaoMonday` | `boolean` |

### 🟢 Situação SGA-Plataforma (~9 estados)

| Estado | Tipo |
|--------|------|
| `veiculosRastreamentoDetalhados` | `VeiculoRastreamentoDetalhado[]` |
| `filtroConferenciaVeiculosRastreamento` | `FiltroConferencia` |
| `conferenciaVeiculoRastreamentoModalOpen` | `boolean` |
| `selectedVeiculoConferenciaRastreamento` | `VeiculoRastreamentoDetalhado \| null` |
| `conferenciaVeiculoRastreamentoLoading` | `boolean` |
| `veiculosRastreamentoConferenciaMetrics` | `ConferenciaMetrics` |
| `veiculosRastreamentoPagination` | `{ page, limit, total, totalPages }` |
| `veiculosRastreamentoLoadingPage` | `boolean` |

### 🟢 Instalações Vigicar — Já parcialmente isolado (mover)

### 🔵 Consultores OS — Compartilha lógica de OS

### Shell (DashboardLayout) — ~5 estados globais

| Estado | Tipo |
|--------|------|
| `setor` | `Setor` |
| `moduloAtivo` (viewMode) | `string` |
| `activeTab` | `'dashboard' \| 'dados'` |
| `dateRange` | `{ startDate, endDate }` |
| `loading` (global) | `boolean` |

---

# 🚀 Fases de Execução

## Fase 0 — Preparação e Infraestrutura

**Risco: Baixo | Impacto no usuário: Zero**

### Tarefas

- [ ] Criar estrutura de diretórios (`app/`, `shared/`, `modules/`, `legacy/`)
- [ ] Configurar path aliases em `tsconfig.json` e `vite.config.ts` (`@/`)
- [ ] Criar `shared/services/httpClient.ts` (instância Axios)
- [ ] Criar `shared/hooks/useDebounce.ts`
- [ ] Criar `shared/hooks/usePagination.ts`
- [ ] Criar `shared/hooks/useExport.ts`
- [ ] Criar `shared/hooks/useToast.ts`
- [ ] Criar `shared/types/common.ts` (tipos compartilhados)
- [ ] Criar `shared/utils/formatters.ts` (formatDateBR, formatCurrency, etc.)
- [ ] Criar `shared/utils/constants.ts`
- [ ] Mover `Dashboard.tsx` para `legacy/Dashboard.tsx`
- [ ] Atualizar `App.tsx` para importar de `legacy/`
- [ ] Build + teste — tudo deve funcionar igual

### Validação

```bash
cd frontend && npx vite build && cp -r dist/* ../public/
cd .. && npm run dev
# Abrir http://localhost:3000 — TUDO deve funcionar idêntico
```

### Commit

```bash
git commit -m "refactor(frontend): criar estrutura modular e hooks compartilhados"
```

---

## Fase 1 — Extrair Componentes Compartilhados

**Risco: Baixo | Impacto no usuário: Zero**

### Tarefas

- [ ] Extrair `IndicatorCard` de `Dashboard.tsx` → `shared/components/IndicatorCard.tsx`
- [ ] Extrair `MiniSparkline` de `Dashboard.tsx` → `shared/components/MiniSparkline.tsx`
- [ ] Extrair `getIndicatorIcon` → `shared/utils/indicatorIcons.tsx`
- [ ] Extrair `TopBrasilLogo` → `shared/components/TopBrasilLogo.tsx`
- [ ] Extrair icon wrappers → `shared/components/Icons.tsx`
- [ ] Extrair toast logic → `shared/components/Toast.tsx`
- [ ] Mover `ModuleHeader.tsx` → `shared/components/ModuleHeader.tsx`
- [ ] Mover `ExportModal.tsx` → `shared/components/ExportModal.tsx`
- [ ] Criar `shared/components/ui/Badge.tsx`
- [ ] Criar `shared/components/ui/Spinner.tsx`
- [ ] Criar `shared/components/ui/EmptyState.tsx`
- [ ] Criar `shared/components/ui/ErrorState.tsx`
- [ ] Atualizar imports no `legacy/Dashboard.tsx`
- [ ] Build + teste

### Commit

```bash
git commit -m "refactor(shared): extrair componentes compartilhados para shared/"
```

---

## Fase 2 — Criar DashboardLayout (Shell)

**Risco: Baixo-Médio | Impacto no usuário: Zero (paralelo)**

### Tarefas

- [ ] Criar `app/layouts/DashboardLayout.tsx` com top-header + sub-nav + setor switcher
- [ ] Criar `app/providers/ExportContext.tsx` (estado global do modal de export)
- [ ] Criar `app/providers/AppProvider.tsx`
- [ ] Criar sistema de `MODULE_MAP` com registro declarativo de módulos
- [ ] Implementar `Suspense` + `lazy()` no router de módulos
- [ ] Criar `SubNav` como componente separado
- [ ] Criar `SetorSwitcher` como componente separado
- [ ] **NÃO ATIVAR AINDA** — manter `legacy/Dashboard.tsx` como padrão
- [ ] Build + teste (legacy continua funcionando)

### Commit

```bash
git commit -m "feat(shell): criar DashboardLayout com lazy loading e module map"
```

---

## Fase 3 — Migrar Instalações Vigicar

**Risco: Baixo (já é praticamente independente)**

### Tarefas

- [ ] Criar `modules/rastreamento/instalacoes-vigicar/`
- [ ] Mover `InstalacoesVigicar.tsx` e `instalacoes-vigicar.css`
- [ ] Criar `useInstalacoesVigicar.ts` — extrair lógica do componente
- [ ] Criar `vigicar.api.ts` — extrair chamadas API
- [ ] Criar `vigicar.types.ts` — extrair tipos
- [ ] Criar `index.ts` — re-export
- [ ] Registrar no `MODULE_MAP` do `DashboardLayout`
- [ ] **ATIVAR** o DashboardLayout para o módulo Vigicar (flag/rota)
- [ ] Testar módulo isolado no novo layout
- [ ] Testar que o legacy continua funcionando para os demais módulos
- [ ] Build + teste visual completo

### Commit

```bash
git commit -m "refactor(vigicar): migrar instalações vigicar para arquitetura modular"
```

---

## Fase 4 — Migrar Ordens de Serviço (Rastreamento)

**Risco: Médio (módulo mais complexo — 22 estados, 5 debounces, filtros avançados)**

### Tarefas

- [ ] Criar `modules/rastreamento/ordens-servico/`
- [ ] Criar `useOrdensServico.ts` — migrar 22 estados + toda a lógica
- [ ] Substituir 5 debounce useState+useEffect por `useDebounce` hook
- [ ] Criar `ordens.api.ts` — extrair `fetchOrdensServicoDashboard`, `fetchOSPorCidade`, `fetchPlacasPorCidade`
- [ ] Criar `ordens.types.ts` — extrair tipos de OS
- [ ] Criar `OrdensServico.tsx` — componente com Dashboard + Dados (tabs)
- [ ] Criar `components/PlacasExpandidas.tsx` — lógica de expand cidade
- [ ] Criar `components/OSFilters.tsx` — barra de filtros avançados
- [ ] Registrar no `MODULE_MAP`
- [ ] Testar todos os filtros: cidade, técnico, placa, cód OS, FIPE, semTécnico
- [ ] Testar ordenação (mais-os, mais-abertas, etc.)
- [ ] Testar expand cidade → placas → modal integração Monday
- [ ] Testar paginação
- [ ] Build + teste visual completo

### Commit

```bash
git commit -m "refactor(ordens-servico): migrar módulo OS para arquitetura modular"
```

---

## Fase 5 — Migrar Boletos Duplicados

**Risco: Médio (conferência, paginação client-side, métricas gerais)**

### Tarefas

- [ ] Criar `modules/processos/boletos-duplicados/`
- [ ] Criar `useBoletosDuplicados.ts` — migrar ~15 estados
- [ ] Criar `boletos.api.ts` — extrair `fetchBoletosDuplicadosDetalhados`, `conferirBoleto`, `reabrirConferencia`, `fetchDashboardSummary`
- [ ] Criar `boletos.types.ts` — extrair tipos de boletos
- [ ] Mover `ConferenciaModal.tsx` → `components/ConferenciaModal.tsx`
- [ ] Criar `BoletosDuplicados.tsx` — com dashboard + dados views
- [ ] Registrar no `MODULE_MAP`
- [ ] Testar conferência (conferir + reabrir)
- [ ] Testar filtros (pendentes/conferidos/todos)
- [ ] Testar métricas gerais expandíveis
- [ ] Testar paginação client-side
- [ ] Testar exportação com dados completos
- [ ] Build + teste visual completo

### Commit

```bash
git commit -m "refactor(boletos): migrar boletos duplicados para arquitetura modular"
```

---

## Fase 6 — Migrar Veículos sem Boletos + Situação SGA

**Risco: Médio (2 variantes: processos e rastreamento)**

### Tarefas

- [ ] Criar `modules/processos/veiculos-sem-boletos/`
- [ ] Criar `useVeiculosSemBoletos.ts` — migrar ~14 estados
- [ ] Criar `veiculos.api.ts` — extrair APIs
- [ ] Mover `ConferenciaVeiculoModal.tsx` → `components/`
- [ ] Criar `VeiculosSemBoletos.tsx`
- [ ] Criar `modules/rastreamento/situacao-sga/`
- [ ] Criar `useSituacaoSGA.ts` — migrar ~9 estados
- [ ] Criar `sga.api.ts` — extrair APIs
- [ ] Mover `ConferenciaSGAPlataformaModal.tsx` → `components/`
- [ ] Criar `SituacaoSGA.tsx`
- [ ] Registrar ambos no `MODULE_MAP`
- [ ] Testar conferência em ambos os módulos
- [ ] Testar legenda de cores (nunca teve, >60 dias, etc.)
- [ ] Testar paginação server-side
- [ ] Build + teste visual completo

### Commit

```bash
git commit -m "refactor(veiculos): migrar veículos sem boletos e situação SGA para modular"
```

---

## Fase 7 — Migrar Triagem Pós-Venda + Programação de Envios + Consultores

**Risco: Baixo (módulos menores e mais simples)**

### Tarefas

- [ ] Criar `modules/processos/triagem-pos-venda/`
- [ ] Criar `useTriagemPosVenda.ts` — migrar ~6 estados
- [ ] Mover `ConferenciaTriagemModal.tsx` → `components/`
- [ ] Criar `TriagemPosVenda.tsx`
- [ ] Criar `modules/processos/programacao-envios/`
- [ ] Criar `useProgramacaoEnvios.ts` — migrar ~6 estados
- [ ] Mover `BoletoEnvioModal.tsx` → `components/`
- [ ] Criar `ProgramacaoEnvios.tsx`
- [ ] Criar `modules/integracao/consultores-os/`
- [ ] Criar `useConsultoresOS.ts`
- [ ] Criar `ConsultoresOS.tsx`
- [ ] Registrar todos no `MODULE_MAP`
- [ ] Testar cada módulo individualmente
- [ ] Build + teste visual completo

### Commit

```bash
git commit -m "refactor(modules): migrar triagem, programação envios e consultores para modular"
```

---

## Fase 8 — Cleanup Final e Ativação

**Risco: Baixo (apenas remoção de código legado)**

### Tarefas

- [ ] Ativar `DashboardLayout` como componente principal no `App.tsx`
- [ ] Remover `legacy/Dashboard.tsx`
- [ ] Remover `legacy/` diretório
- [ ] Limpar `services/api.ts` — remover funções migradas para módulos
- [ ] Limpar `types/index.ts` — remover tipos migradas para módulos
- [ ] Remover `hooks/useBoletos.ts` (não utilizado)
- [ ] Remover imports não utilizados
- [ ] Rodar TypeScript strict check: `npx tsc --noEmit`
- [ ] Build final
- [ ] Teste visual completo de TODOS os módulos
- [ ] Teste de navegação entre setores
- [ ] Teste de exportação em todos os módulos
- [ ] Teste de responsividade mobile
- [ ] Deploy canary

### Commit

```bash
git commit -m "refactor(cleanup): remover Dashboard.tsx legado e ativar arquitetura modular"
```

---

# 📈 Métricas de Sucesso — Antes vs Depois

| Métrica | Antes | Depois | Melhoria |
|---------|-------|--------|----------|
| Linhas no componente principal | 4.477 | ~100 (Shell) | **-98%** |
| useState no componente principal | 88 | ~5 (Shell) | **-94%** |
| Maior módulo individual | 4.477 | ~400 | **-91%** |
| Bundle inicial | ~800KB (tudo) | ~200KB + lazy | **-75%** |
| Re-renders por interação | Tudo | Só módulo ativo | **~90% menos** |
| Tempo para encontrar um bug | Alto | Direto ao módulo | **~80% menos** |
| Risco de conflito de merge | Alto | Baixo (pastas isoladas) | **~90% menos** |
| Testabilidade unitária | Impossível | 1 hook = 1 test suite | **∞ melhoria** |
| Adicionar novo módulo | Editar Dashboard.tsx | Criar pasta + registrar | **Zero impacto** |

---

# ⚠️ Riscos e Mitigações

| Risco | Probabilidade | Mitigação |
|-------|---------------|-----------|
| Quebra de funcionalidade durante migração | Médio | Manter `legacy/` funcional até fase 8 |
| Estado compartilhado perdido entre módulos | Baixo | Usar `ExportContext` para estados globais |
| Performance pior com lazy loading em rede lenta | Baixo | Preload de módulos frequentes, chunk size otimizado |
| CSS quebrado ao mover componentes | Baixo | CSS é global (`index.css`), não depende de localização |
| Debounce se comportando diferente | Baixo | Testar filtros exaustivamente na fase 4 |
| Dados de exportação incompletos | Médio | Validar que `allDados` é fetched antes de exportar |

---

# 🧪 Checklist de Validação por Fase

Executar APÓS cada fase:

- [ ] `npx tsc --noEmit` — sem erros TypeScript
- [ ] `npx vite build` — build sem erros
- [ ] Copiar dist para public
- [ ] Reiniciar backend
- [ ] Testar no navegador `http://localhost:3000`
- [ ] Navegar entre TODOS os setores (🟠🟢🔵)
- [ ] Abrir TODOS os módulos
- [ ] Testar filtros e busca
- [ ] Testar paginação
- [ ] Testar conferência (abrir modal, conferir, reabrir)
- [ ] Testar exportação (Excel, CSV)
- [ ] Verificar console do navegador — sem errors
- [ ] Testar responsividade (reduzir janela)
- [ ] Commit + push
- [ ] Deploy canary + monitorar

---

# 🔥 Regras de Ouro

> **Um módulo por vez.** Nunca migrar dois módulos na mesma fase.
>
> **Se o legacy ainda funciona, você está seguro.** Só remova na fase final.
>
> **Se não testou no navegador, não migrou.** Código compilando ≠ código funcionando.
>
> **Cada fase é um deploy canary.** Se quebrou, rollback e investigue.

---

Fim da Skill de Migração Modular.
