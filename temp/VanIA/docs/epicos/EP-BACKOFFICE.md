# EP-BACKOFFICE - Web Backoffice Administrativo

## Objetivo do Épico

Desenvolver aplicação web para administração da plataforma, incluindo aprovação de motoristas, gestão de usuários, finanças, suporte e monitoramento do marketplace.

---

## Arquitetura do Backoffice

```
┌─────────────────────────────────────────────────────────────────┐
│                         WEB BACKOFFICE                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                      MÓDULOS                              │   │
│  ├──────────────────────────────────────────────────────────┤   │
│  │                                                           │   │
│  │   Dashboard        │  Métricas e KPIs em tempo real    │   │
│  │   Motoristas       │  Aprovação, gestão, documentos     │   │
│  │   Responsáveis   │  Gestão de pais e alunos          │   │
│  │   Solicitações     │  Monitoramento do marketplace      │   │
│  │   Contratos        │  Gestão de contratos ativos        │   │
│  │   Financeiro       │  Pagamentos, repasses, taxas       │   │
│  │   Moderação       │  Chat, avaliações, denúncias       │   │
│  │   Suporte          │  Tickets e atendimento             │   │
│  │   Configurações   │  Parâmetros do sistema             │   │
│  │   Relatórios       │  Analytics e exportações           │   │
│  │                                                           │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  PERFIS DE ACESSO:                                              │
│  ├── Super Admin: Acesso total                                  │
│  ├── Admin: Gestão operacional                                  │
│  ├── Financeiro: Apenas módulo financeiro                       │
│  ├── Suporte: Tickets e moderação                               │
│  └── Visualizador: Apenas consultas                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Histórias de Usuário

### US-BO-01 - Dashboard Principal

**Como** administrador  
**Quero** ver um dashboard com métricas principais  
**Para** acompanhar a saúde do marketplace

#### Layout do Dashboard

```
┌─────────────────────────────────────────────────────────────────┐
│   VanIA Admin                               Admin      │
├─────────────────────────────────────────────────────────────────┤
│   Dashboard      Período: [Últimos 30 dias ]   [Atualizar] │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐   │
│  │  2.341   │ │  187     │ │  56      │ │  R$127k  │   │
│  │ Pais       │ │ Motoristas │ │ Solicita.  │ │ GMV/mês    │   │
│  │ ↑ 12%      │ │ ↑ 8%       │ │ ativas     │ │ ↑ 15%      │   │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘   │
│                                                                  │
│  ┌────────────────────────────┐ ┌────────────────────────────┐  │
│  │  Funil de Conversão      │ │  Contratos Ativos        │  │
│  │                            │ │                            │  │
│  │ Solicitações:    100%      │ │         ┌─────────┐        │  │
│  │ Com ofertas:      72%      │ │         │  1.856  │        │  │
│  │ Match:            45%      │ │         │contratos│        │  │
│  │ Contrato ativo:   38%      │ │         └─────────┘        │  │
│  │                            │ │                            │  │
│  │ [Ver detalhes]             │ │  +124 este mês             │  │
│  └────────────────────────────┘ └────────────────────────────┘  │
│                                                                  │
│  ┌────────────────────────────┐ ┌────────────────────────────┐  │
│  │  Pendências              │ │  Alertas Recentes        │  │
│  │                            │ │                            │  │
│  │ • 12 motoristas aguardando │ │ • Pico de solicitações     │  │
│  │ • 5 denúncias não lidas    │ │ • 3 pagamentos falharam    │  │
│  │ • 8 tickets de suporte     │ │ • Motorista doc. expirando │  │
│  │                            │ │                            │  │
│  │ [Ver todas]                │ │ [Ver todos]                │  │
│  └────────────────────────────┘ └────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Receita dos Últimos 30 Dias                           │   │
│  │                                                           │   │
│  │     ▁▂▃▅▆▇▇▆▅▃▂▁▂▃▅▆▇▇▆▅▃                         │   │
│  │   Jan           Fev           Mar                        │   │
│  │                                                           │   │
│  │   Total: R$ 127.450,00   Taxa: R$ 6.372,50              │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Métricas do Dashboard

| Métrica | Descrição | Atualização |
|---------|-----------|-------------|
| Total de Pais | Usuários tipo responsável ativos | Tempo real |
| Total de Motoristas | Motoristas aprovados e ativos | Tempo real |
| Solicitações Ativas | Solicitações aguardando match | Tempo real |
| GMV Mensal | Volume bruto de transações | Diária |
| Contratos Ativos | Contratos com status ativo | Tempo real |
| Funil de Conversão | % de cada etapa | Diária |
| Receita (Taxa) | 5% das transações | Diária |

#### Critérios de Aceitação

- [ ] **CA01** - Cards de métricas principais
- [ ] **CA02** - Gráfico de funil de conversão
- [ ] **CA03** - Gráfico de receita temporal
- [ ] **CA04** - Lista de pendências
- [ ] **CA05** - Alertas do sistema
- [ ] **CA06** - Filtro por período
- [ ] **CA07** - Atualização em tempo real

---

### US-BO-02 - Gestão de Motoristas

**Como** administrador  
**Quero** gerenciar motoristas na plataforma  
**Para** aprovar, monitorar e suspender quando necessário

#### Lista de Motoristas

```
┌─────────────────────────────────────────────────────────────────┐
│   VanIA Admin                               Admin      │
├─────────────────────────────────────────────────────────────────┤
│   Motoristas                                                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   Buscar motorista...                                         │
│                                                                  │
│  Filtros: [Status ] [Região ] [Escola ] [Ordenar ]         │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │ [Aguardando: 12] [Ativos: 175] [Suspensos: 8] [Todos: 195]│ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ ☐ │ Foto │ Nome           │ Status    │ Alunos │ Ações   │   │
│  ├──────────────────────────────────────────────────────────┤   │
│  │ ☐ │    │ Carlos Silva   │  Ativo  │ 14/16  │ ⋮      │   │
│  │   │      │  4.9 (127)   │           │        │         │   │
│  │   │      │ São Paulo - SP  │           │        │         │   │
│  ├──────────────────────────────────────────────────────────┤   │
│  │ ☐ │    │ Maria Santos   │  Aguard │ -      │ ⋮      │   │
│  │   │      │ Documentos     │           │        │         │   │
│  │   │      │ São Paulo - SP  │           │        │         │   │
│  ├──────────────────────────────────────────────────────────┤   │
│  │ ☐ │    │ Pedro Oliveira │  Suspen │ 8/16   │ ⋮      │   │
│  │   │      │ Doc. vencido   │           │        │         │   │
│  │   │      │ Guarulhos - SP  │           │        │         │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  Mostrando 1-20 de 195           [< Anterior] [1] [2] [Próx >]  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Detalhes do Motorista

```
┌─────────────────────────────────────────────────────────────────┐
│  ← Voltar                          Carlos Silva                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │                      Carlos Silva                          ││
│  │  [Foto]                4.9 (127 avaliações)               ││
│  │                         Ativo desde: 15/03/2024           ││
│  │                                                              ││
│  │  [ Editar] [🚫 Suspender] [ Enviar Msg] [ Excluir]    ││
│  └─────────────────────────────────────────────────────────────┘│
│                                                                  │
│  [Dados Pessoais] [Documentos] [Veículo] [Alunos] [Financeiro]  │
│                                                                  │
│  ═══════════════════════════════════════════════════════════════│
│                                                                  │
│   Dados Pessoais                                              │
│  ────────────────────────────────────────────────────────────── │
│  Nome:         Carlos Roberto da Silva                          │
│  CPF:          123.456.789-00                                   │
│  Telefone:     (11) 99999-8888                                  │
│  E-mail:       carlos@email.com                                 │
│  Endereço:     R. das Flores, 123 - São Paulo/SP                │
│                                                                  │
│   Documentos                                                  │
│  ────────────────────────────────────────────────────────────── │
│  CNH:           Válida até 15/08/2026  [Ver]                  │
│  Antecedentes:  Verificado em 10/01/2026  [Ver]               │
│  Seguro:        Válido até 20/12/2026  [Ver]                  │
│  Alvará:        Vence em 15 dias  [Ver]                       │
│  Vistoria:      Válida até 30/06/2026  [Ver]                  │
│                                                                  │
│   Veículo                                                     │
│  ────────────────────────────────────────────────────────────── │
│  Modelo:       Renault Master 2022                              │
│  Placa:        ABC-1234                                         │
│  Capacidade:   16 passageiros                                   │
│  [Ver fotos]                                                    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Listar motoristas com filtros
- [ ] **CA02** - Buscar por nome, CPF, placa
- [ ] **CA03** - Ver detalhes completos
- [ ] **CA04** - Ver e aprovar documentos
- [ ] **CA05** - Suspender motorista
- [ ] **CA06** - Reativar motorista
- [ ] **CA07** - Enviar mensagem
- [ ] **CA08** - Ver histórico de ações

---

### US-BO-03 - Aprovação de Motoristas

**Como** administrador  
**Quero** aprovar novos motoristas  
**Para** garantir qualidade e segurança

#### Fila de Aprovação

```
┌─────────────────────────────────────────────────────────────────┐
│   VanIA Admin                                              │
├─────────────────────────────────────────────────────────────────┤
│   Aprovação de Motoristas                    [12 pendentes]    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Maria Santos                      Cadastro: 08/02/2026│   │
│  │    São Paulo - SP                                        │   │
│  │                                                          │   │
│  │    Progresso:  80%                   │   │
│  │                                                          │   │
│  │     Dados pessoais                                     │   │
│  │     CNH verificada                                     │   │
│  │     Antecedentes OK                                    │   │
│  │     Aguardando vistoria                                │   │
│  │     Seguro ativo                                       │   │
│  │                                                          │   │
│  │    [Analisar Cadastro]                                   │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  João Pereira                      Cadastro: 07/02/2026│   │
│  │    Guarulhos - SP                                        │   │
│  │                                                          │   │
│  │    Progresso:  100%                  │   │
│  │                                                          │   │
│  │     Todos os documentos verificados                    │   │
│  │                                                          │   │
│  │    [Aprovar] [Reprovar] [Solicitar Correção]            │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Checklist de Aprovação

```
┌─────────────────────────────────────────────────────────────────┐
│  Análise de Cadastro: João Pereira                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   CHECKLIST DE APROVAÇÃO                                      │
│                                                                  │
│  ☑️ 1. DADOS PESSOAIS                                           │
│     ├── Nome confere com documento                              │
│     ├── CPF válido                                              │
│     └── Endereço verificável                                    │
│                                                                  │
│  ☑️ 2. CNH                                                      │
│     ├── Categoria D ou E                                        │
│     ├── Dentro da validade                                      │
│     ├── Foto confere com selfie                                 │
│     └── Sem restrições                                          │
│                                                                  │
│  ☑️ 3. ANTECEDENTES                                             │
│     ├── Certidão negativa federal                               │
│     ├── Certidão negativa estadual                              │
│     └── Sem impedimentos                                        │
│                                                                  │
│  ☑️ 4. VEÍCULO                                                  │
│     ├── CRLV em dia                                             │
│     ├── Ano máximo 15 anos                                      │
│     ├── Capacidade informada correta                            │
│     ├── Fotos adequadas                                         │
│     └── Adesivo escolar visível                                 │
│                                                                  │
│  ☑️ 5. DOCUMENTOS COMPLEMENTARES                                │
│     ├── Alvará municipal válido                                 │
│     ├── Seguro de passageiros ativo                             │
│     └── Curso de transporte escolar                             │
│                                                                  │
│  ────────────────────────────────────────────────────────────── │
│                                                                  │
│  Observações:                                                    │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                                                          │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  [ Reprovar]  [ Solicitar Correção]  [ Aprovar]           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Listar cadastros pendentes
- [ ] **CA02** - Ver progresso do cadastro
- [ ] **CA03** - Verificar cada documento
- [ ] **CA04** - Aprovar cadastro completo
- [ ] **CA05** - Reprovar com motivo
- [ ] **CA06** - Solicitar correção específica
- [ ] **CA07** - Notificar motorista automaticamente
- [ ] **CA08** - Histórico de aprovações

#### Regras de Negócio

- **RN01** - Só pode aprovar se 100% completo
- **RN02** - Reprovação requer motivo obrigatório
- **RN03** - Motorista pode corrigir e reenviar
- **RN04** - SLA de aprovação: 48h úteis

---

### US-BO-04 - Gestão de Responsáveis (Pais)

**Como** administrador  
**Quero** gerenciar pais/responsáveis  
**Para** resolver problemas e monitorar uso

#### Critérios de Aceitação

- [ ] **CA01** - Listar responsáveis
- [ ] **CA02** - Buscar por nome, CPF, telefone
- [ ] **CA03** - Ver detalhes e filhos
- [ ] **CA04** - Ver contratos ativos
- [ ] **CA05** - Ver histórico de pagamentos
- [ ] **CA06** - Bloquear/desbloquear conta
- [ ] **CA07** - Enviar comunicação

---

### US-BO-05 - Monitoramento de Solicitações

**Como** administrador  
**Quero** monitorar solicitações do marketplace  
**Para** identificar problemas e oportunidades

#### Dashboard de Solicitações

```
┌─────────────────────────────────────────────────────────────────┐
│   Monitoramento de Solicitações                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐   │
│  │ 56         │ │ 42         │ │ 23         │ │ 15         │   │
│  │ Ativas     │ │ Com ofertas│ │ Sem ofertas│ │ Expiradas  │   │
│  │ (hoje)     │ │            │ │ (>24h)     │ │ (semana)   │   │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘   │
│                                                                  │
│   ALERTAS                                                     │
│  ────────────────────────────────────────────────────────────── │
│  • 23 solicitações sem oferta há mais de 24h                    │
│  • 5 escolas sem motoristas cadastrados                         │
│  • Região Norte com deficit de motoristas                       │
│                                                                  │
│   MAPA DE CALOR                                               │
│  ────────────────────────────────────────────────────────────── │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                                                          │   │
│  │              [MAPA COM CONCENTRAÇÃO DE                   │   │
│  │               SOLICITAÇÕES POR REGIÃO]                   │   │
│  │                                                          │   │
│  │     Alta demanda    Média    Baixa                 │   │
│  │                                                          │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│   SOLICITAÇÕES SEM OFERTA (>24h)                              │
│  ────────────────────────────────────────────────────────────── │
│  │ ID    │ Escola          │ Região      │ Há     │ Ação    │   │
│  │ #1234 │ Colégio ABC     │ Zona Norte  │ 3 dias │ [Ver]   │   │
│  │ #1235 │ Escola XYZ      │ Centro      │ 2 dias │ [Ver]   │   │
│  │ #1236 │ Colégio DEF     │ Zona Sul    │ 1 dia  │ [Ver]   │   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Dashboard de solicitações
- [ ] **CA02** - Alertas de solicitações sem oferta
- [ ] **CA03** - Mapa de calor por região
- [ ] **CA04** - Identificar gaps de cobertura
- [ ] **CA05** - Listar solicitações problemáticas
- [ ] **CA06** - Contatar pai para ajudar

---

### US-BO-06 - Gestão de Contratos

**Como** administrador  
**Quero** gerenciar contratos ativos  
**Para** resolver disputas e monitorar operação

#### Critérios de Aceitação

- [ ] **CA01** - Listar todos os contratos
- [ ] **CA02** - Filtrar por status
- [ ] **CA03** - Ver detalhes do contrato
- [ ] **CA04** - Cancelar contrato (excepcional)
- [ ] **CA05** - Ajustar valor (excepcional)
- [ ] **CA06** - Histórico de alterações

---

### US-BO-07 - Módulo Financeiro

**Como** administrador financeiro  
**Quero** gerenciar as finanças da plataforma  
**Para** acompanhar receitas e repasses

#### Dashboard Financeiro

```
┌─────────────────────────────────────────────────────────────────┐
│   Financeiro                          Fevereiro 2026        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐   │
│  │ R$ 127.450 │ │ R$ 6.372   │ │ R$ 118.230 │ │ R$ 8.450   │   │
│  │ GMV        │ │ Taxa (5%)  │ │ Repassado  │ │ Pendente   │   │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘   │
│                                                                  │
│  [Transações] [Repasses] [Inadimplência] [Reembolsos]           │
│                                                                  │
│  ═══════════════════════════════════════════════════════════════│
│                                                                  │
│   TRANSAÇÕES RECENTES                                         │
│  ────────────────────────────────────────────────────────────── │
│  │ Data  │ Pai         │ Motorista   │ Valor  │ Taxa  │ Status│ │
│  │ 10/02 │ Maria S.    │ Carlos S.   │ R$380  │ R$19  │     │ │
│  │ 10/02 │ João P.     │ Ana L.      │ R$420  │ R$21  │     │ │
│  │ 10/02 │ Pedro M.    │ José O.     │ R$350  │ R$17  │     │ │
│  │ 09/02 │ Ana C.      │ Maria S.    │ R$400  │ R$20  │     │ │
│                                                                  │
│  [Exportar CSV]  [Exportar PDF]                                 │
│                                                                  │
│  ────────────────────────────────────────────────────────────── │
│                                                                  │
│   RECEITA POR MÊS                                             │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │      ▁▂▃▅▆▇                                            │   │
│  │    Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec       │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Gestão de Repasses

```
┌─────────────────────────────────────────────────────────────────┐
│  💸 Repasses para Motoristas                                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  [Pendentes: 45] [Agendados: 23] [Realizados: 156] [Todos]      │
│                                                                  │
│  ────────────────────────────────────────────────────────────── │
│                                                                  │
│   PENDENTES DE REPASSE                                        │
│                                                                  │
│  │ Motorista     │ Valor     │ Pagto em   │ Repasse em │ Ação │ │
│  │ Carlos Silva  │ R$ 2.280  │ 10/02      │ 12/02      │ [️] │ │
│  │ Maria Santos  │ R$ 1.890  │ 10/02      │ 12/02      │ [️] │ │
│  │ Pedro Oliveira│ R$ 3.150  │ 09/02      │ 11/02      │ [️] │ │
│                                                                  │
│  [Executar Repasses do Dia]                                     │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Dashboard financeiro
- [ ] **CA02** - Listar transações
- [ ] **CA03** - Filtrar por período, status
- [ ] **CA04** - Ver detalhes da transação
- [ ] **CA05** - Gerenciar repasses
- [ ] **CA06** - Executar repasses manualmente
- [ ] **CA07** - Processar reembolsos
- [ ] **CA08** - Relatório de inadimplência
- [ ] **CA09** - Exportar relatórios

---

### US-BO-08 - Moderação de Conteúdo

**Como** moderador  
**Quero** moderar chats e avaliações  
**Para** manter ambiente seguro

#### Fila de Moderação

```
┌─────────────────────────────────────────────────────────────────┐
│   Moderação                              [8 pendentes]        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  [Denúncias: 5] [Avaliações: 12] [Chats: 3]                     │
│                                                                  │
│  ═══════════════════════════════════════════════════════════════│
│                                                                  │
│  🚨 DENÚNCIAS RECENTES                                          │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  10/02 14:30   │   Tipo: Comportamento inadequado      │   │
│  │                                                          │   │
│  │ Denunciante: Maria Silva (Responsável)                   │   │
│  │ Denunciado: João Pereira (Motorista)                     │   │
│  │                                                          │   │
│  │ Descrição:                                               │   │
│  │ "O motorista chegou atrasado 3 vezes essa semana e       │   │
│  │ não responde mensagens..."                               │   │
│  │                                                          │   │
│  │ [Ver Conversa]  [Ver Histórico]                          │   │
│  │                                                          │   │
│  │ [Arquivar]  [Advertir]  [Suspender Motorista]           │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  10/02 11:15   │   Tipo: Tentativa de bypass           │   │
│  │                                                          │   │
│  │ Chat detectou tentativa de compartilhar telefone         │   │
│  │ Usuário: Pedro Oliveira (Motorista)                      │   │
│  │                                                          │   │
│  │ Mensagem bloqueada:                                      │   │
│  │ "Me liga no 11 9****-****"                              │   │
│  │                                                          │   │
│  │ [Ignorar]  [Advertir]  [Bloquear Usuário]               │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Listar denúncias
- [ ] **CA02** - Ver detalhes da denúncia
- [ ] **CA03** - Acessar conversa do chat
- [ ] **CA04** - Aplicar advertência
- [ ] **CA05** - Suspender usuário
- [ ] **CA06** - Moderar avaliações
- [ ] **CA07** - Aprovar/rejeitar comentários
- [ ] **CA08** - Histórico de moderação

---

### US-BO-09 - Suporte ao Cliente

**Como** atendente de suporte  
**Quero** gerenciar tickets de atendimento  
**Para** resolver problemas dos usuários

#### Sistema de Tickets

```
┌─────────────────────────────────────────────────────────────────┐
│   Suporte                               [15 tickets abertos]   │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  [Novos: 5] [Em andamento: 8] [Aguardando: 2] [Resolvidos]      │
│                                                                  │
│  ═══════════════════════════════════════════════════════════════│
│                                                                  │
│   TICKETS ABERTOS                                             │
│                                                                  │
│  │ #  │ Assunto              │ Usuário    │ Prioridade │ Tempo │ │
│  │ 142│ Pagamento duplicado  │ Maria S.   │  Alta    │ 2h    │ │
│  │ 141│ Não consigo rastrear │ João P.    │  Média   │ 4h    │ │
│  │ 140│ Motorista não aparece│ Ana L.     │  Média   │ 6h    │ │
│  │ 139│ Como cancelar?       │ Pedro M.   │  Baixa   │ 1d    │ │
│                                                                  │
│  ────────────────────────────────────────────────────────────── │
│                                                                  │
│   TICKET #142                                                 │
│                                                                  │
│  Assunto: Pagamento duplicado                                   │
│  Usuário: Maria Silva (maria@email.com)                         │
│  Criado: 10/02/2026 10:30                                       │
│  Prioridade:  Alta                                            │
│                                                                  │
│  ────────────────────────────────────────────────────────────── │
│                                                                  │
│  Maria Silva (10/02 10:30):                                     │
│  "Fui cobrada duas vezes na mensalidade de fevereiro.           │
│   Podem verificar?"                                             │
│                                                                  │
│  Sistema (10/02 10:31):                                         │
│  "Ticket recebido. Tempo estimado de resposta: 2 horas."        │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ Responder...                                             │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  [Escalonar]  [Transferir]  [Resolver]                          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Listar tickets
- [ ] **CA02** - Filtrar por status, prioridade
- [ ] **CA03** - Ver detalhes e histórico
- [ ] **CA04** - Responder ticket
- [ ] **CA05** - Escalonar para nível 2
- [ ] **CA06** - Resolver e fechar
- [ ] **CA07** - Templates de resposta
- [ ] **CA08** - SLA por prioridade

---

### US-BO-10 - Configurações do Sistema

**Como** super administrador  
**Quero** configurar parâmetros do sistema  
**Para** ajustar o funcionamento da plataforma

#### Parâmetros Configuráveis

| Categoria | Parâmetro | Valor Padrão |
|-----------|-----------|--------------|
| Financeiro | Taxa da plataforma | 5% |
| Financeiro | Prazo de repasse (dias) | 2 |
| Financeiro | Multa por atraso | 2% |
| Financeiro | Juros diário | 0.033% |
| Solicitações | Tempo de expiração (dias) | 7 |
| Solicitações | Máximo por pai | 3 |
| Ofertas | Valor mínimo | R$ 150 |
| Ofertas | Máximo de edições | 3 |
| Contrato | Período de teste (dias) | 7 |
| Contrato | Dias para suspensão | 15 |
| Contrato | Dias para cancelamento | 30 |
| Motorista | Idade máxima veículo | 15 anos |
| Motorista | Distância máxima rota | 3 km |

#### Critérios de Aceitação

- [ ] **CA01** - Editar parâmetros financeiros
- [ ] **CA02** - Editar parâmetros de solicitações
- [ ] **CA03** - Editar parâmetros de contratos
- [ ] **CA04** - Histórico de alterações
- [ ] **CA05** - Requer confirmação de admin

---

### US-BO-11 - Relatórios e Analytics

**Como** administrador  
**Quero** gerar relatórios detalhados  
**Para** tomar decisões baseadas em dados

#### Tipos de Relatório

| Relatório | Descrição | Formato |
|-----------|-----------|---------|
| Financeiro Mensal | Receita, taxas, repasses | PDF, Excel |
| Conversão | Funil completo por período | PDF, Excel |
| Motoristas | Cadastros, aprovações, churn | PDF, Excel |
| Responsáveis | Aquisição, retenção | PDF, Excel |
| Regional | Performance por região | PDF, Excel |
| Inadimplência | Atrasos e recuperação | PDF, Excel |
| Satisfação | NPS, avaliações | PDF, Excel |

#### Critérios de Aceitação

- [ ] **CA01** - Gerar relatório financeiro
- [ ] **CA02** - Gerar relatório de conversão
- [ ] **CA03** - Gerar relatório por região
- [ ] **CA04** - Filtrar por período
- [ ] **CA05** - Exportar PDF e Excel
- [ ] **CA06** - Agendar envio automático

---

### US-BO-12 - Gestão de Usuários Admin

**Como** super administrador  
**Quero** gerenciar usuários do backoffice  
**Para** controlar acessos

#### Critérios de Aceitação

- [ ] **CA01** - Criar usuário admin
- [ ] **CA02** - Definir perfil de acesso
- [ ] **CA03** - Editar permissões
- [ ] **CA04** - Desativar usuário
- [ ] **CA05** - Resetar senha
- [ ] **CA06** - Log de acessos

---

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US-BO-01 | 8 | Alta |
| US-BO-02 | 8 | Alta |
| US-BO-03 | 8 | Alta |
| US-BO-04 | 5 | Alta |
| US-BO-05 | 5 | Alta |
| US-BO-06 | 5 | Média |
| US-BO-07 | 13 | Alta |
| US-BO-08 | 8 | Alta |
| US-BO-09 | 8 | Alta |
| US-BO-10 | 5 | Média |
| US-BO-11 | 8 | Média |
| US-BO-12 | 5 | Alta |
| **Total** | **86** | |

---

## Stack Tecnológica

```
┌─────────────────────────────────────────────────────────────┐
│                    WEB BACKOFFICE STACK                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  FRONTEND:                                                   │
│  ├── Next.js 14+ (App Router)                               │
│  ├── React 18+                                              │
│  ├── TypeScript                                             │
│  ├── Tailwind CSS                                           │
│  ├── shadcn/ui (componentes)                                │
│  ├── TanStack Query (data fetching)                         │
│  ├── Zustand (estado global)                                │
│  ├── React Hook Form + Zod                                  │
│  ├── Recharts (gráficos)                                    │
│  └── React Table (tabelas)                                  │
│                                                              │
│  BACKEND:                                                    │
│  ├── API compartilhada com apps mobile                      │
│  ├── Endpoints específicos /admin/*                         │
│  └── Autenticação com roles                                 │
│                                                              │
│  AUTENTICAÇÃO:                                               │
│  ├── NextAuth.js                                            │
│  ├── JWT com refresh token                                  │
│  └── RBAC (Role-Based Access Control)                       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Wireframes Web

### Layout Principal

```
┌─────────────────────────────────────────────────────────────────┐
│   VanIA Admin                             Admin      │
├──────────────┬──────────────────────────────────────────────────┤
│              │                                                   │
│   Dashboard│                                                   │
│   Motoristas│        [ÁREA DE CONTEÚDO]                        │
│   Responsáveis│                                                │
│   Solicitações│                                                │
│   Contratos│                                                   │
│   Financeiro│                                                  │
│   Moderação│                                                   │
│   Suporte  │                                                   │
│   Relatórios│                                                  │
│   Config   │                                                   │
│              │                                                   │
│              │                                                   │
│              │                                                   │
│              │                                                   │
│              │                                                   │
├──────────────┴──────────────────────────────────────────────────┤
│  © 2026 VanIA                          v1.0.0               │
└─────────────────────────────────────────────────────────────────┘
```
