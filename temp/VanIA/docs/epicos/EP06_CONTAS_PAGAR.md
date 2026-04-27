# EP06 - Contas a Pagar / Despesas

## Objetivo do Épico

Controlar todas as despesas da operação de transporte escolar, permitindo análise de custos, cálculo do lucro real e organização para a contabilidade, com suporte a upload de comprovantes.

---

## Histórias de Usuário

### US06.01 - Cadastro de Categorias de Despesas

**Como** transportador  
**Quero** configurar categorias de despesas  
**Para** organizar e classificar meus gastos

#### Categorias Padrão

** Pessoal**
- Salários
- Pró-labore
- INSS
- FGTS
- Vale transporte
- Vale refeição
- Outros encargos

**🚍 Operação**
- Combustível
- Manutenção preventiva
- Manutenção corretiva
- Lavagem
- Pedágio
- Estacionamento
- Seguro do veículo
- IPVA
- Licenciamento
- Multas

**🧾 Tributos**
- DAS Simples Nacional
- ISS
- INSS patronal
- IR
- Outras guias

**🧑‍💼 Administração**
- Serviços contábeis
- Sistema/Software
- Internet
- Telefone
- Material de escritório
- Aluguel
- Água/Luz

** Outros**
- Categoria livre

#### Critérios de Aceitação

- [ ] **CA01** - Categorias padrão pré-configuradas
- [ ] **CA02** - Criar categorias personalizadas
- [ ] **CA03** - Subcategorias opcionais
- [ ] **CA04** - Inativar categoria (não exclui)
- [ ] **CA05** - Cor/ícone para identificação visual
- [ ] **CA06** - Ordenação customizável

#### Regras de Negócio

- **RN01** - Categorias padrão não podem ser excluídas
- **RN02** - Categoria com despesas não pode ser excluída
- **RN03** - Categorias são usadas em relatórios e DRE

---

### US06.02 - Cadastro de Despesa

**Como** transportador  
**Quero** registrar minhas despesas  
**Para** controlar os gastos da operação

#### Campos da Despesa

**Obrigatórios:**
- Descrição
- Categoria
- Valor
- Data de vencimento
- Forma de pagamento prevista

**Opcionais:**
- Subcategoria
- Centro de custo (veículo/rota)
- Fornecedor
- Número do documento
- Observações
- Comprovante (upload)

#### Critérios de Aceitação

- [ ] **CA01** - Formulário de cadastro com validação
- [ ] **CA02** - Categoria obrigatória
- [ ] **CA03** - Valor pode ser digitado ou calculado
- [ ] **CA04** - Centro de custo vincula a veículo/rota
- [ ] **CA05** - Upload de comprovante na criação
- [ ] **CA06** - Status inicial: Aberta

#### Regras de Negócio

- **RN01** - Despesa pode ser editada enquanto aberta
- **RN02** - Despesa paga só permite editar observações

---

### US06.03 - Despesas Recorrentes

**Como** transportador  
**Quero** cadastrar despesas que se repetem todo mês  
**Para** não precisar criar manualmente cada vez

#### Campos Adicionais

- Frequência (Mensal, Quinzenal, Semanal)
- Data de início
- Data de fim (opcional - indefinido)
- Dia de geração (1-28)

#### Critérios de Aceitação

- [ ] **CA01** - Marcar despesa como recorrente
- [ ] **CA02** - Sistema gera automaticamente a cada período
- [ ] **CA03** - Geração antecipada (X dias antes do vencimento)
- [ ] **CA04** - Editar recorrência afeta futuras, não passadas
- [ ] **CA05** - Pausar recorrência temporariamente
- [ ] **CA06** - Cancelar recorrência (mantém geradas)

#### Exemplos de Despesas Recorrentes

| Despesa | Valor | Frequência | Vencimento |
|---------|-------|------------|------------|
| Pró-labore | R$ 2.000 | Mensal | Dia 5 |
| Contador | R$ 350 | Mensal | Dia 10 |
| Internet | R$ 99 | Mensal | Dia 15 |
| Combustível | R$ 1.500 | Mensal | Dia 20 |

#### Regras de Negócio

- **RN01** - Recorrentes são geradas 5 dias antes do vencimento
- **RN02** - Se dia não existe no mês (31), usa último dia
- **RN03** - Job diário verifica e gera recorrentes

---

### US06.04 - Upload de Comprovantes

**Como** transportador  
**Quero** anexar comprovantes às despesas  
**Para** documentar e facilitar a contabilidade

#### Formatos Aceitos

- PDF
- JPG/JPEG
- PNG
- HEIC (iPhone)

#### Critérios de Aceitação

- [ ] **CA01** - Upload por arquivo ou foto (câmera)
- [ ] **CA02** - Múltiplos comprovantes por despesa
- [ ] **CA03** - Preview inline
- [ ] **CA04** - Download individual ou ZIP
- [ ] **CA05** - Limite de 10MB por arquivo
- [ ] **CA06** - Armazenamento seguro em nuvem
- [ ] **CA07** - Comprovante pode ser adicionado após criar despesa

#### Regras de Negócio

- **RN01** - Comprovante não é obrigatório, mas recomendado
- **RN02** - Comprovantes são incluídos na exportação contábil
- **RN03** - Exclusão de comprovante mantém log

---

### US06.05 - OCR de Comprovantes (V2)

**Como** transportador  
**Quero** que o sistema leia dados do comprovante automaticamente  
**Para** agilizar o cadastro de despesas

#### Dados Extraídos

- Valor total
- Data do documento
- CNPJ do fornecedor
- Tipo de estabelecimento

#### Critérios de Aceitação

- [ ] **CA01** - Processar imagem com OCR
- [ ] **CA02** - Sugerir preenchimento dos campos
- [ ] **CA03** - Usuário confirma/corrige dados
- [ ] **CA04** - Funciona com cupom fiscal e NF
- [ ] **CA05** - Processamento em background

#### Regras de Negócio

- **RN01** - OCR é sugestão, usuário valida
- **RN02** - Qualidade da imagem afeta resultado
- **RN03** - Feature premium (V2)

---

### US06.06 - Fluxo de Pagamento

**Como** transportador  
**Quero** marcar despesas como pagas  
**Para** controlar o que já foi quitado

#### Status da Despesa

| Status | Descrição | Cor |
|--------|-----------|-----|
| Aberta | Não venceu, não paga |  Azul |
| Atrasada | Vencida, não paga |  Vermelho |
| Paga | Quitada |  Verde |
| Cancelada | Não será paga |  Cinza |

#### Campos ao Pagar

- Data do pagamento
- Valor pago (pode ser diferente)
- Forma de pagamento efetiva
- Comprovante (upload)
- Observações

#### Critérios de Aceitação

- [ ] **CA01** - Botão "Pagar" na despesa aberta/atrasada
- [ ] **CA02** - Data padrão = hoje
- [ ] **CA03** - Valor padrão = valor da despesa
- [ ] **CA04** - Solicitar comprovante ao pagar
- [ ] **CA05** - Atualiza status e impacta DRE
- [ ] **CA06** - Notificação de despesa atrasada

#### Regras de Negócio

- **RN01** - Despesa paga impacta resultado do mês do pagamento
- **RN02** - Diferença de valor é registrada (juros, desconto)
- **RN03** - Estorno reverte pagamento (histórico mantido)

---

### US06.07 - Painel de Contas a Pagar

**Como** transportador  
**Quero** ver todas as despesas em um painel  
**Para** gerenciar pagamentos

#### Critérios de Aceitação

- [ ] **CA01** - Resumo: Total, Vence Hoje, Atrasado, Pago
- [ ] **CA02** - Lista de despesas com filtros
- [ ] **CA03** - Filtros: Status, Categoria, Período, Veículo
- [ ] **CA04** - Ordenação por vencimento, valor, categoria
- [ ] **CA05** - Ações: Ver, Editar, Pagar, Cancelar
- [ ] **CA06** - Seleção em lote para pagar múltiplas

#### Widgets

```
┌────────────┬────────────┬────────────┬────────────┐
│ 💸 Total   │  Hoje    │  Atrasado│  Pago    │
│ R$ 8.450   │ R$ 850     │ R$ 350     │ R$ 5.200   │
│ 23 desp.   │ 3 desp.    │ 1 desp.    │ 14 desp.   │
└────────────┴────────────┴────────────┴────────────┘
```

---

### US06.08 - Alertas de Vencimento

**Como** transportador  
**Quero** receber alertas de despesas a vencer  
**Para** não atrasar pagamentos

#### Tipos de Alerta

| Tipo | Quando | Canal |
|------|--------|-------|
| Antecipado | 3 dias antes | App/E-mail |
| No dia | No vencimento | App/Push |
| Atraso | 1 dia depois | App/E-mail |

#### Critérios de Aceitação

- [ ] **CA01** - Configurar dias de antecedência
- [ ] **CA02** - Ativar/desativar por canal
- [ ] **CA03** - Notificação no app (badge)
- [ ] **CA04** - E-mail com lista de despesas
- [ ] **CA05** - Resumo diário opcional

---

### US06.09 - Centro de Custo

**Como** transportador  
**Quero** associar despesas a veículos ou rotas  
**Para** saber o custo de cada operação

#### Critérios de Aceitação

- [ ] **CA01** - Vincular despesa a veículo
- [ ] **CA02** - Vincular despesa a rota
- [ ] **CA03** - Despesa pode não ter centro de custo (geral)
- [ ] **CA04** - Relatório de despesas por veículo/rota
- [ ] **CA05** - Custo por aluno calculado

#### Regras de Negócio

- **RN01** - Centro de custo é opcional
- **RN02** - Despesas gerais são rateadas proporcionalmente (opcional)

---

### US06.10 - Relatório de Despesas

**Como** transportador  
**Quero** gerar relatório de despesas  
**Para** analisar custos e enviar para contabilidade

#### Critérios de Aceitação

- [ ] **CA01** - Relatório por período
- [ ] **CA02** - Agrupamento por categoria
- [ ] **CA03** - Filtro por status (pagas, abertas)
- [ ] **CA04** - Comparativo com período anterior
- [ ] **CA05** - Gráfico de pizza por categoria
- [ ] **CA06** - Exportação Excel/PDF
- [ ] **CA07** - Download de comprovantes em ZIP

#### Métricas do Relatório

- Total de despesas
- Despesas por categoria (%)
- Evolução mensal
- Custo por veículo/rota

---

### US06.11 - Importação de Despesas

**Como** transportador  
**Quero** importar despesas de planilha  
**Para** migrar dados existentes

#### Critérios de Aceitação

- [ ] **CA01** - Template Excel/CSV para download
- [ ] **CA02** - Upload e validação do arquivo
- [ ] **CA03** - Preview antes de importar
- [ ] **CA04** - Mapeamento de colunas
- [ ] **CA05** - Relatório de erros
- [ ] **CA06** - Importação parcial (só válidos)

#### Campos do Template

| Descrição | Categoria | Valor | Vencimento | Pago? | Data Pgto |
|-----------|-----------|-------|------------|-------|-----------|
| Combustível | Operação | 500 | 15/01/2026 | Sim | 14/01/2026 |

---

## Dependências

- **EP01** - Cadastros (veículos, rotas)

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US06.01 | 3 | Alta |
| US06.02 | 5 | Alta |
| US06.03 | 5 | Alta |
| US06.04 | 5 | Alta |
| US06.05 | 8 | Baixa (V2) |
| US06.06 | 5 | Alta |
| US06.07 | 5 | Alta |
| US06.08 | 3 | Média |
| US06.09 | 3 | Média |
| US06.10 | 5 | Alta |
| US06.11 | 5 | Baixa |
| **Total** | **52** | |

---

## Wireframes

### Cadastro de Despesa
```
┌─────────────────────────────────────────────────────────┐
│ 💸 Nova Despesa                                    [X]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Descrição *                                            │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Abastecimento veículo                           │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Categoria *                   Subcategoria             │
│  ┌───────────────────────┐    ┌───────────────────┐    │
│  │ 🚍 Operação          │    │ Combustível      │    │
│  └───────────────────────┘    └───────────────────┘    │
│                                                         │
│  Valor *                       Vencimento *             │
│  ┌───────────────────────┐    ┌───────────────────┐    │
│  │ R$ 350,00             │    │ 20/01/2026        │    │
│  └───────────────────────┘    └───────────────────┘    │
│                                                         │
│  Forma de Pagamento            Centro de Custo          │
│  ┌───────────────────────┐    ┌───────────────────┐    │
│  │ PIX                  │    │ Van ABC-1234     │    │
│  └───────────────────────┘    └───────────────────┘    │
│                                                         │
│  [ ] Despesa recorrente (mensal)                       │
│                                                         │
│  📎 Comprovante                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │                                                  │   │
│  │    Tirar Foto     Escolher Arquivo          │   │
│  │                                                  │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Observações                                            │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Posto Shell - BR 101                            │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│                           [Cancelar]  [Salvar Despesa] │
└─────────────────────────────────────────────────────────┘
```

### Painel de Contas a Pagar
```
┌─────────────────────────────────────────────────────────┐
│ 💸 Contas a Pagar                      Janeiro/2026    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ ┌────────────┬────────────┬────────────┬────────────┐  │
│ │ 💸 Total   │  Hoje    │  Atrasado│  Pago    │  │
│ │ R$ 8.450   │ R$ 850     │ R$ 350     │ R$ 5.200   │  │
│ │ 23 desp.   │ 3 desp.    │ 1 desp.    │ 14 desp.   │  │
│ └────────────┴────────────┴────────────┴────────────┘  │
│                                                         │
│ [+ Nova Despesa]                                        │
│                                                         │
│  Buscar...  [Categoria ] [Status ] [Veículo ]    │
│                                                         │
│ ┌───────────────────────────────────────────────────┐  │
│ │ ☐ │ Descrição     │ Categ.   │ Vencto │ Valor │St│  │
│ ├───┼───────────────┼──────────┼────────┼───────┼──┤  │
│ │ ☐ │ Combustível   │ 🚍 Oper. │ Hoje   │ R$350 ││  │
│ │ ☐ │ Contador      │ 🧑‍💼 Adm. │ Hoje   │ R$350 ││  │
│ │ ☐ │ IPVA parcela  │ 🚍 Oper. │ 15/01  │ R$450 ││  │
│ │ ☐ │ Pró-labore    │  Pess. │ 05/02  │ R$2000││  │
│ └───┴───────────────┴──────────┴────────┴───────┴──┘  │
│                                                         │
│ Selecionados: 0  [Pagar Selecionados]                  │
│                                                         │
│ Mostrando 1-10 de 23        [< 1 2 3 >]                │
└─────────────────────────────────────────────────────────┘
```

### Modal de Pagamento
```
┌─────────────────────────────────────────────────────────┐
│  Pagar Despesa                                   [X]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Combustível - Posto Shell                              │
│  Categoria: 🚍 Operação > Combustível                   │
│  Vencimento: 20/01/2026                                │
│  Valor: R$ 350,00                                       │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  Data do Pagamento *        Valor Pago *                │
│  ┌───────────────────┐     ┌───────────────────┐       │
│  │ 20/01/2026        │     │ R$ 350,00         │       │
│  └───────────────────┘     └───────────────────┘       │
│                                                         │
│  Forma de Pagamento *                                   │
│  ┌─────────────────────────────────────────────────┐   │
│  │ PIX                                            │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  📎 Comprovante do Pagamento                            │
│  ┌─────────────────────────────────────────────────┐   │
│  │  🧾 comprovante_pix.pdf                    [X]  │   │
│  └─────────────────────────────────────────────────┘   │
│  [+ Adicionar Comprovante]                              │
│                                                         │
│                     [Cancelar]  [Confirmar Pagamento ]│
└─────────────────────────────────────────────────────────┘
```

### Despesa Recorrente
```
┌─────────────────────────────────────────────────────────┐
│  Configurar Recorrência                          [X]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Frequência *                                           │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Mensal                                         │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Dia do Vencimento *                                    │
│  ┌─────────────────────────────────────────────────┐   │
│  │ 5                                              │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Data de Início *           Data de Fim                 │
│  ┌───────────────────┐     ┌───────────────────┐       │
│  │ 01/02/2026        │     │ (Indeterminado)   │       │
│  └───────────────────┘     └───────────────────┘       │
│                                                         │
│   Próximas gerações:                                  │
│     • 05/02/2026 - R$ 350,00                           │
│     • 05/03/2026 - R$ 350,00                           │
│     • 05/04/2026 - R$ 350,00                           │
│     ...                                                 │
│                                                         │
│                        [Cancelar]  [Confirmar]         │
└─────────────────────────────────────────────────────────┘
```
