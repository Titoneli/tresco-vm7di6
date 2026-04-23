# Glossário - VanIA

## Termos do Negócio

### A

**Aditivo**
Documento complementar ao contrato original que formaliza alterações (valor, rota, horário) sem necessidade de novo contrato.

**Aluno**
Criança ou adolescente que utiliza o serviço de transporte escolar. Sempre vinculado a um responsável financeiro.

**Acordo**
Negociação com cliente inadimplente para parcelamento ou desconto de valores em atraso.

### B

**Baixa**
Ação de registrar o pagamento de uma parcela ou despesa. Pode ser automática (webhook) ou manual.

### C

**Carnê**
Conjunto de parcelas geradas a partir de um contrato. Representa todas as mensalidades do período contratado.

**Centro de Custo**
Forma de classificar despesas por veículo ou rota, permitindo análise de rentabilidade por operação.

**Contrato**
Documento formal que estabelece os termos do serviço de transporte entre o transportador e o responsável.

### D

**DAS (Documento de Arrecadação do Simples Nacional)**
Guia única de pagamento de impostos para empresas optantes pelo Simples Nacional.

**DRE (Demonstração do Resultado do Exercício)**
Relatório que mostra receitas, despesas e lucro/prejuízo de um período.

**Despesa**
Qualquer gasto da operação: combustível, manutenção, salários, impostos, etc.

**Despesa Recorrente**
Despesa que se repete periodicamente (mensal), gerada automaticamente pelo sistema.

### E

**Estorno**
Reversão de um pagamento registrado incorretamente.

### I

**Inadimplência**
Situação de parcelas vencidas e não pagas. Calculada como percentual do total a receber.

**ISS (Imposto Sobre Serviços)**
Imposto municipal que incide sobre serviços, incluindo transporte escolar.

### L

**Lucro Operacional**
Resultado financeiro = Receita Líquida - Despesas Totais.

### M

**Margem de Lucro**
Percentual do lucro em relação à receita. Fórmula: (Lucro / Receita) × 100.

**MEI (Microempreendedor Individual)**
Categoria de empresa com faturamento até R$ 81.000/ano e regras simplificadas.

**Mensalidade**
Valor cobrado mensalmente pelo serviço de transporte escolar.

### N

**NFS-e (Nota Fiscal de Serviço Eletrônica)**
Documento fiscal eletrônico que comprova a prestação de serviço e recolhimento de impostos.

### O

**Ocupação**
Percentual de alunos transportados em relação à capacidade do veículo/rota.

### P

**Parcela**
Uma cobrança individual dentro do carnê. Tem vencimento, valor e status próprios.

**PIX**
Sistema de pagamento instantâneo do Banco Central. Permite cobrança via QR Code ou chave.

**Pró-labore**
Remuneração do sócio/proprietário da empresa.

### R

**Responsável (Financeiro)**
Pessoa física (pai, mãe ou responsável legal) que assina o contrato e é cobrada pelas mensalidades.

**Rota**
Trajeto definido com pontos de parada, escolas atendidas e valor associado.

**RPS (Recibo Provisório de Serviço)**
Documento enviado à prefeitura para conversão em NFS-e.

### S

**Simples Nacional**
Regime tributário simplificado para micro e pequenas empresas.

**Status da Parcela**
- **Aberta**: Não venceu, não paga
- **Atrasada**: Vencida, não paga
- **Paga**: Quitada
- **Cancelada**: Não será cobrada
- **Em Acordo**: Incluída em negociação

### T

**Template**
Modelo pré-configurado de documento (contrato) ou mensagem (WhatsApp/e-mail).

**Ticket Médio**
Valor médio por aluno. Fórmula: Receita Total / Número de Alunos.

**Tomador**
Pessoa ou empresa que recebe o serviço (na NFS-e, é o responsável).

**Turno**
Período de transporte: Manhã, Tarde ou Integral.

### V

**Vigência**
Período de validade do contrato (data início a data fim).

---

## Termos Técnicos

### A

**API (Application Programming Interface)**
Interface que permite comunicação entre sistemas. Usada para integrações.

**API Key**
Chave de autenticação para acessar APIs externas.

### B

**Boleto**
Forma de pagamento via código de barras, com vencimento definido.

### C

**Callback / Webhook**
Notificação automática enviada por um sistema quando ocorre um evento.

**CNAE (Classificação Nacional de Atividades Econômicas)**
Código que identifica a atividade da empresa. Transporte escolar: 4923-0/02.

**CORS (Cross-Origin Resource Sharing)**
Mecanismo de segurança que controla acesso entre domínios diferentes.

### G

**Gateway de Pagamento**
Serviço intermediário que processa pagamentos (Asaas, PagSeguro, etc).

### H

**HSM (Highly Structured Message)**
Mensagem pré-aprovada pelo WhatsApp Business API.

### J

**JWT (JSON Web Token)**
Padrão de token para autenticação em APIs.

### L

**LGPD (Lei Geral de Proteção de Dados)**
Lei brasileira que regulamenta tratamento de dados pessoais.

### O

**OCR (Optical Character Recognition)**
Tecnologia que converte imagem em texto. Usada para ler comprovantes.

**ORM (Object-Relational Mapping)**
Biblioteca que facilita interação com banco de dados (ex: Prisma).

### P

**Payload**
Dados enviados em uma requisição ou webhook.

### R

**Rate Limiting**
Limitação de requisições por período para evitar abuso.

**RBAC (Role-Based Access Control)**
Controle de acesso baseado em papéis (Admin, Operador, etc).

### S

**Sandbox**
Ambiente de testes que simula o sistema real sem impacto.

**SaaS (Software as a Service)**
Modelo de software oferecido como serviço via internet.

**SSR (Server-Side Rendering)**
Renderização de páginas no servidor antes de enviar ao navegador.

### T

**Token**
Código único usado para autenticação ou identificação.

**txid**
Identificador único de transação PIX.

### W

**Webhook**
URL que recebe notificações automáticas de eventos externos.

**WYSIWYG (What You See Is What You Get)**
Editor visual que mostra o resultado final durante a edição.

---

## Siglas

| Sigla | Significado |
|-------|-------------|
| API | Application Programming Interface |
| CA | Critério de Aceitação |
| CNPJ | Cadastro Nacional de Pessoa Jurídica |
| CPF | Cadastro de Pessoa Física |
| DRE | Demonstração do Resultado do Exercício |
| EP | Épico |
| FGTS | Fundo de Garantia do Tempo de Serviço |
| HSM | Highly Structured Message |
| INSS | Instituto Nacional do Seguro Social |
| IPVA | Imposto sobre Propriedade de Veículos Automotores |
| ISS | Imposto Sobre Serviços |
| JWT | JSON Web Token |
| KPI | Key Performance Indicator |
| LGPD | Lei Geral de Proteção de Dados |
| MEI | Microempreendedor Individual |
| MVP | Minimum Viable Product |
| NFS-e | Nota Fiscal de Serviço Eletrônica |
| OCR | Optical Character Recognition |
| PDF | Portable Document Format |
| PIX | Pagamento Instantâneo |
| PRD | Product Requirements Document |
| RBAC | Role-Based Access Control |
| RN | Regra de Negócio |
| RPS | Recibo Provisório de Serviço |
| SaaS | Software as a Service |
| SMTP | Simple Mail Transfer Protocol |
| SSR | Server-Side Rendering |
| US | User Story (História de Usuário) |
| XML | Extensible Markup Language |
