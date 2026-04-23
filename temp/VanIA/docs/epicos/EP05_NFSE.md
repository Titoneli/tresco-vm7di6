# EP05 - Emissão de NFS-e

## Objetivo do Épico

Automatizar a emissão de Notas Fiscais de Serviço Eletrônicas (NFS-e) para os serviços de transporte escolar, garantindo conformidade fiscal e agilidade no processo.

---

## Histórias de Usuário

### US05.01 - Configuração Fiscal

**Como** transportador  
**Quero** configurar os dados fiscais da empresa  
**Para** emitir notas fiscais corretamente

#### Campos de Configuração

**Dados da Empresa:**
- CNPJ (já cadastrado)
- Inscrição Municipal
- Regime Tributário (Simples Nacional, Lucro Presumido, MEI)
- Optante Simples Nacional (Sim/Não)

**Dados do Serviço:**
- Código do Serviço Municipal
- CNAE
- Descrição padrão do serviço
- Alíquota ISS (%)
- Código de tributação municipal

**Certificado Digital:**
- Upload do certificado A1 (.pfx)
- Senha do certificado
- Data de validade

**Integração:**
- Provedor de NFS-e (direto com prefeitura ou agregador)
- Ambiente (Homologação/Produção)

#### Critérios de Aceitação

- [ ] **CA01** - Validação de CNPJ e Inscrição Municipal
- [ ] **CA02** - Upload seguro de certificado digital
- [ ] **CA03** - Teste de conexão com prefeitura/agregador
- [ ] **CA04** - Alerta de vencimento do certificado (30 dias)
- [ ] **CA05** - Ambiente de homologação para testes

#### Regras de Negócio

- **RN01** - Certificado digital é obrigatório para emissão
- **RN02** - Configuração deve ser validada antes de primeira emissão
- **RN03** - Alteração de regime tributário requer revisão

---

### US05.02 - Emissão de NFS-e Individual

**Como** transportador  
**Quero** emitir nota fiscal para uma parcela paga  
**Para** cumprir obrigação fiscal

#### Campos da NFS-e

**Prestador (automático):**
- Dados da empresa configurados

**Tomador:**
- Nome/Razão Social do responsável
- CPF/CNPJ
- Endereço completo
- E-mail

**Serviço:**
- Descrição (ex: "Serviço de transporte escolar - Aluno: João Silva - Ref: Jan/2026")
- Valor do serviço
- Alíquota ISS
- Valor ISS
- Código do serviço

#### Critérios de Aceitação

- [ ] **CA01** - Emitir NFS-e a partir de parcela paga
- [ ] **CA02** - Dados do tomador preenchidos automaticamente
- [ ] **CA03** - Preview antes de emitir
- [ ] **CA04** - Comunicação com prefeitura/agregador
- [ ] **CA05** - Armazenamento do XML e PDF
- [ ] **CA06** - Número da nota registrado no sistema
- [ ] **CA07** - Status: Processando, Autorizada, Rejeitada

#### Regras de Negócio

- **RN01** - Nota só pode ser emitida para parcela paga
- **RN02** - Uma nota por parcela (evita duplicidade)
- **RN03** - Descrição inclui nome do aluno e referência

---

### US05.03 - Emissão de NFS-e em Lote

**Como** transportador  
**Quero** emitir notas fiscais para todas as parcelas pagas do mês  
**Para** agilizar o processo fiscal

#### Critérios de Aceitação

- [ ] **CA01** - Selecionar período (mês/ano)
- [ ] **CA02** - Lista de parcelas elegíveis (pagas, sem nota)
- [ ] **CA03** - Preview com total de notas e valores
- [ ] **CA04** - Emissão em fila (uma por vez)
- [ ] **CA05** - Relatório de sucesso/erro
- [ ] **CA06** - Notas rejeitadas ficam pendentes para correção

#### Regras de Negócio

- **RN01** - Máximo de 100 notas por lote
- **RN02** - Erro em uma nota não interrompe as demais
- **RN03** - Notas com erro podem ser reprocessadas

---

### US05.04 - Emissão Automática

**Como** transportador  
**Quero** que notas sejam emitidas automaticamente após pagamento  
**Para** eliminar trabalho manual

#### Critérios de Aceitação

- [ ] **CA01** - Configuração: emissão automática (Sim/Não)
- [ ] **CA02** - Ao confirmar pagamento, nota é gerada
- [ ] **CA03** - Fila de emissão com status
- [ ] **CA04** - Notificação se nota rejeitada
- [ ] **CA05** - Log de emissões automáticas

#### Regras de Negócio

- **RN01** - Emissão automática só funciona se configuração válida
- **RN02** - Erros são notificados por e-mail/app

---

### US05.05 - Envio de NFS-e por E-mail

**Como** transportador  
**Quero** enviar a NFS-e por e-mail para o cliente  
**Para** que ele tenha o documento fiscal

#### Critérios de Aceitação

- [ ] **CA01** - Botão "Enviar por E-mail" na nota emitida
- [ ] **CA02** - PDF da nota em anexo
- [ ] **CA03** - Template de e-mail configurável
- [ ] **CA04** - Envio automático após emissão (configurável)
- [ ] **CA05** - Histórico de envios

#### Template Padrão

```
Assunto: Nota Fiscal de Serviço - {{empresa_nome}}

Prezado(a) {{tomador_nome}},

Segue em anexo a Nota Fiscal de Serviço referente ao transporte escolar.

Número da Nota: {{nfse_numero}}
Data de Emissão: {{nfse_data}}
Valor: R$ {{nfse_valor}}
Referência: {{parcela_referencia}}

Atenciosamente,
{{empresa_nome}}
```

---

### US05.06 - Consulta e Gestão de NFS-e

**Como** transportador  
**Quero** consultar todas as notas emitidas  
**Para** ter controle fiscal organizado

#### Critérios de Aceitação

- [ ] **CA01** - Lista de notas com filtros (período, cliente, status)
- [ ] **CA02** - Status: Processando, Autorizada, Cancelada, Rejeitada
- [ ] **CA03** - Download individual de XML e PDF
- [ ] **CA04** - Download em lote (ZIP)
- [ ] **CA05** - Busca por número, cliente, valor
- [ ] **CA06** - Vínculo com parcela/aluno

#### Regras de Negócio

- **RN01** - Notas devem ser mantidas por 5 anos (obrigação legal)
- **RN02** - XML é o documento oficial

---

### US05.07 - Cancelamento de NFS-e

**Como** transportador  
**Quero** cancelar uma NFS-e emitida incorretamente  
**Para** corrigir erros

#### Critérios de Aceitação

- [ ] **CA01** - Botão "Cancelar" na nota autorizada
- [ ] **CA02** - Motivo obrigatório
- [ ] **CA03** - Comunicação com prefeitura para cancelamento
- [ ] **CA04** - Prazo limite para cancelamento (varia por cidade)
- [ ] **CA05** - Nota cancelada mantém histórico
- [ ] **CA06** - Parcela volta a ficar disponível para nova nota

#### Regras de Negócio

- **RN01** - Cancelamento só dentro do prazo legal (geralmente 24-48h)
- **RN02** - Após prazo, só carta de correção (se aplicável)
- **RN03** - Nota cancelada aparece nos relatórios como tal

---

### US05.08 - Carta de Correção (CC-e)

**Como** transportador  
**Quero** emitir carta de correção  
**Para** corrigir erros em notas fora do prazo de cancelamento

#### Critérios de Aceitação

- [ ] **CA01** - Emitir CC-e para nota autorizada
- [ ] **CA02** - Campo de descrição da correção
- [ ] **CA03** - Limitações conforme legislação
- [ ] **CA04** - PDF da CC-e disponível
- [ ] **CA05** - Vinculada à nota original

#### Regras de Negócio

- **RN01** - CC-e não altera valor ou dados do tomador
- **RN02** - Máximo de CCs por nota varia por município
- **RN03** - Nem todas as prefeituras suportam CC-e

---

### US05.09 - Relatório Fiscal

**Como** transportador  
**Quero** gerar relatório fiscal mensal  
**Para** enviar para a contabilidade

#### Critérios de Aceitação

- [ ] **CA01** - Relatório por período
- [ ] **CA02** - Total de notas emitidas
- [ ] **CA03** - Total de serviços prestados
- [ ] **CA04** - Total de ISS retido/devido
- [ ] **CA05** - Exportação em Excel e PDF
- [ ] **CA06** - Download de todos os XMLs do período

#### Conteúdo do Relatório

| Campo | Descrição |
|-------|-----------|
| Número da NFS-e | Identificador único |
| Data de Emissão | Data da nota |
| Tomador | Nome/CNPJ/CPF |
| Valor do Serviço | R$ |
| Alíquota ISS | % |
| Valor ISS | R$ |
| Situação | Autorizada/Cancelada |

---

### US05.10 - Integração com Agregador

**Como** transportador  
**Quero** usar um agregador de NFS-e  
**Para** não me preocupar com integrações de cada prefeitura

#### Agregadores Suportados

- NFE.io
- Enotas
- Tecnospeed
- Webmaniacs

#### Critérios de Aceitação

- [ ] **CA01** - Configuração de API do agregador
- [ ] **CA02** - Autenticação segura (API Key)
- [ ] **CA03** - Envio e consulta de notas
- [ ] **CA04** - Callbacks/webhooks de status
- [ ] **CA05** - Fallback se agregador offline

#### Regras de Negócio

- **RN01** - Agregador é a opção padrão (mais fácil)
- **RN02** - Integração direta só se prefeitura suportada
- **RN03** - Custo do agregador é por nota (informar ao usuário)

---

## Dependências

- **EP01** - Cadastros (empresa, responsável)
- **EP04** - Contas a Receber (parcelas pagas)
- **Integração** - Prefeitura ou agregador de NFS-e

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US05.01 | 5 | Alta |
| US05.02 | 8 | Alta |
| US05.03 | 5 | Alta |
| US05.04 | 5 | Média |
| US05.05 | 3 | Alta |
| US05.06 | 5 | Alta |
| US05.07 | 5 | Alta |
| US05.08 | 3 | Baixa |
| US05.09 | 5 | Alta |
| US05.10 | 8 | Alta |
| **Total** | **52** | |

---

## Wireframes

### Configuração Fiscal
```
┌─────────────────────────────────────────────────────────┐
│  Configuração Fiscal                                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   Dados da Empresa                                    │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  CNPJ                         Inscrição Municipal       │
│  ┌───────────────────┐       ┌───────────────────┐     │
│  │ 12.345.678/0001-90│       │ 123456            │     │
│  └───────────────────┘       └───────────────────┘     │
│                                                         │
│  Regime Tributário                                      │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Simples Nacional                               │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  📜 Dados do Serviço                                    │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  Código do Serviço            CNAE                      │
│  ┌───────────────────┐       ┌───────────────────┐     │
│  │ 16.01             │       │ 4923-0/02         │     │
│  └───────────────────┘       └───────────────────┘     │
│                                                         │
│  Alíquota ISS (%)             Descrição Padrão          │
│  ┌───────────────────┐       ┌───────────────────┐     │
│  │ 5,00              │       │ Transporte escolar│     │
│  └───────────────────┘       └───────────────────┘     │
│                                                         │
│   Certificado Digital                                 │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   Certificado configurado                             │
│     Válido até: 15/06/2027                              │
│     [Substituir Certificado]                            │
│                                                         │
│  🔌 Integração                                          │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  Provedor: [NFE.io ]  Ambiente: [Produção ]          │
│                                                         │
│  [Testar Conexão]                              [Salvar] │
└─────────────────────────────────────────────────────────┘
```

### Lista de NFS-e
```
┌─────────────────────────────────────────────────────────┐
│  Notas Fiscais                       [+ Emitir Lote]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Buscar...    [Período ] [Status ] [Exportar ]   │
│                                                         │
│ ┌───────────────────────────────────────────────────┐  │
│ │ Nº      │ Data     │ Tomador      │ Valor   │ St │  │
│ ├─────────┼──────────┼──────────────┼─────────┼────┤  │
│ │ 2026001 │ 15/01/26 │ Maria Silva  │ R$ 405  │  │  │
│ │ 2026002 │ 15/01/26 │ Pedro Costa  │ R$ 380  │  │  │
│ │ 2026003 │ 16/01/26 │ Ana Souza    │ R$ 450  │  │  │
│ │ 2026004 │ 16/01/26 │ João Lima    │ R$ 405  │  │  │
│ └─────────┴──────────┴──────────────┴─────────┴────┘  │
│                                                         │
│ Legenda:  Autorizada   Processando   Rejeitada    │
│                                                         │
│ Mostrando 1-10 de 156       [< 1 2 3 ... >]            │
└─────────────────────────────────────────────────────────┘
```

### Emissão em Lote
```
┌─────────────────────────────────────────────────────────┐
│  Emissão de NFS-e em Lote                             │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Período: [ Janeiro  ] [ 2026  ]  [Buscar Parcelas]  │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   Resumo                                              │
│                                                         │
│  Parcelas pagas no período:              45             │
│  (-) Já com NFS-e emitida:               38             │
│  ────────────────────────────────────────               │
│  = Parcelas elegíveis:                    7             │
│                                                         │
│   Valor total a faturar: R$ 2.835,00                 │
│   ISS estimado (5%): R$ 141,75                       │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  [] Enviar NFS-e por e-mail automaticamente           │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │ ☑ │ Aluno         │ Responsável   │ Valor      │   │
│  ├───┼───────────────┼───────────────┼────────────┤   │
│  │ ☑ │ João Silva    │ Maria Silva   │ R$ 405,00  │   │
│  │ ☑ │ Ana Costa     │ Pedro Costa   │ R$ 380,00  │   │
│  │ ☑ │ Lucas Souza   │ Ana Souza     │ R$ 450,00  │   │
│  └───┴───────────────┴───────────────┴────────────┘   │
│                                                         │
│                   [Cancelar]  [Emitir 7 Notas Fiscais] │
└─────────────────────────────────────────────────────────┘
```
