# PRD v2 — VanIA: Plataforma de Transporte Escolar

## Nova Visão do Produto

**VanIA** é uma plataforma completa de transporte escolar que conecta **pais/responsáveis** que precisam de transporte para seus filhos com **motoristas** que oferecem esse serviço.

### Modelo de Negócio: Marketplace (estilo inDrive)

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│    PAIS                                     MOTORISTAS      │
│                                                                  │
│   "Preciso de van para                    "Tenho van e faço     │
│    levar meu filho da                      transporte escolar   │
│    Rua X até Escola Y"                     na região Z"         │
│                                                                  │
│         │                                        │              │
│                                                               │
│    ┌─────────────────────────────────────────────────┐          │
│    │                                                  │          │
│    │          PLATAFORMA VANIA                 │          │
│    │                                                  │          │
│    │   • Pais publicam necessidade de transporte    │          │
│    │   • Motoristas veem e fazem OFERTAS            │          │
│    │   • Pais escolhem melhor oferta                │          │
│    │   • Contrato fechado → Serviço recorrente      │          │
│    │                                                  │          │
│    └─────────────────────────────────────────────────┘          │
│                                                                  │
│                         │                                        │
│                                                                 │
│               BACKOFFICE (Administração)                       │
│                                                                  │
│   • Gestão de usuários e documentos                             │
│   • Moderação de ofertas e contratos                            │
│   • Financeiro (comissões, pagamentos)                          │
│   • Relatórios e analytics                                       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## As 3 Plataformas

### 1. App Pais/Responsáveis (Mobile - iOS/Android)

**Objetivo:** Encontrar e contratar transporte escolar de forma segura e transparente.

**Funcionalidades principais:**
- Cadastro e verificação de identidade
- Publicar necessidade de transporte (origem → destino/escola)
- Receber e comparar ofertas de motoristas
- Ver perfil, avaliações e documentos do motorista
- Negociar preço
- Contratar serviço
- Pagar mensalidade (PIX, cartão)
- Rastrear van em tempo real
- Receber notificações (van chegando, chegou na escola)
- Avaliar motorista
- Chat com motorista

### 2. App Motorista (Mobile - iOS/Android)

**Objetivo:** Encontrar clientes, gerenciar rotas e controlar o negócio.

**Funcionalidades principais:**
- Cadastro com documentos (CNH, veículo, antecedentes)
- Definir área de atuação
- Ver solicitações de transporte na região
- Fazer ofertas com valor mensal
- Gerenciar alunos e rotas
- Controle de presença (check-in/check-out)
- Compartilhar localização em tempo real
- Receber pagamentos
- Emitir NFS-e
- Chat com pais
- Dashboard financeiro

### 3. Backoffice Web (Administração)

**Objetivo:** Gerenciar toda a plataforma, usuários, financeiro e compliance.

**Funcionalidades principais:**
- Aprovação de motoristas (verificação de documentos)
- Moderação de conteúdo e reclamações
- Gestão financeira (comissões, repasses)
- Relatórios e analytics
- Configurações da plataforma
- Suporte ao usuário
- Gestão de notificações push

---

## Fluxo Principal: Do Match ao Serviço

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           FLUXO DO MARKETPLACE                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   SOLICITAÇÃO                                                             │
│  ─────────────                                                               │
│  Pai publica necessidade:                                                   │
│  • Endereço de embarque (casa)                                              │
│  • Escola destino                                                            │
│  • Turno (manhã/tarde/integral)                                             │
│  • Quantidade de filhos                                                      │
│  • Necessidades especiais (opcional)                                        │
│                                                                              │
│                                                                             │
│                                                                              │
│   DESCOBERTA                                                              │
│  ──────────────                                                              │
│  Sistema notifica motoristas da região                                      │
│  que atendem aquela escola/área                                             │
│                                                                              │
│                                                                             │
│                                                                              │
│   OFERTA                                                                  │
│  ─────────                                                                   │
│  Motoristas interessados fazem ofertas:                                     │
│  • Valor mensal proposto                                                    │
│  • Horários de coleta/entrega                                               │
│  • Informações do veículo                                                   │
│  • Mensagem personalizada                                                   │
│                                                                              │
│                                                                             │
│                                                                              │
│   COMPARAÇÃO                                                              │
│  ────────────                                                                │
│  Pai compara ofertas:                                                       │
│  • Preço                                                                    │
│  • Avaliações do motorista                                                  │
│  • Distância/tempo                                                          │
│  • Veículo                                                                  │
│  • Vagas disponíveis                                                        │
│                                                                              │
│                                                                             │
│                                                                              │
│   NEGOCIAÇÃO (opcional)                                                   │
│  ───────────────────────                                                     │
│  Chat para:                                                                 │
│  • Tirar dúvidas                                                            │
│  • Negociar valor                                                           │
│  • Combinar horários                                                        │
│  • Conhecer pessoalmente                                                    │
│                                                                              │
│                                                                             │
│                                                                              │
│   CONTRATAÇÃO                                                             │
│  ──────────────                                                              │
│  Pai aceita oferta:                                                         │
│  • Contrato digital gerado                                                  │
│  • Primeiro pagamento                                                       │
│  • Dados compartilhados                                                     │
│  • Serviço inicia na data combinada                                         │
│                                                                              │
│                                                                             │
│                                                                              │
│   SERVIÇO RECORRENTE                                                      │
│  ─────────────────────                                                       │
│  Todo mês:                                                                  │
│  • Cobrança automática                                                      │
│  • Rastreamento em tempo real                                               │
│  • Notificações de chegada                                                  │
│  • Check-in/check-out                                                       │
│  • Avaliação mensal                                                         │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Personas Detalhadas

### Persona 1: Maria (Mãe) - App Pais

**Perfil:**
- 35 anos, trabalha fora
- 2 filhos (8 e 10 anos)
- Mora em bairro residencial, escola a 5km

**Dores:**
- Não tem tempo de levar/buscar filhos
- Preocupada com segurança
- Dificuldade de encontrar van confiável
- Não sabe se o preço é justo
- Quer saber quando filho chegou na escola

**Objetivos:**
- Encontrar transporte seguro e confiável
- Comparar opções e preços
- Ter tranquilidade no dia a dia
- Rastrear a van em tempo real
- Comunicação fácil com motorista

---

### Persona 2: Carlos (Motorista) - App Motorista

**Perfil:**
- 45 anos, ex-motorista de ônibus
- Van própria, regularizada
- Trabalha há 8 anos com transporte escolar
- Atende 2 escolas na região

**Dores:**
- Dificuldade de encontrar novos clientes
- Inadimplência
- Gestão manual (WhatsApp, caderninho)
- Não sabe calcular lucro real
- Cobrança manual todo mês

**Objetivos:**
- Ter mais clientes
- Receber em dia
- Organizar rotas e alunos
- Mostrar profissionalismo
- Crescer o negócio

---

### Persona 3: Admin (Operador) - Backoffice

**Perfil:**
- Funcionário da VanIA
- Responsável por operações

**Objetivos:**
- Aprovar motoristas rapidamente
- Resolver disputas
- Garantir qualidade do serviço
- Monitorar métricas do negócio

---

## Modelo de Monetização

### Opção 1: Comissão por Transação
- **Taxa:** 10-15% sobre mensalidade
- Cobrado do motorista a cada pagamento recebido

### Opção 2: Assinatura Motorista
- **Plano Básico:** Grátis (até 10 alunos)
- **Plano Pro:** R$ 49/mês (ilimitado + recursos extras)
- **Plano Business:** R$ 99/mês (múltiplos veículos + relatórios)

### Opção 3: Híbrido
- Taxa reduzida (5%) + Assinatura opcional para recursos premium

### Receitas Adicionais
- Taxa de urgência (encontrar van de última hora)
- Destaque na busca (motoristas pagam para aparecer primeiro)
- Verificação premium (selo de motorista verificado)

---

## KPIs do Produto

### Métricas de Aquisição
| Métrica | Meta |
|---------|------|
| Downloads App Pais | 10.000/mês |
| Cadastros Pais | 5.000/mês |
| Cadastros Motoristas | 500/mês |
| Motoristas Aprovados | 80% |

### Métricas de Engajamento
| Métrica | Meta |
|---------|------|
| Solicitações publicadas | 3.000/mês |
| Ofertas por solicitação | > 3 |
| Taxa de conversão (match) | > 40% |
| Tempo até primeiro match | < 24h |

### Métricas de Retenção
| Métrica | Meta |
|---------|------|
| Churn mensal pais | < 5% |
| Churn mensal motoristas | < 3% |
| NPS | > 50 |
| Avaliação média | > 4.5 |

### Métricas Financeiras
| Métrica | Meta |
|---------|------|
| GMV mensal | R$ 500k (6 meses) |
| Receita mensal | R$ 50k (6 meses) |
| Take rate | 10% |
| CAC | < R$ 50 |
| LTV | > R$ 500 |

---

## Segurança e Confiança

### Para Motoristas (obrigatório)
- CNH categoria D ou E
- Certificado de curso de transporte escolar
- Antecedentes criminais
- Documento do veículo (CRLV)
- Laudo de vistoria do veículo
- Seguro de passageiros
- Autorização da prefeitura (alvará)
- Foto do motorista (verificação facial)
- Foto do veículo

### Para Pais
- Verificação de telefone (SMS)
- Verificação de e-mail
- Documento de identidade (opcional, mas recomendado)

### Funcionalidades de Segurança
- Rastreamento em tempo real
- Compartilhamento de rota com família
- Botão de emergência
- Histórico de viagens
- Avaliações verificadas
- Chat in-app (sem expor telefone)
- Suporte 24/7

---

## Roadmap de Lançamento

### Fase 1: MVP (3 meses)
**Objetivo:** Validar modelo em 1 cidade

- [ ] App Pais (básico)
  - Cadastro
  - Publicar solicitação
  - Ver ofertas
  - Aceitar oferta
  - Pagamento PIX
  
- [ ] App Motorista (básico)
  - Cadastro com documentos
  - Ver solicitações
  - Fazer oferta
  - Aceitar pagamento
  
- [ ] Backoffice (básico)
  - Aprovação de motoristas
  - Dashboard básico

### Fase 2: Confiança (2 meses)
**Objetivo:** Aumentar segurança e retenção

- [ ] Rastreamento em tempo real
- [ ] Notificações push
- [ ] Chat in-app
- [ ] Sistema de avaliações
- [ ] Check-in/check-out de alunos
- [ ] Verificação de documentos automatizada

### Fase 3: Financeiro (2 meses)
**Objetivo:** Automatizar pagamentos

- [ ] Pagamento recorrente (cartão)
- [ ] Split de pagamento (comissão automática)
- [ ] Carnê virtual
- [ ] Lembretes de pagamento
- [ ] NFS-e automática

### Fase 4: Crescimento (2 meses)
**Objetivo:** Escalar para outras cidades

- [ ] Multi-cidade
- [ ] Indicação (pais indicam pais)
- [ ] Programa de fidelidade
- [ ] Marketing automatizado
- [ ] App para escola (parceria)

### Fase 5: Diferenciação (3 meses)
**Objetivo:** Features premium

- [ ] Roteirização inteligente
- [ ] Previsão de demanda
- [ ] Seguro integrado
- [ ] Financiamento para motoristas
- [ ] API para escolas

---

## 🏆 Diferencial Competitivo

| Aspecto | Tradicional | VanIA |
|---------|-------------|-----------|
| Encontrar van | Indicação boca a boca | App com múltiplas opções |
| Preço | Fixo, sem comparação | Ofertas competitivas |
| Confiança | Só indicação | Documentos verificados |
| Pagamento | Dinheiro/PIX manual | Automático no app |
| Comunicação | WhatsApp pessoal | Chat in-app |
| Rastreamento | Não tem | Tempo real |
| Avaliação | Não tem | Sistema de reviews |
| Transparência | Baixa | Total |

---

## Comparativo com Concorrentes

| Feature | VanIA | Vans Avulsas | Escolas | Uber/99 |
|---------|-----------|--------------|---------|---------|
| Foco em escolar |  |  |  |  |
| Marketplace |  |  |  |  |
| Verificação docs |  |  | Parcial |  |
| Preço negociável |  |  |  |  |
| Recorrência |  | Manual | Manual |  |
| Rastreamento |  |  | Parcial |  |
| Pagamento in-app |  |  | Parcial |  |

---

## Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| Poucos motoristas | Alta | Alto | Onboarding ativo, benefícios iniciais |
| Poucos pais | Alta | Alto | Marketing em escolas, indicação |
| Acidentes | Baixa | Alto | Seguro obrigatório, verificações |
| Regulação | Média | Alto | Compliance com leis municipais |
| Fraude | Média | Médio | Verificação de identidade, ratings |
| Concorrência | Média | Médio | Foco regional, experiência superior |

---

## 📐 Métricas de Sucesso do MVP

**Após 3 meses em 1 cidade:**

- [ ] 500 pais cadastrados
- [ ] 50 motoristas ativos
- [ ] 200 contratos fechados
- [ ] R$ 80k GMV
- [ ] NPS > 40
- [ ] < 5% churn

---

**Documento atualizado em:** Janeiro/2026  
**Versão:** 2.0  
**Status:** Em desenvolvimento
