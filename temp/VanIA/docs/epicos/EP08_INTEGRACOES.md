# EP08 - Integrações e Exportações

## Objetivo do Épico

Integrar o sistema com serviços externos (WhatsApp, pagamentos, NFS-e) e fornecer exportações de dados para contabilidade e análise, garantindo uma operação conectada e automatizada.

---

## Histórias de Usuário

### US08.01 - Integração WhatsApp Business API

**Como** transportador  
**Quero** enviar mensagens automáticas pelo WhatsApp  
**Para** ter maior taxa de entrega e engajamento

#### Provedor Suportado

- WhatsApp Business API (via Meta)
- Agregadores: Twilio, MessageBird, Take Blip, Z-API

#### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Envio de texto | Mensagens simples |
| Templates | Mensagens pré-aprovadas (HSM) |
| Mídia | PDF (contrato, boleto) |
| Botões | Ações rápidas |

#### Critérios de Aceitação

- [ ] **CA01** - Configuração de API/Token
- [ ] **CA02** - Cadastro de templates homologados
- [ ] **CA03** - Envio individual e em lote
- [ ] **CA04** - Status de entrega (enviado, entregue, lido)
- [ ] **CA05** - Limite de envios por hora (evitar bloqueio)
- [ ] **CA06** - Fallback se API indisponível

#### Templates Necessários

| Template | Uso | Variáveis |
|----------|-----|-----------|
| `cobranca_vencimento` | Cobrança próxima | nome, aluno, valor, vencimento, pix |
| `cobranca_atraso` | Cobrança atrasada | nome, aluno, valor, dias_atraso |
| `contrato_envio` | Envio de contrato | nome, aluno, link |
| `pagamento_confirmado` | Confirmação | nome, aluno, valor, referencia |

#### Regras de Negócio

- **RN01** - Templates devem ser aprovados pela Meta (24-48h)
- **RN02** - Mensagens fora de template só em janela de 24h
- **RN03** - Respeitar opt-out do usuário
- **RN04** - Máximo 1000 msg/dia por número (tier inicial)

---

### US08.02 - Integração E-mail (SMTP/API)

**Como** transportador  
**Quero** enviar e-mails automaticamente  
**Para** comunicação formal e backup do WhatsApp

#### Provedores Suportados

- SMTP próprio
- SendGrid
- Amazon SES
- Mailgun

#### Critérios de Aceitação

- [ ] **CA01** - Configuração de SMTP ou API
- [ ] **CA02** - Templates HTML responsivos
- [ ] **CA03** - Envio com anexos (PDF)
- [ ] **CA04** - Rastreamento de abertura/clique
- [ ] **CA05** - Unsubscribe (LGPD)
- [ ] **CA06** - Domínio verificado (SPF/DKIM)

#### Regras de Negócio

- **RN01** - E-mail deve ter versão texto plano
- **RN02** - Link de unsubscribe obrigatório
- **RN03** - Bounce/spam management

---

### US08.03 - Integração Gateway de Pagamento

**Como** transportador  
**Quero** integrar com gateway de pagamento  
**Para** gerar PIX/boleto e receber automaticamente

#### Gateways Suportados

- Asaas (recomendado)
- PagSeguro
- Mercado Pago
- Pagar.me
- Iugu

#### Funcionalidades por Gateway

| Funcionalidade | Asaas | PagSeguro | Mercado Pago |
|----------------|-------|-----------|--------------|
| PIX |  |  |  |
| Boleto |  |  |  |
| Cartão recorrente |  |  |  |
| Webhook |  |  |  |
| Split |  |  |  |

#### Critérios de Aceitação

- [ ] **CA01** - Configuração de API Key/Token
- [ ] **CA02** - Ambiente sandbox para testes
- [ ] **CA03** - Criação de cobrança PIX
- [ ] **CA04** - Criação de boleto
- [ ] **CA05** - Webhook de confirmação de pagamento
- [ ] **CA06** - Consulta de status
- [ ] **CA07** - Tratamento de erros

#### Fluxo de Webhook

```
Gateway                    Sistema
   │                          │
   │ POST /webhook/pagamento  │
   ├─────────────────────────>│
   │                          │ Valida assinatura
   │                          │ Identifica parcela (txid)
   │                          │ Marca como paga
   │                          │ Dispara eventos
   │      200 OK              │
   │<─────────────────────────┤
```

#### Regras de Negócio

- **RN01** - Webhook deve validar assinatura/origem
- **RN02** - Idempotência (mesmo webhook não processa 2x)
- **RN03** - Retry em caso de falha
- **RN04** - Log de todas as transações

---

### US08.04 - Integração NFS-e (Agregador)

**Como** transportador  
**Quero** integrar com agregador de NFS-e  
**Para** emitir notas sem me preocupar com cada prefeitura

#### Agregadores Suportados

- NFE.io
- Enotas
- Tecnospeed
- Webmaniacs

#### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Emissão | Enviar RPS e receber NFS-e |
| Consulta | Verificar status da nota |
| Cancelamento | Cancelar nota emitida |
| Download | Obter XML e PDF |

#### Critérios de Aceitação

- [ ] **CA01** - Configuração de API
- [ ] **CA02** - Cadastro de empresa no agregador
- [ ] **CA03** - Emissão de nota via API
- [ ] **CA04** - Consulta de status
- [ ] **CA05** - Download de XML/PDF
- [ ] **CA06** - Webhook de retorno
- [ ] **CA07** - Ambiente de homologação

#### Regras de Negócio

- **RN01** - Certificado digital pode ser no agregador
- **RN02** - Custo por nota (informar ao usuário)
- **RN03** - Timeout de resposta (nota pode demorar)

---

### US08.05 - Integração Assinatura Digital (V2)

**Como** transportador  
**Quero** integrar com serviço de assinatura digital  
**Para** contratos com validade jurídica

#### Provedores Suportados

- Clicksign
- DocuSign
- D4Sign

#### Critérios de Aceitação

- [ ] **CA01** - Upload de documento para assinatura
- [ ] **CA02** - Definir signatários
- [ ] **CA03** - Envio de solicitação
- [ ] **CA04** - Webhook de conclusão
- [ ] **CA05** - Download do documento assinado
- [ ] **CA06** - Histórico de assinaturas

---

### US08.06 - Exportação Contábil

**Como** transportador  
**Quero** exportar dados para a contabilidade  
**Para** facilitar o fechamento mensal

#### Conteúdo do Pacote

```
 Exportacao_Jan_2026/
├──  DRE_Jan_2026.pdf
├──  DRE_Jan_2026.xlsx
├──  Receitas_Jan_2026.xlsx
├──  Despesas_Jan_2026.xlsx
├──  NFSe/
│   ├──  NFSe_2026001.xml
│   ├──  NFSe_2026001.pdf
│   └── ...
├──  Comprovantes/
│   ├──  Desp_001_combustivel.pdf
│   ├──  Desp_002_manutencao.jpg
│   └── ...
└──  Resumo_Fiscal.pdf
```

#### Critérios de Aceitação

- [ ] **CA01** - Gerar pacote por período
- [ ] **CA02** - Incluir DRE em PDF e Excel
- [ ] **CA03** - Relatório de receitas com NFS-e
- [ ] **CA04** - Relatório de despesas com comprovantes
- [ ] **CA05** - XMLs das notas em pasta separada
- [ ] **CA06** - Download como ZIP
- [ ] **CA07** - Envio automático por e-mail

#### Regras de Negócio

- **RN01** - Pacote gerado após fechamento do mês
- **RN02** - Pode ser regenerado a qualquer momento
- **RN03** - Histórico de exportações mantido

---

### US08.07 - Exportação de Dados (Excel/CSV)

**Como** transportador  
**Quero** exportar dados do sistema em Excel/CSV  
**Para** análises externas e backup

#### Exportações Disponíveis

| Dados | Campos |
|-------|--------|
| Alunos | Nome, responsável, escola, rota, status, valor |
| Responsáveis | Nome, CPF, telefone, e-mail, endereço |
| Contratos | Número, aluno, vigência, valor, status |
| Parcelas | Referência, vencimento, valor, status, pagamento |
| Despesas | Descrição, categoria, valor, vencimento, status |
| NFS-e | Número, data, tomador, valor, status |

#### Critérios de Aceitação

- [ ] **CA01** - Botão "Exportar" em cada listagem
- [ ] **CA02** - Filtros aplicados na exportação
- [ ] **CA03** - Formato Excel (.xlsx)
- [ ] **CA04** - Formato CSV
- [ ] **CA05** - Colunas selecionáveis
- [ ] **CA06** - Limite de registros (evitar timeout)

---

### US08.08 - API Pública (V2)

**Como** desenvolvedor/integrador  
**Quero** acessar dados do sistema via API  
**Para** integrar com outros sistemas

#### Endpoints Principais

```
GET    /api/v1/alunos
GET    /api/v1/alunos/:id
POST   /api/v1/alunos

GET    /api/v1/parcelas
POST   /api/v1/parcelas/:id/baixa

GET    /api/v1/contratos
GET    /api/v1/despesas

GET    /api/v1/relatorios/dre
```

#### Critérios de Aceitação

- [ ] **CA01** - Autenticação via API Key
- [ ] **CA02** - Rate limiting
- [ ] **CA03** - Documentação Swagger/OpenAPI
- [ ] **CA04** - Versionamento de API
- [ ] **CA05** - Sandbox para testes
- [ ] **CA06** - Webhooks configuráveis

---

### US08.09 - Webhooks de Saída

**Como** desenvolvedor  
**Quero** receber notificações de eventos do sistema  
**Para** integrar com outros sistemas em tempo real

#### Eventos Disponíveis

| Evento | Payload |
|--------|---------|
| `parcela.paga` | parcela_id, valor, data_pagamento |
| `parcela.atrasada` | parcela_id, dias_atraso |
| `contrato.criado` | contrato_id, aluno_id |
| `nfse.emitida` | nfse_id, numero, valor |
| `aluno.criado` | aluno_id, dados |

#### Critérios de Aceitação

- [ ] **CA01** - Configurar URL de webhook
- [ ] **CA02** - Selecionar eventos
- [ ] **CA03** - Assinatura HMAC para validação
- [ ] **CA04** - Retry em caso de falha (3x)
- [ ] **CA05** - Log de webhooks enviados
- [ ] **CA06** - Testar webhook manualmente

---

### US08.10 - Integração Contabilidade (Retorno)

**Como** transportador  
**Quero** receber guias de impostos do contador  
**Para** centralizar tudo no sistema

#### Funcionalidades

- Upload de guias (DAS, ISS, INSS)
- Criação automática de despesa a partir da guia
- Vinculação com período fiscal

#### Critérios de Aceitação

- [ ] **CA01** - Área para contador fazer upload
- [ ] **CA02** - Acesso via link (sem login completo)
- [ ] **CA03** - Upload de PDF da guia
- [ ] **CA04** - Informar valor e vencimento
- [ ] **CA05** - Sistema cria despesa automaticamente
- [ ] **CA06** - Notificação ao transportador

---

### US08.11 - Backup e Exportação Total

**Como** transportador  
**Quero** exportar todos os meus dados  
**Para** backup e portabilidade (LGPD)

#### Critérios de Aceitação

- [ ] **CA01** - Solicitar exportação total
- [ ] **CA02** - Processamento em background
- [ ] **CA03** - Notificação quando pronto
- [ ] **CA04** - Download por link temporário (24h)
- [ ] **CA05** - Formato JSON + PDFs
- [ ] **CA06** - Inclui todos os dados do usuário

#### Regras de Negócio

- **RN01** - Direito garantido pela LGPD
- **RN02** - Máximo 1 exportação por semana
- **RN03** - Dados anonimizados de terceiros

---

## Dependências

- Todos os módulos anteriores

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US08.01 | 8 | Alta |
| US08.02 | 5 | Alta |
| US08.03 | 8 | Alta |
| US08.04 | 8 | Alta |
| US08.05 | 5 | Baixa (V2) |
| US08.06 | 5 | Alta |
| US08.07 | 3 | Alta |
| US08.08 | 13 | Baixa (V2) |
| US08.09 | 5 | Baixa (V2) |
| US08.10 | 5 | Média |
| US08.11 | 5 | Média |
| **Total** | **70** | |

---

## Wireframes

### Configuração de Integrações
```
┌─────────────────────────────────────────────────────────┐
│  Integrações                                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   WhatsApp Business                                   │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Status:  Conectado                           │   │
│  │  Número: +55 11 99999-9999                      │   │
│  │  Mensagens hoje: 45/1000                        │   │
│  │                                                  │   │
│  │  [Configurar]  [Desconectar]  [Testar]          │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│   Gateway de Pagamento                                │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Provedor: Asaas                                │   │
│  │  Status:  Ativo                               │   │
│  │  Ambiente: Produção                             │   │
│  │  Saldo: R$ 2.450,00                             │   │
│  │                                                  │   │
│  │  [Configurar]  [Ver Transações]                 │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│   Emissão de NFS-e                                    │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Provedor: NFE.io                               │   │
│  │  Status:  Ativo                               │   │
│  │  Certificado: Válido até 15/06/2027             │   │
│  │                                                  │   │
│  │  [Configurar]  [Testar Emissão]                 │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│   E-mail (SMTP)                                       │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Status:  Configurado                         │   │
│  │  Servidor: smtp.sendgrid.net                    │   │
│  │                                                  │   │
│  │  [Configurar]  [Enviar Teste]                   │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Exportação Contábil
```
┌─────────────────────────────────────────────────────────┐
│  Exportação para Contabilidade                        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Período: [ Janeiro  ] [ 2026  ]                     │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   Conteúdo do Pacote                                  │
│                                                         │
│  [] DRE (PDF + Excel)                                 │
│  [] Relatório de Receitas                             │
│  [] Relatório de Despesas                             │
│  [] Comprovantes de Despesas (38 arquivos)            │
│  [] XMLs das NFS-e (42 arquivos)                      │
│  [] Resumo Fiscal                                      │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   Enviar para:                                        │
│  ┌─────────────────────────────────────────────────┐   │
│  │ contador@escritorio.com.br                      │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  [] Enviar cópia para meu e-mail                      │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   Resumo do Período                                   │
│                                                         │
│  Receita: R$ 15.390,00                                 │
│  Despesas: R$ 10.450,00                                │
│  Lucro: R$ 4.940,00                                    │
│  NFS-e emitidas: 42                                    │
│  Despesas registradas: 23                              │
│                                                         │
│              [Cancelar]  [Gerar e Enviar Pacote ]    │
└─────────────────────────────────────────────────────────┘
```

### Configuração de Webhook (Desenvolvedor)
```
┌─────────────────────────────────────────────────────────┐
│  Webhooks de Saída                                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  [+ Novo Webhook]                                       │
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │  Webhook: Notificação de Pagamento                  ││
│ │  ─────────────────────────────────────────────────  ││
│ │                                                     ││
│ │  URL: https://meusite.com/api/webhooks/vania   ││
│ │  Secret: ****************************              ││
│ │                                                     ││
│ │  Eventos:                                           ││
│ │  [] parcela.paga                                  ││
│ │  [ ] parcela.atrasada                              ││
│ │  [ ] contrato.criado                               ││
│ │  [] nfse.emitida                                  ││
│ │                                                     ││
│ │  Status:  Ativo                                   ││
│ │  Último envio: 27/01/2026 15:32                    ││
│ │  Taxa de sucesso: 98.5%                            ││
│ │                                                     ││
│ │  [Editar] [Testar] [Ver Logs] [Desativar]          ││
│ └─────────────────────────────────────────────────────┘│
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │  📜 Últimos Envios                                  ││
│ │                                                     ││
│ │  27/01 15:32  parcela.paga      200 OK           ││
│ │  27/01 14:15  nfse.emitida      200 OK           ││
│ │  27/01 12:00  parcela.paga      500 (retry 1/3) ││
│ │  27/01 12:05  parcela.paga      200 OK (retry)   ││
│ └─────────────────────────────────────────────────────┘│
│                                                         │
└─────────────────────────────────────────────────────────┘
```
