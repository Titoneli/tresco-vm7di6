# Requisitos Técnicos - VanIA Marketplace

## 1. Visão Geral da Arquitetura

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           VANIA MARKETPLACE                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────┐                        │
│  │  App      │   │  App      │   │  Web      │                        │
│  │ Pais        │   │ Motorista   │   │ Backoffice  │                        │
│  │ (iOS/And)   │   │ (iOS/And)   │   │ (Admin)     │                        │
│  └──────┬──────┘   └──────┬──────┘   └──────┬──────┘                        │
│         │                 │                  │                               │
│         └─────────────────┼──────────────────┘                               │
│                           │                                                  │
│                                                                             │
│         ┌─────────────────────────────────────┐                             │
│         │           API GATEWAY               │                             │
│         │        (Rate Limiting)              │                             │
│         └─────────────────┬───────────────────┘                             │
│                           │                                                  │
│         ┌─────────────────┼───────────────────┐                             │
│         │                 │                   │                              │
│                                                                           │
│  ┌─────────────┐  ┌─────────────┐   ┌─────────────┐                         │
│  │ Auth        │  │ Core API    │   │ WebSocket   │                         │
│  │ Service     │  │ (REST)      │   │ Server      │                         │
│  └─────────────┘  └──────┬──────┘   └─────────────┘                         │
│                          │                                                   │
│         ┌────────────────┼────────────────────┐                             │
│         │                │                    │                              │
│                                                                           │
│  ┌─────────────┐  ┌─────────────┐   ┌─────────────┐                         │
│  │ PostgreSQL  │  │ Redis       │   │ S3/Storage  │                         │
│  │ (Prisma)    │  │ (Cache/PubSub)│  │ (Files)    │                         │
│  └─────────────┘  └─────────────┘   └─────────────┘                         │
│                                                                              │
│         ┌─────────────────────────────────────────┐                         │
│         │           INTEGRAÇÕES                   │                         │
│         ├─────────────────────────────────────────┤                         │
│         │ • Asaas (Pagamentos)                    │                         │
│         │ • NFE.io (Notas Fiscais)                │                         │
│         │ • Google Maps (Geolocalização)          │                         │
│         │ • Firebase (Push Notifications)         │                         │
│         │ • Twilio/Zenvia (SMS)                   │                         │
│         └─────────────────────────────────────────┘                         │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Stack Tecnológica

### 2.1 Mobile Apps (Pais e Motorista)

```yaml
Framework: React Native 0.73+
  - Expo SDK 50+
  - TypeScript
  
Navegação:
  - React Navigation 6
  - Deep Linking
  
Estado:
  - Zustand (estado global)
  - TanStack Query (server state)
  
UI/UX:
  - NativeWind (Tailwind para RN)
  - React Native Paper / Tamagui
  
Mapas:
  - react-native-maps
  - Google Maps SDK
  
Notificações:
  - Firebase Cloud Messaging
  - Expo Notifications
  
Storage:
  - MMKV (key-value)
  - Expo SecureStore (sensíveis)
  
Real-time:
  - Socket.io client
```

### 2.2 Web Backoffice

```yaml
Framework: Next.js 14+
  - App Router
  - Server Components
  - TypeScript
  
UI:
  - Tailwind CSS
  - shadcn/ui
  - Radix UI Primitives
  
Estado:
  - Zustand
  - TanStack Query
  
Formulários:
  - React Hook Form
  - Zod (validação)
  
Tabelas:
  - TanStack Table
  
Gráficos:
  - Recharts
  - Tremor
  
Autenticação:
  - NextAuth.js
  - JWT + Refresh Token
```

### 2.3 Backend API

```yaml
Runtime: Node.js 20 LTS

Framework: 
  Opção A: NestJS (enterprise)
  Opção B: Fastify + tRPC (performático)
  
ORM: Prisma 5+

Database: PostgreSQL 15+

Cache: Redis 7+

File Storage: 
  - AWS S3 / Cloudflare R2
  - Local dev: MinIO

Message Queue:
  - BullMQ (Redis-based)
  
WebSocket:
  - Socket.io
  
Validação:
  - Zod
  
Documentação:
  - OpenAPI/Swagger
```

---

## 3. Modelo de Dados (Prisma Schema)

### 3.1 Entidades Principais

```prisma
// prisma/schema.prisma

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// ============================================
// USUÁRIOS E AUTENTICAÇÃO
// ============================================

enum UserType {
  RESPONSAVEL
  MOTORISTA
  ADMIN
}

enum UserStatus {
  PENDING
  ACTIVE
  SUSPENDED
  BLOCKED
}

model User {
  id            BigInt      @id @default(autoincrement())
  type          UserType
  status        UserStatus  @default(PENDING)
  
  // Auth
  email         String      @unique
  phone         String      @unique
  passwordHash  String
  phoneVerified Boolean     @default(false)
  emailVerified Boolean     @default(false)
  
  // Profile
  name          String
  cpf           String      @unique
  avatarUrl     String?
  
  // Timestamps
  createdAt     DateTime    @default(now())
  updatedAt     DateTime    @updatedAt
  lastLoginAt   DateTime?
  
  // Relations
  responsavel   Responsavel?
  motorista     Motorista?
  admin         Admin?
  devices       Device[]
  notifications Notification[]
  
  @@index([type, status])
  @@index([email])
  @@index([phone])
}

model Device {
  id          BigInt   @id @default(autoincrement())
  userId      BigInt
  user        User     @relation(fields: [userId], references: [id])
  
  platform    String   // ios, android, web
  pushToken   String?
  deviceId    String
  appVersion  String
  
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  
  @@unique([userId, deviceId])
}

// ============================================
// RESPONSÁVEL (PAI/MÃE)
// ============================================

model Responsavel {
  id          BigInt   @id @default(autoincrement())
  userId      BigInt   @unique
  user        User     @relation(fields: [userId], references: [id])
  
  // Endereço principal
  address     Address?
  
  // Relations
  filhos      Filho[]
  solicitacoes Solicitacao[]
  contratos   Contrato[]
  pagamentos  Pagamento[]
  avaliacoes  Avaliacao[]   @relation("AvaliacoesDadas")
  chats       ChatParticipant[]
  
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}

model Filho {
  id              BigInt   @id @default(autoincrement())
  responsavelId   BigInt
  responsavel     Responsavel @relation(fields: [responsavelId], references: [id])
  
  name            String
  birthDate       DateTime
  photoUrl        String?
  
  // Escola
  escolaId        BigInt
  escola          Escola   @relation(fields: [escolaId], references: [id])
  serie           String
  turno           Turno
  
  // Endereço de embarque (se diferente)
  embarqueAddressId BigInt?
  embarqueAddress   Address? @relation(fields: [embarqueAddressId], references: [id])
  
  // Info adicional
  necessidadesEspeciais String?
  alergias              String?
  observacoes           String?
  
  // Contato emergência
  contatoEmergenciaNome  String?
  contatoEmergenciaPhone String?
  
  // Relations
  solicitacoes    SolicitacaoFilho[]
  contratos       ContratoFilho[]
  presencas       Presenca[]
  
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt
  
  @@index([responsavelId])
  @@index([escolaId])
}

enum Turno {
  MANHA
  TARDE
  INTEGRAL
}

// ============================================
// MOTORISTA
// ============================================

enum MotoristaStatus {
  CADASTRO_PENDENTE
  AGUARDANDO_APROVACAO
  APROVADO
  SUSPENSO
  BLOQUEADO
}

model Motorista {
  id          BigInt          @id @default(autoincrement())
  userId      BigInt          @unique
  user        User            @relation(fields: [userId], references: [id])
  status      MotoristaStatus @default(CADASTRO_PENDENTE)
  
  // Perfil
  bio         String?
  experienciaAnos Int?
  
  // Documentos
  documentos  MotoristaDocumento[]
  
  // Veículo
  veiculo     Veiculo?
  
  // Financeiro
  dadosBancarios DadosBancarios?
  
  // Operação
  escolasAtendidas MotoristaEscola[]
  regioesAtuacao   MotoristaRegiao[]
  vagasDisponiveis Int @default(0)
  
  // Avaliação
  rating          Float @default(0)
  totalAvaliacoes Int   @default(0)
  
  // Relations
  ofertas     Oferta[]
  contratos   Contrato[]
  rotas       Rota[]
  recebimentos Recebimento[]
  avaliacoes  Avaliacao[]   @relation("AvaliacoesRecebidas")
  chats       ChatParticipant[]
  
  // Timestamps
  aprovadoEm  DateTime?
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  
  @@index([status])
}

model MotoristaDocumento {
  id            BigInt   @id @default(autoincrement())
  motoristaId   BigInt
  motorista     Motorista @relation(fields: [motoristaId], references: [id])
  
  tipo          DocumentoTipo
  fileUrl       String
  validoAte     DateTime?
  verificado    Boolean  @default(false)
  verificadoPor String?
  verificadoEm  DateTime?
  
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  
  @@unique([motoristaId, tipo])
}

enum DocumentoTipo {
  CNH_FRENTE
  CNH_VERSO
  CNH_SELFIE
  CRLV
  SEGURO
  ALVARA
  VISTORIA
  ANTECEDENTES
  CURSO
}

model Veiculo {
  id            BigInt   @id @default(autoincrement())
  motoristaId   BigInt   @unique
  motorista     Motorista @relation(fields: [motoristaId], references: [id])
  
  placa         String   @unique
  marca         String
  modelo        String
  ano           Int
  cor           String
  capacidade    Int
  
  // Características
  arCondicionado Boolean @default(false)
  cameras        Boolean @default(false)
  gps            Boolean @default(false)
  
  // Fotos
  fotos         VeiculoFoto[]
  
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
}

model VeiculoFoto {
  id         BigInt   @id @default(autoincrement())
  veiculoId  BigInt
  veiculo    Veiculo  @relation(fields: [veiculoId], references: [id])
  
  tipo       String   // frente, lateral, interior, adesivo
  url        String
  ordem      Int
  
  createdAt  DateTime @default(now())
}

model DadosBancarios {
  id           BigInt   @id @default(autoincrement())
  motoristaId  BigInt   @unique
  motorista    Motorista @relation(fields: [motoristaId], references: [id])
  
  tipoConta    String   // PF ou PJ
  banco        String
  agencia      String
  conta        String
  digito       String
  chavePix     String?
  tipoChavePix String?  // cpf, cnpj, email, telefone, aleatoria
  
  createdAt    DateTime @default(now())
  updatedAt    DateTime @updatedAt
}

model MotoristaEscola {
  motoristaId BigInt
  motorista   Motorista @relation(fields: [motoristaId], references: [id])
  escolaId    BigInt
  escola      Escola    @relation(fields: [escolaId], references: [id])
  
  @@id([motoristaId, escolaId])
}

model MotoristaRegiao {
  id          BigInt   @id @default(autoincrement())
  motoristaId BigInt
  motorista   Motorista @relation(fields: [motoristaId], references: [id])
  
  cidade      String
  estado      String
  bairros     String[] // lista de bairros
  
  // Geometria para queries espaciais
  centroLat   Float
  centroLng   Float
  raioKm      Float
  
  @@index([motoristaId])
}

// ============================================
// ESCOLA E ENDEREÇO
// ============================================

model Escola {
  id         BigInt   @id @default(autoincrement())
  
  nome       String
  tipo       String   // publica, particular
  
  // Endereço
  addressId  BigInt
  address    Address  @relation(fields: [addressId], references: [id])
  
  // Contato
  telefone   String?
  email      String?
  
  // Relations
  filhos     Filho[]
  motoristas MotoristaEscola[]
  solicitacoes Solicitacao[]
  
  createdAt  DateTime @default(now())
  updatedAt  DateTime @updatedAt
  
  @@index([nome])
}

model Address {
  id          BigInt   @id @default(autoincrement())
  
  cep         String
  logradouro  String
  numero      String
  complemento String?
  bairro      String
  cidade      String
  estado      String
  
  // Coordenadas
  lat         Float
  lng         Float
  
  // Relations
  responsaveis Responsavel[]
  filhos       Filho[]
  escolas      Escola[]
  
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  
  @@index([lat, lng])
  @@index([cidade, bairro])
}

// ============================================
// MARKETPLACE - SOLICITAÇÕES E OFERTAS
// ============================================

enum SolicitacaoStatus {
  ATIVA
  PAUSADA
  MATCH       // Oferta aceita
  EXPIRADA
  CANCELADA
}

model Solicitacao {
  id              BigInt            @id @default(autoincrement())
  responsavelId   BigInt
  responsavel     Responsavel       @relation(fields: [responsavelId], references: [id])
  
  status          SolicitacaoStatus @default(ATIVA)
  
  // Escola destino
  escolaId        BigInt
  escola          Escola            @relation(fields: [escolaId], references: [id])
  
  // Endereço de embarque
  embarqueAddressId BigInt
  embarqueAddress   Address         @relation(fields: [embarqueAddressId], references: [id])
  
  // Configuração
  turno           Turno
  horarioEntrada  String?           // "07:30"
  horarioSaida    String?           // "12:00"
  dataInicioDesejada DateTime?
  
  // Orçamento
  orcamentoMaximo Float?
  
  // Observações
  observacoes     String?
  
  // Filhos incluídos
  filhos          SolicitacaoFilho[]
  
  // Ofertas recebidas
  ofertas         Oferta[]
  
  // Se fechou
  ofertaAceitaId  BigInt?           @unique
  ofertaAceita    Oferta?           @relation("OfertaAceita", fields: [ofertaAceitaId], references: [id])
  
  // Timestamps
  expiraEm        DateTime
  createdAt       DateTime          @default(now())
  updatedAt       DateTime          @updatedAt
  
  @@index([status])
  @@index([escolaId])
  @@index([expiraEm])
}

model SolicitacaoFilho {
  solicitacaoId BigInt
  solicitacao   Solicitacao @relation(fields: [solicitacaoId], references: [id])
  filhoId       BigInt
  filho         Filho       @relation(fields: [filhoId], references: [id])
  
  @@id([solicitacaoId, filhoId])
}

enum OfertaStatus {
  PENDENTE
  VISUALIZADA
  ACEITA
  RECUSADA
  EXPIRADA
  CANCELADA
}

model Oferta {
  id              BigInt       @id @default(autoincrement())
  solicitacaoId   BigInt
  solicitacao     Solicitacao  @relation(fields: [solicitacaoId], references: [id])
  motoristaId     BigInt
  motorista       Motorista    @relation(fields: [motoristaId], references: [id])
  
  status          OfertaStatus @default(PENDENTE)
  
  // Proposta
  valorMensal     Float
  dataInicioDisponivel DateTime
  mensagem        String?
  
  // Histórico de edições
  edicoes         OfertaEdicao[]
  
  // Se aceita, gera contrato
  solicitacaoAceita Solicitacao? @relation("OfertaAceita")
  contrato        Contrato?
  
  // Timestamps
  visualizadaEm   DateTime?
  respondidaEm    DateTime?
  createdAt       DateTime     @default(now())
  updatedAt       DateTime     @updatedAt
  
  @@unique([solicitacaoId, motoristaId])
  @@index([motoristaId, status])
}

model OfertaEdicao {
  id           BigInt   @id @default(autoincrement())
  ofertaId     BigInt
  oferta       Oferta   @relation(fields: [ofertaId], references: [id])
  
  valorAnterior Float
  valorNovo     Float
  motivo        String?
  
  createdAt    DateTime @default(now())
}

// ============================================
// CONTRATO
// ============================================

enum ContratoStatus {
  AGUARDANDO_CONFIRMACAO
  AGUARDANDO_PAGAMENTO
  PERIODO_TESTE
  ATIVO
  SUSPENSO
  CANCELADO
  ENCERRADO
}

model Contrato {
  id              BigInt          @id @default(autoincrement())
  
  // Partes
  responsavelId   BigInt
  responsavel     Responsavel     @relation(fields: [responsavelId], references: [id])
  motoristaId     BigInt
  motorista       Motorista       @relation(fields: [motoristaId], references: [id])
  
  // Origem
  ofertaId        BigInt          @unique
  oferta          Oferta          @relation(fields: [ofertaId], references: [id])
  
  status          ContratoStatus  @default(AGUARDANDO_CONFIRMACAO)
  
  // Termos
  valorMensal     Float
  diaVencimento   Int
  dataInicio      DateTime
  fimPeriodoTeste DateTime        // 7 dias após início
  
  // Documento
  documentoPdfUrl String?
  
  // Filhos no contrato
  filhos          ContratoFilho[]
  
  // Pagamentos
  pagamentos      Pagamento[]
  
  // Cancelamento
  motivoCancelamento String?
  canceladoPor       String?
  
  // Timestamps
  confirmadoEm    DateTime?
  ativadoEm       DateTime?
  suspendidoEm    DateTime?
  encerradoEm     DateTime?
  createdAt       DateTime        @default(now())
  updatedAt       DateTime        @updatedAt
  
  @@index([responsavelId, status])
  @@index([motoristaId, status])
}

model ContratoFilho {
  contratoId BigInt
  contrato   Contrato @relation(fields: [contratoId], references: [id])
  filhoId    BigInt
  filho      Filho    @relation(fields: [filhoId], references: [id])
  
  @@id([contratoId, filhoId])
}

// ============================================
// PAGAMENTOS
// ============================================

enum PagamentoStatus {
  PENDENTE
  PROCESSANDO
  CONFIRMADO
  FALHOU
  REEMBOLSADO
  ESTORNADO
}

enum MetodoPagamento {
  PIX
  CARTAO_CREDITO
  BOLETO
}

model Pagamento {
  id              BigInt           @id @default(autoincrement())
  contratoId      BigInt
  contrato        Contrato         @relation(fields: [contratoId], references: [id])
  responsavelId   BigInt
  responsavel     Responsavel      @relation(fields: [responsavelId], references: [id])
  
  // Referência
  mesReferencia   String           // "2026-02"
  vencimento      DateTime
  
  // Valores
  valorBruto      Float
  taxaPlataforma  Float
  multa           Float            @default(0)
  juros           Float            @default(0)
  valorTotal      Float
  
  // Método
  metodo          MetodoPagamento
  
  // Status
  status          PagamentoStatus  @default(PENDENTE)
  
  // Gateway (Asaas)
  gatewayId       String?
  gatewayResponse Json?
  pixQrCode       String?
  pixCopiaECola   String?
  boletoUrl       String?
  boletoBarcode   String?
  
  // Repasse
  recebimento     Recebimento?
  
  // Timestamps
  pagoEm          DateTime?
  createdAt       DateTime         @default(now())
  updatedAt       DateTime         @updatedAt
  
  @@index([contratoId])
  @@index([status])
  @@index([vencimento])
}

enum RecebimentoStatus {
  PENDENTE
  AGENDADO
  REALIZADO
  FALHOU
}

model Recebimento {
  id              BigInt            @id @default(autoincrement())
  pagamentoId     BigInt            @unique
  pagamento       Pagamento         @relation(fields: [pagamentoId], references: [id])
  motoristaId     BigInt
  motorista       Motorista         @relation(fields: [motoristaId], references: [id])
  
  // Valores
  valorBruto      Float
  taxaPlataforma  Float
  valorLiquido    Float
  
  // Status
  status          RecebimentoStatus @default(PENDENTE)
  
  // Transferência
  dataAgendada    DateTime?
  transferenciaId String?
  
  // Timestamps
  realizadoEm     DateTime?
  createdAt       DateTime          @default(now())
  updatedAt       DateTime          @updatedAt
  
  @@index([motoristaId, status])
  @@index([dataAgendada])
}

// ============================================
// ROTA E RASTREAMENTO
// ============================================

enum RotaStatus {
  AGENDADA
  EM_ANDAMENTO
  FINALIZADA
  CANCELADA
}

model Rota {
  id           BigInt     @id @default(autoincrement())
  motoristaId  BigInt
  motorista    Motorista  @relation(fields: [motoristaId], references: [id])
  
  data         DateTime   @db.Date
  turno        Turno
  status       RotaStatus @default(AGENDADA)
  
  // Tracking
  iniciadaEm   DateTime?
  finalizadaEm DateTime?
  
  // Pontos da rota
  pontos       RotaPonto[]
  
  // Posições GPS
  posicoes     RotaPosicao[]
  
  // Presenças
  presencas    Presenca[]
  
  createdAt    DateTime   @default(now())
  updatedAt    DateTime   @updatedAt
  
  @@unique([motoristaId, data, turno])
  @@index([data, status])
}

model RotaPonto {
  id         BigInt   @id @default(autoincrement())
  rotaId     BigInt
  rota       Rota     @relation(fields: [rotaId], references: [id])
  
  ordem      Int
  tipo       String   // embarque, desembarque, escola
  addressId  String
  
  // Previsão
  previsaoChegada DateTime?
  
  // Realizado
  chegadaEm  DateTime?
  
  @@index([rotaId, ordem])
}

model RotaPosicao {
  id        BigInt   @id @default(autoincrement())
  rotaId    BigInt
  rota      Rota     @relation(fields: [rotaId], references: [id])
  
  lat       Float
  lng       Float
  velocidade Float?
  bearing    Float?
  accuracy   Float?
  
  timestamp DateTime
  
  @@index([rotaId, timestamp])
}

model Presenca {
  id       BigInt   @id @default(autoincrement())
  rotaId   BigInt
  rota     Rota     @relation(fields: [rotaId], references: [id])
  filhoId  BigInt
  filho    Filho    @relation(fields: [filhoId], references: [id])
  
  status   PresencaStatus
  
  // Registro
  embarqueEm    DateTime?
  desembarqueEm DateTime?
  
  observacao    String?
  
  createdAt DateTime @default(now())
  
  @@unique([rotaId, filhoId])
}

enum PresencaStatus {
  AGUARDANDO
  EMBARCOU
  DESEMBARCOU
  AUSENTE
  AUSENTE_AVISADO
}

// ============================================
// CHAT
// ============================================

model Chat {
  id           BigInt            @id @default(autoincrement())
  
  // Contexto
  tipo         ChatTipo
  solicitacaoId BigInt?
  contratoId    BigInt?
  
  participants ChatParticipant[]
  messages     Message[]
  
  createdAt    DateTime          @default(now())
  updatedAt    DateTime          @updatedAt
}

enum ChatTipo {
  NEGOCIACAO     // Durante oferta
  CONTRATO       // Após contratação
  SUPORTE        // Com admin
}

model ChatParticipant {
  chatId        BigInt
  chat          Chat         @relation(fields: [chatId], references: [id])
  
  responsavelId BigInt?
  responsavel   Responsavel? @relation(fields: [responsavelId], references: [id])
  motoristaId   BigInt?
  motorista     Motorista?   @relation(fields: [motoristaId], references: [id])
  adminId       BigInt?
  admin         Admin?       @relation(fields: [adminId], references: [id])
  
  lastReadAt    DateTime?
  
  @@id([chatId, responsavelId, motoristaId, adminId])
}

model Message {
  id         BigInt   @id @default(autoincrement())
  chatId     BigInt
  chat       Chat     @relation(fields: [chatId], references: [id])
  
  senderId   BigInt
  senderType UserType
  
  content    String
  tipo       MessageTipo @default(TEXT)
  mediaUrl   String?
  
  // Status
  readAt     DateTime?
  
  createdAt  DateTime @default(now())
  
  @@index([chatId, createdAt])
}

enum MessageTipo {
  TEXT
  IMAGE
  LOCATION
  SYSTEM
}

// ============================================
// AVALIAÇÃO
// ============================================

model Avaliacao {
  id              BigInt   @id @default(autoincrement())
  
  // Quem avalia
  responsavelId   BigInt
  responsavel     Responsavel @relation("AvaliacoesDadas", fields: [responsavelId], references: [id])
  
  // Quem é avaliado
  motoristaId     BigInt
  motorista       Motorista   @relation("AvaliacoesRecebidas", fields: [motoristaId], references: [id])
  
  // Contexto
  contratoId      BigInt
  periodo         String      // "2026-02"
  
  // Notas
  notaGeral       Int         // 1-5
  pontualidade    Int?
  comunicacao     Int?
  cuidadoCriancas Int?
  condicaoVeiculo Int?
  
  comentario      String?
  anonimo         Boolean     @default(false)
  
  // Moderação
  status          AvaliacaoStatus @default(PENDENTE)
  moderadoPor     String?
  motivoRejeicao  String?
  
  createdAt       DateTime    @default(now())
  updatedAt       DateTime    @updatedAt
  
  @@unique([responsavelId, motoristaId, periodo])
  @@index([motoristaId, status])
}

enum AvaliacaoStatus {
  PENDENTE
  APROVADA
  REJEITADA
}

// ============================================
// NOTIFICAÇÕES
// ============================================

model Notification {
  id         BigInt   @id @default(autoincrement())
  userId     BigInt
  user       User     @relation(fields: [userId], references: [id])
  
  tipo       String
  titulo     String
  corpo      String
  data       Json?
  
  lida       Boolean  @default(false)
  lidaEm     DateTime?
  
  createdAt  DateTime @default(now())
  
  @@index([userId, lida, createdAt])
}

// ============================================
// ADMIN
// ============================================

model Admin {
  id       BigInt   @id @default(autoincrement())
  userId   BigInt   @unique
  user     User     @relation(fields: [userId], references: [id])
  
  role     AdminRole
  
  chats    ChatParticipant[]
  
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

enum AdminRole {
  SUPER_ADMIN
  ADMIN
  FINANCEIRO
  SUPORTE
  VISUALIZADOR
}

// ============================================
// CONFIGURAÇÕES E LOGS
// ============================================

model Config {
  id     String @id
  valor  String
  tipo   String // string, number, boolean, json
  
  updatedAt DateTime @updatedAt
}

model AuditLog {
  id         BigInt   @id @default(autoincrement())
  
  userId     BigInt
  userType   UserType
  action     String
  entity     String
  entityId   String
  oldValue   Json?
  newValue   Json?
  ip         String?
  userAgent  String?
  
  createdAt  DateTime @default(now())
  
  @@index([entity, entityId])
  @@index([userId, createdAt])
}
```

---

## 4. API Endpoints

### 4.1 Autenticação

```yaml
POST /auth/register:
  body: { type, name, email, phone, password, cpf }
  response: { user, tokens }

POST /auth/login:
  body: { email, password } | { phone, password }
  response: { user, tokens }

POST /auth/verify-phone:
  body: { phone, code }
  response: { success }

POST /auth/refresh:
  body: { refreshToken }
  response: { accessToken, refreshToken }

POST /auth/forgot-password:
  body: { email }
  response: { success }

POST /auth/reset-password:
  body: { token, password }
  response: { success }
```

### 4.2 Responsável (Pais)

```yaml
# Perfil
GET    /responsavel/me
PUT    /responsavel/me
PUT    /responsavel/me/address

# Filhos
GET    /responsavel/filhos
POST   /responsavel/filhos
GET    /responsavel/filhos/:id
PUT    /responsavel/filhos/:id
DELETE /responsavel/filhos/:id

# Solicitações
GET    /responsavel/solicitacoes
POST   /responsavel/solicitacoes
GET    /responsavel/solicitacoes/:id
PUT    /responsavel/solicitacoes/:id
DELETE /responsavel/solicitacoes/:id
POST   /responsavel/solicitacoes/:id/pausar
POST   /responsavel/solicitacoes/:id/reativar

# Ofertas
GET    /responsavel/solicitacoes/:id/ofertas
GET    /responsavel/ofertas/:id
POST   /responsavel/ofertas/:id/aceitar
POST   /responsavel/ofertas/:id/recusar

# Contratos
GET    /responsavel/contratos
GET    /responsavel/contratos/:id
POST   /responsavel/contratos/:id/cancelar

# Pagamentos
GET    /responsavel/pagamentos
GET    /responsavel/pagamentos/:id
POST   /responsavel/pagamentos/:id/pagar
GET    /responsavel/pagamentos/:id/pix
GET    /responsavel/pagamentos/:id/boleto

# Rastreamento
GET    /responsavel/rastreamento/:contratoId

# Avaliações
POST   /responsavel/avaliacoes
GET    /responsavel/avaliacoes
```

### 4.3 Motorista

```yaml
# Perfil e Cadastro
GET    /motorista/me
PUT    /motorista/me
GET    /motorista/cadastro/status
POST   /motorista/cadastro/documentos
POST   /motorista/cadastro/veiculo
POST   /motorista/cadastro/dados-bancarios
POST   /motorista/cadastro/regioes
POST   /motorista/cadastro/escolas
POST   /motorista/cadastro/enviar-aprovacao

# Solicitações
GET    /motorista/solicitacoes
GET    /motorista/solicitacoes/:id

# Ofertas
GET    /motorista/ofertas
POST   /motorista/ofertas
GET    /motorista/ofertas/:id
PUT    /motorista/ofertas/:id
DELETE /motorista/ofertas/:id

# Alunos
GET    /motorista/alunos
GET    /motorista/alunos/:id

# Contratos
GET    /motorista/contratos
GET    /motorista/contratos/:id
POST   /motorista/contratos/:id/confirmar

# Rotas
GET    /motorista/rotas
POST   /motorista/rotas
GET    /motorista/rotas/:id
POST   /motorista/rotas/:id/iniciar
POST   /motorista/rotas/:id/finalizar
POST   /motorista/rotas/:id/posicao
POST   /motorista/rotas/:id/presenca/:filhoId

# Financeiro
GET    /motorista/financeiro/resumo
GET    /motorista/financeiro/recebimentos
GET    /motorista/financeiro/recebimentos/:id

# Avaliações
GET    /motorista/avaliacoes
```

### 4.4 Chat

```yaml
GET    /chats
GET    /chats/:id
GET    /chats/:id/messages
POST   /chats/:id/messages
POST   /chats/:id/read
```

### 4.5 Comum

```yaml
# Escolas
GET    /escolas
GET    /escolas/:id
POST   /escolas

# Endereços
GET    /address/cep/:cep
POST   /address/geocode

# Notificações
GET    /notifications
PUT    /notifications/:id/read
PUT    /notifications/read-all

# Upload
POST   /upload
```

### 4.6 Admin

```yaml
# Dashboard
GET    /admin/dashboard

# Motoristas
GET    /admin/motoristas
GET    /admin/motoristas/:id
PUT    /admin/motoristas/:id
POST   /admin/motoristas/:id/aprovar
POST   /admin/motoristas/:id/reprovar
POST   /admin/motoristas/:id/suspender
POST   /admin/motoristas/:id/reativar

# Responsáveis
GET    /admin/responsaveis
GET    /admin/responsaveis/:id

# Solicitações
GET    /admin/solicitacoes
GET    /admin/solicitacoes/:id

# Contratos
GET    /admin/contratos
GET    /admin/contratos/:id
PUT    /admin/contratos/:id

# Financeiro
GET    /admin/financeiro/resumo
GET    /admin/financeiro/transacoes
GET    /admin/financeiro/repasses
POST   /admin/financeiro/repasses/:id/executar

# Moderação
GET    /admin/moderacao/denuncias
GET    /admin/moderacao/avaliacoes
PUT    /admin/moderacao/denuncias/:id
PUT    /admin/moderacao/avaliacoes/:id

# Configurações
GET    /admin/config
PUT    /admin/config

# Relatórios
GET    /admin/relatorios/:tipo
```

---

## 5. WebSocket Events

### 5.1 Eventos do Responsável

```typescript
// Recebidos pelo app
interface ResponsavelEvents {
  'oferta:nova': { solicitacaoId, oferta };
  'oferta:atualizada': { ofertaId, oferta };
  'contrato:atualizado': { contratoId, status };
  'pagamento:confirmado': { pagamentoId };
  'rastreamento:posicao': { contratoId, lat, lng, eta };
  'rastreamento:status': { contratoId, filhoId, status };
  'mensagem:nova': { chatId, message };
}
```

### 5.2 Eventos do Motorista

```typescript
// Recebidos pelo app
interface MotoristaEvents {
  'solicitacao:nova': { solicitacao };
  'oferta:visualizada': { ofertaId };
  'oferta:aceita': { ofertaId, contrato };
  'oferta:recusada': { ofertaId };
  'pagamento:recebido': { recebimentoId, valor };
  'mensagem:nova': { chatId, message };
}
```

---

## 6. Integrações

### 6.1 Asaas (Pagamentos)

```yaml
Funcionalidades:
  - Criar cliente
  - Criar cobrança (PIX, boleto, cartão)
  - Cobrança recorrente
  - Webhook de pagamento
  - Split de pagamento
  - Transferência para motorista

Endpoints:
  - POST /customers
  - POST /payments
  - POST /subscriptions
  - POST /transfers
  
Webhooks:
  - PAYMENT_RECEIVED
  - PAYMENT_OVERDUE
  - PAYMENT_REFUNDED
```

### 6.2 Firebase (Notificações)

```yaml
Funcionalidades:
  - Push notifications (iOS/Android)
  - Topics por tipo de usuário
  - Data messages

Implementação:
  - Firebase Admin SDK
  - Expo Notifications
```

### 6.3 Google Maps

```yaml
Funcionalidades:
  - Geocoding (endereço → coordenadas)
  - Reverse geocoding
  - Distance Matrix
  - Directions API
  - Places Autocomplete
```

### 6.4 SMS (Twilio/Zenvia)

```yaml
Funcionalidades:
  - Verificação de telefone (OTP)
  - Notificações críticas
```

---

## 7. Infraestrutura

### 7.1 Produção

```yaml
Cloud Provider: AWS / Vercel / Railway

Serviços:
  App Mobile:
    - Expo EAS Build
    - App Store / Play Store
    
  Web Backoffice:
    - Vercel (Next.js)
    
  API:
    - AWS ECS / Railway
    - Auto-scaling
    
  Database:
    - AWS RDS PostgreSQL
    - Read replicas
    
  Cache:
    - AWS ElastiCache Redis
    
  Storage:
    - AWS S3 / Cloudflare R2
    - CloudFront CDN
    
  Monitoring:
    - Sentry (errors)
    - Datadog / Grafana (metrics)
    - LogRocket (sessions)
```

### 7.2 CI/CD

```yaml
Pipeline:
  - GitHub Actions
  - Lint + Type check
  - Testes unitários
  - Testes E2E
  - Build
  - Deploy staging
  - Deploy production
```

---

## 8. Segurança

### 8.1 Autenticação

- JWT com refresh token
- Expiração: access 15min, refresh 7 dias
- Blacklist de tokens revogados
- Rate limiting por IP/user

### 8.2 Dados Sensíveis

- Senhas com bcrypt (cost 12)
- Dados PII criptografados
- HTTPS obrigatório
- Sanitização de inputs

### 8.3 LGPD

- Consentimento explícito
- Exportação de dados
- Exclusão de conta
- Política de privacidade

---

## 9. Estimativas de Desenvolvimento

### 9.1 Por Módulo

| Módulo | Sprints (2 sem) | Pontos |
|--------|-----------------|--------|
| Infraestrutura/Setup | 1 | 30 |
| Auth + Onboarding | 1.5 | 45 |
| App Pais (core) | 2 | 60 |
| App Motorista (core) | 2.5 | 75 |
| Marketplace/Match | 2 | 60 |
| Pagamentos | 1.5 | 45 |
| Rastreamento | 1 | 30 |
| Chat | 1 | 30 |
| Web Backoffice | 2 | 60 |
| Integrações | 1 | 30 |
| Testes/QA | 1.5 | 45 |
| **Total** | **17** | **510** |

### 9.2 Roadmap

```
Fase 1 - MVP (4 meses):
  - Auth + Onboarding
  - Solicitações e Ofertas
  - Contratação básica
  - Pagamento PIX
  - Chat

Fase 2 - Core (2 meses):
  - Rastreamento GPS
  - Pagamentos recorrentes
  - Avaliações
  - Notificações completas

Fase 3 - Scale (2 meses):
  - Web Backoffice completo
  - Relatórios
  - Otimizações
  - Multi-região
```
