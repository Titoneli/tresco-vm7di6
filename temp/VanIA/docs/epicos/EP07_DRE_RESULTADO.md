# EP07 - Demonstração de Resultado (DRE)

## Objetivo do Épico

Apresentar o resultado financeiro da operação de forma clara e visual, permitindo ao transportador entender seu lucro real, analisar a saúde do negócio e tomar decisões baseadas em dados.

---

## Histórias de Usuário

### US07.01 - Dashboard Financeiro

**Como** transportador  
**Quero** ver um painel com a situação financeira atual  
**Para** ter visão rápida do negócio

#### Widgets do Dashboard

| Widget | Descrição |
|--------|-----------|
| Receita do Mês | Total recebido no período |
| Despesas do Mês | Total pago no período |
| Lucro do Mês | Receita - Despesas |
| Inadimplência | Valor em atraso |
| Gráfico de Evolução | Últimos 6 meses |
| Top 5 Despesas | Maiores categorias |

#### Critérios de Aceitação

- [ ] **CA01** - Dashboard carrega ao entrar no sistema
- [ ] **CA02** - Período selecionável (mês/ano)
- [ ] **CA03** - Comparativo com mês anterior (%)
- [ ] **CA04** - Cores indicativas (verde/vermelho)
- [ ] **CA05** - Atualização em tempo real
- [ ] **CA06** - Responsivo (mobile)

#### Regras de Negócio

- **RN01** - Receita = parcelas pagas no período
- **RN02** - Despesas = despesas pagas no período
- **RN03** - Lucro = Receita - Despesas

---

### US07.02 - DRE Simplificada

**Como** transportador  
**Quero** ver uma demonstração de resultado simplificada  
**Para** entender a composição do meu lucro

#### Estrutura da DRE

```
RECEITA BRUTA
  (+) Mensalidades recebidas
  (+) Cobranças avulsas
  (+) Outras receitas
────────────────────────────
= RECEITA BRUTA TOTAL                    R$ XX.XXX,XX

(-) DEDUÇÕES
  (-) Inadimplência (não recebido)
  (-) Descontos concedidos
  (-) Cancelamentos/Estornos
────────────────────────────
= RECEITA LÍQUIDA                        R$ XX.XXX,XX

(-) DESPESAS OPERACIONAIS
  (-) Pessoal
      • Salários
      • Pró-labore
      • Encargos
  (-) Operação
      • Combustível
      • Manutenção
      • Pedágio
      • Seguro
  (-) Tributos
      • DAS / ISS
      • INSS
  (-) Administrativo
      • Contador
      • Sistema
      • Internet/Telefone
────────────────────────────
= DESPESAS TOTAIS                        R$ XX.XXX,XX

────────────────────────────
= LUCRO/PREJUÍZO OPERACIONAL             R$ XX.XXX,XX

Margem de Lucro: XX,X%
```

#### Critérios de Aceitação

- [ ] **CA01** - Exibir DRE por período (mês, trimestre, ano)
- [ ] **CA02** - Expandir/recolher categorias
- [ ] **CA03** - Clicar em valor abre detalhamento
- [ ] **CA04** - Indicadores visuais de performance
- [ ] **CA05** - Comparativo com período anterior
- [ ] **CA06** - Exportação PDF/Excel

#### Regras de Negócio

- **RN01** - Receita baseada em regime de caixa (quando recebeu)
- **RN02** - Despesas baseadas em regime de caixa (quando pagou)
- **RN03** - Inadimplência = parcelas vencidas não pagas

---

### US07.03 - Análise por Período

**Como** transportador  
**Quero** analisar o resultado de diferentes períodos  
**Para** identificar tendências e sazonalidade

#### Períodos Disponíveis

- Mensal
- Trimestral
- Semestral
- Anual
- Personalizado (data início - data fim)

#### Critérios de Aceitação

- [ ] **CA01** - Seletor de período intuitivo
- [ ] **CA02** - Gráfico de evolução do lucro
- [ ] **CA03** - Tabela comparativa mês a mês
- [ ] **CA04** - Identificar melhor/pior mês
- [ ] **CA05** - Média mensal do período

#### Exemplo de Análise Anual

| Mês | Receita | Despesas | Lucro | Margem |
|-----|---------|----------|-------|--------|
| Jan | 15.000 | 10.500 | 4.500 | 30% |
| Fev | 14.500 | 10.200 | 4.300 | 29% |
| ... | ... | ... | ... | ... |
| **Ano** | **175.000** | **122.500** | **52.500** | **30%** |

---

### US07.04 - Análise por Veículo

**Como** transportador  
**Quero** ver o resultado por veículo  
**Para** identificar quais são rentáveis

#### Critérios de Aceitação

- [ ] **CA01** - Receita por veículo (alunos vinculados)
- [ ] **CA02** - Despesas por veículo (centro de custo)
- [ ] **CA03** - Lucro por veículo
- [ ] **CA04** - Ranking de rentabilidade
- [ ] **CA05** - Custo por aluno/veículo

#### Estrutura

```
VEÍCULO: VAN ABC-1234

Receita
  • Alunos vinculados: 15
  • Receita mensal: R$ 6.075,00

Despesas Diretas
  • Combustível: R$ 1.200,00
  • Manutenção: R$ 350,00
  • Seguro (rateio): R$ 200,00
  • IPVA (rateio): R$ 150,00
  Total: R$ 1.900,00

Resultado: R$ 4.175,00 (68,7%)
Custo por aluno: R$ 126,67
```

#### Regras de Negócio

- **RN01** - Despesas sem centro de custo podem ser rateadas
- **RN02** - Rateio proporcional ao número de alunos ou receita
- **RN03** - Veículo sem despesas mostra alerta

---

### US07.05 - Análise por Rota

**Como** transportador  
**Quero** ver o resultado por rota  
**Para** precificar corretamente

#### Critérios de Aceitação

- [ ] **CA01** - Receita por rota
- [ ] **CA02** - Despesas vinculadas à rota
- [ ] **CA03** - Lucro por rota
- [ ] **CA04** - Ocupação da rota (alunos/capacidade)
- [ ] **CA05** - Sugestão de preço baseada em custos

#### Regras de Negócio

- **RN01** - Despesas de combustível podem ser estimadas por km
- **RN02** - Custo fixo é rateado entre rotas

---

### US07.06 - Indicadores de Performance (KPIs)

**Como** transportador  
**Quero** ver indicadores chave do negócio  
**Para** monitorar a saúde financeira

#### KPIs Principais

| KPI | Fórmula | Meta Sugerida |
|-----|---------|---------------|
| Margem de Lucro | Lucro / Receita | > 25% |
| Taxa de Inadimplência | Atrasado / Total | < 5% |
| Ticket Médio | Receita / Alunos | - |
| Custo por Aluno | Despesas / Alunos | - |
| Ocupação | Alunos / Capacidade | > 80% |
| Receita por Veículo | Receita / Veículos | - |

#### Critérios de Aceitação

- [ ] **CA01** - Cards com KPIs principais
- [ ] **CA02** - Indicador de tendência (↑↓)
- [ ] **CA03** - Comparativo com período anterior
- [ ] **CA04** - Meta configurável por KPI
- [ ] **CA05** - Alerta quando fora da meta
- [ ] **CA06** - Histórico de evolução

---

### US07.07 - Gráficos e Visualizações

**Como** transportador  
**Quero** ver gráficos do resultado financeiro  
**Para** visualizar tendências facilmente

#### Tipos de Gráficos

| Tipo | Uso |
|------|-----|
| Linha | Evolução mensal de receita/despesa/lucro |
| Barras | Comparativo de períodos |
| Pizza | Composição de despesas por categoria |
| Gauge | Indicadores vs meta |
| Área | Receita vs Despesas (sobreposição) |

#### Critérios de Aceitação

- [ ] **CA01** - Gráfico de evolução (últimos 12 meses)
- [ ] **CA02** - Gráfico de composição de despesas
- [ ] **CA03** - Gráfico de receita vs despesas
- [ ] **CA04** - Interatividade (hover mostra valores)
- [ ] **CA05** - Download do gráfico (PNG)
- [ ] **CA06** - Responsivo

---

### US07.08 - Projeção Financeira

**Como** transportador  
**Quero** ver projeção do resultado futuro  
**Para** planejar o negócio

#### Critérios de Aceitação

- [ ] **CA01** - Projeção baseada em contratos ativos
- [ ] **CA02** - Considera despesas recorrentes
- [ ] **CA03** - Estimativa de inadimplência (histórica)
- [ ] **CA04** - Cenários: otimista, realista, pessimista
- [ ] **CA05** - Próximos 3, 6, 12 meses

#### Estrutura da Projeção

```
PROJEÇÃO - Próximos 3 meses

Receita Prevista
  • Contratos ativos: 45 alunos
  • Valor médio: R$ 410,00
  • Receita bruta: R$ 18.450,00/mês
  • (-) Inadimplência estimada (5%): R$ 922,50
  = Receita líquida estimada: R$ 17.527,50/mês

Despesas Previstas
  • Recorrentes cadastradas: R$ 8.500,00
  • Variáveis estimadas (histórico): R$ 2.200,00
  = Despesas estimadas: R$ 10.700,00/mês

Lucro Projetado: R$ 6.827,50/mês
```

#### Regras de Negócio

- **RN01** - Projeção é estimativa, não garantia
- **RN02** - Considera apenas contratos ativos
- **RN03** - Inadimplência baseada nos últimos 6 meses

---

### US07.09 - Alertas Financeiros

**Como** transportador  
**Quero** receber alertas sobre situação financeira  
**Para** agir preventivamente

#### Tipos de Alerta

| Alerta | Condição | Ação |
|--------|----------|------|
| Lucro negativo | Lucro < 0 | Notificação + E-mail |
| Margem baixa | Margem < 15% | Notificação |
| Inadimplência alta | > 10% | Notificação + Sugestões |
| Despesas acima | > 80% da receita | Notificação |
| Queda de receita | < 10% vs mês anterior | Notificação |

#### Critérios de Aceitação

- [ ] **CA01** - Configurar limites para alertas
- [ ] **CA02** - Notificação no app
- [ ] **CA03** - E-mail para alertas críticos
- [ ] **CA04** - Histórico de alertas
- [ ] **CA05** - Sugestões de ação

---

### US07.10 - Exportação para Contabilidade

**Como** transportador  
**Quero** exportar o resultado para o contador  
**Para** facilitar o fechamento contábil

#### Conteúdo da Exportação

- DRE do período
- Relatório de receitas (com NFS-e)
- Relatório de despesas (com comprovantes)
- XMLs das notas fiscais
- Resumo de impostos

#### Critérios de Aceitação

- [ ] **CA01** - Pacote de exportação mensal
- [ ] **CA02** - Formatos: PDF + Excel + ZIP (anexos)
- [ ] **CA03** - Envio por e-mail para contador
- [ ] **CA04** - Histórico de exportações
- [ ] **CA05** - Agendamento automático (todo dia X)

---

## Dependências

- **EP04** - Contas a Receber (receitas)
- **EP06** - Contas a Pagar (despesas)

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US07.01 | 8 | Alta |
| US07.02 | 8 | Alta |
| US07.03 | 5 | Alta |
| US07.04 | 5 | Média |
| US07.05 | 5 | Média |
| US07.06 | 5 | Alta |
| US07.07 | 5 | Média |
| US07.08 | 5 | Baixa |
| US07.09 | 3 | Média |
| US07.10 | 5 | Alta |
| **Total** | **54** | |

---

## Wireframes

### Dashboard Financeiro
```
┌─────────────────────────────────────────────────────────┐
│  Dashboard                           Janeiro/2026    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ ┌────────────┬────────────┬────────────┬────────────┐  │
│ │  Receita │ 💸 Despesas│  Lucro   │  Inadimp.│  │
│ │ R$ 15.390  │ R$ 10.450  │ R$ 4.940   │ R$ 1.215   │  │
│ │ ↑ 5%       │ ↓ 3%       │ ↑ 12%      │ ↓ 8%       │  │
│ └────────────┴────────────┴────────────┴────────────┘  │
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │                  Evolução do Lucro                  ││
│ │  R$6k │            ╱╲                               ││
│ │  R$4k │     ╱╲    ╱  ╲   ╱╲                        ││
│ │  R$2k │ ╱╲╱  ╲╱╲╱    ╲╱  ╲                        ││
│ │    0  │─────────────────────────                    ││
│ │       │ Ago Set Out Nov Dez Jan                     ││
│ └─────────────────────────────────────────────────────┘│
│                                                         │
│ ┌────────────────────────┬────────────────────────────┐│
│ │   Despesas por       │   KPIs                   ││
│ │     Categoria          │                            ││
│ │                        │  Margem: 32%             ││
│ │    Pessoal 35%    │  Inadimpl.: 3%           ││
│ │    Operação 30%    │  Ocupação: 85%           ││
│ │    Tributos 20%     │  Ticket: R$342 ─           ││
│ │    Admin 15%         │                            ││
│ └────────────────────────┴────────────────────────────┘│
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### DRE Simplificada
```
┌─────────────────────────────────────────────────────────┐
│  DRE - Demonstração de Resultado      Janeiro/2026   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Período: [ Janeiro  ] [ 2026  ]    [Exportar ]   │
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │                                                     ││
│ │  RECEITA BRUTA                                      ││
│ │    Mensalidades recebidas ............ R$ 16.200,00 ││
│ │    Cobranças avulsas ..................... R$ 405,00││
│ │  ─────────────────────────────────────────────────  ││
│ │  = RECEITA BRUTA TOTAL ............... R$ 16.605,00 ││
│ │                                       ↑ 5% vs Dez   ││
│ │                                                     ││
│ │  (-) DEDUÇÕES                                       ││
│ │    Inadimplência ..................... (R$ 1.215,00)││
│ │  ─────────────────────────────────────────────────  ││
│ │  = RECEITA LÍQUIDA ................... R$ 15.390,00 ││
│ │                                                     ││
│ │  (-) DESPESAS OPERACIONAIS            [Expandir ] ││
│ │     Pessoal ......................... (R$ 3.500,00)││
│ │        Pró-labore ......... R$ 2.000,00            ││
│ │        INSS ............... R$ 1.100,00            ││
│ │        FGTS ...............   R$ 400,00            ││
│ │     Operação ........................ (R$ 3.850,00)││
│ │     Tributos ........................ (R$ 1.800,00)││
│ │     Administrativo .................. (R$ 1.300,00)││
│ │  ─────────────────────────────────────────────────  ││
│ │  = DESPESAS TOTAIS .................. (R$ 10.450,00)││
│ │                                                     ││
│ │  ═════════════════════════════════════════════════  ││
│ │  = LUCRO OPERACIONAL .................. R$ 4.940,00 ││
│ │                                                     ││
│ │     Margem de Lucro: 32,1%                        ││
│ │                                                     ││
│ └─────────────────────────────────────────────────────┘│
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Análise por Veículo
```
┌─────────────────────────────────────────────────────────┐
│  Resultado por Veículo               Janeiro/2026    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │ Veículo      │ Receita  │ Despesas │ Lucro   │  %   ││
│ ├──────────────┼──────────┼──────────┼─────────┼──────┤│
│ │  ABC-1234  │ R$ 6.075 │ R$ 3.200 │ R$ 2.875│ 47%  ││
│ │  DEF-5678  │ R$ 5.670 │ R$ 3.100 │ R$ 2.570│ 45%  ││
│ │  GHI-9012  │ R$ 4.860 │ R$ 4.150 │ R$  710│ 14%  ││
│ └──────────────┴──────────┴──────────┴─────────┴──────┘│
│                                                         │
│   GHI-9012 com margem baixa - verificar despesas     │
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │  Detalhes: Van ABC-1234                    [Fechar] ││
│ │  ───────────────────────────────────────────────────││
│ │                                                     ││
│ │   Indicadores                                     ││
│ │  • Alunos: 15                                       ││
│ │  • Ocupação: 94% (15/16)                           ││
│ │  • Receita/aluno: R$ 405,00                        ││
│ │  • Custo/aluno: R$ 213,33                          ││
│ │  • Lucro/aluno: R$ 191,67                          ││
│ │                                                     ││
│ │  💸 Despesas do Veículo                             ││
│ │  • Combustível: R$ 1.450,00                        ││
│ │  • Manutenção: R$ 850,00                           ││
│ │  • Seguro: R$ 350,00                               ││
│ │  • Lavagem: R$ 150,00                              ││
│ │  • Outros: R$ 400,00                               ││
│ │                                                     ││
│ └─────────────────────────────────────────────────────┘│
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Projeção Financeira
```
┌─────────────────────────────────────────────────────────┐
│ 🔮 Projeção Financeira                  Próx. 3 meses  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Baseado em: 45 contratos ativos | Ticket médio: R$410 │
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │           │  Fev/26   │  Mar/26   │  Abr/26        ││
│ ├───────────┼───────────┼───────────┼────────────────┤│
│ │ Receita   │ R$ 17.528 │ R$ 17.528 │ R$ 17.528      ││
│ │ Despesas  │ R$ 10.700 │ R$ 10.700 │ R$ 11.200*     ││
│ │ Lucro     │ R$ 6.828  │ R$ 6.828  │ R$ 6.328       ││
│ │ Margem    │ 39%       │ 39%       │ 36%            ││
│ └───────────┴───────────┴───────────┴────────────────┘│
│                                                         │
│  * Abril: IPVA parcela prevista                        │
│                                                         │
│   Cenários                                            │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Otimista (inadimpl. 2%):  Lucro R$ 7.350/mês   │   │
│  │ Realista (inadimpl. 5%):  Lucro R$ 6.828/mês   │   │
│  │ Pessimista (inadimpl. 10%): Lucro R$ 5.883/mês │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│   Atenção: 3 contratos vencem em Mar/26              │
│     Impacto se não renovar: -R$ 1.230/mês              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```
