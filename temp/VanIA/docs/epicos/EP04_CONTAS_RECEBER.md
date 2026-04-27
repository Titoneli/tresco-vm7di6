# EP04 - Contas a Receber

## Objetivo do Épico

Controlar todos os recebimentos da operação, com suporte a múltiplas formas de pagamento (PIX, cartão, boleto, dinheiro), baixa automática e manual, e gestão de inadimplência.

---

## Histórias de Usuário

### US04.01 - Geração de PIX

**Como** transportador  
**Quero** gerar código PIX para cada parcela  
**Para** facilitar o pagamento dos clientes

#### Tipos de PIX

| Tipo | Descrição | Prioridade |
|------|-----------|------------|
| PIX Copia e Cola | Código para copiar e pagar | Alta (MVP) |
| QR Code | Imagem para escanear | Alta (MVP) |
| PIX com Webhook | Baixa automática | Alta (MVP) |

#### Critérios de Aceitação

- [ ] **CA01** - Gera PIX Copia e Cola para cada parcela
- [ ] **CA02** - Gera QR Code visual
- [ ] **CA03** - PIX vinculado à parcela (identificador único)
- [ ] **CA04** - Valor do PIX = valor da parcela (com multa/juros se atrasado)
- [ ] **CA05** - Expiração configurável (padrão: 24h)
- [ ] **CA06** - Regenera PIX se expirado

#### Dados do PIX

- Chave PIX (CNPJ/CPF/e-mail/telefone/aleatória)
- Valor
- Descrição (nome do aluno + referência)
- Identificador único (txid)
- Data de expiração

#### Regras de Negócio

- **RN01** - Um PIX por parcela (regenera se expirado)
- **RN02** - Identificador único para rastreamento
- **RN03** - Pagamento parcial não é aceito (valor exato)

---

### US04.02 - Baixa Automática (Webhook PIX)

**Como** transportador  
**Quero** que pagamentos PIX sejam baixados automaticamente  
**Para** eliminar trabalho manual de conferência

#### Critérios de Aceitação

- [ ] **CA01** - Integração com gateway de pagamento (Asaas, PagSeguro, etc)
- [ ] **CA02** - Webhook recebe notificação de pagamento
- [ ] **CA03** - Sistema identifica parcela pelo txid
- [ ] **CA04** - Parcela marcada como "Paga" automaticamente
- [ ] **CA05** - Data e hora do pagamento registradas
- [ ] **CA06** - Comprovante disponível para download
- [ ] **CA07** - Notificação para o transportador (opcional)

#### Regras de Negócio

- **RN01** - Pagamento deve corresponder exatamente ao valor
- **RN02** - Pagamento em duplicidade é alertado
- **RN03** - Log de todas as transações

---

### US04.03 - Baixa Manual

**Como** transportador  
**Quero** dar baixa manual em pagamentos  
**Para** registrar pagamentos em dinheiro ou transferência

#### Critérios de Aceitação

- [ ] **CA01** - Botão "Dar Baixa" na parcela
- [ ] **CA02** - Selecionar forma de pagamento (Dinheiro, Transferência, Cheque, Outro)
- [ ] **CA03** - Informar data do pagamento
- [ ] **CA04** - Informar valor recebido (pode ser diferente)
- [ ] **CA05** - Campo para observações
- [ ] **CA06** - Upload de comprovante (opcional)
- [ ] **CA07** - Confirmação antes de salvar

#### Formas de Pagamento

- Dinheiro
- Transferência bancária
- PIX (manual)
- Cheque
- Cartão (manual)
- Outro

#### Regras de Negócio

- **RN01** - Baixa manual registra usuário que fez a ação
- **RN02** - Se valor diferente, registra diferença
- **RN03** - Baixa pode ser estornada (desfazer)

---

### US04.04 - Cartão Recorrente (V2)

**Como** transportador  
**Quero** cobrar no cartão de crédito recorrente  
**Para** garantir recebimento automático

#### Critérios de Aceitação

- [ ] **CA01** - Cadastro de cartão pelo responsável (área do cliente)
- [ ] **CA02** - Tokenização (não armazena dados do cartão)
- [ ] **CA03** - Cobrança automática no vencimento
- [ ] **CA04** - Tentativa de recobrança em caso de falha
- [ ] **CA05** - Notificação de cobrança realizada/falha
- [ ] **CA06** - Cancelamento do cartão pelo responsável

#### Regras de Negócio

- **RN01** - Máximo 3 tentativas de cobrança
- **RN02** - Intervalo de 3 dias entre tentativas
- **RN03** - Após 3 falhas, notifica transportador

---

### US04.05 - Geração de Boleto (V2)

**Como** transportador  
**Quero** gerar boleto bancário  
**Para** oferecer alternativa de pagamento

#### Critérios de Aceitação

- [ ] **CA01** - Gerar boleto por parcela
- [ ] **CA02** - Boleto registrado (com baixa automática)
- [ ] **CA03** - PDF do boleto para download/envio
- [ ] **CA04** - Código de barras e linha digitável
- [ ] **CA05** - Multa e juros configurados no boleto

#### Regras de Negócio

- **RN01** - Taxa de boleto pode ser repassada ou absorvida
- **RN02** - Boleto vencido pode ser atualizado

---

### US04.06 - Painel de Contas a Receber

**Como** transportador  
**Quero** ver um painel com todas as contas a receber  
**Para** ter visão geral da situação financeira

#### Critérios de Aceitação

- [ ] **CA01** - Resumo: Total a receber, Vencendo hoje, Atrasados
- [ ] **CA02** - Lista de parcelas com filtros
- [ ] **CA03** - Filtros: Status, Período, Aluno, Rota
- [ ] **CA04** - Ordenação por vencimento, valor, aluno
- [ ] **CA05** - Ações em lote: enviar cobrança, exportar
- [ ] **CA06** - Indicadores visuais de prioridade

#### Widgets do Painel

```
┌─────────────────────────────────────────────────────────┐
│   A Receber         Vence Hoje       Atrasado    │
│  R$ 12.450,00        R$ 1.620,00        R$ 2.835,00    │
│  32 parcelas         4 parcelas         7 parcelas     │
└─────────────────────────────────────────────────────────┘
```

#### Regras de Negócio

- **RN01** - Atrasados são destacados (vermelho)
- **RN02** - Valores incluem multa/juros quando aplicável

---

### US04.07 - Gestão de Inadimplência

**Como** transportador  
**Quero** gerenciar clientes inadimplentes  
**Para** tomar ações de cobrança

#### Níveis de Inadimplência

| Nível | Dias de Atraso | Ação Sugerida |
|-------|----------------|---------------|
| Leve | 1-7 dias | Lembrete automático |
| Moderado | 8-30 dias | Contato direto |
| Grave | 31-60 dias | Aviso de suspensão |
| Crítico | 60+ dias | Suspensão / Negativação |

#### Critérios de Aceitação

- [ ] **CA01** - Lista de inadimplentes com aging
- [ ] **CA02** - Histórico de cobranças enviadas
- [ ] **CA03** - Ações: Ligar, Enviar mensagem, Agendar
- [ ] **CA04** - Marcar como "Em negociação"
- [ ] **CA05** - Acordo de parcelamento
- [ ] **CA06** - Suspensão do serviço (com aviso)

#### Regras de Negócio

- **RN01** - Suspensão requer aviso prévio (5 dias)
- **RN02** - Inadimplência não cancela contrato automaticamente
- **RN03** - Histórico de negociações é mantido

---

### US04.08 - Acordo/Negociação

**Como** transportador  
**Quero** fazer acordo com cliente inadimplente  
**Para** recuperar valores de forma viável

#### Critérios de Aceitação

- [ ] **CA01** - Selecionar parcelas para acordo
- [ ] **CA02** - Calcular total devido (com multa/juros)
- [ ] **CA03** - Aplicar desconto no acordo
- [ ] **CA04** - Parcelar valor do acordo
- [ ] **CA05** - Gerar novas parcelas do acordo
- [ ] **CA06** - Parcelas originais marcadas como "Em acordo"
- [ ] **CA07** - Documentar termos do acordo

#### Regras de Negócio

- **RN01** - Acordo cancela parcelas originais (vincula)
- **RN02** - Se acordo não for pago, retorna situação original
- **RN03** - Histórico de acordos por cliente

---

### US04.09 - Estorno de Pagamento

**Como** transportador  
**Quero** estornar um pagamento registrado  
**Para** corrigir erros ou devoluções

#### Critérios de Aceitação

- [ ] **CA01** - Estornar parcela paga
- [ ] **CA02** - Motivo obrigatório
- [ ] **CA03** - Parcela volta para status anterior
- [ ] **CA04** - Histórico do estorno mantido
- [ ] **CA05** - Impacto em relatórios (receita estornada)

#### Regras de Negócio

- **RN01** - Estorno não devolve dinheiro (apenas registro)
- **RN02** - Se precisar devolver, registrar como despesa

---

### US04.10 - Recebimento Antecipado

**Como** transportador  
**Quero** registrar pagamento antecipado  
**Para** casos de pagamento adiantado

#### Critérios de Aceitação

- [ ] **CA01** - Baixar parcela futura
- [ ] **CA02** - Aplicar desconto por antecipação (configurável)
- [ ] **CA03** - Baixar múltiplas parcelas de uma vez
- [ ] **CA04** - Exibir economia total do cliente

#### Regras de Negócio

- **RN01** - Desconto antecipação é opcional
- **RN02** - Pagamento de todo o período pode ter desconto especial

---

### US04.11 - Relatório de Recebimentos

**Como** transportador  
**Quero** ver relatório de recebimentos  
**Para** acompanhar a receita

#### Critérios de Aceitação

- [ ] **CA01** - Relatório por período
- [ ] **CA02** - Agrupamento: dia, semana, mês
- [ ] **CA03** - Filtro por forma de pagamento
- [ ] **CA04** - Total recebido vs esperado
- [ ] **CA05** - Gráfico de evolução
- [ ] **CA06** - Exportação Excel/PDF

#### Métricas do Relatório

- Total recebido
- Total esperado
- Inadimplência (%)
- Ticket médio
- Recebimentos por forma de pagamento

---

## Dependências

- **EP01** - Cadastros
- **EP03** - Carnê (parcelas)
- **Integração** - Gateway de pagamento

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US04.01 | 5 | Alta |
| US04.02 | 8 | Alta |
| US04.03 | 3 | Alta |
| US04.04 | 8 | Baixa (V2) |
| US04.05 | 5 | Baixa (V2) |
| US04.06 | 5 | Alta |
| US04.07 | 5 | Alta |
| US04.08 | 5 | Média |
| US04.09 | 2 | Média |
| US04.10 | 3 | Baixa |
| US04.11 | 5 | Alta |
| **Total** | **54** | |

---

## Wireframes

### Painel de Contas a Receber
```
┌─────────────────────────────────────────────────────────┐
│  Contas a Receber                   Janeiro/2026     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ ┌────────────┬────────────┬────────────┬────────────┐  │
│ │  Total   │  Hoje    │  Atrasado│  Recebido│  │
│ │ R$ 18.225  │ R$ 2.025   │ R$ 1.215   │ R$ 14.985  │  │
│ │ 45 parc.   │ 5 parc.    │ 3 parc.    │ 37 parc.   │  │
│ └────────────┴────────────┴────────────┴────────────┘  │
│                                                         │
│  Buscar...  [Status ] [Vencimento ] [Rota ]      │
│                                                         │
│ ┌───────────────────────────────────────────────────┐  │
│ │ ☐ │ Aluno       │ Vencto  │ Valor   │ Status │ ⋯ │  │
│ ├───┼─────────────┼─────────┼─────────┼────────┼───┤  │
│ │ ☐ │ João Silva  │ 10/01   │ R$ 405  │  Atr │ ⋯ │  │
│ │ ☐ │ Maria Costa │ 15/01   │ R$ 380  │  Abe │ ⋯ │  │
│ │ ☐ │ Pedro Souza │ 15/01   │ R$ 450  │  Abe │ ⋯ │  │
│ └───┴─────────────┴─────────┴─────────┴────────┴───┘  │
│                                                         │
│ Selecionados: 0  [Enviar Cobrança] [Dar Baixa]        │
└─────────────────────────────────────────────────────────┘
```

### Modal de Baixa Manual
```
┌─────────────────────────────────────────────────────────┐
│  Dar Baixa - João Silva                          [X] │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Parcela: 5/10 - Janeiro/2026                          │
│  Valor: R$ 405,00                                       │
│  Vencimento: 10/01/2026                                │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  Forma de Pagamento *                                   │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Dinheiro                                       │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Data do Pagamento *        Valor Recebido              │
│  ┌───────────────────┐     ┌───────────────────┐       │
│  │ 12/01/2026        │     │ R$ 405,00         │       │
│  └───────────────────┘     └───────────────────┘       │
│                                                         │
│  Comprovante (opcional)                                 │
│  ┌─────────────────────────────────────────────────┐   │
│  │  📎 Arraste ou clique para anexar               │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Observações                                            │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Pago na escola                                  │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│                        [Cancelar]  [Confirmar Baixa ] │
└─────────────────────────────────────────────────────────┘
```

### Tela de Inadimplência
```
┌─────────────────────────────────────────────────────────┐
│  Gestão de Inadimplência                             │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   Resumo                                              │
│  ┌────────────┬────────────┬────────────┐              │
│  │  Leve   │  Moder.  │  Grave   │              │
│  │ 3 clientes│ 2 clientes │ 1 cliente  │              │
│  │ R$ 1.215  │ R$ 810     │ R$ 1.620   │              │
│  └────────────┴────────────┴────────────┘              │
│                                                         │
│ ┌─────────────────────────────────────────────────────┐│
│ │  Maria Costa                    Atraso: 45 dias  ││
│ │    3 parcelas | R$ 1.215 + R$ 73 (multa/juros)     ││
│ │    Último contato: 15/12/2025                       ││
│ │    [ WhatsApp] [ Ligar] [ Acordo] [ Susp.] ││
│ ├─────────────────────────────────────────────────────┤│
│ │  Pedro Souza                    Atraso: 22 dias  ││
│ │    2 parcelas | R$ 810 + R$ 32 (multa/juros)       ││
│ │    Último contato: 05/01/2026                       ││
│ │    [ WhatsApp] [ Ligar] [ Acordo]            ││
│ └─────────────────────────────────────────────────────┘│
│                                                         │
└─────────────────────────────────────────────────────────┘
```
