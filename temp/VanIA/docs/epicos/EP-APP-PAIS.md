# EP-APP-PAIS - App Pais/Responsáveis

## Objetivo do Épico

Desenvolver aplicativo mobile (iOS/Android) para pais e responsáveis encontrarem, contratarem e acompanharem o transporte escolar de seus filhos de forma segura e transparente.

---

## Histórias de Usuário

### US-PAIS-01 - Onboarding e Cadastro

**Como** pai/responsável  
**Quero** me cadastrar no aplicativo  
**Para** começar a buscar transporte escolar

#### Fluxo de Onboarding

```
┌─────────────────────────────────────────┐
│  1. Tela de boas-vindas                 │
│     - Carrossel de benefícios           │
│     - "Começar" / "Já tenho conta"      │
├─────────────────────────────────────────┤
│  2. Cadastro                            │
│     - Nome completo                     │
│     - Telefone (validação SMS)          │
│     - E-mail                            │
│     - Senha                             │
│     - OU login social (Google/Apple)    │
├─────────────────────────────────────────┤
│  3. Verificação                         │
│     - Código SMS (6 dígitos)            │
│     - Reenviar código                   │
├─────────────────────────────────────────┤
│  4. Dados básicos                       │
│     - CPF (validação)                   │
│     - Endereço (CEP + autocomplete)     │
├─────────────────────────────────────────┤
│  5. Cadastrar primeiro filho            │
│     - Nome                              │
│     - Data nascimento                   │
│     - Escola                            │
│     - Turno                             │
├─────────────────────────────────────────┤
│  6. Permissões                          │
│     - Notificações                      │
│     - Localização                       │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Cadastro com telefone + SMS OTP
- [ ] **CA02** - Login social (Google, Apple)
- [ ] **CA03** - Validação de CPF
- [ ] **CA04** - Busca de endereço por CEP
- [ ] **CA05** - Permitir pular cadastro de filho (fazer depois)
- [ ] **CA06** - Termos de uso e política de privacidade
- [ ] **CA07** - Recuperação de senha

#### Regras de Negócio

- **RN01** - Telefone deve ser único no sistema
- **RN02** - CPF deve ser único no sistema
- **RN03** - Código SMS expira em 5 minutos
- **RN04** - Máximo 3 tentativas de SMS por hora

---

### US-PAIS-02 - Cadastro de Filhos

**Como** pai/responsável  
**Quero** cadastrar meus filhos no aplicativo  
**Para** solicitar transporte para eles

#### Campos do Filho

**Obrigatórios:**
- Nome completo
- Data de nascimento
- Escola (busca ou cadastro)
- Série/ano
- Turno (manhã, tarde, integral)
- Endereço de embarque (se diferente do responsável)

**Opcionais:**
- Foto
- Necessidades especiais
- Alergias/condições médicas
- Pessoa autorizada para emergência
- Observações para o motorista

#### Critérios de Aceitação

- [ ] **CA01** - Cadastrar múltiplos filhos
- [ ] **CA02** - Buscar escola por nome ou endereço
- [ ] **CA03** - Cadastrar escola nova (se não existir)
- [ ] **CA04** - Endereço de embarque diferente por filho
- [ ] **CA05** - Upload de foto do filho
- [ ] **CA06** - Editar/excluir filho

#### Regras de Negócio

- **RN01** - Idade mínima: 3 anos / máxima: 18 anos
- **RN02** - Filho com contrato ativo não pode ser excluído

---

### US-PAIS-03 - Publicar Solicitação de Transporte

**Como** pai/responsável  
**Quero** publicar que preciso de transporte escolar  
**Para** receber ofertas de motoristas

#### Fluxo de Publicação

```
┌─────────────────────────────────────────┐
│  1. Selecionar filho(s)                 │
│     - Lista de filhos cadastrados       │
│     - Checkbox para seleção múltipla    │
├─────────────────────────────────────────┤
│  2. Confirmar endereços                 │
│     - Embarque (casa)                   │
│     - Desembarque (escola)              │
│     - Mapa com preview do trajeto       │
├─────────────────────────────────────────┤
│  3. Definir turno                       │
│     - Manhã (ida)                       │
│     - Tarde (volta)                     │
│     - Integral (ida + volta)            │
│     - Horários específicos              │
├─────────────────────────────────────────┤
│  4. Informações adicionais              │
│     - Data de início desejada           │
│     - Observações                       │
│     - Preferências (ar-cond., etc)      │
├─────────────────────────────────────────┤
│  5. Orçamento (opcional)                │
│     - Valor máximo que pode pagar       │
│     - Ou deixar em branco               │
├─────────────────────────────────────────┤
│  6. Publicar                            │
│     - Resumo da solicitação             │
│     - Botão "Publicar Solicitação"      │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Selecionar um ou mais filhos
- [ ] **CA02** - Confirmar/editar endereços
- [ ] **CA03** - Ver trajeto no mapa
- [ ] **CA04** - Definir turno e horários
- [ ] **CA05** - Informar valor máximo (opcional)
- [ ] **CA06** - Adicionar observações
- [ ] **CA07** - Notificação quando receber ofertas
- [ ] **CA08** - Editar solicitação antes de receber ofertas
- [ ] **CA09** - Cancelar solicitação

#### Regras de Negócio

- **RN01** - Solicitação fica ativa por 7 dias
- **RN02** - Após 7 dias sem aceite, expira (pode republicar)
- **RN03** - Máximo 3 solicitações ativas por pai
- **RN04** - Filho já em contrato não pode ter nova solicitação

---

### US-PAIS-04 - Visualizar e Comparar Ofertas

**Como** pai/responsável  
**Quero** ver as ofertas de motoristas  
**Para** escolher a melhor opção

#### Tela de Ofertas

```
┌─────────────────────────────────────────┐
│  João → Escola ABC                    │
│    Manhã + Tarde | Publicado há 2h      │
├─────────────────────────────────────────┤
│                                         │
│   3 ofertas recebidas                 │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │  Carlos Silva         4.9   │    │
│  │  Van Renault Master 2022      │    │
│  │  800m do seu endereço         │    │
│  │  12/15 vagas ocupadas         │    │
│  │                                 │    │
│  │  R$ 380,00/mês                │    │
│  │                                 │    │
│  │ [Ver Perfil]  [Conversar]       │    │
│  │                    [Aceitar]    │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │  Maria Santos         4.7   │    │
│  │  Van Fiat Ducato 2021         │    │
│  │  1.2km do seu endereço        │    │
│  │  8/16 vagas ocupadas          │    │
│  │                                 │    │
│  │  R$ 420,00/mês                │    │
│  │                                 │    │
│  │ [Ver Perfil]  [Conversar]       │    │
│  │                    [Aceitar]    │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │  Pedro Oliveira       4.5   │    │
│  │ ...                             │    │
│  └─────────────────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘
```

#### Informações da Oferta

- Foto e nome do motorista
- Avaliação (estrelas + qtd reviews)
- Veículo (modelo, ano, foto)
- Distância do endereço
- Vagas ocupadas/total
- Valor mensal proposto
- Mensagem do motorista
- Tempo de resposta

#### Critérios de Aceitação

- [ ] **CA01** - Listar ofertas ordenadas (mais recentes)
- [ ] **CA02** - Ordenar por: preço, avaliação, distância
- [ ] **CA03** - Ver perfil completo do motorista
- [ ] **CA04** - Ver fotos do veículo
- [ ] **CA05** - Ver documentos verificados (selo)
- [ ] **CA06** - Ver avaliações de outros pais
- [ ] **CA07** - Iniciar conversa pelo chat
- [ ] **CA08** - Aceitar oferta

#### Regras de Negócio

- **RN01** - Só pode aceitar uma oferta por solicitação
- **RN02** - Ao aceitar, outras ofertas são recusadas automaticamente
- **RN03** - Motorista é notificado quando oferta é visualizada

---

### US-PAIS-05 - Perfil do Motorista

**Como** pai/responsável  
**Quero** ver o perfil detalhado do motorista  
**Para** ter confiança na contratação

#### Informações do Perfil

**Dados Pessoais:**
- Nome completo
- Foto
- Tempo de experiência
- Escolas que atende
- Região de atuação

**Verificações (selos):**
-  CNH verificada
-  Antecedentes verificados
-  Veículo vistoriado
-  Seguro ativo
-  Alvará municipal

**Veículo:**
- Modelo e ano
- Fotos (frente, lateral, interior)
- Capacidade
- Ar condicionado
- Câmeras de segurança (sim/não)
- Monitoramento GPS (sim/não)

**Avaliações:**
- Nota geral (1-5 estrelas)
- Quantidade de avaliações
- Comentários recentes
- Depoimentos

**Estatísticas:**
- Tempo no app
- Quantidade de alunos transportados
- Taxa de pontualidade
- Taxa de cancelamento

#### Critérios de Aceitação

- [ ] **CA01** - Exibir todas as verificações
- [ ] **CA02** - Galeria de fotos do veículo
- [ ] **CA03** - Lista de avaliações com filtro
- [ ] **CA04** - Botão para conversar
- [ ] **CA05** - Botão para aceitar oferta
- [ ] **CA06** - Reportar perfil

---

### US-PAIS-06 - Chat com Motorista

**Como** pai/responsável  
**Quero** conversar com o motorista  
**Para** tirar dúvidas e negociar

#### Funcionalidades do Chat

- Mensagens de texto
- Envio de fotos
- Envio de localização
- Áudio (opcional)
- Histórico preservado
- Notificação de novas mensagens

#### Critérios de Aceitação

- [ ] **CA01** - Chat em tempo real
- [ ] **CA02** - Histórico de conversas
- [ ] **CA03** - Push notification de mensagens
- [ ] **CA04** - Enviar fotos
- [ ] **CA05** - Compartilhar localização
- [ ] **CA06** - Indicador de online/offline
- [ ] **CA07** - Indicador de "digitando..."
- [ ] **CA08** - Chat disponível antes e depois do contrato

#### Regras de Negócio

- **RN01** - Telefone não é exibido no chat (privacidade)
- **RN02** - Chat é moderado (filtro de palavras)
- **RN03** - Histórico mantido por 12 meses

---

### US-PAIS-07 - Aceitar Oferta e Contratar

**Como** pai/responsável  
**Quero** aceitar uma oferta  
**Para** contratar o transporte escolar

#### Fluxo de Contratação

```
┌─────────────────────────────────────────┐
│  1. Revisar detalhes                    │
│     - Resumo da oferta                  │
│     - Valor mensal                      │
│     - Data de início                    │
│     - Horários acordados                │
├─────────────────────────────────────────┤
│  2. Dados do contrato                   │
│     - Período (mensal, semestral, anual)│
│     - Dia de vencimento                 │
│     - Dados para nota fiscal            │
├─────────────────────────────────────────┤
│  3. Forma de pagamento                  │
│     - PIX                               │
│     - Cartão de crédito                 │
│     - Boleto                            │
├─────────────────────────────────────────┤
│  4. Aceitar termos                      │
│     - Contrato de prestação de serviço  │
│     - Política de cancelamento          │
├─────────────────────────────────────────┤
│  5. Pagamento                           │
│     - Primeira mensalidade              │
│     - Confirmação                       │
├─────────────────────────────────────────┤
│  6. Confirmação                         │
│     - Contrato ativo!                   │
│     - Dados do motorista                │
│     - Próximos passos                   │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Revisar todos os detalhes antes de confirmar
- [ ] **CA02** - Escolher forma de pagamento
- [ ] **CA03** - Aceitar termos do contrato
- [ ] **CA04** - Realizar primeiro pagamento
- [ ] **CA05** - Receber confirmação por push e e-mail
- [ ] **CA06** - Contrato disponível em PDF
- [ ] **CA07** - Motorista é notificado

#### Regras de Negócio

- **RN01** - Contrato só é ativado após pagamento confirmado
- **RN02** - Motorista tem 24h para confirmar (senão cancela)
- **RN03** - 7 dias de teste com reembolso integral

---

### US-PAIS-08 - Acompanhar Transporte (Rastreamento)

**Como** pai/responsável  
**Quero** acompanhar a van em tempo real  
**Para** saber onde meu filho está

#### Tela de Rastreamento

```
┌─────────────────────────────────────────┐
│                                         │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │           MAPA               │    │
│  │                                 │    │
│  │      Casa                     │    │
│  │       \                        │    │
│  │        \   ← Van aqui        │    │
│  │         \   (2 min)            │    │
│  │          \                     │    │
│  │            Escola            │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   João                                │
│  Status:  A caminho da escola        │
│                                         │
│   Previsão de chegada: 07:25         │
│   Última atualização: agora          │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Histórico de hoje:                  │
│  • 07:05 - Embarcou em casa            │
│  • 07:10 - Parou na Rua das Flores     │
│  • 07:18 - Posição atual               │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  [ Ligar]  [ Chat]  [ Compartilhar]│
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Ver posição da van em tempo real
- [ ] **CA02** - Ver trajeto no mapa
- [ ] **CA03** - Previsão de chegada (ETA)
- [ ] **CA04** - Status do filho (aguardando, embarcou, desembarcou)
- [ ] **CA05** - Histórico de pontos do dia
- [ ] **CA06** - Compartilhar localização com terceiros
- [ ] **CA07** - Notificação quando van estiver chegando
- [ ] **CA08** - Notificação quando filho embarcar/desembarcar

#### Regras de Negócio

- **RN01** - Rastreamento só durante horário de rota
- **RN02** - Atualização a cada 15 segundos
- **RN03** - Histórico disponível por 30 dias

---

### US-PAIS-09 - Notificações

**Como** pai/responsável  
**Quero** receber notificações  
**Para** acompanhar o transporte sem abrir o app

#### Tipos de Notificação

| Evento | Push | E-mail | SMS |
|--------|------|--------|-----|
| Nova oferta recebida |  |  |  |
| Mensagem no chat |  |  |  |
| Oferta aceita/recusada |  |  |  |
| Van chegando (5 min) |  |  |  |
| Filho embarcou |  |  |  |
| Filho desembarcou |  |  |  |
| Cobrança gerada |  |  |  |
| Pagamento confirmado |  |  |  |
| Pagamento atrasado |  |  |  |
| Motorista cancelou |  |  |  |

#### Critérios de Aceitação

- [ ] **CA01** - Push notifications configuráveis
- [ ] **CA02** - Configurar quais notificações receber
- [ ] **CA03** - Horário de não perturbe
- [ ] **CA04** - Notificações agrupadas
- [ ] **CA05** - Deep link para tela relevante

---

### US-PAIS-10 - Pagamentos

**Como** pai/responsável  
**Quero** pagar a mensalidade pelo app  
**Para** ter praticidade e histórico

#### Formas de Pagamento

- **PIX** (instantâneo)
- **Cartão de crédito** (recorrente)
- **Boleto** (3 dias úteis)

#### Tela de Pagamentos

```
┌─────────────────────────────────────────┐
│  Pagamentos                           │
├─────────────────────────────────────────┤
│                                         │
│  Próximo vencimento: 10/02/2026         │
│  Valor: R$ 380,00                       │
│                                         │
│  [Pagar Agora]                          │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Forma de pagamento salva:           │
│  •••• 4589 (Visa)  [Alterar]            │
│                                         │
│  [] Pagamento automático ativado       │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   Histórico:                          │
│                                         │
│  Jan/2026  R$ 380,00   Pago  [Recibo] │
│  Dez/2025  R$ 380,00   Pago  [Recibo] │
│  Nov/2025  R$ 380,00   Pago  [Recibo] │
│                                         │
└─────────────────────────────────────────┘
```

#### Critérios de Aceitação

- [ ] **CA01** - Ver próximo vencimento
- [ ] **CA02** - Pagar com PIX (QR Code + copia-cola)
- [ ] **CA03** - Pagar com cartão salvo
- [ ] **CA04** - Cadastrar novo cartão
- [ ] **CA05** - Ativar pagamento automático
- [ ] **CA06** - Histórico de pagamentos
- [ ] **CA07** - Download de recibo/nota

#### Regras de Negócio

- **RN01** - Pagamento automático 3 dias antes do vencimento
- **RN02** - Notificação se cartão recusado
- **RN03** - Multa após 5 dias de atraso

---

### US-PAIS-11 - Avaliar Motorista

**Como** pai/responsável  
**Quero** avaliar o motorista  
**Para** ajudar outros pais e dar feedback

#### Critérios de Avaliação

- **Nota geral** (1-5 estrelas)
- **Pontualidade** (1-5)
- **Comunicação** (1-5)
- **Cuidado com crianças** (1-5)
- **Condição do veículo** (1-5)
- **Comentário** (opcional)

#### Critérios de Aceitação

- [ ] **CA01** - Solicitar avaliação mensalmente
- [ ] **CA02** - Avaliar após 7 dias de uso
- [ ] **CA03** - Critérios específicos
- [ ] **CA04** - Comentário opcional
- [ ] **CA05** - Editar avaliação em até 7 dias
- [ ] **CA06** - Avaliação anônima (opcional)

#### Regras de Negócio

- **RN01** - Só pode avaliar motorista com contrato ativo/encerrado
- **RN02** - Uma avaliação por mês

---

### US-PAIS-12 - Cancelar Contrato

**Como** pai/responsável  
**Quero** cancelar o contrato  
**Para** encerrar o serviço

#### Fluxo de Cancelamento

1. Solicitar cancelamento
2. Informar motivo
3. Ver política de cancelamento
4. Confirmar data de encerramento
5. Confirmação

#### Política de Cancelamento

- Primeiros 7 dias: reembolso integral
- Após 7 dias: aviso de 30 dias ou multa de 1 mensalidade
- Proporcional se no meio do mês

#### Critérios de Aceitação

- [ ] **CA01** - Solicitar cancelamento pelo app
- [ ] **CA02** - Informar motivo (obrigatório)
- [ ] **CA03** - Ver valor de multa/reembolso
- [ ] **CA04** - Definir última data de uso
- [ ] **CA05** - Confirmação por e-mail
- [ ] **CA06** - Motorista é notificado

---

### US-PAIS-13 - Configurações e Perfil

**Como** pai/responsável  
**Quero** gerenciar meus dados e configurações  
**Para** manter informações atualizadas

#### Configurações Disponíveis

**Perfil:**
- Editar dados pessoais
- Alterar foto
- Alterar endereço
- Gerenciar filhos

**Conta:**
- Alterar senha
- Alterar e-mail
- Gerenciar cartões
- Excluir conta

**Notificações:**
- Configurar cada tipo
- Horário de não perturbe

**Privacidade:**
- Compartilhamento de dados
- Exportar dados (LGPD)

**Suporte:**
- Central de ajuda
- Chat com suporte
- Reportar problema

---

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US-PAIS-01 | 8 | Alta |
| US-PAIS-02 | 5 | Alta |
| US-PAIS-03 | 8 | Alta |
| US-PAIS-04 | 5 | Alta |
| US-PAIS-05 | 3 | Alta |
| US-PAIS-06 | 8 | Alta |
| US-PAIS-07 | 8 | Alta |
| US-PAIS-08 | 13 | Alta |
| US-PAIS-09 | 5 | Média |
| US-PAIS-10 | 8 | Alta |
| US-PAIS-11 | 3 | Média |
| US-PAIS-12 | 5 | Média |
| US-PAIS-13 | 5 | Média |
| **Total** | **84** | |

---

## Wireframes Mobile

### Tela Home (Pais)

```
┌─────────────────────────────────────────┐
│ ≡                    VanIA        │
├─────────────────────────────────────────┤
│                                         │
│  Olá, Maria! 👋                         │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   João                        │    │
│  │  Escola ABC | Manhã + Tarde     │    │
│  │                                 │    │
│  │   Carlos Silva                │    │
│  │  Status:  Ativo               │    │
│  │                                 │    │
│  │  [Rastrear]  [Mensagem]         │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │  👧 Ana                         │    │
│  │  Colégio XYZ | Manhã            │    │
│  │                                 │    │
│  │   Buscando transporte...      │    │
│  │  3 ofertas recebidas            │    │
│  │                                 │    │
│  │  [Ver Ofertas]                  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  [+ Adicionar Filho]                    │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│   Próximo pagamento: 10/02           │
│     R$ 380,00                           │
│     [Pagar Agora]                       │
│                                         │
├─────────────────────────────────────────┤
│                                │
│  Home   Buscar   Chat   Perfil          │
└─────────────────────────────────────────┘
```

### Tela de Publicar Solicitação

```
┌─────────────────────────────────────────┐
│ ←  Solicitar Transporte                 │
├─────────────────────────────────────────┤
│                                         │
│  Passo 1 de 4                           │
│  ━━━━━━━━━━━━○○○○                       │
│                                         │
│  Selecione o(s) filho(s):               │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ ☑️  João                      │    │
│  │    8 anos | Escola ABC          │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ ☐ 👧 Ana                        │    │
│  │    6 anos | Colégio XYZ         │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ + Cadastrar novo filho          │    │
│  └─────────────────────────────────┘    │
│                                         │
│                                         │
│                                         │
│                                         │
│                                         │
│                                         │
│              [Próximo →]                │
│                                         │
└─────────────────────────────────────────┘
```

### Tela de Rastreamento

```
┌─────────────────────────────────────────┐
│ ←  Rastreamento                       │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │                                 │    │
│  │         [MAPA GOOGLE]           │    │
│  │                                 │    │
│  │     --------  -------    │    │
│  │                                 │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│   João está na van                    │
│                                         │
│   Van a 800m da escola               │
│   Chegada em ~3 minutos               │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│  Motorista: Carlos Silva                │
│  Placa: ABC-1234                        │
│                                         │
│  ─────────────────────────────────────  │
│                                         │
│    [ Ligar]      [ Mensagem]       │
│                                         │
└─────────────────────────────────────────┘
```
