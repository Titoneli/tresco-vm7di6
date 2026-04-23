# EP03 - Carnê Virtual e Comunicação

## Objetivo do Épico

Gerar automaticamente as parcelas (carnê) do período contratado e enviar cobranças e lembretes via WhatsApp e e-mail, reduzindo inadimplência e trabalho manual.

---

## Histórias de Usuário

### US03.01 - Geração Automática de Parcelas

**Como** transportador  
**Quero** que o sistema gere automaticamente as parcelas do contrato  
**Para** não precisar criar manualmente cada cobrança

#### Critérios de Aceitação

- [ ] **CA01** - Ao ativar contrato, parcelas são geradas automaticamente
- [ ] **CA02** - Quantidade de parcelas = meses de vigência do contrato
- [ ] **CA03** - Cada parcela com data de vencimento no dia configurado
- [ ] **CA04** - Valor da parcela = valor do contrato (com desconto se houver)
- [ ] **CA05** - Parcelas criadas com status "Aberta"
- [ ] **CA06** - Primeira parcela pode ser proporcional (dias do mês)

#### Campos da Parcela

- Número da parcela (1/12, 2/12...)
- Referência (mês/ano)
- Data de vencimento
- Valor original
- Desconto
- Valor final
- Status (Aberta, Paga, Atrasada, Cancelada)
- Forma de pagamento (quando paga)
- Data de pagamento (quando paga)
- Observações

#### Regras de Negócio

- **RN01** - Parcelas só são geradas para contratos ativos
- **RN02** - Se vencimento cair em fim de semana/feriado, antecipa para dia útil anterior
- **RN03** - Parcela atrasada: vencimento < hoje e status != Paga
- **RN04** - Multa e juros calculados automaticamente após vencimento

---

### US03.02 - Visualização do Carnê

**Como** transportador  
**Quero** visualizar o carnê completo de um aluno  
**Para** acompanhar a situação financeira

#### Critérios de Aceitação

- [ ] **CA01** - Tela de carnê mostra todas as parcelas do contrato
- [ ] **CA02** - Indicador visual de status (cor/ícone)
- [ ] **CA03** - Resumo: Total, Pago, A Receber, Atrasado
- [ ] **CA04** - Filtro por período/status
- [ ] **CA05** - Acesso rápido: baixar parcela, enviar cobrança
- [ ] **CA06** - Histórico de pagamentos

#### Regras de Negócio

- **RN01** - Valores atrasados mostram multa + juros calculados
- **RN02** - Desconto pontualidade só aparece se dentro do prazo

---

### US03.03 - Carnê do Responsável (Área do Cliente)

**Como** responsável  
**Quero** acessar meu carnê online  
**Para** ver parcelas e efetuar pagamentos

#### Critérios de Aceitação

- [ ] **CA01** - Acesso via link único (sem login)
- [ ] **CA02** - Link enviado por WhatsApp/e-mail
- [ ] **CA03** - Exibe parcelas em aberto e pagas
- [ ] **CA04** - Botão para gerar PIX/boleto
- [ ] **CA05** - Comprovantes de pagamento disponíveis
- [ ] **CA06** - Design mobile-first
- [ ] **CA07** - Link expira em 30 dias (renova a cada envio)

#### Regras de Negócio

- **RN01** - Link é único por responsável (acesso a todos os alunos)
- **RN02** - Área somente leitura (não altera dados)

---

### US03.04 - Envio de Cobrança por WhatsApp

**Como** transportador  
**Quero** enviar cobrança por WhatsApp  
**Para** maior taxa de visualização e pagamento

#### Critérios de Aceitação

- [ ] **CA01** - Envio individual (uma parcela)
- [ ] **CA02** - Envio em lote (todas as parcelas do mês)
- [ ] **CA03** - Mensagem com: valor, vencimento, PIX copia-e-cola
- [ ] **CA04** - Link para área do cliente
- [ ] **CA05** - Template configurável
- [ ] **CA06** - Agendamento de envio
- [ ] **CA07** - Histórico de envios

#### Template Padrão

```
Olá {{responsavel_nome}}! 👋

Segue a cobrança de transporte escolar:

 Aluno: {{aluno_nome}}
 Referência: {{parcela_referencia}}
 Valor: R$ {{parcela_valor}}
📆 Vencimento: {{parcela_vencimento}}

 *PIX Copia e Cola:*
{{pix_copia_cola}}

Ou acesse seu carnê completo:
 {{link_area_cliente}}

Obrigado!
{{empresa_nome}}
```

#### Regras de Negócio

- **RN01** - Envio em lote respeita horário comercial (8h-20h)
- **RN02** - Limite de envios por dia para evitar bloqueio
- **RN03** - Não envia para parcelas já pagas

---

### US03.05 - Envio de Cobrança por E-mail

**Como** transportador  
**Quero** enviar cobrança por e-mail  
**Para** ter registro formal da cobrança

#### Critérios de Aceitação

- [ ] **CA01** - Envio individual ou em lote
- [ ] **CA02** - Template HTML responsivo
- [ ] **CA03** - Inclui QR Code do PIX
- [ ] **CA04** - Link para área do cliente
- [ ] **CA05** - Rastreamento de abertura
- [ ] **CA06** - Template configurável

#### Regras de Negócio

- **RN01** - E-mail deve ter versão texto plano (fallback)
- **RN02** - Unsubscribe obrigatório (LGPD)

---

### US03.06 - Lembretes Automáticos

**Como** transportador  
**Quero** que o sistema envie lembretes automaticamente  
**Para** reduzir inadimplência sem esforço manual

#### Tipos de Lembrete

| Tipo | Quando | Canal |
|------|--------|-------|
| Pré-vencimento | X dias antes | WhatsApp + E-mail |
| No vencimento | No dia | WhatsApp |
| Pós-vencimento | X dias depois | WhatsApp + E-mail |
| Atraso | A cada X dias | WhatsApp |

#### Critérios de Aceitação

- [ ] **CA01** - Configuração de dias de antecedência/atraso
- [ ] **CA02** - Ativar/desativar cada tipo de lembrete
- [ ] **CA03** - Templates diferentes por tipo
- [ ] **CA04** - Horário de envio configurável
- [ ] **CA05** - Log de lembretes enviados
- [ ] **CA06** - Não envia se parcela foi paga

#### Configurações Padrão

- Pré-vencimento: 3 dias antes
- No vencimento: dia do vencimento às 9h
- Pós-vencimento: 1 dia depois
- Atraso recorrente: a cada 7 dias

#### Templates

**Pré-vencimento:**
```
Olá {{responsavel_nome}}! 👋

Lembrete: a mensalidade do transporte escolar vence em {{dias_para_vencimento}} dias.

 Aluno: {{aluno_nome}}
 Valor: R$ {{parcela_valor}}
📆 Vencimento: {{parcela_vencimento}}

 PIX: {{pix_copia_cola}}

{{empresa_nome}}
```

**Atraso:**
```
Olá {{responsavel_nome}}! 

Identificamos uma pendência no transporte escolar:

 Aluno: {{aluno_nome}}
 Valor original: R$ {{parcela_valor}}
📆 Venceu em: {{parcela_vencimento}}
 Atraso: {{dias_atraso}} dias

 Valor atualizado: R$ {{valor_com_multa_juros}}
(Multa + juros)

 PIX: {{pix_copia_cola}}

Por favor, regularize para evitar interrupção do serviço.

{{empresa_nome}}
```

#### Regras de Negócio

- **RN01** - Máximo 4 lembretes de atraso
- **RN02** - Para de enviar após 60 dias de atraso (negativação)
- **RN03** - Não envia lembretes para contratos inativos
- **RN04** - Lembretes são enviados em horário comercial

---

### US03.07 - Gestão de Envios

**Como** transportador  
**Quero** visualizar histórico de mensagens enviadas  
**Para** saber o que foi comunicado ao cliente

#### Critérios de Aceitação

- [ ] **CA01** - Lista de mensagens por responsável
- [ ] **CA02** - Filtro por tipo (cobrança, lembrete, contrato)
- [ ] **CA03** - Status: Enviado, Entregue, Lido, Erro
- [ ] **CA04** - Data/hora do envio
- [ ] **CA05** - Preview do conteúdo enviado
- [ ] **CA06** - Reenvio com um clique

---

### US03.08 - Disparo em Massa

**Como** transportador  
**Quero** enviar cobranças para todos os clientes de uma vez  
**Para** agilizar o processo mensal

#### Critérios de Aceitação

- [ ] **CA01** - Seleção de período (mês/ano)
- [ ] **CA02** - Preview da lista de envios
- [ ] **CA03** - Exclui parcelas já pagas
- [ ] **CA04** - Exclui responsáveis sem WhatsApp/e-mail
- [ ] **CA05** - Confirmação antes de disparar
- [ ] **CA06** - Envio gradual (evita bloqueio)
- [ ] **CA07** - Relatório de envios (sucesso/erro)

#### Regras de Negócio

- **RN01** - Limite de 100 mensagens por hora (WhatsApp)
- **RN02** - Disparo pode ser agendado
- **RN03** - Falhas são reenviadas automaticamente (até 3x)

---

### US03.09 - Ajuste de Parcela

**Como** transportador  
**Quero** ajustar valor ou vencimento de uma parcela  
**Para** tratar casos especiais

#### Critérios de Aceitação

- [ ] **CA01** - Editar valor (desconto especial, correção)
- [ ] **CA02** - Editar data de vencimento
- [ ] **CA03** - Adicionar observação/motivo
- [ ] **CA04** - Histórico de alterações
- [ ] **CA05** - Não permite editar parcela paga

#### Regras de Negócio

- **RN01** - Ajuste requer justificativa
- **RN02** - Mantém valor original para referência
- **RN03** - Novo envio de cobrança disponível após ajuste

---

### US03.10 - Cancelamento de Parcela

**Como** transportador  
**Quero** cancelar uma parcela  
**Para** casos de desistência ou erro

#### Critérios de Aceitação

- [ ] **CA01** - Cancelamento individual ou em lote
- [ ] **CA02** - Motivo obrigatório
- [ ] **CA03** - Parcela cancelada sai dos relatórios de receber
- [ ] **CA04** - Histórico mantido para auditoria

#### Regras de Negócio

- **RN01** - Parcela paga não pode ser cancelada (usar estorno)
- **RN02** - Cancelamento pode ser desfeito (reativar)

---

### US03.11 - Parcela Avulsa

**Como** transportador  
**Quero** criar uma cobrança avulsa  
**Para** cobrar valores extras (material, passeio, etc)

#### Critérios de Aceitação

- [ ] **CA01** - Criar parcela fora do carnê regular
- [ ] **CA02** - Descrição personalizada
- [ ] **CA03** - Vinculada ao aluno/responsável
- [ ] **CA04** - Mesmas opções de envio e baixa
- [ ] **CA05** - Identificada como "Avulsa" nos relatórios

#### Regras de Negócio

- **RN01** - Parcela avulsa não afeta contrato
- **RN02** - Entra nos relatórios financeiros

---

## Dependências

- **EP01** - Cadastros
- **EP02** - Contratos (para geração automática)

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US03.01 | 5 | Alta |
| US03.02 | 3 | Alta |
| US03.03 | 8 | Alta |
| US03.04 | 5 | Alta |
| US03.05 | 3 | Média |
| US03.06 | 8 | Alta |
| US03.07 | 3 | Média |
| US03.08 | 5 | Média |
| US03.09 | 3 | Média |
| US03.10 | 2 | Média |
| US03.11 | 3 | Baixa |
| **Total** | **48** | |

---

## Wireframes

### Carnê do Aluno
```
┌─────────────────────────────────────────────────────────┐
│  Carnê - João Silva                                   │
│    Contrato 2026/0001 | Colégio ABC | Rota 1           │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌────────────┬────────────┬────────────┬────────────┐ │
│  │  R$ 4.050  │  R$ 1.620  │  R$ 2.025  │  R$ 405    │ │
│  │   Total    │    Pago    │  A Receber │  Atrasado  │ │
│  └────────────┴────────────┴────────────┴────────────┘ │
│                                                         │
│  [Enviar Carnê Completo]  [Adicionar Parcela Avulsa]   │
│                                                         │
│ ┌──────┬───────────┬───────────┬─────────┬───────────┐ │
│ │ Parc │ Vencto    │ Valor     │ Status  │ Ações     │ │
│ ├──────┼───────────┼───────────┼─────────┼───────────┤ │
│ │ 1/10 │ 10/02/26  │ R$ 405,00 │  Pago │         │ │
│ │ 2/10 │ 10/03/26  │ R$ 405,00 │  Pago │         │ │
│ │ 3/10 │ 10/04/26  │ R$ 405,00 │  Pago │         │ │
│ │ 4/10 │ 10/05/26  │ R$ 405,00 │  Pago │         │ │
│ │ 5/10 │ 10/06/26  │ R$ 405,00 │  Atr  │       │ │
│ │ 6/10 │ 10/07/26  │ R$ 405,00 │  Aber │       │ │
│ │ ...  │ ...       │ ...       │ ...     │ ...       │ │
│ └──────┴───────────┴───────────┴─────────┴───────────┘ │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Área do Cliente (Mobile)
```
┌─────────────────────────────────┐
│ 🚌 VanIA                    │
├─────────────────────────────────┤
│                                 │
│  Olá, Maria Silva!              │
│                                 │
│   João Silva                  │
│     Colégio ABC                 │
│                                 │
│  ┌───────────────────────────┐  │
│  │  Próximo Vencimento       │  │
│  │                           │  │
│  │   R$ 405,00             │  │
│  │   10/02/2026            │  │
│  │                           │  │
│  │  [Pagar com PIX]          │  │
│  └───────────────────────────┘  │
│                                 │
│   Todas as Parcelas          │
│                                 │
│  ┌───────────────────────────┐  │
│  │ Fev/26  R$ 405   Aberta │  │
│  │ Mar/26  R$ 405   Aberta │  │
│  │ Jan/26  R$ 405   Pago   │  │
│  │ Dez/25  R$ 405   Pago   │  │
│  └───────────────────────────┘  │
│                                 │
│   Contato                     │
│  (11) 99999-9999                │
│                                 │
└─────────────────────────────────┘
```

### Disparo em Massa
```
┌─────────────────────────────────────────────────────────┐
│  Envio de Cobranças em Massa                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Referência: [ Fevereiro  ] [ 2026  ]                │
│                                                         │
│  Canal: [] WhatsApp  [] E-mail                       │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   Resumo do Envio                                     │
│                                                         │
│  Total de parcelas do período:        45                │
│  (-) Já pagas:                        12                │
│  (-) Sem WhatsApp/E-mail:              2                │
│  ────────────────────────────────────────               │
│  = Parcelas a enviar:                 31                │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   Agendar envio: [ ] Agora  [] Agendar              │
│                    Data: [01/02/2026] Hora: [09:00]    │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  [Ver Lista Completa]                                   │
│                                                         │
│                    [Cancelar]  [Confirmar Envio ]    │
└─────────────────────────────────────────────────────────┘
```
