# VanIA - Visão Geral da Aplicação

## Índice

1. [O que é o VanIA?](#1-o-que-é-o-vania)
2. [Qual problema resolvemos?](#2-qual-problema-resolvemos)
3. [Para quem é a solução?](#3-para-quem-é-a-solução)
4. [Como funciona na prática?](#4-como-funciona-na-prática)
5. [Sistema de Rotas e Matching](#5-sistema-de-rotas-e-matching)
6. [Estrutura da Plataforma](#6-estrutura-da-plataforma)
7. [Funcionalidades Principais](#7-funcionalidades-principais)
8. [Arquitetura Técnica Simplificada](#8-arquitetura-técnica-simplificada)
9. [Modelo de Negócio](#9-modelo-de-negócio)
10. [Roadmap do Projeto](#10-roadmap-do-projeto)
11. [Métricas de Sucesso](#11-métricas-de-sucesso)
12. [Perguntas para Discussão](#12-perguntas-para-discussão)

---

## 1. O que é o VanIA?

O **VanIA** é uma plataforma digital (marketplace) que conecta **pais/responsáveis** a **motoristas de transporte escolar**, funcionando de forma similar ao inDrive, mas para contratação de van escolar.

### Em uma frase:
> "O VanIA usa inteligência artificial para conectar pais a motoristas de van escolar que já passam perto de suas casas — acabando com a 'invisibilidade mútua' que impede famílias e transportadores de se encontrarem."

### O Grande Diferencial:
> Pais não sabem que existe um motorista passando a 200 metros de casa todos os dias. Motoristas não sabem que há uma família precisando de transporte no trajeto que já fazem. O VanIA resolve isso com **matching inteligente baseado em geolocalização e rotas**.

### Componentes da Plataforma:

```
┌─────────────────────────────────────────────────────────────┐
│                          VANIA                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                   MATCHING INTELIGENTE                      │
│                   ────────────────────                      │
│         Motor de IA que cruza rotas de motoristas           │
│         com endereços de pais em tempo real                 │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   APP PAIS          APP MOTORISTA         BACKOFFICE        │
│   ────────          ─────────────         ──────────        │
│   • Ver vans        • Descobrir           • Aprovar         │
│     próximas          demandas              motoristas      │
│   • Receber         • Enviar              • Financeiro      │
│     sugestões         propostas           • Relatórios      │
│   • Aceitar         • Gerenciar           • Analytics       │
│     ofertas           alunos                                │
│   • Pagar           • Otimizar                              │
│     mensalidade       rotas                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Qual problema resolvemos?

### Dores dos Pais/Responsáveis:
| Problema Atual | Como o VanIA resolve |
|----------------|--------------------------|
| Não saber se existe van que passe perto de casa | Matching inteligente que conecta pais a motoristas com rotas próximas ao endereço, mesmo que nenhum dos dois saiba da existência do outro |
| Dificuldade em encontrar motoristas confiáveis | Motoristas verificados com documentação validada |
| Não saber onde está o filho durante o trajeto | Rastreamento em tempo real no app |
| Falta de transparência nos preços | Comparação de ofertas lado a lado |
| Comunicação difícil com o motorista | Chat integrado na plataforma |
| Pagamentos desorganizados | Pagamento digital com histórico |

### Dores dos Motoristas:
| Problema Atual | Como o VanIA resolve |
|----------------|--------------------------|
| Não saber que existem famílias precisando de transporte no trajeto que já faz | IA identifica automaticamente demandas compatíveis com suas rotas atuais, revelando oportunidades "invisíveis" |
| Dificuldade em preencher vagas ociosas na van | Sugestões proativas de famílias próximas às rotas existentes |
| Rotas ineficientes com muitos desvios | Otimização inteligente agrupando alunos por proximidade geográfica |
| Gestão manual de pagamentos | Recebimento automático via plataforma |
| Comunicação fragmentada (WhatsApp) | Tudo centralizado no app |

---

## 3. Para quem é a solução?

### Personas Principais:

```
┌──────────────────────────────────────────────────────────────────┐
│                                                                  │
│   RESPONSÁVEL                        MOTORISTA                   │
│   ───────────                        ─────────                   │
│   • Pais e mães                      • Profissional autônomo     │
│   • Tutores legais                   • Cooperativado             │
│   • Avós responsáveis                • Funcionário de empresa    │
│                                                                  │
│   NECESSIDADES:                      NECESSIDADES:               │
│   • Segurança do filho               • Captar clientes           │
│   • Praticidade                      • Organizar financeiro      │
│   • Confiança no motorista           • Gestão de alunos          │
│   • Bom custo-benefício              • Profissionalização        │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### Mercado-Alvo Inicial:
- **Geografia:** RMBH
- **Perfil:** Famílias classe A/B/C/D com filhos em idade escolar
- **Escolas:** Particulares e públicas

---

## 4. Como funciona na prática?

### O Matching Inteligente - O Coracao do VanIA

```
┌─────────────────────────────────────────────────────────────────┐
│                  COMO O MATCHING FUNCIONA                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   DADOS DE ENTRADA:                                             │
│   ─────────────────                                             │
│                                                                 │
│   Motorista cadastra:            Responsavel cadastra:          │
│   • Rotas que ja faz              • Endereco de casa             │
│   • Escolas que atende            • Escola do filho              │
│   • Horarios de operacao          • Turno desejado               │
│   • Vagas disponiveis             • Necessidades especiais       │
│                                                                 │
│                            |                                    │
│                            v                                    │
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                  MOTOR DE INTELIGENCIA                    │   │
│   │                                                           │   │
│   │  • Analise de proximidade geografica (raio em km)         │   │
│   │  • Compatibilidade de rotas (desvio minimo)               │   │
│   │  • Match de escola + turno                                │   │
│   │  • Score de compatibilidade (0-100%)                      │   │
│   │  • Estimativa de impacto na rota atual                    │   │
│   │                                                           │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│                            |                                    │
│                            v                                    │
│                                                                 │
│   RESULTADO:                                                    │
│   ──────────                                                    │
│                                                                 │
│   Motorista recebe:              Responsavel recebe:            │
│   "Familia a 300m da sua rota    "3 motoristas ja passam        │
│    precisa de transporte para     perto da sua casa indo        │
│    a Escola Sao Paulo - manha"    para a escola do seu filho"   │
│                                                                 │
│   --> Ambos descobrem oportunidades que antes eram INVISIVEIS   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Cenario Real - A Magica do Matching:

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   ANTES DO VANIA:                                               │
│   ───────────────                                               │
│                                                                 │
│   [Casa da Maria] ---------------------------> [Escola]         │
│        |                                                        │
│        |  (Maria nao sabe que o Joao passa aqui todo dia)       │
│        |                                                        │
│   [Rota do Joao] -----+                                         │
│        (Joao nao sabe  |                                        │
│         que a Maria    +----------------------> [Escola]        │
│         precisa de                                              │
│         transporte)                                             │
│                                                                 │
│   [X] Resultado: Maria procura van e nao encontra               │
│   [X] Resultado: Joao tem 2 vagas ociosas na van                │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   COM O VANIA:                                                  │
│   ────────────                                                  │
│                                                                 │
│   [Casa da Maria] -----[VANIA]---------------> [Escola]         │
│        |                  |                                     │
│        |    +-------------+                                     │
│        |    |  VanIA detecta:                                   │
│        |    |  "Maria esta a 200m                               │
│        |    |   da rota do Joao"                                │
│        |    |                                                   │
│   [Rota do Joao] -----+----------------------> [Escola]         │
│                       |                                         │
│                       +---> Notifica ambos!                     │
│                                                                 │
│   [OK] Resultado: Maria recebe sugestao do Joao                 │
│   [OK] Resultado: Joao descobre demanda na sua rota             │
│   [OK] Resultado: Contrato fechado com desvio de apenas 200m    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Jornada Completa - Do Cadastro ao Transporte:

```
                           JORNADA DO USUÁRIO
                           
    ┌─────────────────────────────────────────────────────────────┐
    │                                                             │
    │  FASE 1: CADASTRO                                           │
    │  ─────────────────                                          │
    │                                                             │
    │  [Responsável]              [Motorista]                     │
    │       │                          │                          │
    │                                                           │
    │  Baixa o app              Baixa o app                       │
    │       │                          │                          │
    │                                                           │
    │  Cadastra dados           Cadastra dados                    │
    │       │                          │                          │
    │                                                           │
    │  Cadastra filho(s)        Envia documentos                  │
    │       │                    (CNH, veículo, etc)              │
    │       │                          │                          │
    │       │                                                    │
    │       │                   Aguarda aprovação ──── BACKOFFICE│
    │       │                          │                    │     │
    │       │                          ────────────────────┘     │
    │       │                          │                          │
    │                                                           │
    │   Pronto!                Aprovado!                       │
    │                                                             │
    └─────────────────────────────────────────────────────────────┘
    
    ┌─────────────────────────────────────────────────────────────┐
    │                                                             │
    │  FASE 2: CONTRATAÇÃO (Modelo Marketplace)                   │
    │  ─────────────────────────────────────────                  │
    │                                                             │
    │  [Responsável]                              [Motorista]     │
    │       │                                          │          │
    │                                                 │          │
    │  Cria SOLICITAÇÃO                                │          │
    │  • Escola do filho                               │          │
    │  • Endereço de embarque                          │          │
    │  • Turno (manhã/tarde)                           │          │
    │       │                                          │          │
    │                                                 │          │
    │  Solicitação fica visível ──────────────────────│          │
    │  para motoristas da região                       │          │
    │       │                                                    │
    │       │                                   Vê solicitação    │
    │       │                                          │          │
    │       │                                                    │
    │       │─────────────────────────────── Envia OFERTA        │
    │       │                                   • Valor mensal    │
    │                                          • Mensagem        │
    │  Recebe notificação                                         │
    │       │                                                     │
    │                                                            │
    │  Avalia ofertas                                             │
    │  (pode receber várias)                                      │
    │       │                                                     │
    │                                                            │
    │   Negocia via CHAT                                        │
    │       │                                                     │
    │                                                            │
    │   ACEITA uma oferta                                       │
    │       │                                                     │
    │                                                            │
    │  CONTRATO gerado automaticamente                            │
    │                                                             │
    └─────────────────────────────────────────────────────────────┘
    
    ┌─────────────────────────────────────────────────────────────┐
    │                                                             │
    │  FASE 3: OPERAÇÃO DIÁRIA                                    │
    │  ─────────────────────────                                  │
    │                                                             │
    │  [Responsável]                              [Motorista]     │
    │       │                                          │          │
    │       │                                                    │
    │       │                                   Inicia ROTA       │
    │       │                                          │          │
    │       │─────── GPS em tempo real ──────────────┤           │
    │       │                                          │          │
    │                                                           │
    │  Acompanha no mapa                        Registra embarque │
    │       │                                          │          │
    │       │─────── Notificação ────────────────────┤           │
    │       │         "João embarcou!"                 │          │
    │       │                                          │          │
    │       │                                                    │
    │       │                                   Registra chegada  │
    │       │                                   na escola         │
    │       │─────── Notificação ────────────────────┤           │
    │       │         "João chegou na escola!"         │          │
    │       │                                          │          │
    │       │                                                    │
    │       │                                   Finaliza rota     │
    │                                                             │
    └─────────────────────────────────────────────────────────────┘
    
    ┌─────────────────────────────────────────────────────────────┐
    │                                                             │
    │  FASE 4: PAGAMENTO MENSAL                                   │
    │  ──────────────────────────                                 │
    │                                                             │
    │  [Sistema]                [Responsável]        [Motorista]  │
    │       │                        │                    │       │
    │                               │                    │       │
    │  Gera cobrança                 │                    │       │
    │  (dia X do mês)                │                    │       │
    │       │                        │                    │       │
    │                                                   │       │
    │  Envia notificação ────── Recebe aviso            │        │
    │                                │                    │       │
    │                                                    │       │
    │                           Paga via                  │       │
    │                           PIX/Boleto/Cartão         │       │
    │                                │                    │       │
    │                               │                    │       │
    │  Processa pagamento ──────────┘                    │       │
    │       │                                             │       │
    │                                                    │       │
    │  Retém 5% (taxa)                                    │       │
    │       │                                             │       │
    │                                                           │
    │  Repassa 95% ─────────────────────────────── Recebe        │
    │                                                             │
    └─────────────────────────────────────────────────────────────┘
```

---

## 5. Sistema de Rotas e Matching

>  **Documentação técnica completa:** [REQUISITOS_ROTAS_MATCHING.md](REQUISITOS_ROTAS_MATCHING.md)

### Como o Motorista Cadastra suas Rotas

O motorista pode cadastrar suas rotas de duas formas:

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CADASTRO DE ROTAS                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   MODO SIMPLES (MVP)                 MODO AVANÇADO (Futuro)         │
│   ──────────────────                 ─────────────────────          │
│                                                                     │
│   Motorista informa:                 Motorista traça no mapa:       │
│   • Escola(s) que atende             • Ponto de partida             │
│   • Turno (manhã/tarde)              • Pontos de coleta atuais      │
│   • Bairros de atuação               • Trajeto completo             │
│   • Vagas disponíveis                • Escola de destino            │
│   • Horários                         • Sistema gera polilinha       │
│   • Valor sugerido                                                  │
│                                                                     │
│    Fácil e rápido                   Muito preciso               │
│    Menos preciso                    Mais trabalhoso             │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Como o Pai Encontra uma Van

```
┌─────────────────────────────────────────────────────────────────────┐
│                    FLUXO DE BUSCA DO RESPONSÁVEL                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│    PAI INFORMA:                                                   │
│      ┌─────────────────────────────────────────────────────────┐    │
│      │  Escola: Colégio Santo Agostinho                      │    │
│      │  Endereço: Rua das Acácias, 150 - Eldorado            │    │
│      │  Turno: Manhã                                         │    │
│      └─────────────────────────────────────────────────────────┘    │
│                               │                                     │
│                                                                    │
│    SISTEMA PROCESSA:                                              │
│      ┌─────────────────────────────────────────────────────────┐    │
│      │  Motor de Matching                                     │    │
│      │    • Filtra rotas por escola                            │    │
│      │    • Filtra por turno                                   │    │
│      │    • Calcula distância da casa até cada rota            │    │
│      │    • Aplica raio máximo (ex: 1km)                       │    │
│      │    • Calcula score de compatibilidade                   │    │
│      └─────────────────────────────────────────────────────────┘    │
│                               │                                     │
│                                                                    │
│    RESULTADO:                                                     │
│      ┌─────────────────────────────────────────────────────────┐    │
│      │ "3 vans encontradas para sua região!"                   │    │
│      │                                                         │    │
│      │  Carlos Silva     150m    4.8   R$ 480   2 vagas  │    │
│      │  Ana Oliveira     400m    4.9   R$ 450   1 vaga   │    │
│      │  Pedro Santos     750m    4.5   R$ 420   3 vagas  │    │
│      │                                                         │    │
│      │ [  Ver Perfil ]  [  Enviar Mensagem ]               │    │
│      └─────────────────────────────────────────────────────────┘    │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Algoritmo de Matching - Visão Simplificada

```
┌─────────────────────────────────────────────────────────────────────┐
│                    SCORE DE COMPATIBILIDADE                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   O sistema calcula um SCORE (0-100) para cada motorista:           │
│                                                                     │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │                                                             │   │
│   │   DISTÂNCIA (40%)     quanto mais perto, melhor             │   │
│   │      │   │
│   │                                                             │   │
│   │   AVALIAÇÃO (30%)     nota do motorista                     │   │
│   │      │   │
│   │                                                             │   │
│   │   DESVIO (20%)        km extras para buscar aluno           │   │
│   │      │   │
│   │                                                             │   │
│   │   VAGAS (10%)         mais vagas = mais interesse           │   │
│   │      │   │
│   │                                                             │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│   Exemplo: Motorista Carlos                                         │
│   • Distância: 150m → 38 pontos                                     │
│   • Avaliação: 4.8 → 29 pontos                                      │
│   • Desvio: 0.3km → 17 pontos                                       │
│   • Vagas: 2 → 4 pontos                                             │
│   • SCORE TOTAL: 88 pontos                                        │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Configurações do Matching

| Parâmetro | Valor Padrão | Descrição |
|-----------|--------------|-----------|
| Raio de busca | 1.000m | Distância máxima da casa do pai até a rota |
| Buffer da rota | 500m | Área de cobertura ao redor do trajeto |
| Máx. resultados | 20 | Limite de vans retornadas por busca |

---

## 6. Estrutura da Plataforma

### Três Aplicações Distintas:

| Aplicação | Tipo | Usuários | Propósito |
|-----------|------|----------|-----------|
| **App Pais** | Mobile (iOS/Android) | Pais e responsáveis | Buscar, contratar e acompanhar |
| **App Motorista** | Mobile (iOS/Android) | Motoristas | Receber demandas, gerenciar alunos |
| **Web Backoffice** | Web (Desktop) | Equipe VanIA | Administrar a plataforma |

### Visão das Telas Principais:

```
┌─────────────────────────────────────────────────────────────────┐
│                     APP PAIS - TELAS PRINCIPAIS                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │    HOME   │  │   FILHOS   │  │  OFERTAS  │              │
│  │             │  │             │  │             │              │
│  │ • Contratos │  │ • Lista     │  │ • Pendentes │              │
│  │   ativos    │  │ • Cadastrar │  │ • Comparar  │              │
│  │ • Próximas  │  │ • Editar    │  │ • Aceitar   │              │
│  │   cobranças │  │             │  │             │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   MAPA    │  │   CHAT     │  │   PAGAR   │              │
│  │             │  │             │  │             │              │
│  │ • Posição   │  │ • Conversas │  │ • Histórico │              │
│  │   da van    │  │ • Motorista │  │ • PIX       │              │
│  │ • ETA       │  │             │  │ • Boleto    │              │
│  │             │  │             │  │             │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                  APP MOTORISTA - TELAS PRINCIPAIS               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │    HOME   │  │  DEMANDAS │  │  ALUNOS   │               │
│  │             │  │             │  │             │              │
│  │ • Dashboard │  │ • Novas     │  │ • Lista     │              │
│  │ • Resumo    │  │ • Próximas  │  │ • Presenças │              │
│  │   financeiro│  │ • Enviar    │  │ • Contatos  │              │
│  │             │  │   oferta    │  │             │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   ROTA    │  │   FINANC.  │  │   DOCS    │              │
│  │             │  │             │  │             │              │
│  │ • Iniciar   │  │ • A receber │  │ • CNH       │              │
│  │ • Registrar │  │ • Recebidos │  │ • Veículo   │              │
│  │   presença  │  │ • Extrato   │  │ • Alvará    │              │
│  │             │  │             │  │             │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    WEB BACKOFFICE - MÓDULOS                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │   DASHBOARD                                            │   │
│  │  • KPIs principais (usuários, contratos, receita)        │   │
│  │  • Gráficos de tendência                                 │   │
│  │  • Alertas e pendências                                  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   USUÁRIOS│  │   MOTOR.  │  │   FINANC. │               │
│  │             │  │             │  │             │              │
│  │ • Listar    │  │ • Aprovar   │  │ • Transações│              │
│  │ • Bloquear  │  │ • Reprovar  │  │ • Repasses  │              │
│  │ • Detalhes  │  │ • Suspender │  │ • Relatórios│              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   CONTRAT.│  │   MODER.  │   │   SUPORTE │              │
│  │             │  │             │  │             │              │
│  │ • Ativos    │  │ • Denúncias │  │ • Tickets   │              │
│  │ • Cancelados│  │ • Avaliações│  │ • Chat      │              │
│  │ • Pendentes │  │ • Conflitos │  │ • FAQ       │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 7. Funcionalidades Principais

### Por Aplicação:

#### App Pais/Responsáveis

| Funcionalidade | Descrição | Prioridade |
|----------------|-----------|------------|
| Cadastro de filhos | Registrar dados, escola, turno, necessidades especiais | Alta |
| **Descoberta inteligente** | **Ver motoristas que já passam perto de casa automaticamente** | **Alta** |
| **Sugestões proativas** | **Receber notificações quando novo motorista compatível surgir** | **Alta** |
| Mapa de cobertura | Visualizar rotas de motoristas na região | Alta |
| Criar solicitação | Publicar necessidade de transporte | Alta |
| Receber ofertas | Ver propostas dos motoristas com score de compatibilidade | Alta |
| Aceitar/recusar ofertas | Escolher motorista | Alta |
| Chat com motorista | Comunicação direta | Alta |
| Rastreamento GPS | Ver localização da van em tempo real | Alta |
| Pagamento digital | PIX, boleto ou cartão | Alta |
| Histórico de pagamentos | Consultar comprovantes | Média |
| Avaliar motorista | Dar nota e comentário | Média |
| Notificações | Alertas de embarque, chegada, pagamento | Alta |

#### App Motorista

| Funcionalidade | Descrição | Prioridade |
|----------------|-----------|------------|
| Cadastro completo | Dados pessoais e profissionais | Alta |
| Upload de documentos | CNH, veículo, alvará, etc. | Alta |
| **Cadastro de rotas** | **Registrar trajetos que já faz (escolas, horários, pontos)** | **Alta** |
| **Descoberta de demandas** | **Ver famílias que precisam de transporte nas suas rotas** | **Alta** |
| **Sugestões de expansão** | **IA sugere novos alunos com mínimo desvio da rota atual** | **Alta** |
| **Simulador de rota** | **Ver impacto de adicionar novo aluno antes de aceitar** | **Alta** |
| Ver solicitações | Demandas da região filtradas por compatibilidade | Alta |
| Enviar ofertas | Propor valor e condições | Alta |
| Gerenciar alunos | Lista de crianças transportadas | Alta |
| Iniciar/finalizar rota | Controle de trajeto | Alta |
| Registrar presença | Marcar embarque/desembarque | Alta |
| Ver financeiro | Valores a receber e recebidos | Alta |
| Chat com responsável | Comunicação direta | Alta |
| Atualizar documentos | Renovar docs vencidos | Média |

#### Web Backoffice

| Funcionalidade | Descrição | Prioridade |
|----------------|-----------|------------|
| Dashboard | Visão geral da plataforma | Alta |
| Aprovar motoristas | Validar documentação | Alta |
| Gestão de usuários | Visualizar, bloquear, suporte | Alta |
| Financeiro | Transações, repasses, relatórios | Alta |
| Moderação | Denúncias e avaliações | Média |
| Configurações | Parâmetros do sistema | Média |
| Relatórios | Exportar dados, analytics | Média |

---

## 8. Arquitetura Técnica Simplificada

### Visão de Alto Nível:

```
┌─────────────────────────────────────────────────────────────────┐
│                    ARQUITETURA VANIA                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│        USUÁRIOS                                                  │
│        ────────                                                  │
│                                                                  │
│    App Pais     App Motorista     Backoffice              │
│        │              │                   │                      │
│        └──────────────┼───────────────────┘                      │
│                       │                                          │
│                                                                 │
│        ┌──────────────────────────────┐                         │
│        │      INTERNET (HTTPS)      │                         │
│        └──────────────────────────────┘                         │
│                       │                                          │
│                                                                 │
│        ┌──────────────────────────────┐                         │
│        │        API GATEWAY           │ ── Segurança, limites  │
│        └──────────────────────────────┘                         │
│                       │                                          │
│        ┌──────────────┼──────────────┬──────────────┐           │
│        │              │              │              │            │
│                                                              │
│   ┌─────────┐   ┌─────────┐   ┌──────────┐   ┌───────────┐      │
│   │  AUTH   │   │  API    │   │ MATCHING │   │ WEBSOCKET │      │
│   │ Service │   │  REST   │   │  ENGINE  │   │  (tempo   │      │
│   │         │   │         │   │        │   │   real)   │      │
│   │ • Login │   │ • CRUD  │   │ • Geo    │   │ • Chat    │      │
│   │ • Token │   │ • Lógica│   │ • Score  │   │ • GPS     │      │
│   │         │   │         │   │ • Routes │   │ • Alerts  │      │
│   └─────────┘   └─────────┘   └──────────┘   └───────────┘      │
│        │              │              │                           │
│        └──────────────┼──────────────┘                           │
│                       │                                          │
│        ┌──────────────┼──────────────┐                          │
│        │              │              │                           │
│                                                               │
│   ┌─────────┐   ┌─────────┐   ┌─────────────┐                   │
│   │PostgreSQL│  │  Redis  │   │  S3/Storage │                   │
│   │         │   │         │   │             │                   │
│   │ • Dados │   │ • Cache │   │ • Arquivos  │                   │
│   │ • Usuários│ │ • Sessões│  │ • Fotos     │                   │
│   │ • Contratos││ • Filas │   │ • Docs      │                   │
│   └─────────┘   └─────────┘   └─────────────┘                   │
│                                                                  │
│        INTEGRAÇÕES EXTERNAS                                      │
│        ────────────────────                                      │
│                                                                  │
│   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐        │
│   │  ASAAS  │   │ GOOGLE  │   │FIREBASE │   │ TWILIO  │        │
│   │         │   │  MAPS   │   │         │   │         │        │
│   │Pagamentos│  │  Mapas  │   │  Push   │   │  SMS    │        │
│   └─────────┘   └─────────┘   └─────────┘   └─────────┘        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Tecnologias Utilizadas:

| Camada | Tecnologia | Por que escolhemos? |
|--------|------------|---------------------|
| **Apps Mobile** | React Native + Expo | Um código para iOS e Android |
| **Web Backoffice** | Next.js + React | Moderno, rápido, SEO-friendly |
| **Backend/API** | Node.js + NestJS | JavaScript em todo stack, escalável |
| **Banco de Dados** | PostgreSQL + PostGIS | Robusto com suporte nativo a consultas geoespaciais |
| **Matching Engine** | Python + Scikit-learn | Algoritmos de ML para scoring e otimização de rotas |
| **Cache** | Redis + Redis Geo | Velocidade + busca por proximidade em tempo real |
| **Armazenamento** | AWS S3 | Fotos e documentos na nuvem |
| **Pagamentos** | Asaas | Gateway brasileiro, PIX nativo |
| **Mapas/Rotas** | Google Maps + Directions API | Cobertura do Brasil + cálculo de rotas e desvios |
| **Notificações** | Firebase | Push gratuito e confiável |

---

## 9. Modelo de Negócio

### Como o VanIA ganha dinheiro?

```
┌─────────────────────────────────────────────────────────────────┐
│                    MODELO DE RECEITA                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│                      TAXA POR TRANSAÇÃO                         │
│                      ──────────────────                         │
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                                                         │   │
│   │   Responsável paga ────────── R$ 500,00 (mensalidade)  │   │
│   │                                     │                   │   │
│   │                                                        │   │
│   │                              ┌─────────────┐            │   │
│   │                              │  VANIA      │            │   │
│   │                              │   retém 5%  │            │   │
│   │                              │  = R$ 25,00 │            │   │
│   │                              └─────────────             │   │
│   │                                     │                   │   │
│   │                                                        │   │
│   │   Motorista recebe ──────── R$ 475,00 (95%)            │   │
│   │                                                         │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│                                                                 │
│   PROJEÇÃO DE RECEITA (exemplo):                                │
│   ─────────────────────────────                                 │
│                                                                 │
│   • 1.000 contratos ativos                                      │
│   • Mensalidade média: R$ 450                                   │
│   • GMV mensal: R$ 450.000                                      │
│   • Receita VanIA (5%): R$ 22.500/mês                           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Estratégia de Precificação:

| Fase | Taxa | Justificativa |
|------|------|---------------|
| Lançamento | 0% (3 meses) | Atrair usuários iniciais |
| Crescimento | 3% | Competitivo, ganhar mercado |
| Maturidade | 5% | Sustentável para operação |

### Futuras Fontes de Receita (Roadmap):

1. **Planos Premium** para motoristas (destaque nas buscas)
2. **Seguros** parceria com seguradoras
3. **Antecipação de recebíveis** para motoristas
4. **Publicidade** segmentada (escolas, uniformes, etc.)

---

## 10. Roadmap do Projeto

### Fases de Desenvolvimento:

```
┌─────────────────────────────────────────────────────────────────┐
│                      ROADMAP VANIA                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  FASE 1 - MVP (4 meses)                             │
│  ─────────────────────                                          │
│   Cadastro de usuários (pais e motoristas)                     │
│   Cadastro de filhos com escola e endereço                     │
│   Cadastro de rotas pelo motorista                             │
│   MATCHING BÁSICO (proximidade + escola)                       │
│   Sugestões de motoristas para pais                            │
│   Sugestões de demandas para motoristas                        │
│   Solicitações e ofertas                                       │
│   Chat básico                                                  │
│   Contratação                                                  │
│   Pagamento PIX                                                │
│   Backoffice básico                                            │
│                                                                 │
│  FASE 2 - CORE (2 meses)                                  │
│  ────────────────────                                           │
│   MATCHING AVANÇADO (score + desvio de rota)                   │
│   Simulador de impacto na rota para motoristas                 │
│   Mapa de cobertura para pais                                  │
│   Rastreamento GPS em tempo real                               │
│   Registro de presença                                         │
│   Pagamentos recorrentes                                       │
│   Sistema de avaliações                                        │
│   Notificações inteligentes (novo match disponível!)           │
│                                                                 │
│  FASE 3 - SCALE (2 meses)                                   │
│  ─────────────────────                                          │
│   Backoffice completo                                          │
│   Relatórios avançados                                         │
│   Otimização de rotas                                          │
│   Multi-região                                                 │
│   App para iOS (publicação)                                    │
│                                                                 │
│  FASE 4 - GROWTH (3 meses)                                   │
│  ──────────────────────                                         │
│   Planos premium                                               │
│   Integração com escolas                                       │
│   API para terceiros                                           │
│   Analytics avançado                                           │
│                                                                 │
│                                                                 │
│  TIMELINE:                                                      │
│  ─────────                                                      │
│  Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out      │
│  ├─────────────────────┤─────────────┤─────────────┤────────┤   │
│       FASE 1 (MVP)        FASE 2        FASE 3      FASE 4      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 11. Métricas de Sucesso

### KPIs Principais:

| Métrica | Descrição | Meta Ano 1 |
|---------|-----------|------------|
| **MAU** | Usuários ativos mensais | 5.000 |
| **Contratos Ativos** | Serviços recorrentes | 2.000 |
| **GMV** | Volume transacionado | R$ 1M/mês |
| **Take Rate** | Taxa efetiva cobrada | 5% |
| **Receita Bruta** | GMV × Take Rate | R$ 50k/mês |
| **NPS** | Satisfação do usuário | > 50 |
| **Churn** | Taxa de cancelamento | < 5%/mês |
| **CAC** | Custo aquisição cliente | < R$ 50 |
| **LTV** | Valor do cliente (12 meses) | > R$ 300 |

### KPIs de Matching (Diferencial):

| Métrica | Descrição | Meta Ano 1 |
|---------|-----------|------------|
| **Match Rate** | % de solicitações que recebem sugestão | > 80% |
| **Conversão de Match** | % de sugestões que viram contrato | > 25% |
| **Tempo até Match** | Tempo médio para receber primeira sugestão | < 24h |
| **Desvio Médio** | Km adicionais na rota por novo aluno | < 1 km |
| **Ocupação de Vans** | % médio de vagas preenchidas | > 85% |
| **Matches Invisíveis** | Conexões que não existiriam sem a IA | Medir |

### Dashboard de Acompanhamento:

```
┌─────────────────────────────────────────────────────────────────┐
│                       DASHBOARD - EXEMPLO                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   USUARIOS                    CONTRATOS           FINANCEIRO    │
│   ────────                    ─────────           ──────────    │
│   ┌─────────┐                ┌─────────┐         ┌──────────┐   │
│   │  3.247  │                │  1.456  │         │ R$ 680K  │   │
│   │  ativos │                │  ativos │         │   GMV    │   │
│   │  +12%   │                │   +8%   │         │   +15%   │   │
│   └─────────┘                └─────────┘         └──────────┘   │
│                                                                 │
│   Motoristas: 234            Novos: 45          Receita: R$34K  │
│   Responsaveis: 3.013        Cancelados: 12     Repasses: R$646K│
│                                                                 │
│   ─────────────────────────────────────────────────────────     │
│                                                                 │
│   GRAFICO DE CRESCIMENTO (ultimos 6 meses)                      │
│                                                                 │
│   Contratos                                              ##     │
│             |                                        ##  ##     │
│             |                                    ##  ##  ##     │
│             |                                ##  ##  ##  ##     │
│             |                            ##  ##  ##  ##  ##     │
│             |                        ##  ##  ##  ##  ##  ##     │
│             +------------------------------------------------   │
│               Jul   Ago   Set   Out   Nov   Dez                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 12. Perguntas para Discussão

1. **Modelo de Negócio:**
   - A taxa de 5% é adequada?
   - Devemos oferecer período gratuito?
   - Quais outras fontes de receita devemos priorizar?

2. **Estratégia de Mercado:**
   - Focar em escolas particulares ou públicas primeiro?
   - Parceria com cooperativas existentes ou competição direta?
