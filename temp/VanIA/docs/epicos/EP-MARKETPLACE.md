# EP-MARKETPLACE - Sistema de Match e Marketplace

## Objetivo do Épico

Desenvolver o core do sistema de marketplace que conecta pais/responsáveis com motoristas de transporte escolar, incluindo algoritmos de match, sistema de ofertas, negociação e gestão de contratos.

---

## Arquitetura do Marketplace

### Modelo Conceitual (Inspirado no inDrive)

```
┌─────────────────────────────────────────────────────────────────┐
│                         MARKETPLACE                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   DEMANDA (Pais)              OFERTA (Motoristas)               │
│                                                                  │
│   ┌──────────────┐           ┌──────────────┐                   │
│   │ Solicitação  │           │   Motorista  │                   │
│   │              │           │   Aprovado   │                   │
│   │ - Filho(s)   │           │              │                   │
│   │ - Escola     │           │ - Perfil     │                   │
│   │ - Endereço   │           │ - Veículo    │                   │
│   │ - Turno      │           │ - Região     │                   │
│   │ - Orçamento  │           │ - Escolas    │                   │
│   └──────────────┘           └──────────────┘                   │
│          │                          │                            │
│          │    ┌──────────────┐      │                            │
│          └───│   MATCHING   │─────┘                            │
│               │   ENGINE     │                                   │
│               │              │                                   │
│               │ - Geolocation│                                   │
│               │ - Escola     │                                   │
│               │ - Capacidade │                                   │
│               │ - Score      │                                   │
│               └──────────────┘                                   │
│                      │                                           │
│                                                                 │
│               ┌──────────────┐                                   │
│               │   OFERTAS    │                                   │
│               │              │                                   │
│               │ Motorista    │                                   │
│               │ propõe valor │                                   │
│               │ e condições  │                                   │
│               └──────────────┘                                   │
│                      │                                           │
│                                                                 │
│               ┌──────────────┐                                   │
│               │  NEGOCIAÇÃO  │                                   │
│               │              │                                   │
│               │ Chat         │                                   │
│               │ Contraproposta│                                  │
│               └──────────────┘                                   │
│                      │                                           │
│                                                                 │
│               ┌──────────────┐                                   │
│               │    MATCH     │                                   │
│               │   (Aceite)   │                                   │
│               └──────────────┘                                   │
│                      │                                           │
│                                                                 │
│               ┌──────────────┐                                   │
│               │  CONTRATO    │                                   │
│               │  RECORRENTE  │                                   │
│               └──────────────┘                                   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Diferenças do inDrive Original

| Aspecto | inDrive (Corridas) | VanIA (Escolar) |
|---------|-------------------|---------------------|
| Natureza | Viagem única | Contrato recorrente |
| Pagamento | Por corrida | Mensalidade |
| Relação | Transacional | Longo prazo |
| Decisão | Imediata (segundos) | Considerada (dias) |
| Verificação | Básica | Extensiva (documentos) |
| Confiança | Avaliação | Documentos + Avaliação |

---

## Histórias de Usuário

### US-MKT-01 - Algoritmo de Matching Geográfico

**Como** sistema  
**Quero** identificar motoristas compatíveis com cada solicitação  
**Para** apresentar apenas opções relevantes

#### Critérios de Match

```
┌─────────────────────────────────────────────────────────────┐
│                    MATCHING CRITERIA                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. GEOGRÁFICO (Obrigatório)                                │
│     ├── Motorista atende a escola?                         │
│     ├── Endereço dentro da área de atuação?                │
│     └── Distância máxima da rota atual: 2km                 │
│                                                              │
│  2. CAPACIDADE (Obrigatório)                                │
│     └── Motorista tem vagas disponíveis?                   │
│                                                              │
│  3. TURNO (Obrigatório)                                     │
│     └── Motorista opera no turno solicitado?               │
│                                                              │
│  4. SCORE (Ranking)                                         │
│     ├── Avaliação (peso 30%)                                │
│     ├── Proximidade (peso 25%)                              │
│     ├── Tempo de resposta (peso 20%)                        │
│     ├── Taxa de aceite (peso 15%)                           │
│     └── Tempo na plataforma (peso 10%)                      │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Filtrar motoristas por escola atendida
- [ ] **CA02** - Filtrar por região de atuação
- [ ] **CA03** - Filtrar por vagas disponíveis
- [ ] **CA04** - Filtrar por turno de operação
- [ ] **CA05** - Calcular distância do endereço à rota
- [ ] **CA06** - Ordenar por score composto
- [ ] **CA07** - Limitar a 20 motoristas por solicitação

#### Regras de Negócio

- **RN01** - Só motoristas aprovados e ativos
- **RN02** - Só motoristas com documentos válidos
- **RN03** - Distância máxima: 3km da rota existente
- **RN04** - Mínimo 1 vaga disponível

---

### US-MKT-02 - Notificação de Nova Solicitação

**Como** motorista  
**Quero** ser notificado de novas solicitações compatíveis  
**Para** fazer ofertas rapidamente

#### Fluxo de Notificação

```
┌─────────────────────────────────────────┐
│  PAI PUBLICA SOLICITAÇÃO                │
└───────────────┬─────────────────────────┘
                │
                
┌─────────────────────────────────────────┐
│  MATCHING ENGINE                        │
│  - Identifica motoristas compatíveis    │
│  - Calcula score de cada um             │
│  - Ordena por relevância                │
└───────────────┬─────────────────────────┘
                │
                
┌─────────────────────────────────────────┐
│  NOTIFICAÇÃO PUSH (Imediata)            │
│                                         │
│  "Nova solicitação na sua região!"      │
│   Jd. Flores → Colégio ABC            │
│   1 criança | Manhã + Tarde           │
│                                         │
│  [Ver Detalhes]                         │
└───────────────┬─────────────────────────┘
                │
                
┌─────────────────────────────────────────┐
│  SE NÃO ABRIR EM 1H                     │
│  → E-mail de resumo                     │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Push notification imediata
- [ ] **CA02** - Deep link para solicitação
- [ ] **CA03** - E-mail resumo se não visualizar
- [ ] **CA04** - Configurar horários de notificação
- [ ] **CA05** - Não notificar se sem vagas

#### Regras de Negócio

- **RN01** - Respeitar horário de não perturbe
- **RN02** - Máximo 10 notificações por dia
- **RN03** - Agrupar se múltiplas solicitações

---

### US-MKT-03 - Sistema de Ofertas

**Como** motorista  
**Quero** fazer ofertas para solicitações  
**Para** conquistar novos clientes

#### Modelo de Dados - Oferta

```typescript
interface Oferta {
  id: string;
  solicitacaoId: string;
  motoristaId: string;
  
  // Proposta
  valorMensal: number;
  dataInicioDisponivel: Date;
  mensagemPersonalizada: string;
  
  // Status
  status: 'pendente' | 'visualizada' | 'aceita' | 'recusada' | 'expirada' | 'cancelada';
  
  // Timestamps
  criadaEm: Date;
  visualizadaEm?: Date;
  respondidaEm?: Date;
  
  // Histórico de edições
  edicoes: OfertaEdicao[];
}

interface OfertaEdicao {
  valorAnterior: number;
  valorNovo: number;
  motivoEdicao: string;
  editadaEm: Date;
}
```

#### Estados da Oferta

```
┌──────────────────────────────────────────────────────────────┐
│                    CICLO DE VIDA DA OFERTA                    │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│   ┌─────────┐                                                │
│   │ CRIADA  │ ←── Motorista envia oferta                     │
│   └────┬────┘                                                │
│        │                                                      │
│                                                              │
│   ┌─────────┐                                                │
│   │PENDENTE │ ←── Aguardando visualização do pai             │
│   └────┬────┘                                                │
│        │                                                      │
│        ├────────────────┬─────────────────┐                  │
│                                                           │
│   ┌─────────┐     ┌──────────┐      ┌──────────┐            │
│   │VISUALIZ.│     │ EDITADA  │      │ CANCELADA│            │
│   └────┬────┘     └────┬─────┘      └──────────┘            │
│        │               │                                     │
│        │──────────────┘                                     │
│        │                                                      │
│        ├─────────────────┬────────────────┐                  │
│                                                           │
│   ┌─────────┐      ┌──────────┐     ┌──────────┐            │
│   │ ACEITA  │      │ RECUSADA │     │ EXPIRADA │            │
│   └────┬────┘      └──────────┘     └──────────┘            │
│        │                                                      │
│                                                              │
│   ┌─────────┐                                                │
│   │CONTRATO │                                                │
│   │ GERADO  │                                                │
│   └─────────┘                                                │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Criar oferta com valor e mensagem
- [ ] **CA02** - Editar oferta enquanto pendente
- [ ] **CA03** - Cancelar oferta
- [ ] **CA04** - Visualizar status da oferta
- [ ] **CA05** - Notificar quando visualizada
- [ ] **CA06** - Notificar quando respondida
- [ ] **CA07** - Expirar com a solicitação

#### Regras de Negócio

- **RN01** - Uma oferta por solicitação por motorista
- **RN02** - Valor mínimo: R$ 150,00
- **RN03** - Máximo 3 edições de valor
- **RN04** - Oferta expira junto com solicitação (7 dias)

---

### US-MKT-04 - Exibição de Ofertas para Pais

**Como** pai/responsável  
**Quero** ver todas as ofertas recebidas  
**Para** comparar e escolher a melhor

#### Ordenação de Ofertas

```
┌─────────────────────────────────────────┐
│  OPÇÕES DE ORDENAÇÃO                    │
├─────────────────────────────────────────┤
│                                         │
│   Recomendados (padrão)               │
│     Score = (Avaliação × 0.4) +         │
│             (Preço × 0.3) +             │
│             (Proximidade × 0.2) +       │
│             (Vagas × 0.1)               │
│                                         │
│   Menor preço                         │
│                                         │
│   Melhor avaliação                    │
│                                         │
│   Mais próximo                        │
│                                         │
│   Mais recentes                       │
│                                         │
└─────────────────────────────────────────┘
```

#### Informações Exibidas

Para cada oferta:
- Foto e nome do motorista
- Avaliação (estrelas + quantidade)
- Tempo na plataforma
- Valor proposto
- Distância do endereço
- Vagas ocupadas/total
- Mensagem personalizada
- Selo de verificações

#### Critérios de Aceitação

- [ ] **CA01** - Listar todas as ofertas
- [ ] **CA02** - Ordenar por recomendados
- [ ] **CA03** - Ordenar por preço
- [ ] **CA04** - Ordenar por avaliação
- [ ] **CA05** - Comparar até 3 ofertas lado a lado
- [ ] **CA06** - Ver perfil completo do motorista
- [ ] **CA07** - Iniciar chat antes de aceitar

---

### US-MKT-05 - Chat de Negociação

**Como** pai ou motorista  
**Quero** conversar antes de fechar  
**Para** tirar dúvidas e negociar

#### Funcionalidades do Chat

```
┌─────────────────────────────────────────────────────────────┐
│                      CHAT DE NEGOCIAÇÃO                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  RECURSOS:                                                   │
│  ├── Mensagens de texto                                     │
│  ├── Envio de fotos                                         │
│  ├── Compartilhar localização                               │
│  ├── Indicador de digitando                                 │
│  ├── Status de leitura                                      │
│  └── Notificações push                                      │
│                                                              │
│  MODERAÇÃO:                                                  │
│  ├── Filtro de palavras impróprias                          │
│  ├── Bloqueio de telefone/e-mail                            │
│  └── Denúncia de mensagens                                  │
│                                                              │
│  CONTEXTO:                                                   │
│  ├── Card da solicitação no topo                            │
│  ├── Card da oferta atual                                   │
│  └── Botão de aceitar sempre visível                        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Chat em tempo real (WebSocket)
- [ ] **CA02** - Histórico persistente
- [ ] **CA03** - Push notifications
- [ ] **CA04** - Envio de fotos
- [ ] **CA05** - Compartilhar localização
- [ ] **CA06** - Indicadores de status
- [ ] **CA07** - Filtro de conteúdo
- [ ] **CA08** - Bloquear dados pessoais

#### Regras de Negócio

- **RN01** - Telefone/e-mail não podem ser enviados
- **RN02** - Chat disponível até contrato ou recusa
- **RN03** - Histórico mantido por 12 meses

---

### US-MKT-06 - Aceite e Geração de Contrato

**Como** pai  
**Quero** aceitar uma oferta  
**Para** formalizar a contratação

#### Fluxo de Aceite

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUXO DE CONTRATAÇÃO                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. PAI ACEITA OFERTA                                       │
│     └── Confirma valor e condições                          │
│                                                              │
│  2. MOTORISTA CONFIRMA (24h)                                │
│     └── Valida capacidade e disponibilidade                 │
│                                                              │
│  3. CONTRATO GERADO                                         │
│     ├── PDF automático                                      │
│     ├── Termos e condições                                  │
│     └── Assinatura digital (opcional)                       │
│                                                              │
│  4. PAGAMENTO INICIAL                                       │
│     └── Primeira mensalidade                                │
│                                                              │
│  5. CONTRATO ATIVO                                          │
│     ├── Aluno adicionado à lista                            │
│     ├── Pai recebe dados do motorista                       │
│     └── Motorista recebe dados do aluno                     │
│                                                              │
│  6. PERÍODO DE TESTE (7 dias)                               │
│     └── Cancelamento com reembolso integral                 │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Modelo de Dados - Contrato

```typescript
interface Contrato {
  id: string;
  
  // Partes
  responsavelId: string;
  motoristaId: string;
  alunoIds: string[];
  
  // Origem
  solicitacaoId: string;
  ofertaId: string;
  
  // Termos
  valorMensal: number;
  diaVencimento: number;
  dataInicio: Date;
  periodoTeste: Date; // 7 dias
  
  // Status
  status: 'aguardando_confirmacao' | 'aguardando_pagamento' | 
          'ativo' | 'periodo_teste' | 'cancelado' | 'encerrado';
  
  // Documento
  documentoPdfUrl: string;
  assinaturas: Assinatura[];
  
  // Timestamps
  criadoEm: Date;
  confirmadoEm?: Date;
  ativadoEm?: Date;
  encerradoEm?: Date;
}
```

#### Critérios de Aceitação

- [ ] **CA01** - Confirmar aceite da oferta
- [ ] **CA02** - Motorista confirma em 24h
- [ ] **CA03** - Gerar contrato PDF automático
- [ ] **CA04** - Assinatura digital (opcional)
- [ ] **CA05** - Processar primeiro pagamento
- [ ] **CA06** - Ativar contrato após pagamento
- [ ] **CA07** - Período de teste de 7 dias
- [ ] **CA08** - Recusar outras ofertas automaticamente

#### Regras de Negócio

- **RN01** - Motorista tem 24h para confirmar
- **RN02** - Sem confirmação: oferta volta a pendente
- **RN03** - Contrato só ativa após pagamento
- **RN04** - 7 dias de teste com reembolso integral

---

### US-MKT-07 - Processamento de Pagamentos

**Como** plataforma  
**Quero** processar pagamentos entre pais e motoristas  
**Para** garantir segurança nas transações

#### Fluxo de Pagamento

```
┌─────────────────────────────────────────────────────────────┐
│                   FLUXO DE PAGAMENTO                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  PAI                 PLATAFORMA              MOTORISTA       │
│   │                      │                      │            │
│   │──── Paga R$380 ─────│                      │            │
│   │                      │                      │            │
│   │                      │ Retém taxa (5%)      │            │
│   │                      │ R$ 19,00             │            │
│   │                      │                      │            │
│   │                      │───── R$361 ─────────│            │
│   │                      │      (D+2)           │            │
│   │                      │                      │            │
│                                                              │
│  FORMAS DE PAGAMENTO:                                        │
│  ├── PIX (instantâneo) → Repasse D+2                        │
│  ├── Cartão de crédito → Repasse D+30                       │
│  └── Boleto bancário → Repasse D+2 após compensação         │
│                                                              │
│  SPLIT DE PAGAMENTO:                                         │
│  ├── Motorista: 95%                                         │
│  └── Plataforma: 5%                                         │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Modelo de Dados - Pagamento

```typescript
interface Pagamento {
  id: string;
  contratoId: string;
  
  // Valores
  valorBruto: number;
  taxaPlataforma: number;
  valorLiquido: number;
  
  // Método
  metodoPagamento: 'pix' | 'cartao_credito' | 'boleto';
  dadosPagamento: DadosPagamento;
  
  // Status
  status: 'pendente' | 'processando' | 'confirmado' | 
          'falhou' | 'reembolsado' | 'estornado';
  
  // Gateway
  gatewayId: string; // Asaas
  gatewayResponse: any;
  
  // Repasse
  repasseStatus: 'pendente' | 'agendado' | 'realizado';
  repasseData?: Date;
  repasseId?: string;
  
  // Timestamps
  criadoEm: Date;
  confirmadoEm?: Date;
  repassadoEm?: Date;
}
```

#### Critérios de Aceitação

- [ ] **CA01** - Integrar com gateway (Asaas)
- [ ] **CA02** - Processar PIX
- [ ] **CA03** - Processar cartão de crédito
- [ ] **CA04** - Processar boleto
- [ ] **CA05** - Calcular split automático
- [ ] **CA06** - Agendar repasse ao motorista
- [ ] **CA07** - Webhook de confirmação
- [ ] **CA08** - Reembolso no período de teste

---

### US-MKT-08 - Cobrança Recorrente

**Como** plataforma  
**Quero** gerar cobranças mensais automaticamente  
**Para** garantir pagamentos regulares

#### Ciclo de Cobrança

```
┌─────────────────────────────────────────────────────────────┐
│                  CICLO DE COBRANÇA MENSAL                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  DIA 1 DO MÊS                                               │
│  └── Gerar cobranças do mês                                 │
│                                                              │
│  DIA VENCIMENTO - 5                                         │
│  └── Notificação: "Sua mensalidade vence em 5 dias"         │
│                                                              │
│  DIA VENCIMENTO - 3                                         │
│  └── Cobrança automática (se cartão cadastrado)             │
│                                                              │
│  DIA VENCIMENTO                                             │
│  └── Data limite sem juros                                  │
│                                                              │
│  DIA VENCIMENTO + 1                                         │
│  └── Notificação: "Pagamento atrasado"                      │
│                                                              │
│  DIA VENCIMENTO + 5                                         │
│  └── Multa de 2% + Juros 0.033%/dia                         │
│  └── Notificação para motorista                             │
│                                                              │
│  DIA VENCIMENTO + 15                                        │
│  └── Contrato suspenso                                      │
│  └── Aluno não embarca                                      │
│                                                              │
│  DIA VENCIMENTO + 30                                        │
│  └── Contrato cancelado                                     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Gerar cobranças automáticas
- [ ] **CA02** - Notificações de vencimento
- [ ] **CA03** - Cobrança automática no cartão
- [ ] **CA04** - Calcular multa e juros
- [ ] **CA05** - Suspender após 15 dias
- [ ] **CA06** - Cancelar após 30 dias
- [ ] **CA07** - Notificar motorista de inadimplência

---

### US-MKT-09 - Sistema de Avaliações

**Como** plataforma  
**Quero** coletar avaliações dos usuários  
**Para** manter qualidade do serviço

#### Modelo de Avaliação

```typescript
interface Avaliacao {
  id: string;
  
  // Quem avalia quem
  avaliadorId: string;
  avaliadorTipo: 'responsavel' | 'motorista';
  avaliadoId: string;
  avaliadoTipo: 'responsavel' | 'motorista';
  
  // Contexto
  contratoId: string;
  periodo: string; // "2026-02"
  
  // Notas
  notaGeral: number; // 1-5
  criterios: {
    pontualidade?: number;
    comunicacao?: number;
    cuidadoCriancas?: number;
    condicaoVeiculo?: number;
    pagamentoEmDia?: number;
  };
  
  // Comentário
  comentario?: string;
  anonimo: boolean;
  
  // Moderação
  status: 'pendente' | 'aprovada' | 'rejeitada';
  
  criadaEm: Date;
}
```

#### Quando Solicitar Avaliação

- Após 7 dias do primeiro embarque
- Mensalmente (se contrato ativo)
- Ao encerrar contrato

#### Critérios de Aceitação

- [ ] **CA01** - Solicitar avaliação automaticamente
- [ ] **CA02** - Avaliação por critérios
- [ ] **CA03** - Comentário opcional
- [ ] **CA04** - Opção de anonimato
- [ ] **CA05** - Moderação de comentários
- [ ] **CA06** - Calcular média ponderada
- [ ] **CA07** - Exibir no perfil

#### Regras de Negócio

- **RN01** - Só pode avaliar com contrato ativo/encerrado
- **RN02** - Uma avaliação por mês por contrato
- **RN03** - Comentários passam por moderação

---

### US-MKT-10 - Gerenciamento de Solicitações

**Como** plataforma  
**Quero** gerenciar o ciclo de vida das solicitações  
**Para** manter o marketplace saudável

#### Estados da Solicitação

```
┌──────────────────────────────────────────────────────────────┐
│               CICLO DE VIDA DA SOLICITAÇÃO                    │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│   ┌─────────┐                                                │
│   │ CRIADA  │ ←── Pai publica solicitação                    │
│   └────┬────┘                                                │
│        │                                                      │
│                                                              │
│   ┌─────────┐                                                │
│   │ ATIVA   │ ←── Motoristas podem fazer ofertas             │
│   └────┬────┘                                                │
│        │                                                      │
│        ├────────────┬────────────┬────────────┐              │
│                                                          │
│   ┌─────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐        │
│   │ MATCH   │ │ EXPIRADA │ │CANCELADA │ │PAUSADA   │        │
│   │(Aceita) │ │ (7 dias) │ │(Pelo pai)│ │(Tempor.) │        │
│   └────┬────┘ └──────────┘ └──────────┘ └────┬─────┘        │
│        │                                      │               │
│                                              │               │
│   ┌─────────┐                                │               │
│   │CONTRATO │                                │               │
│   │ GERADO  │───────────────────────────────┘               │
│   └─────────┘     (Reativar)                                 │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Criar solicitação
- [ ] **CA02** - Editar solicitação (se sem ofertas)
- [ ] **CA03** - Pausar solicitação
- [ ] **CA04** - Cancelar solicitação
- [ ] **CA05** - Expirar após 7 dias
- [ ] **CA06** - Republicar solicitação expirada
- [ ] **CA07** - Notificar sobre expiração

---

### US-MKT-11 - Métricas e Analytics

**Como** plataforma  
**Quero** coletar métricas do marketplace  
**Para** otimizar a operação

#### Métricas Principais

```
┌─────────────────────────────────────────────────────────────┐
│                    MÉTRICAS DO MARKETPLACE                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  CONVERSÃO:                                                  │
│  ├── Solicitações → Com ofertas: X%                         │
│  ├── Com ofertas → Match: X%                                │
│  ├── Match → Contrato ativo: X%                             │
│  └── Funil completo: X%                                     │
│                                                              │
│  TEMPO:                                                      │
│  ├── Tempo médio para 1ª oferta: X horas                    │
│  ├── Tempo médio para match: X dias                         │
│  └── Tempo médio para pagamento: X horas                    │
│                                                              │
│  SATISFAÇÃO:                                                 │
│  ├── NPS de pais: X                                         │
│  ├── NPS de motoristas: X                                   │
│  └── Taxa de cancelamento: X%                               │
│                                                              │
│  FINANCEIRO:                                                 │
│  ├── GMV (Volume bruto): R$ X                               │
│  ├── Receita (taxas): R$ X                                  │
│  └── Ticket médio: R$ X                                     │
│                                                              │
│  RETENÇÃO:                                                   │
│  ├── Churn de contratos: X%                                 │
│  ├── Renovação automática: X%                               │
│  └── LTV médio: R$ X                                        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Dashboard de métricas em tempo real
- [ ] **CA02** - Funil de conversão
- [ ] **CA03** - Métricas de tempo
- [ ] **CA04** - Métricas financeiras
- [ ] **CA05** - Exportar relatórios
- [ ] **CA06** - Alertas de anomalias

---

### US-MKT-12 - Prevenção de Fraude

**Como** plataforma  
**Quero** detectar e prevenir fraudes  
**Para** proteger usuários

#### Regras de Fraude

```
┌─────────────────────────────────────────────────────────────┐
│                   PREVENÇÃO DE FRAUDE                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  MOTORISTAS:                                                 │
│  ├── Verificação de documentos (CNH, CRLV)                  │
│  ├── Validação de antecedentes criminais                    │
│  ├── Selfie com documento                                   │
│  ├── Verificação de endereço                                │
│  └── Limite de ofertas por dia                              │
│                                                              │
│  PAIS:                                                       │
│  ├── Verificação de telefone (SMS)                          │
│  ├── Validação de CPF                                       │
│  ├── Verificação de cartão                                  │
│  └── Limite de solicitações                                 │
│                                                              │
│  TRANSAÇÕES:                                                 │
│  ├── Análise de padrões anormais                            │
│  ├── Bloqueio de valores suspeitos                          │
│  ├── Verificação de localização                             │
│  └── Período de carência para saque                         │
│                                                              │
│  COMUNICAÇÃO:                                                │
│  ├── Filtro de dados pessoais no chat                       │
│  ├── Detecção de tentativa de bypass                        │
│  └── Denúncia de comportamento                              │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Verificação de documentos
- [ ] **CA02** - Validação de identidade
- [ ] **CA03** - Filtro de comunicação
- [ ] **CA04** - Análise de transações
- [ ] **CA05** - Sistema de denúncias
- [ ] **CA06** - Bloqueio de contas suspeitas

---

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US-MKT-01 | 13 | Alta |
| US-MKT-02 | 5 | Alta |
| US-MKT-03 | 8 | Alta |
| US-MKT-04 | 5 | Alta |
| US-MKT-05 | 8 | Alta |
| US-MKT-06 | 13 | Alta |
| US-MKT-07 | 13 | Alta |
| US-MKT-08 | 8 | Alta |
| US-MKT-09 | 5 | Média |
| US-MKT-10 | 5 | Alta |
| US-MKT-11 | 8 | Média |
| US-MKT-12 | 8 | Alta |
| **Total** | **99** | |

---

## Diagramas Técnicos

### Arquitetura do Match Engine

```
┌─────────────────────────────────────────────────────────────┐
│                     MATCHING ENGINE                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    INPUT                             │    │
│  │                                                      │    │
│  │  Solicitação {                                       │    │
│  │    escola: "Colégio ABC",                           │    │
│  │    endereco: { lat: -23.55, lng: -46.63 },          │    │
│  │    turno: "manha_tarde",                            │    │
│  │    criancas: 1                                       │    │
│  │  }                                                   │    │
│  │                                                      │    │
│  └─────────────────────────────────────────────────────┘    │
│                          │                                   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              FILTROS OBRIGATÓRIOS                    │    │
│  │                                                      │    │
│  │  1. Escola: motoristas.escolas.contains(escola)     │    │
│  │  2. Região: geoDistance(endereco, rota) < 3km       │    │
│  │  3. Vagas: motorista.vagas >= criancas              │    │
│  │  4. Turno: motorista.turnos.contains(turno)         │    │
│  │  5. Status: motorista.status == 'aprovado'          │    │
│  │  6. Docs: motorista.documentosValidos == true       │    │
│  │                                                      │    │
│  └─────────────────────────────────────────────────────┘    │
│                          │                                   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                 SCORE CALCULATION                    │    │
│  │                                                      │    │
│  │  score = (avaliacao * 0.30) +                       │    │
│  │          (proximidade * 0.25) +                     │    │
│  │          (tempoResposta * 0.20) +                   │    │
│  │          (taxaAceite * 0.15) +                      │    │
│  │          (tempoPlataforma * 0.10)                   │    │
│  │                                                      │    │
│  └─────────────────────────────────────────────────────┘    │
│                          │                                   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    OUTPUT                            │    │
│  │                                                      │    │
│  │  motoristas: [                                       │    │
│  │    { id: "mot_1", score: 0.92, distancia: 800 },    │    │
│  │    { id: "mot_2", score: 0.87, distancia: 1200 },   │    │
│  │    { id: "mot_3", score: 0.81, distancia: 1500 },   │    │
│  │    ...                                               │    │
│  │  ]                                                   │    │
│  │                                                      │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Fluxo de Dados WebSocket

```
┌─────────────────────────────────────────────────────────────┐
│                    REAL-TIME UPDATES                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  APP PAIS ────────── WebSocket ────────── API SERVER      │
│                           │                                  │
│  Eventos recebidos:       │        Eventos emitidos:        │
│  • nova_oferta            │        • solicitacao_criada     │
│  • oferta_atualizada      │        • oferta_criada          │
│  • mensagem_chat          │        • oferta_aceita          │
│  • contrato_ativo         │        • mensagem_enviada       │
│  • pagamento_confirmado   │        • pagamento_processado   │
│                           │                                  │
│  ─────────────────────────┼─────────────────────────────── │
│                           │                                  │
│  APP MOTORISTA ──────────┼────────── API SERVER           │
│                           │                                  │
│  Eventos recebidos:       │        Eventos emitidos:        │
│  • nova_solicitacao       │        • oferta_enviada         │
│  • oferta_visualizada     │        • mensagem_enviada       │
│  • oferta_aceita          │        • embarque_registrado    │
│  • mensagem_chat          │        • rota_iniciada          │
│  • pagamento_recebido     │        • rota_finalizada        │
│                           │                                  │
└─────────────────────────────────────────────────────────────┘
```
