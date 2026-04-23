# Requisitos Técnicos - VanIA

## 1. Stack Tecnológica Recomendada

### Frontend

| Tecnologia | Justificativa |
|------------|---------------|
| **Next.js 14+** | SSR, App Router, performance |
| **React 18+** | Biblioteca UI padrão |
| **TypeScript** | Tipagem estática, menos bugs |
| **Tailwind CSS** | Estilização rápida e consistente |
| **shadcn/ui** | Componentes acessíveis e customizáveis |
| **React Query** | Cache e estado de servidor |
| **React Hook Form** | Formulários performáticos |
| **Zod** | Validação de schemas |

### Backend

| Tecnologia | Justificativa |
|------------|---------------|
| **Node.js 20+** | Runtime JavaScript |
| **Next.js API Routes** ou **NestJS** | Framework backend |
| **Prisma** | ORM type-safe |
| **PostgreSQL** | Banco relacional robusto |
| **Redis** | Cache e filas |
| **Bull/BullMQ** | Processamento de jobs |

### Infraestrutura

| Serviço | Uso |
|---------|-----|
| **Vercel** ou **Railway** | Deploy do app |
| **Supabase** ou **Neon** | PostgreSQL gerenciado |
| **Upstash** | Redis serverless |
| **Cloudflare R2** ou **AWS S3** | Armazenamento de arquivos |
| **Resend** ou **SendGrid** | Envio de e-mails |

### Integrações

| Serviço | Uso |
|---------|-----|
| **Asaas** | Gateway de pagamento (PIX, boleto) |
| **Z-API** ou **Twilio** | WhatsApp Business |
| **NFE.io** ou **Enotas** | Emissão de NFS-e |
| **Clicksign** | Assinatura digital (V2) |

---

## 2. Arquitetura

### Visão Geral

```
┌─────────────────────────────────────────────────────────────┐
│                        FRONTEND                              │
│                     (Next.js + React)                        │
│                                                              │
│   ┌─────────────┐ ┌─────────────┐ ┌─────────────────────┐  │
│   │   Webapp    │ │ Área Cliente│ │ Portal Contador     │  │
│   │   (Admin)   │ │  (Público)  │ │    (Limitado)       │  │
│   └─────────────┘ └─────────────┘ └─────────────────────┘  │
└───────────────────────────┬─────────────────────────────────┘
                            │
                            
┌─────────────────────────────────────────────────────────────┐
│                         API                                  │
│                  (Next.js API / NestJS)                      │
│                                                              │
│   ┌───────────┐ ┌───────────┐ ┌───────────┐ ┌───────────┐  │
│   │   Auth    │ │  Alunos   │ │ Financeiro│ │   Fiscal  │  │
│   └───────────┘ └───────────┘ └───────────┘ └───────────┘  │
│   ┌───────────┐ ┌───────────┐ ┌───────────┐ ┌───────────┐  │
│   │ Contratos │ │  Cobranças│ │ Relatórios│ │ Webhooks  │  │
│   └───────────┘ └───────────┘ └───────────┘ └───────────┘  │
└───────────────────────────┬─────────────────────────────────┘
                            │
          ┌─────────────────┼─────────────────┐
                                            
┌─────────────────┐ ┌─────────────┐ ┌─────────────────────┐
│   PostgreSQL    │ │    Redis    │ │    File Storage     │
│   (Supabase)    │ │  (Upstash)  │ │   (Cloudflare R2)   │
└─────────────────┘ └─────────────┘ └─────────────────────┘
          │
          └───────────────────────────────────┐
                                              
┌─────────────────────────────────────────────────────────────┐
│                    INTEGRAÇÕES EXTERNAS                      │
│                                                              │
│   ┌───────────┐ ┌───────────┐ ┌───────────┐ ┌───────────┐  │
│   │   Asaas   │ │  WhatsApp │ │   NFE.io  │ │ Clicksign │  │
│   │(Pagamentos)│ │  (Z-API)  │ │  (NFS-e)  │ │(Assinatura)│ │
│   └───────────┘ └───────────┘ └───────────┘ └───────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Estrutura de Pastas (Next.js App Router)

```
vania/
├── src/
│   ├── app/
│   │   ├── (auth)/
│   │   │   ├── login/
│   │   │   └── register/
│   │   ├── (dashboard)/
│   │   │   ├── alunos/
│   │   │   ├── contratos/
│   │   │   ├── financeiro/
│   │   │   │   ├── receber/
│   │   │   │   ├── pagar/
│   │   │   │   └── dre/
│   │   │   ├── fiscal/
│   │   │   ├── relatorios/
│   │   │   └── configuracoes/
│   │   ├── (public)/
│   │   │   └── cliente/[token]/
│   │   └── api/
│   │       ├── alunos/
│   │       ├── contratos/
│   │       ├── parcelas/
│   │       ├── despesas/
│   │       ├── nfse/
│   │       └── webhooks/
│   ├── components/
│   │   ├── ui/
│   │   ├── forms/
│   │   ├── tables/
│   │   └── charts/
│   ├── lib/
│   │   ├── prisma.ts
│   │   ├── auth.ts
│   │   └── utils.ts
│   ├── services/
│   │   ├── asaas.ts
│   │   ├── whatsapp.ts
│   │   ├── nfse.ts
│   │   └── email.ts
│   ├── hooks/
│   ├── types/
│   └── schemas/
├── prisma/
│   └── schema.prisma
├── public/
└── ...
```

---

## 3. Modelo de Dados (Prisma Schema)

```prisma
// prisma/schema.prisma

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// ==================== AUTENTICAÇÃO ====================

model User {
  id            String    @id @default(cuid())
  email         String    @unique
  password      String
  name          String
  role          Role      @default(ADMIN)
  empresaId     String
  empresa       Empresa   @relation(fields: [empresaId], references: [id])
  createdAt     DateTime  @default(now())
  updatedAt     DateTime  @updatedAt

  @@index([empresaId])
}

enum Role {
  ADMIN
  OPERATOR
  VIEWER
}

// ==================== EMPRESA ====================

model Empresa {
  id                  String    @id @default(cuid())
  razaoSocial         String
  nomeFantasia        String?
  cnpj                String    @unique
  inscricaoMunicipal  String?
  regimeTributario    RegimeTributario?
  endereco            Json      // { cep, logradouro, numero, complemento, bairro, cidade, uf }
  telefone            String
  email               String
  logo                String?   // URL da imagem
  
  // Configurações
  configFinanceiro    Json?     // { diaVencimento, multa, juros, desconto }
  configComunicacao   Json?     // { templates, horarios }
  configNfse          Json?     // { certificado, ambiente, codigoServico }
  
  // Relacionamentos
  users               User[]
  veiculos            Veiculo[]
  escolas             Escola[]
  rotas               Rota[]
  responsaveis        Responsavel[]
  alunos              Aluno[]
  contratos           Contrato[]
  parcelas            Parcela[]
  despesas            Despesa[]
  categoriasDespesa   CategoriaDespesa[]
  nfses               Nfse[]
  
  createdAt           DateTime  @default(now())
  updatedAt           DateTime  @updatedAt
}

enum RegimeTributario {
  SIMPLES_NACIONAL
  LUCRO_PRESUMIDO
  MEI
}

// ==================== VEÍCULOS ====================

model Veiculo {
  id                  String    @id @default(cuid())
  empresaId           String
  empresa             Empresa   @relation(fields: [empresaId], references: [id])
  
  placa               String
  modelo              String
  anoFabricacao       Int
  capacidade          Int
  tipo                TipoVeiculo
  renavam             String?
  cor                 String?
  vencimentoLicenciamento DateTime?
  vencimentoVistoria  DateTime?
  foto                String?
  ativo               Boolean   @default(true)
  observacoes         String?
  
  rotas               Rota[]
  despesas            Despesa[]
  
  createdAt           DateTime  @default(now())
  updatedAt           DateTime  @updatedAt

  @@unique([empresaId, placa])
  @@index([empresaId])
}

enum TipoVeiculo {
  VAN
  MICRO_ONIBUS
  ONIBUS
}

// ==================== ESCOLAS ====================

model Escola {
  id          String    @id @default(cuid())
  empresaId   String
  empresa     Empresa   @relation(fields: [empresaId], references: [id])
  
  nome        String
  endereco    Json      // { cep, logradouro, numero, complemento, bairro, cidade, uf }
  tipo        TipoEscola
  telefone    String?
  email       String?
  contato     String?
  horarios    Json?     // { manha: { entrada, saida }, tarde: {...}, integral: {...} }
  ativo       Boolean   @default(true)
  observacoes String?
  
  rotas       Rota[]
  alunos      Aluno[]
  
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt

  @@index([empresaId])
}

enum TipoEscola {
  MUNICIPAL
  ESTADUAL
  PARTICULAR
}

// ==================== ROTAS ====================

model Rota {
  id          String    @id @default(cuid())
  empresaId   String
  empresa     Empresa   @relation(fields: [empresaId], references: [id])
  
  nome        String
  descricao   String?
  veiculoId   String
  veiculo     Veiculo   @relation(fields: [veiculoId], references: [id])
  turno       Turno?
  horarioSaida    String?
  horarioChegada  String?
  valorMensal     Decimal   @db.Decimal(10, 2)
  pontosParada    Json?     // Array de pontos
  kmEstimado      Decimal?  @db.Decimal(10, 2)
  ativo           Boolean   @default(true)
  observacoes     String?
  
  escolas         Escola[]
  alunos          Aluno[]
  despesas        Despesa[]
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt

  @@index([empresaId])
}

enum Turno {
  MANHA
  TARDE
  INTEGRAL
}

// ==================== RESPONSÁVEIS ====================

model Responsavel {
  id              String    @id @default(cuid())
  empresaId       String
  empresa         Empresa   @relation(fields: [empresaId], references: [id])
  
  nome            String
  cpf             String
  rg              String?
  telefone        String
  telefoneSecundario String?
  email           String
  endereco        Json      // { cep, logradouro, numero, complemento, bairro, cidade, uf }
  profissao       String?
  localTrabalho   String?
  
  // Token para acesso à área do cliente
  tokenAcesso     String    @unique @default(cuid())
  
  alunos          Aluno[]
  contratos       Contrato[]
  parcelas        Parcela[]
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt

  @@unique([empresaId, cpf])
  @@index([empresaId])
  @@index([tokenAcesso])
}

// ==================== ALUNOS ====================

model Aluno {
  id                  String    @id @default(cuid())
  empresaId           String
  empresa             Empresa   @relation(fields: [empresaId], references: [id])
  
  nome                String
  dataNascimento      DateTime
  cpf                 String?
  rg                  String?
  serie               String?
  foto                String?
  enderecoEmbarque    Json?     // Se diferente do responsável
  infoMedicas         String?
  necessidadesEspeciais String?
  contatoEmergencia   Json?     // { nome, telefone, parentesco }
  
  responsavelId       String
  responsavel         Responsavel @relation(fields: [responsavelId], references: [id])
  escolaId            String
  escola              Escola    @relation(fields: [escolaId], references: [id])
  rotaId              String
  rota                Rota      @relation(fields: [rotaId], references: [id])
  turno               Turno
  
  status              StatusAluno @default(ATIVO)
  observacoes         String?
  
  contratos           Contrato[]
  parcelas            Parcela[]
  
  createdAt           DateTime  @default(now())
  updatedAt           DateTime  @updatedAt

  @@index([empresaId])
  @@index([responsavelId])
  @@index([escolaId])
  @@index([rotaId])
}

enum StatusAluno {
  ATIVO
  INATIVO
  PENDENTE
}

// ==================== CONTRATOS ====================

model Contrato {
  id              String    @id @default(cuid())
  empresaId       String
  empresa         Empresa   @relation(fields: [empresaId], references: [id])
  
  numero          String    // Ex: 2026/0001
  
  alunoId         String
  aluno           Aluno     @relation(fields: [alunoId], references: [id])
  responsavelId   String
  responsavel     Responsavel @relation(fields: [responsavelId], references: [id])
  
  dataInicio      DateTime
  dataFim         DateTime
  valorMensal     Decimal   @db.Decimal(10, 2)
  desconto        Decimal?  @db.Decimal(10, 2)
  percentualDesconto Decimal? @db.Decimal(5, 2)
  valorFinal      Decimal   @db.Decimal(10, 2)
  diaVencimento   Int
  
  templateId      String?
  pdfUrl          String?
  pdfAssinadoUrl  String?
  
  status          StatusContrato @default(RASCUNHO)
  dataAssinatura  DateTime?
  
  observacoes     String?
  
  parcelas        Parcela[]
  aditivos        AditivoContrato[]
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt

  @@unique([empresaId, numero])
  @@index([empresaId])
  @@index([alunoId])
  @@index([status])
}

enum StatusContrato {
  RASCUNHO
  ENVIADO
  ASSINADO
  ATIVO
  ENCERRADO
  CANCELADO
}

model AditivoContrato {
  id          String    @id @default(cuid())
  contratoId  String
  contrato    Contrato  @relation(fields: [contratoId], references: [id])
  
  numero      Int       // 1, 2, 3...
  tipo        TipoAditivo
  descricao   String
  pdfUrl      String?
  
  createdAt   DateTime  @default(now())
}

enum TipoAditivo {
  ALTERACAO_VALOR
  ALTERACAO_ROTA
  ALTERACAO_ESCOLA
  ALTERACAO_HORARIO
  OUTRO
}

// ==================== PARCELAS / CARNÊ ====================

model Parcela {
  id              String    @id @default(cuid())
  empresaId       String
  empresa         Empresa   @relation(fields: [empresaId], references: [id])
  
  contratoId      String?
  contrato        Contrato? @relation(fields: [contratoId], references: [id])
  alunoId         String
  aluno           Aluno     @relation(fields: [alunoId], references: [id])
  responsavelId   String
  responsavel     Responsavel @relation(fields: [responsavelId], references: [id])
  
  numero          Int       // 1, 2, 3...
  referencia      String    // "Jan/2026"
  dataVencimento  DateTime
  
  valorOriginal   Decimal   @db.Decimal(10, 2)
  desconto        Decimal?  @db.Decimal(10, 2)
  valorFinal      Decimal   @db.Decimal(10, 2)
  
  // Dados de pagamento
  status          StatusParcela @default(ABERTA)
  dataPagamento   DateTime?
  valorPago       Decimal?  @db.Decimal(10, 2)
  formaPagamento  FormaPagamento?
  
  // PIX
  pixCopiaCola    String?
  pixQrCode       String?
  pixTxId         String?   @unique
  pixExpiracao    DateTime?
  
  // Gateway
  cobrancaExternaId String?   // ID no Asaas/PagSeguro
  boletoUrl       String?
  boletoLinhaDigitavel String?
  
  // NFS-e
  nfseId          String?
  nfse            Nfse?     @relation(fields: [nfseId], references: [id])
  
  tipo            TipoParcela @default(MENSALIDADE)
  observacoes     String?
  
  // Log de envios
  envios          EnvioParcela[]
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt

  @@index([empresaId])
  @@index([contratoId])
  @@index([alunoId])
  @@index([responsavelId])
  @@index([status])
  @@index([dataVencimento])
}

enum StatusParcela {
  ABERTA
  PAGA
  ATRASADA
  CANCELADA
  EM_ACORDO
}

enum FormaPagamento {
  PIX
  BOLETO
  CARTAO
  DINHEIRO
  TRANSFERENCIA
  CHEQUE
  OUTRO
}

enum TipoParcela {
  MENSALIDADE
  AVULSA
  ACORDO
}

model EnvioParcela {
  id          String    @id @default(cuid())
  parcelaId   String
  parcela     Parcela   @relation(fields: [parcelaId], references: [id])
  
  canal       CanalEnvio
  tipo        TipoEnvio
  status      StatusEnvio
  erro        String?
  
  createdAt   DateTime  @default(now())
}

enum CanalEnvio {
  WHATSAPP
  EMAIL
}

enum TipoEnvio {
  COBRANCA
  LEMBRETE
  CONTRATO
  NFSE
}

enum StatusEnvio {
  ENVIADO
  ENTREGUE
  LIDO
  ERRO
}

// ==================== DESPESAS / CONTAS A PAGAR ====================

model CategoriaDespesa {
  id          String    @id @default(cuid())
  empresaId   String
  empresa     Empresa   @relation(fields: [empresaId], references: [id])
  
  nome        String
  tipo        TipoCategoriaDespesa
  cor         String?
  icone       String?
  padrao      Boolean   @default(false)  // Categorias do sistema
  ativo       Boolean   @default(true)
  
  despesas    Despesa[]
  
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt

  @@unique([empresaId, nome])
  @@index([empresaId])
}

enum TipoCategoriaDespesa {
  PESSOAL
  OPERACAO
  TRIBUTOS
  ADMINISTRATIVO
  OUTROS
}

model Despesa {
  id              String    @id @default(cuid())
  empresaId       String
  empresa         Empresa   @relation(fields: [empresaId], references: [id])
  
  descricao       String
  categoriaId     String
  categoria       CategoriaDespesa @relation(fields: [categoriaId], references: [id])
  
  valor           Decimal   @db.Decimal(10, 2)
  dataVencimento  DateTime
  formaPagamento  FormaPagamento?
  
  // Centro de custo
  veiculoId       String?
  veiculo         Veiculo?  @relation(fields: [veiculoId], references: [id])
  rotaId          String?
  rota            Rota?     @relation(fields: [rotaId], references: [id])
  
  fornecedor      String?
  numeroDocumento String?
  
  // Recorrência
  recorrente      Boolean   @default(false)
  recorrenciaId   String?   // ID da configuração de recorrência
  
  // Pagamento
  status          StatusDespesa @default(ABERTA)
  dataPagamento   DateTime?
  valorPago       Decimal?  @db.Decimal(10, 2)
  formaPagamentoEfetiva FormaPagamento?
  
  // Comprovantes
  comprovantes    ComprovanteDespesa[]
  
  observacoes     String?
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt

  @@index([empresaId])
  @@index([categoriaId])
  @@index([status])
  @@index([dataVencimento])
}

enum StatusDespesa {
  ABERTA
  PAGA
  ATRASADA
  CANCELADA
}

model ComprovanteDespesa {
  id          String    @id @default(cuid())
  despesaId   String
  despesa     Despesa   @relation(fields: [despesaId], references: [id])
  
  arquivo     String    // URL do arquivo
  nome        String
  tipo        String    // mime type
  tamanho     Int       // bytes
  
  createdAt   DateTime  @default(now())
}

model RecorrenciaDespesa {
  id              String    @id @default(cuid())
  empresaId       String
  
  descricao       String
  categoriaId     String
  valor           Decimal   @db.Decimal(10, 2)
  formaPagamento  FormaPagamento?
  veiculoId       String?
  rotaId          String?
  
  frequencia      FrequenciaRecorrencia
  diaGeracao      Int       // 1-28
  dataInicio      DateTime
  dataFim         DateTime?
  
  ativo           Boolean   @default(true)
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt
}

enum FrequenciaRecorrencia {
  SEMANAL
  QUINZENAL
  MENSAL
}

// ==================== NFS-e ====================

model Nfse {
  id              String    @id @default(cuid())
  empresaId       String
  empresa         Empresa   @relation(fields: [empresaId], references: [id])
  
  numero          String?   // Número da nota (vem da prefeitura)
  codigoVerificacao String?
  
  // Dados da nota
  dataEmissao     DateTime?
  valorServico    Decimal   @db.Decimal(10, 2)
  aliquotaIss     Decimal   @db.Decimal(5, 2)
  valorIss        Decimal   @db.Decimal(10, 2)
  descricaoServico String
  
  // Tomador
  tomadorNome     String
  tomadorCpfCnpj  String
  tomadorEndereco Json
  tomadorEmail    String?
  
  // Arquivos
  xmlUrl          String?
  pdfUrl          String?
  
  // Status
  status          StatusNfse @default(PROCESSANDO)
  erro            String?
  
  // Integração
  rpsNumero       String?   // Número do RPS enviado
  agregadorId     String?   // ID no agregador (NFE.io, etc)
  
  parcelas        Parcela[]
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt

  @@index([empresaId])
  @@index([status])
}

enum StatusNfse {
  PROCESSANDO
  AUTORIZADA
  REJEITADA
  CANCELADA
}

// ==================== CONFIGURAÇÕES ====================

model TemplateContrato {
  id          String    @id @default(cuid())
  empresaId   String
  
  nome        String
  conteudo    String    @db.Text
  ativo       Boolean   @default(true)
  padrao      Boolean   @default(false)
  
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt
}

model TemplateMensagem {
  id          String    @id @default(cuid())
  empresaId   String
  
  nome        String
  tipo        TipoTemplateMensagem
  canal       CanalEnvio
  conteudo    String    @db.Text
  aprovado    Boolean   @default(false)  // Para WhatsApp HSM
  
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt
}

enum TipoTemplateMensagem {
  COBRANCA_VENCIMENTO
  COBRANCA_ATRASO
  LEMBRETE
  CONTRATO
  NFSE
  PAGAMENTO_CONFIRMADO
}

// ==================== LOGS E AUDITORIA ====================

model AuditLog {
  id          String    @id @default(cuid())
  empresaId   String
  userId      String?
  
  entidade    String    // "Aluno", "Parcela", etc
  entidadeId  String
  acao        String    // "CREATE", "UPDATE", "DELETE"
  dadosAntigos Json?
  dadosNovos  Json?
  
  ip          String?
  userAgent   String?
  
  createdAt   DateTime  @default(now())

  @@index([empresaId])
  @@index([entidade, entidadeId])
}
```

---

## 4. API Endpoints

### Autenticação

```
POST   /api/auth/login
POST   /api/auth/register
POST   /api/auth/logout
POST   /api/auth/refresh
POST   /api/auth/forgot-password
POST   /api/auth/reset-password
```

### Alunos

```
GET    /api/alunos
GET    /api/alunos/:id
POST   /api/alunos
PUT    /api/alunos/:id
DELETE /api/alunos/:id
POST   /api/alunos/matricula    # Wizard completo
```

### Contratos

```
GET    /api/contratos
GET    /api/contratos/:id
POST   /api/contratos
PUT    /api/contratos/:id
DELETE /api/contratos/:id
POST   /api/contratos/:id/gerar-pdf
POST   /api/contratos/:id/enviar
POST   /api/contratos/:id/cancelar
```

### Parcelas

```
GET    /api/parcelas
GET    /api/parcelas/:id
POST   /api/parcelas
PUT    /api/parcelas/:id
POST   /api/parcelas/:id/baixa
POST   /api/parcelas/:id/estorno
POST   /api/parcelas/:id/enviar
POST   /api/parcelas/enviar-lote
GET    /api/parcelas/:id/pix
```

### Despesas

```
GET    /api/despesas
GET    /api/despesas/:id
POST   /api/despesas
PUT    /api/despesas/:id
DELETE /api/despesas/:id
POST   /api/despesas/:id/pagar
POST   /api/despesas/:id/comprovante
```

### NFS-e

```
GET    /api/nfse
GET    /api/nfse/:id
POST   /api/nfse/emitir
POST   /api/nfse/emitir-lote
POST   /api/nfse/:id/cancelar
GET    /api/nfse/:id/xml
GET    /api/nfse/:id/pdf
```

### Relatórios

```
GET    /api/relatorios/dre
GET    /api/relatorios/receitas
GET    /api/relatorios/despesas
GET    /api/relatorios/inadimplencia
GET    /api/relatorios/por-veiculo
GET    /api/relatorios/por-rota
```

### Webhooks (Recebimento)

```
POST   /api/webhooks/asaas
POST   /api/webhooks/nfse
POST   /api/webhooks/whatsapp
```

---

## 5. Segurança

### Autenticação e Autorização

- **JWT** com refresh tokens
- **RBAC** (Role-Based Access Control)
- Sessões armazenadas no Redis
- Rate limiting por IP e usuário

### Proteção de Dados

- Senhas com bcrypt (salt rounds: 12)
- Dados sensíveis criptografados (AES-256)
- HTTPS obrigatório
- Headers de segurança (Helmet)
- CORS configurado

### LGPD

- Consentimento explícito para comunicações
- Exportação de dados (direito de portabilidade)
- Exclusão de dados (direito ao esquecimento)
- Log de acesso aos dados
- Política de retenção (5 anos para dados fiscais)

---

## 6. Performance

### Otimizações

- **Cache**: Redis para dados frequentes
- **CDN**: Cloudflare para assets estáticos
- **Paginação**: Cursor-based para listas grandes
- **Lazy loading**: Componentes e imagens
- **Database**: Índices, connection pooling

### Métricas de Performance

| Métrica | Target |
|---------|--------|
| TTFB | < 200ms |
| LCP | < 2.5s |
| FID | < 100ms |
| CLS | < 0.1 |
| API Response | < 500ms (p95) |

---

## 7. Monitoramento

### Ferramentas

- **Vercel Analytics**: Performance e erros
- **Sentry**: Error tracking
- **Uptime Robot**: Monitoramento de disponibilidade
- **Logtail/Axiom**: Logs centralizados

### Alertas

- Erro 5xx > 1% em 5 min
- Latência p95 > 2s
- Downtime > 1 min
- Falha em webhook > 3x consecutivas

---

## 8. CI/CD

### Pipeline

```yaml
# .github/workflows/ci.yml

name: CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npm run lint
      - run: npm run test
      - run: npm run build

  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

---

## 9. Estimativas de Custo (Infraestrutura)

### Plano Inicial (até 50 empresas)

| Serviço | Custo Estimado |
|---------|----------------|
| Vercel Pro | $20/mês |
| Supabase Pro | $25/mês |
| Upstash Pro | $10/mês |
| Cloudflare R2 | $5/mês |
| Resend | $20/mês |
| Total | ~$80/mês |

### Custos Variáveis (por transação)

| Serviço | Custo |
|---------|-------|
| Asaas (PIX) | R$ 0,99/transação |
| Asaas (Boleto) | R$ 1,99/boleto |
| WhatsApp API | ~$0.005/msg |
| NFE.io | R$ 0,20/nota |

---

## 10. Roadmap Técnico

### Sprint 1-2: Foundation
- [x] Setup do projeto (Next.js + Prisma + Auth)
- [ ] CRUD de cadastros básicos
- [ ] Autenticação e autorização

### Sprint 3-4: Contratos
- [ ] Templates de contrato
- [ ] Geração de PDF
- [ ] Envio por e-mail

### Sprint 5-6: Financeiro Receber
- [ ] Geração de parcelas
- [ ] Integração Asaas (PIX)
- [ ] Baixa automática (webhook)

### Sprint 7-8: Comunicação
- [ ] Integração WhatsApp
- [ ] Lembretes automáticos
- [ ] Área do cliente

### Sprint 9-10: Financeiro Pagar
- [ ] Cadastro de despesas
- [ ] Upload de comprovantes
- [ ] Relatórios

### Sprint 11-12: Fiscal
- [ ] Integração NFS-e
- [ ] DRE
- [ ] Exportação contábil
