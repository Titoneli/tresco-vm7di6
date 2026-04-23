# EP02 - Gestão de Contratos

## Objetivo do Épico

Automatizar a geração, envio e assinatura de contratos de prestação de serviço de transporte escolar, eliminando trabalho manual e garantindo segurança jurídica.

---

## Histórias de Usuário

### US02.01 - Template de Contrato

**Como** transportador  
**Quero** configurar um template de contrato  
**Para** padronizar todos os contratos gerados

#### Campos do Template

**Variáveis disponíveis:**
```
{{empresa_razao_social}}
{{empresa_cnpj}}
{{empresa_endereco}}
{{empresa_telefone}}
{{empresa_email}}

{{responsavel_nome}}
{{responsavel_cpf}}
{{responsavel_rg}}
{{responsavel_endereco}}
{{responsavel_telefone}}
{{responsavel_email}}

{{aluno_nome}}
{{aluno_data_nascimento}}
{{aluno_idade}}

{{escola_nome}}
{{escola_endereco}}

{{rota_nome}}
{{rota_turno}}

{{contrato_numero}}
{{contrato_data_inicio}}
{{contrato_data_fim}}
{{contrato_vigencia_meses}}

{{valor_mensal}}
{{valor_mensal_extenso}}
{{dia_vencimento}}
{{desconto_percentual}}
{{valor_com_desconto}}

{{multa_atraso}}
{{juros_dia}}

{{data_atual}}
{{cidade}}
```

#### Critérios de Aceitação

- [ ] **CA01** - Editor WYSIWYG para criar/editar template
- [ ] **CA02** - Preview com dados reais substituídos
- [ ] **CA03** - Inserção de variáveis via dropdown
- [ ] **CA04** - Validação de variáveis inválidas
- [ ] **CA05** - Múltiplos templates (ex: padrão, integral, especial)
- [ ] **CA06** - Template padrão pré-configurado no primeiro acesso
- [ ] **CA07** - Versionamento de templates

#### Regras de Negócio

- **RN01** - Template deve conter cláusulas obrigatórias mínimas
- **RN02** - Alteração de template não afeta contratos já gerados
- **RN03** - Template ativo é usado como padrão em novos contratos

---

### US02.02 - Geração de Contrato

**Como** transportador  
**Quero** gerar contrato automaticamente para um aluno  
**Para** formalizar a prestação de serviço

#### Campos do Contrato

**Dados do Contrato:**
- Número do contrato (automático)
- Template a usar
- Data de início
- Data de fim (ou vigência em meses)
- Valor mensal
- Desconto (% ou R$)
- Dia de vencimento
- Observações/cláusulas adicionais

#### Critérios de Aceitação

- [ ] **CA01** - Contrato gerado a partir do cadastro do aluno
- [ ] **CA02** - Dados do responsável e aluno preenchidos automaticamente
- [ ] **CA03** - Preview do contrato antes de gerar
- [ ] **CA04** - Permite ajustar valores e datas
- [ ] **CA05** - Gera PDF formatado profissionalmente
- [ ] **CA06** - Número sequencial único por ano (ex: 2026/0001)
- [ ] **CA07** - Armazena PDF no sistema

#### Regras de Negócio

- **RN01** - Aluno só pode ter um contrato ativo por vez
- **RN02** - Novo contrato cancela automaticamente o anterior (com confirmação)
- **RN03** - Data de início define primeira parcela do carnê
- **RN04** - Valor do contrato é base para geração das parcelas

---

### US02.03 - Envio de Contrato por E-mail

**Como** transportador  
**Quero** enviar o contrato por e-mail  
**Para** que o responsável receba e assine

#### Critérios de Aceitação

- [ ] **CA01** - Botão "Enviar por E-mail" no contrato gerado
- [ ] **CA02** - Template de e-mail configurável
- [ ] **CA03** - PDF do contrato em anexo
- [ ] **CA04** - Link para visualização online
- [ ] **CA05** - Rastreamento de abertura (se possível)
- [ ] **CA06** - Reenvio com um clique
- [ ] **CA07** - Histórico de envios

#### Campos do E-mail

- Assunto (configurável)
- Corpo do e-mail (configurável com variáveis)
- Anexo: Contrato em PDF

#### Template Padrão

```
Assunto: Contrato de Transporte Escolar - {{aluno_nome}}

Prezado(a) {{responsavel_nome}},

Segue em anexo o contrato de prestação de serviço de transporte 
escolar para o(a) aluno(a) {{aluno_nome}}.

Dados do Contrato:
- Número: {{contrato_numero}}
- Vigência: {{contrato_data_inicio}} a {{contrato_data_fim}}
- Valor Mensal: R$ {{valor_mensal}}
- Vencimento: Dia {{dia_vencimento}}

Por favor, leia atentamente e entre em contato para qualquer dúvida.

Atenciosamente,
{{empresa_razao_social}}
{{empresa_telefone}}
```

#### Regras de Negócio

- **RN01** - E-mail do responsável deve estar validado
- **RN02** - Máximo 3 reenvios por dia (evitar spam)

---

### US02.04 - Envio de Contrato por WhatsApp

**Como** transportador  
**Quero** enviar o contrato por WhatsApp  
**Para** maior taxa de visualização

#### Critérios de Aceitação

- [ ] **CA01** - Botão "Enviar por WhatsApp"
- [ ] **CA02** - Gera link público temporário para o PDF (24h)
- [ ] **CA03** - Abre WhatsApp Web/App com mensagem pré-preenchida
- [ ] **CA04** - Template de mensagem configurável
- [ ] **CA05** - Registro do envio no histórico

#### Template de Mensagem

```
Olá {{responsavel_nome}}! 👋

Segue o contrato de transporte escolar do(a) {{aluno_nome}}:

 {{link_contrato}}

*Valor:* R$ {{valor_mensal}}/mês
*Vencimento:* Dia {{dia_vencimento}}
*Vigência:* {{contrato_vigencia_meses}} meses

Qualquer dúvida, estou à disposição!

{{empresa_razao_social}}
```

#### Regras de Negócio

- **RN01** - Link expira em 24 horas (segurança)
- **RN02** - Novo envio gera novo link

---

### US02.05 - Assinatura Digital (V2)

**Como** transportador  
**Quero** que o contrato seja assinado digitalmente  
**Para** ter validade jurídica sem papel

#### Critérios de Aceitação

- [ ] **CA01** - Integração com Clicksign ou DocuSign
- [ ] **CA02** - Envio automático para assinatura após aprovação
- [ ] **CA03** - Notificação quando assinado
- [ ] **CA04** - Download do documento assinado
- [ ] **CA05** - Status: Aguardando, Assinado, Recusado, Expirado
- [ ] **CA06** - Fallback para assinatura manual (upload)

#### Regras de Negócio

- **RN01** - Contrato expira para assinatura em 7 dias
- **RN02** - Assinatura digital tem mesmo valor da manuscrita (MP 2.200-2)

---

### US02.06 - Assinatura Manual (Upload)

**Como** transportador  
**Quero** fazer upload do contrato assinado manualmente  
**Para** casos onde a assinatura digital não é possível

#### Critérios de Aceitação

- [ ] **CA01** - Upload de PDF ou imagem do contrato assinado
- [ ] **CA02** - Aceita JPG, PNG, PDF até 10MB
- [ ] **CA03** - Vincula ao contrato original
- [ ] **CA04** - Data de assinatura informada manualmente
- [ ] **CA05** - Status muda para "Assinado"

#### Regras de Negócio

- **RN01** - Upload substitui versão anterior (mantém histórico)

---

### US02.07 - Gestão de Contratos

**Como** transportador  
**Quero** visualizar e gerenciar todos os contratos  
**Para** ter controle da situação

#### Critérios de Aceitação

- [ ] **CA01** - Lista de contratos com filtros (status, período, aluno)
- [ ] **CA02** - Status: Rascunho, Enviado, Assinado, Ativo, Encerrado, Cancelado
- [ ] **CA03** - Indicador visual de contratos próximos do vencimento
- [ ] **CA04** - Ações: Visualizar, Editar (rascunho), Reenviar, Cancelar
- [ ] **CA05** - Exportação da lista (Excel)
- [ ] **CA06** - Busca por nome do aluno ou responsável

#### Regras de Negócio

- **RN01** - Contrato ativo não pode ser editado, apenas cancelado
- **RN02** - Cancelamento requer motivo
- **RN03** - Contrato cancelado mantém histórico

---

### US02.08 - Renovação de Contrato

**Como** transportador  
**Quero** renovar contratos facilmente  
**Para** manter alunos para o próximo período

#### Critérios de Aceitação

- [ ] **CA01** - Alerta de contratos a vencer (30, 15, 7 dias)
- [ ] **CA02** - Botão "Renovar" gera novo contrato baseado no atual
- [ ] **CA03** - Permite ajustar valores na renovação
- [ ] **CA04** - Renovação em lote (múltiplos alunos)
- [ ] **CA05** - Preview antes de confirmar

#### Regras de Negócio

- **RN01** - Renovação mantém histórico do contrato anterior
- **RN02** - Novo número de contrato é gerado
- **RN03** - Parcelas do contrato anterior são mantidas

---

### US02.09 - Aditivo de Contrato

**Como** transportador  
**Quero** criar aditivos para contratos vigentes  
**Para** formalizar alterações sem novo contrato

#### Tipos de Aditivo

- Alteração de valor
- Alteração de rota
- Alteração de escola
- Alteração de horário
- Outros

#### Critérios de Aceitação

- [ ] **CA01** - Vinculado ao contrato original
- [ ] **CA02** - Template específico para aditivo
- [ ] **CA03** - Numeração sequencial (Aditivo 1, 2, 3...)
- [ ] **CA04** - Mesmas opções de envio (e-mail, WhatsApp)
- [ ] **CA05** - Mesmas opções de assinatura

#### Regras de Negócio

- **RN01** - Aditivo só para contratos ativos
- **RN02** - Alteração de valor atualiza parcelas futuras

---

## Dependências

- **EP01** - Cadastros (aluno, responsável, empresa)

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US02.01 | 8 | Alta |
| US02.02 | 5 | Alta |
| US02.03 | 3 | Alta |
| US02.04 | 3 | Alta |
| US02.05 | 8 | Baixa (V2) |
| US02.06 | 2 | Média |
| US02.07 | 5 | Alta |
| US02.08 | 5 | Média |
| US02.09 | 5 | Baixa |
| **Total** | **44** | |

---

## Wireframes

### Geração de Contrato
```
┌─────────────────────────────────────────────────────────┐
│  Novo Contrato                                   [X]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Aluno: João Silva (Colégio ABC - Rota 1)              │
│  Responsável: Maria Silva (123.456.789-00)              │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  Template *                                             │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Contrato Padrão 2026                           │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Data Início *              Data Fim *                  │
│  ┌───────────────────┐     ┌───────────────────┐       │
│  │ 01/02/2026        │     │ 30/11/2026        │       │
│  └───────────────────┘     └───────────────────┘       │
│                                                         │
│  Valor Mensal *             Desconto                    │
│  ┌───────────────────┐     ┌──────────┐ ┌────────┐     │
│  │ R$ 450,00         │     │ 10       │ │ %    │     │
│  └───────────────────┘     └──────────┘ └────────┘     │
│                                                         │
│   Valor com desconto: R$ 405,00                       │
│                                                         │
│  Dia de Vencimento *                                    │
│  ┌─────────────────────────────────────────────────┐   │
│  │ 10                                             │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Observações                                            │
│  ┌─────────────────────────────────────────────────┐   │
│  │                                                  │   │
│  │                                                  │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│              [Cancelar]  [Preview]  [Gerar Contrato]   │
└─────────────────────────────────────────────────────────┘
```

### Lista de Contratos
```
┌─────────────────────────────────────────────────────────┐
│  Contratos                              [+ Novo]      │
├─────────────────────────────────────────────────────────┤
│  Buscar...     [Status ] [Período ] [Exportar ]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   3 contratos vencem nos próximos 30 dias            │
│                                                         │
│ ┌───────┬────────────┬───────────┬──────────┬────────┐ │
│ │ Nº    │ Aluno      │ Vigência  │ Valor    │ Status │ │
│ ├───────┼────────────┼───────────┼──────────┼────────┤ │
│ │ 26/01 │ João Silva │ Fev-Nov   │ R$ 405   │  Ativo│ │
│ │ 26/02 │ Maria...   │ Fev-Nov   │ R$ 450   │  Env. │ │
│ │ 26/03 │ Pedro...   │ Mar-Dez   │ R$ 380   │  Rasc.│ │
│ └───────┴────────────┴───────────┴──────────┴────────┘ │
│                                                         │
│ Mostrando 1-10 de 23        [< 1 2 3 >]                │
└─────────────────────────────────────────────────────────┘
```

### Envio de Contrato
```
┌─────────────────────────────────────────────────────────┐
│  Enviar Contrato 2026/0001                       [X]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Aluno: João Silva                                      │
│  Responsável: Maria Silva                               │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│   E-mail: maria.silva@email.com                       │
│   WhatsApp: (11) 99999-9999                          │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  Como deseja enviar?                                    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │    Enviar por E-mail                          │   │
│  │      PDF em anexo + link de visualização        │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │    Enviar por WhatsApp                        │   │
│  │      Abre WhatsApp com mensagem pronta          │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │  ✍️  Solicitar Assinatura Digital (Clicksign)  │   │
│  │      Envia para assinatura eletrônica           │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│                                         [Cancelar]      │
└─────────────────────────────────────────────────────────┘
```
