# EP-APP-MOTORISTA - App Motorista

## Objetivo do Épico

Desenvolver aplicativo mobile (iOS/Android) para motoristas de transporte escolar encontrarem novos clientes, gerenciarem seus alunos, registrarem rotas e receberem pagamentos.

---

## Histórias de Usuário

### US-MOT-01 - Onboarding e Cadastro

**Como** motorista de transporte escolar  
**Quero** me cadastrar no aplicativo  
**Para** começar a oferecer meus serviços

#### Fluxo de Onboarding

```
┌─────────────────────────────────────────┐
│  1. Tela de boas-vindas                 │
│     - Benefícios para motoristas        │
│     - "Quero ser motorista"             │
├─────────────────────────────────────────┤
│  2. Dados pessoais                      │
│     - Nome completo                     │
│     - CPF                               │
│     - Telefone (validação SMS)          │
│     - E-mail                            │
│     - Senha                             │
├─────────────────────────────────────────┤
│  3. Verificação                         │
│     - Código SMS (6 dígitos)            │
├─────────────────────────────────────────┤
│  4. Documentos (CNH)                    │
│     - Upload frente da CNH              │
│     - Upload verso da CNH               │
│     - Selfie com CNH                    │
│     - Categoria D ou E                  │
├─────────────────────────────────────────┤
│  5. Antecedentes                        │
│     - Autorizar consulta                │
│     - Upload atestado (opcional)        │
├─────────────────────────────────────────┤
│  6. Dados do veículo                    │
│     - Placa                             │
│     - Modelo/Marca/Ano                  │
│     - Capacidade                        │
│     - CRLV                              │
│     - Laudo de vistoria                 │
├─────────────────────────────────────────┤
│  7. Fotos do veículo                    │
│     - Frente                            │
│     - Lateral                           │
│     - Interior                          │
│     - Adesivo escolar                   │
├─────────────────────────────────────────┤
│  8. Documentos complementares           │
│     - Alvará municipal                  │
│     - Seguro de passageiros             │
│     - Curso de transporte escolar       │
├─────────────────────────────────────────┤
│  9. Dados bancários                     │
│     - Banco                             │
│     - Agência/Conta                     │
│     - Tipo (PF ou PJ)                   │
│     - Chave PIX                         │
├─────────────────────────────────────────┤
│ 10. Região de atuação                   │
│     - Bairros/Cidades                   │
│     - Escolas atendidas                 │
├─────────────────────────────────────────┤
│ 11. Aguardar aprovação                  │
│     - Cadastro em análise               │
│     - Prazo: 48h                        │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Validação de telefone por SMS
- [ ] **CA02** - Upload de CNH (frente, verso, selfie)
- [ ] **CA03** - Validação de CNH categoria D ou E
- [ ] **CA04** - Upload de documentos do veículo
- [ ] **CA05** - Upload de fotos do veículo (mínimo 4)
- [ ] **CA06** - Validação de placa (consulta API DETRAN)
- [ ] **CA07** - Upload de documentos complementares
- [ ] **CA08** - Salvar progresso parcial
- [ ] **CA09** - Status de análise visível

#### Regras de Negócio

- **RN01** - CNH deve ter categoria D ou E e estar válida
- **RN02** - Veículo deve ter no máximo 15 anos
- **RN03** - Seguro deve estar vigente
- **RN04** - Análise em até 48h úteis
- **RN05** - Motorista só pode operar após aprovação completa

---

### US-MOT-02 - Dashboard Home

**Como** motorista aprovado  
**Quero** ver um painel resumido  
**Para** acompanhar minha operação

#### Tela Home do Motorista

```
┌─────────────────────────────────────────┐
│ ≡                    VanIA        │
├─────────────────────────────────────────┤
│                                         │
│  Olá, Carlos! 👋                        │
│   4.9 (127 avaliações)                │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   Resumo do Mês               │    │
│  │                                 │    │
│  │  Recebido:      R$ 3.420,00    │    │
│  │  A receber:     R$ 1.520,00    │    │
│  │  Inadimplente:    R$ 380,00    │    │
│  │                                 │    │
│  │  [Ver Detalhes]                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   Minha Van                   │    │
│  │                                 │    │
│  │  Alunos: 14/16                  │    │
│  │  Vagas disponíveis: 2           │    │
│  │                                 │    │
│  │  [Ver Alunos]                   │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   Novas Solicitações          │    │
│  │                                 │    │
│  │  5 pais precisam de transporte  │    │
│  │  na sua região                  │    │
│  │                                 │    │
│  │  [Ver Solicitações]             │    │
│  └─────────────────────────────────┘    │
│                                         │
├─────────────────────────────────────────┤
│                              │
│  Home  Buscar   Rota   Chat   Perfil    │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Exibir resumo financeiro do mês
- [ ] **CA02** - Exibir quantidade de alunos/vagas
- [ ] **CA03** - Exibir novas solicitações na região
- [ ] **CA04** - Acesso rápido às principais funções
- [ ] **CA05** - Badge de notificações

---

### US-MOT-03 - Ver Solicitações de Transporte

**Como** motorista  
**Quero** ver solicitações de pais na minha região  
**Para** fazer ofertas e conseguir novos clientes

#### Lista de Solicitações

```
┌─────────────────────────────────────────┐
│ ←  Solicitações na sua Região          │
├─────────────────────────────────────────┤
│                                         │
│   Filtrar: [Todas] [Escolas] [Bairros]│
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   1 criança | 8 anos          │    │
│  │                                 │    │
│  │   Embarque: Jd. das Flores    │    │
│  │   Escola: Colégio ABC         │    │
│  │   Turno: Manhã + Tarde        │    │
│  │                                 │    │
│  │  📏 Distância: 1.2km da rota    │    │
│  │   Orçamento: até R$ 400       │    │
│  │                                 │    │
│  │   Publicado há 2 horas        │    │
│  │  👀 4 ofertas                   │    │
│  │                                 │    │
│  │  [Ver Detalhes]  [Fazer Oferta] │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │  👧 2 crianças | 6 e 9 anos   │    │
│  │                                 │    │
│  │   Embarque: Centro            │    │
│  │   Escola: Escola XYZ          │    │
│  │   Turno: Manhã                │    │
│  │                                 │    │
│  │  📏 Distância: 800m da rota     │    │
│  │   Orçamento: não informado    │    │
│  │                                 │    │
│  │   Publicado há 5 horas        │    │
│  │  👀 2 ofertas                   │    │
│  │                                 │    │
│  │  [Ver Detalhes]  [Fazer Oferta] │    │
│  └─────────────────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘
```

#### Filtros Disponíveis

- Por escola atendida
- Por bairro/região
- Por turno (manhã, tarde, integral)
- Por distância da rota atual
- Por quantidade de crianças
- Por orçamento máximo

#### Critérios de Aceitação

- [ ] **CA01** - Listar solicitações na região
- [ ] **CA02** - Filtrar por escola
- [ ] **CA03** - Filtrar por bairro
- [ ] **CA04** - Filtrar por turno
- [ ] **CA05** - Ver distância da rota atual
- [ ] **CA06** - Ver quantidade de ofertas já feitas
- [ ] **CA07** - Ver detalhes da solicitação
- [ ] **CA08** - Fazer oferta diretamente

#### Regras de Negócio

- **RN01** - Só exibe solicitações de escolas/regiões configuradas
- **RN02** - Solicitações expiram após 7 dias
- **RN03** - Motorista não pode ver nome/contato antes de match

---

### US-MOT-04 - Fazer Oferta

**Como** motorista  
**Quero** fazer uma oferta para uma solicitação  
**Para** conquistar um novo cliente

#### Fluxo de Oferta

```
┌─────────────────────────────────────────┐
│ ←  Fazer Oferta                         │
├─────────────────────────────────────────┤
│                                         │
│   Resumo da Solicitação:              │
│                                         │
│   1 criança | 8 anos                  │
│   Jd. das Flores → Colégio ABC        │
│   Manhã (entrada 07:30)               │
│     Tarde (saída 12:00)                 │
│   Orçamento máx: R$ 400               │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  Sua Oferta:                            │
│                                         │
│   Valor mensal:                       │
│  ┌─────────────────────────────────┐    │
│  │  R$ [    350,00              ]  │    │
│  └─────────────────────────────────┘    │
│                                         │
│   Mensagem para os pais:              │
│  ┌─────────────────────────────────┐    │
│  │  Olá! Atendo essa escola há 5   │    │
│  │  anos. Minha van tem ar-cond,   │    │
│  │  câmeras e rastreamento GPS.    │    │
│  │  A criança será bem cuidada!    │    │
│  └─────────────────────────────────┘    │
│                                         │
│   Posso começar em:                   │
│  ┌─────────────────────────────────┐    │
│  │  [10/02/2026                 ]  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  Seu perfil será exibido:               │
│   4.9 | 5 anos no app | 14 alunos    │
│                                         │
│              [Enviar Oferta]            │
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Definir valor da mensalidade
- [ ] **CA02** - Escrever mensagem personalizada
- [ ] **CA03** - Informar data de início disponível
- [ ] **CA04** - Ver preview do que o pai verá
- [ ] **CA05** - Editar oferta antes de aceite
- [ ] **CA06** - Cancelar oferta
- [ ] **CA07** - Notificação quando oferta for visualizada
- [ ] **CA08** - Notificação quando oferta for aceita/recusada

#### Regras de Negócio

- **RN01** - Uma oferta por solicitação
- **RN02** - Pode editar até ser aceita
- **RN03** - Valor mínimo: R$ 150,00
- **RN04** - Oferta expira com a solicitação

---

### US-MOT-05 - Gerenciar Minhas Ofertas

**Como** motorista  
**Quero** ver o status das minhas ofertas  
**Para** acompanhar as negociações

#### Tela de Ofertas

```
┌─────────────────────────────────────────┐
│ ←  Minhas Ofertas                       │
├─────────────────────────────────────────┤
│                                         │
│  [Pendentes: 3] [Aceitas: 1] [Todas]    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   ACEITA                              │
│  ┌─────────────────────────────────┐    │
│  │   João | Colégio ABC          │    │
│  │   R$ 350/mês                  │    │
│  │   Início: 10/02/2026          │    │
│  │                                 │    │
│  │  Aguardando pagamento do pai    │    │
│  │                                 │    │
│  │  [Ver Contrato]                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│   PENDENTE                            │
│  ┌─────────────────────────────────┐    │
│  │  👧 1 criança | Escola XYZ      │    │
│  │   R$ 380/mês                  │    │
│  │                                 │    │
│  │  👀 Visualizada                 │    │
│  │   Enviada há 1 dia            │    │
│  │                                 │    │
│  │  [Editar]  [Cancelar]  [Chat]   │    │
│  └─────────────────────────────────┘    │
│                                         │
│   PENDENTE                            │
│  ┌─────────────────────────────────┐    │
│  │  👧 2 crianças | Colégio ABC  │    │
│  │   R$ 600/mês                  │    │
│  │                                 │    │
│  │  Ainda não visualizada          │    │
│  │   Enviada há 3 horas          │    │
│  │                                 │    │
│  │  [Editar]  [Cancelar]           │    │
│  └─────────────────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Listar todas as ofertas
- [ ] **CA02** - Filtrar por status
- [ ] **CA03** - Ver se foi visualizada
- [ ] **CA04** - Editar oferta pendente
- [ ] **CA05** - Cancelar oferta pendente
- [ ] **CA06** - Iniciar chat com pai

---

### US-MOT-06 - Lista de Alunos

**Como** motorista  
**Quero** ver a lista de todos os meus alunos  
**Para** gerenciar minha operação

#### Tela de Alunos

```
┌─────────────────────────────────────────┐
│ ←  Meus Alunos (14)                     │
├─────────────────────────────────────────┤
│                                         │
│   Buscar aluno...                     │
│                                         │
│  Filtrar: [Todos] [Escola] [Turno]      │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Colégio ABC (8 alunos)              │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │  João Silva             ativo │    │
│  │    8 anos | Manhã + Tarde       │    │
│  │     R. das Flores, 123        │    │
│  │     Maria (mãe)               │    │
│  │     R$ 380/mês              │    │
│  │    [Detalhes]  [Ligar]  [Chat]  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 👧 Ana Santos            ativo │    │
│  │    6 anos | Manhã               │    │
│  │     Av. Brasil, 456           │    │
│  │     Pedro (pai)               │    │
│  │     R$ 320/mês  Atrasado   │    │
│  │    [Detalhes]  [Ligar]  [Chat]  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ... mais alunos                        │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Escola XYZ (6 alunos)               │
│  ...                                    │
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Listar todos os alunos ativos
- [ ] **CA02** - Agrupar por escola
- [ ] **CA03** - Filtrar por turno
- [ ] **CA04** - Buscar por nome
- [ ] **CA05** - Ver status de pagamento
- [ ] **CA06** - Ver detalhes do aluno
- [ ] **CA07** - Ligar para responsável
- [ ] **CA08** - Chat com responsável

---

### US-MOT-07 - Ficha do Aluno

**Como** motorista  
**Quero** ver os detalhes de cada aluno  
**Para** ter todas as informações necessárias

#### Tela de Detalhes do Aluno

```
┌─────────────────────────────────────────┐
│ ←  João Silva                         │
├─────────────────────────────────────────┤
│                                         │
│                                       │
│        João Silva                       │
│        8 anos                           │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Escola                              │
│     Colégio ABC                         │
│     3º ano - Fundamental I              │
│     Turno: Manhã + Tarde                │
│     Entrada: 07:30 | Saída: 17:30       │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Endereço                            │
│     R. das Flores, 123                  │
│     Jd. Primavera - São Paulo/SP        │
│     [Ver no mapa]                       │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Responsável                         │
│     Maria Silva (Mãe)                   │
│      (11) 99999-8888                  │
│     [Ligar]  [WhatsApp]  [Chat App]     │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Contrato                            │
│     Valor: R$ 380,00/mês                │
│     Vencimento: dia 10                  │
│     Status:  Em dia                   │
│     [Ver pagamentos]                    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Observações                        │
│     - Alergia a amendoim                │
│     - Usa óculos                        │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Contato de emergência               │
│     José Silva (Avô)                    │
│      (11) 99999-7777                  │
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Ver todos os dados do aluno
- [ ] **CA02** - Ver dados da escola
- [ ] **CA03** - Ver endereço com mapa
- [ ] **CA04** - Ver contatos do responsável
- [ ] **CA05** - Ligar/WhatsApp para responsável
- [ ] **CA06** - Ver status de pagamento
- [ ] **CA07** - Ver observações especiais
- [ ] **CA08** - Ver contato de emergência

---

### US-MOT-08 - Iniciar/Gerenciar Rota

**Como** motorista  
**Quero** iniciar e gerenciar minha rota  
**Para** que os pais acompanhem em tempo real

#### Tela de Rota

```
┌─────────────────────────────────────────┐
│ ←  Rota Manhã                         │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │         [MAPA COM ROTA]         │    │
│  │                                 │    │
│  │   1 → 2 → 3 → 4 →             │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│   Rota em andamento                   │
│   Início: 06:45 | Previsão: 07:25    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Ordem de embarque:                  │
│                                         │
│   1. João Silva - 06:50              │
│       Embarcou às 06:52                 │
│                                         │
│   2. Ana Santos - 07:00              │
│       Embarcou às 07:01                 │
│                                         │
│  → 3. Pedro Oliveira - 07:10           │
│       Próximo ponto                     │
│       [Cheguei]  [Ausente]  [Ligar]     │
│                                         │
│  ○ 4. Maria Costa - 07:15              │
│       Aguardando                        │
│                                         │
│  ○ 5. Lucas Lima - 07:20               │
│       Aguardando                        │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Colégio ABC                         │
│     Previsão de chegada: 07:28          │
│                                         │
└─────────────────────────────────────────┘
```

#### Funcionalidades da Rota

- **Iniciar rota** - Começa rastreamento GPS
- **Cheguei** - Notifica pai que chegou no ponto
- **Embarque/Desembarque** - Registra entrada/saída
- **Ausente** - Marca aluno como faltou
- **Problema** - Relata atraso ou ocorrência
- **Finalizar rota** - Encerra rastreamento

#### Critérios de Aceitação

- [ ] **CA01** - Iniciar rota com um toque
- [ ] **CA02** - Ver lista ordenada de embarques
- [ ] **CA03** - Registrar embarque de cada aluno
- [ ] **CA04** - Marcar aluno como ausente
- [ ] **CA05** - Notificar pais automaticamente
- [ ] **CA06** - Ver mapa com trajeto
- [ ] **CA07** - Calcular ETA para cada ponto
- [ ] **CA08** - Registrar horário de chegada na escola
- [ ] **CA09** - Finalizar rota

#### Regras de Negócio

- **RN01** - GPS deve estar ativo durante a rota
- **RN02** - Atualização a cada 15 segundos
- **RN03** - Notifica pai 5 min antes de chegar
- **RN04** - Registra histórico completo da rota

---

### US-MOT-09 - Registro de Presença

**Como** motorista  
**Quero** registrar a presença/ausência dos alunos  
**Para** ter controle e histórico

#### Modos de Registro

1. **Durante a rota** - Embarque/desembarque
2. **Lista de chamada** - Marcar presença manual
3. **Ausência antecipada** - Pai avisa pelo app

#### Critérios de Aceitação

- [ ] **CA01** - Registrar embarque/desembarque
- [ ] **CA02** - Marcar ausente durante rota
- [ ] **CA03** - Ver ausências avisadas pelos pais
- [ ] **CA04** - Histórico de presenças
- [ ] **CA05** - Relatório mensal de frequência

---

### US-MOT-10 - Chat com Pais

**Como** motorista  
**Quero** conversar com os pais pelo app  
**Para** comunicar avisos e responder dúvidas

#### Funcionalidades do Chat

- Chat individual com cada responsável
- Chat em grupo por escola (broadcast)
- Mensagens de texto, fotos, localização
- Mensagens pré-definidas (templates)

#### Templates de Mensagem

- "Estou chegando em 5 minutos"
- "Cheguei no ponto de embarque"
- "Aluno embarcou"
- "Aluno desembarcou na escola"
- "Atrasado por [motivo]"

#### Critérios de Aceitação

- [ ] **CA01** - Chat individual com pais
- [ ] **CA02** - Mensagem broadcast por escola
- [ ] **CA03** - Templates de mensagem rápida
- [ ] **CA04** - Enviar fotos
- [ ] **CA05** - Compartilhar localização
- [ ] **CA06** - Histórico de conversas

---

### US-MOT-11 - Financeiro - Recebimentos

**Como** motorista  
**Quero** ver meus recebimentos  
**Para** controlar meu financeiro

#### Tela Financeira

```
┌─────────────────────────────────────────┐
│ ←  Financeiro                           │
├─────────────────────────────────────────┤
│                                         │
│   Fevereiro 2026                     │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   Resumo do Mês               │    │
│  │                                 │    │
│  │  Total previsto:   R$ 5.320,00 │    │
│  │   Recebido:      R$ 3.420,00 │    │
│  │   A receber:     R$ 1.520,00 │    │
│  │   Inadimplente:   R$ 380,00 │    │
│  │                                 │    │
│  │  Taxa plataforma:   R$ 266,00  │    │
│  │  Líquido:          R$ 3.154,00 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Detalhamento:                       │
│                                         │
│   João Silva      R$ 380,00  10/02   │
│   Ana Santos      R$ 320,00  10/02   │
│   Pedro Oliveira  R$ 350,00  10/02   │
│   Maria Costa     R$ 400,00  Venc 15 │
│   Lucas Lima      R$ 380,00  Venc 15 │
│   Julia Souza    R$ 380,00  Atraso  │
│      [Cobrar]  [Chat]                   │
│  ...                                    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  [ Ver Relatório Completo]            │
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Ver resumo do mês
- [ ] **CA02** - Ver detalhes por aluno
- [ ] **CA03** - Filtrar por status (pago, pendente, atrasado)
- [ ] **CA04** - Ver taxa da plataforma
- [ ] **CA05** - Ver valor líquido
- [ ] **CA06** - Enviar cobrança pelo app
- [ ] **CA07** - Histórico de meses anteriores
- [ ] **CA08** - Exportar relatório

#### Regras de Negócio

- **RN01** - Taxa da plataforma: 5% (configurável)
- **RN02** - Repasse em D+2 após pagamento confirmado
- **RN03** - Inadimplência após 5 dias de atraso

---

### US-MOT-12 - Emitir Recibo / NFS-e

**Como** motorista  
**Quero** emitir recibos e notas fiscais  
**Para** formalizar os recebimentos

#### Opções de Documento

1. **Recibo simples** - Gerado automaticamente
2. **NFS-e** - Via integração (se MEI/PJ)

#### Critérios de Aceitação

- [ ] **CA01** - Gerar recibo automático após pagamento
- [ ] **CA02** - Personalizar dados do recibo
- [ ] **CA03** - Emitir NFS-e (para MEI/PJ)
- [ ] **CA04** - Enviar recibo por e-mail/WhatsApp
- [ ] **CA05** - Histórico de documentos emitidos

---

### US-MOT-13 - Avaliações Recebidas

**Como** motorista  
**Quero** ver as avaliações dos pais  
**Para** melhorar meu serviço

#### Tela de Avaliações

```
┌─────────────────────────────────────────┐
│ ←  Minhas Avaliações                    │
├─────────────────────────────────────────┤
│                                         │
│                                │
│             4.9                         │
│         127 avaliações                  │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Detalhamento:                       │
│                                         │
│  Pontualidade        4.9  ▊  │
│  Comunicação         4.8  ▋  │
│  Cuidado c/ crianças  5.0    │
│  Veículo             4.7  ▌  │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Comentários recentes:               │
│                                         │
│   "Excelente profissional!    │
│  Meu filho adora ir na van do Carlos."  │
│  - Maria S. | há 3 dias                 │
│                                         │
│   "Muito pontual e            │
│  responsável. Recomendo!"               │
│  - Pedro O. | há 1 semana               │
│                                         │
│   "Bom serviço, mas às vezes  │
│  demora para responder mensagens."      │
│  - Ana L. | há 2 semanas                │
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Ver nota média geral
- [ ] **CA02** - Ver notas por critério
- [ ] **CA03** - Ver comentários
- [ ] **CA04** - Responder comentários (opcional)
- [ ] **CA05** - Filtrar por período

---

### US-MOT-14 - Meu Perfil Público

**Como** motorista  
**Quero** gerenciar meu perfil público  
**Para** atrair mais clientes

#### Informações do Perfil

- Foto profissional
- Bio/descrição
- Escolas atendidas
- Regiões de atuação
- Fotos do veículo
- Diferenciais (ar-cond, câmeras, etc)
- Vagas disponíveis

#### Critérios de Aceitação

- [ ] **CA01** - Editar foto de perfil
- [ ] **CA02** - Editar descrição
- [ ] **CA03** - Gerenciar escolas atendidas
- [ ] **CA04** - Gerenciar regiões
- [ ] **CA05** - Atualizar fotos do veículo
- [ ] **CA06** - Informar vagas disponíveis
- [ ] **CA07** - Preview do perfil público

---

### US-MOT-15 - Documentos e Verificações

**Como** motorista  
**Quero** manter meus documentos atualizados  
**Para** continuar operando regularmente

#### Documentos Monitorados

| Documento | Validade | Renovação |
|-----------|----------|-----------|
| CNH | Anual | 30 dias antes |
| Seguro | Anual | 30 dias antes |
| Vistoria | Semestral | 15 dias antes |
| Alvará | Anual | 30 dias antes |
| Antecedentes | - | Anual |

#### Critérios de Aceitação

- [ ] **CA01** - Ver status de cada documento
- [ ] **CA02** - Alerta de vencimento
- [ ] **CA03** - Upload de documento atualizado
- [ ] **CA04** - Histórico de documentos
- [ ] **CA05** - Bloqueio automático se expirado

#### Regras de Negócio

- **RN01** - 30 dias antes: aviso amarelo
- **RN02** - 7 dias antes: aviso vermelho
- **RN03** - Expirado: conta suspensa

---

### US-MOT-16 - Configurações

**Como** motorista  
**Quero** configurar minha conta  
**Para** personalizar o aplicativo

#### Configurações Disponíveis

**Conta:**
- Dados pessoais
- Dados bancários
- Alterar senha
- Verificação em 2 etapas

**Notificações:**
- Novas solicitações
- Mensagens
- Pagamentos
- Documentos

**Veículo:**
- Dados do veículo
- Capacidade
- Fotos

**Operação:**
- Escolas atendidas
- Regiões de atuação
- Disponibilidade

---

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US-MOT-01 | 13 | Alta |
| US-MOT-02 | 5 | Alta |
| US-MOT-03 | 8 | Alta |
| US-MOT-04 | 5 | Alta |
| US-MOT-05 | 3 | Alta |
| US-MOT-06 | 5 | Alta |
| US-MOT-07 | 3 | Alta |
| US-MOT-08 | 13 | Alta |
| US-MOT-09 | 5 | Média |
| US-MOT-10 | 8 | Média |
| US-MOT-11 | 8 | Alta |
| US-MOT-12 | 5 | Média |
| US-MOT-13 | 3 | Média |
| US-MOT-14 | 5 | Média |
| US-MOT-15 | 5 | Alta |
| US-MOT-16 | 3 | Baixa |
| **Total** | **97** | |

---

## Wireframes Mobile

### Tela Home (Motorista)

```
┌─────────────────────────────────────────┐
│ ≡                    VanIA        │
├─────────────────────────────────────────┤
│                                         │
│  Bom dia, Carlos! 👋                    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │  [ Iniciar Rota da Manhã]     │    │
│  │                                 │    │
│  │  8 alunos | Colégio ABC         │    │
│  │  Início previsto: 06:45         │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌──────────┐  ┌──────────┐             │
│  │        │  │        │             │
│  │ R$3.420  │  │ 14       │             │
│  │ Recebido │  │ Alunos   │             │
│  └──────────┘  └──────────┘             │
│                                         │
│  ┌──────────┐  ┌──────────┐             │
│  │        │  │        │             │
│  │ 5        │  │ 4.9      │             │
│  │ Novos    │  │ Rating   │             │
│  └──────────┘  └──────────┘             │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Atividade recente:                  │
│                                         │
│  • Nova solicitação - Jd. Flores        │
│  • Pagamento recebido - R$ 380          │
│  • Mensagem de Maria Silva              │
│                                         │
├─────────────────────────────────────────┤
│                              │
│  Home  Buscar   Rota   Chat   Perfil    │
└─────────────────────────────────────────┘
```

### Tela de Rota Ativa

```
┌─────────────────────────────────────────┐
│ ←  Rota Manhã                         │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │         [MAPA GPS]              │    │
│  │                                 │    │
│  │     Próximo ponto: 800m       │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  Próximo: Pedro Oliveira               │
│   R. das Palmeiras, 456              │
│   Chegada em 2 min                   │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │  [    CHEGUEI   ]             │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   João Silva          06:52          │
│   Ana Santos          07:01          │
│  → Pedro Oliveira      chegando...     │
│  ○ Maria Costa         07:15           │
│  ○ Lucas Lima          07:20           │
│                                         │
│   Colégio ABC - ETA 07:28            │
│                                         │
└─────────────────────────────────────────┘
```
