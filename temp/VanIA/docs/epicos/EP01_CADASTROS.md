# EP01 - Cadastros e Configurações

## Objetivo do Épico

Permitir que o transportador configure sua operação com todos os cadastros base necessários: empresa, veículos, rotas, escolas, alunos e responsáveis.

---

## Histórias de Usuário

### US01.01 - Cadastro da Empresa/Transportador

**Como** transportador  
**Quero** cadastrar os dados da minha empresa  
**Para** que o sistema personalize contratos, notas fiscais e comunicações

#### Campos Obrigatórios
- Razão Social
- Nome Fantasia
- CNPJ ou CPF (MEI)
- Inscrição Municipal
- Endereço completo (CEP, logradouro, número, complemento, bairro, cidade, UF)
- Telefone
- E-mail
- Logo (upload de imagem)

#### Campos Opcionais
- Inscrição Estadual
- Regime tributário (Simples Nacional, Lucro Presumido, MEI)
- CNAE principal

#### Critérios de Aceitação

- [ ] **CA01** - Sistema valida CNPJ/CPF (dígitos verificadores)
- [ ] **CA02** - Sistema busca endereço automaticamente pelo CEP (API ViaCEP)
- [ ] **CA03** - Logo aceita formatos JPG, PNG até 2MB
- [ ] **CA04** - Dados são exibidos no cabeçalho de contratos e notas
- [ ] **CA05** - Permite edição a qualquer momento
- [ ] **CA06** - Histórico de alterações é mantido

#### Regras de Negócio

- **RN01** - CNPJ/CPF deve ser único no sistema
- **RN02** - Pelo menos um telefone é obrigatório
- **RN03** - E-mail deve ser válido e confirmado

---

### US01.02 - Cadastro de Veículos

**Como** transportador  
**Quero** cadastrar meus veículos  
**Para** vincular alunos e controlar capacidade

#### Campos Obrigatórios
- Placa
- Modelo
- Ano de fabricação
- Capacidade de passageiros
- Tipo (Van, Micro-ônibus, Ônibus)

#### Campos Opcionais
- Renavam
- Chassi
- Cor
- Data de vencimento do licenciamento
- Data de vencimento da vistoria
- Foto do veículo
- Observações

#### Critérios de Aceitação

- [ ] **CA01** - Placa é validada no formato brasileiro (ABC1234 ou ABC1D23)
- [ ] **CA02** - Sistema alerta 30 dias antes do vencimento de licenciamento/vistoria
- [ ] **CA03** - Exibe contador de alunos vinculados vs capacidade
- [ ] **CA04** - Permite inativar veículo sem excluir
- [ ] **CA05** - Histórico de manutenções pode ser visualizado

#### Regras de Negócio

- **RN01** - Placa deve ser única no cadastro
- **RN02** - Não permite vincular mais alunos que a capacidade
- **RN03** - Veículo inativo não aparece em novas matrículas

---

### US01.03 - Cadastro de Escolas

**Como** transportador  
**Quero** cadastrar as escolas que atendo  
**Para** organizar rotas e vincular alunos

#### Campos Obrigatórios
- Nome da escola
- Endereço completo
- Tipo (Municipal, Estadual, Particular)

#### Campos Opcionais
- Telefone
- E-mail
- Nome do contato
- Horários de entrada/saída
- Observações

#### Critérios de Aceitação

- [ ] **CA01** - Busca endereço por CEP
- [ ] **CA02** - Permite cadastrar múltiplos horários (manhã, tarde, integral)
- [ ] **CA03** - Exibe quantidade de alunos vinculados
- [ ] **CA04** - Permite inativar escola

#### Regras de Negócio

- **RN01** - Escola inativa mantém histórico mas não aparece em novos cadastros

---

### US01.04 - Cadastro de Rotas

**Como** transportador  
**Quero** cadastrar minhas rotas  
**Para** precificar e organizar o transporte

#### Campos Obrigatórios
- Nome/identificador da rota
- Descrição
- Veículo vinculado
- Escola(s) atendida(s)
- Valor mensal padrão

#### Campos Opcionais
- Turno (Manhã, Tarde, Integral)
- Horário de saída
- Horário de chegada
- Pontos de parada (lista ordenada)
- Quilometragem estimada
- Observações

#### Critérios de Aceitação

- [ ] **CA01** - Rota pode atender múltiplas escolas
- [ ] **CA02** - Valor pode ser diferenciado por turno
- [ ] **CA03** - Lista de paradas é ordenável (drag-and-drop)
- [ ] **CA04** - Exibe alunos vinculados à rota
- [ ] **CA05** - Permite clonar rota existente

#### Regras de Negócio

- **RN01** - Rota deve ter pelo menos uma escola vinculada
- **RN02** - Valor da rota é usado como padrão no contrato, mas pode ser alterado

---

### US01.05 - Cadastro de Responsáveis

**Como** transportador  
**Quero** cadastrar os responsáveis financeiros  
**Para** gerar contratos e cobranças

#### Campos Obrigatórios
- Nome completo
- CPF
- Telefone principal (WhatsApp)
- E-mail
- Endereço completo

#### Campos Opcionais
- RG
- Telefone secundário
- Profissão
- Local de trabalho
- Grau de parentesco com o aluno

#### Critérios de Aceitação

- [ ] **CA01** - CPF é validado (dígitos verificadores)
- [ ] **CA02** - Telefone WhatsApp é marcado para envio de cobranças
- [ ] **CA03** - E-mail é validado
- [ ] **CA04** - Busca endereço por CEP
- [ ] **CA05** - Um responsável pode ter múltiplos alunos
- [ ] **CA06** - Exibe histórico financeiro do responsável

#### Regras de Negócio

- **RN01** - CPF deve ser único
- **RN02** - Responsável é o titular do contrato e das cobranças
- **RN03** - WhatsApp é obrigatório para envio de cobranças

---

### US01.06 - Cadastro de Alunos

**Como** transportador  
**Quero** cadastrar os alunos  
**Para** controlar o transporte e gerar contratos

#### Campos Obrigatórios
- Nome completo
- Data de nascimento
- Responsável financeiro (vinculado)
- Escola
- Rota
- Turno

#### Campos Opcionais
- CPF do aluno
- RG do aluno
- Série/ano escolar
- Endereço de embarque (se diferente do responsável)
- Foto do aluno
- Informações médicas/alergias
- Necessidades especiais
- Contato de emergência
- Observações

#### Critérios de Aceitação

- [ ] **CA01** - Responsável é selecionado de cadastro existente ou criado na hora
- [ ] **CA02** - Escola e rota são selecionadas de cadastros existentes
- [ ] **CA03** - Idade é calculada automaticamente
- [ ] **CA04** - Permite upload de foto
- [ ] **CA05** - Informações médicas são destacadas visualmente
- [ ] **CA06** - Status do aluno: Ativo, Inativo, Pendente

#### Regras de Negócio

- **RN01** - Aluno deve ter responsável financeiro
- **RN02** - Aluno deve ter escola e rota vinculadas
- **RN03** - Aluno inativo não gera novas cobranças
- **RN04** - Ao inativar, perguntar se cancela cobranças futuras

---

### US01.07 - Matrícula Rápida (Wizard)

**Como** transportador  
**Quero** fazer matrícula completa em um único fluxo  
**Para** agilizar o processo de fechamento

#### Fluxo do Wizard

1. **Passo 1** - Dados do Responsável
2. **Passo 2** - Dados do Aluno
3. **Passo 3** - Seleção de Rota e Valores
4. **Passo 4** - Configuração do Contrato
5. **Passo 5** - Revisão e Confirmação

#### Critérios de Aceitação

- [ ] **CA01** - Progresso é salvo a cada passo (pode continuar depois)
- [ ] **CA02** - Permite voltar para passos anteriores
- [ ] **CA03** - Validação em tempo real
- [ ] **CA04** - Ao finalizar, gera contrato automaticamente
- [ ] **CA05** - Opção de enviar contrato imediatamente
- [ ] **CA06** - Exibe resumo com valores e datas

#### Regras de Negócio

- **RN01** - Se responsável já existe (CPF), preenche dados automaticamente
- **RN02** - Desconto pode ser aplicado no passo 3
- **RN03** - Data de início do contrato define primeira parcela

---

### US01.08 - Configurações do Sistema

**Como** transportador  
**Quero** configurar parâmetros gerais do sistema  
**Para** personalizar minha operação

#### Configurações Disponíveis

**Financeiro:**
- Dia de vencimento padrão (1-28)
- Tolerância para atraso (dias)
- Multa por atraso (%)
- Juros por dia de atraso (%)
- Desconto para pagamento antecipado (%)

**Comunicação:**
- Template de mensagem WhatsApp (cobrança)
- Template de mensagem WhatsApp (lembrete)
- Template de e-mail (cobrança)
- Dias de antecedência para lembrete
- Horário de envio de mensagens

**Contrato:**
- Template de contrato padrão
- Cláusulas adicionais
- Vigência padrão (meses)

**Notificações:**
- Alertas de vencimento de documentos
- Alertas de inadimplência
- Resumo diário/semanal

#### Critérios de Aceitação

- [ ] **CA01** - Configurações têm valores padrão sensatos
- [ ] **CA02** - Preview de mensagens com variáveis substituídas
- [ ] **CA03** - Configurações aplicam a novos cadastros (não retroativo)
- [ ] **CA04** - Histórico de alterações

---

## Dependências

- Nenhuma (módulo base)

## Estimativa

| História | Pontos | Prioridade |
|----------|--------|------------|
| US01.01 | 5 | Alta |
| US01.02 | 3 | Alta |
| US01.03 | 2 | Alta |
| US01.04 | 3 | Alta |
| US01.05 | 5 | Alta |
| US01.06 | 5 | Alta |
| US01.07 | 8 | Média |
| US01.08 | 5 | Média |
| **Total** | **36** | |

---

## Wireframes

### Tela de Lista de Alunos
```
┌─────────────────────────────────────────────────────────┐
│ 🎒 Alunos                          [+ Nova Matrícula]   │
├─────────────────────────────────────────────────────────┤
│  Buscar...          [Escola ] [Rota ] [Status ]   │
├─────────────────────────────────────────────────────────┤
│ ┌─────┬────────────┬──────────┬────────┬────────┬────┐ │
│ │   │ Nome       │ Escola   │ Rota   │ Status │ ⋯  │ │
│ ├─────┼────────────┼──────────┼────────┼────────┼────┤ │
│ │   │ João Silva │ Col. ABC │ Rota 1 │      │ ⋯  │ │
│ │   │ Maria...   │ Esc. XYZ │ Rota 2 │      │ ⋯  │ │
│ │   │ Pedro...   │ Col. ABC │ Rota 1 │      │ ⋯  │ │
│ └─────┴────────────┴──────────┴────────┴────────┴────┘ │
│                                                         │
│ Mostrando 1-10 de 45        [< 1 2 3 4 5 >]            │
└─────────────────────────────────────────────────────────┘
```

### Wizard de Matrícula
```
┌─────────────────────────────────────────────────────────┐
│ Nova Matrícula                                          │
├─────────────────────────────────────────────────────────┤
│  Responsável → ○ Aluno → ○ Rota → ○ Contrato → ○ Fim  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  CPF do Responsável                                     │
│  ┌─────────────────────────────────┐                   │
│  │ 123.456.789-00                  │ [Buscar]          │
│  └─────────────────────────────────┘                   │
│                                                         │
│   Responsável não encontrado. Preencha os dados:     │
│                                                         │
│  Nome Completo *                                        │
│  ┌─────────────────────────────────────────────────┐   │
│  │                                                  │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  WhatsApp *                    E-mail *                 │
│  ┌───────────────────┐        ┌────────────────────┐   │
│  │ (11) 99999-9999   │        │ email@exemplo.com  │   │
│  └───────────────────┘        └────────────────────┘   │
│                                                         │
│                              [Cancelar]  [Próximo →]   │
└─────────────────────────────────────────────────────────┘
```
