#  VanIA - Marketplace de Transporte Escolar

> ** Novo no projeto?** Comece pela [Visão Geral](./VISAO_GERAL.md) - documento acessível para analistas e gestores.

## Visão Geral

Plataforma que conecta pais/responsáveis a motoristas de transporte escolar, permitindo que pais publiquem suas necessidades de transporte e motoristas façam ofertas competitivas - modelo inspirado no inDrive.

---

## Plataformas

| Plataforma | Descrição | Tecnologia |
|------------|-----------|------------|
| **App Pais** | Aplicativo mobile para pais buscarem e contratarem transporte | React Native + Expo |
| **App Motorista** | Aplicativo mobile para motoristas encontrarem clientes | React Native + Expo |
| **Web Backoffice** | Painel administrativo da plataforma | Next.js 14 |

---

## Documentação

### Visão Geral
| Documento | Descrição |
|-----------|-----------|
| [Visão Geral da Aplicação](./VISAO_GERAL.md) |  **Comece aqui!** Documento para analistas e diretores |
| [PRD v2 - Marketplace](./PRD_V2_MARKETPLACE.md) | Visão do produto marketplace |
| [Requisitos Técnicos v2](./REQUISITOS_TECNICOS_V2.md) | Stack, Prisma schema, APIs |
| [Glossário](./GLOSSARIO.md) | Termos e definições do domínio |

### Épicos do Marketplace

| Épico | Descrição | User Stories | Pontos |
|-------|-----------|--------------|--------|
| [EP-APP-PAIS](./epicos/EP-APP-PAIS.md) | App para pais/responsáveis | 13 | 84 |
| [EP-APP-MOTORISTA](./epicos/EP-APP-MOTORISTA.md) | App para motoristas | 16 | 97 |
| [EP-MARKETPLACE](./epicos/EP-MARKETPLACE.md) | Core do marketplace e matching | 12 | 99 |
| [EP-BACKOFFICE](./epicos/EP-BACKOFFICE.md) | Painel administrativo web | 12 | 86 |

**Total: 53 User Stories | ~366 Story Points**

### Documentação Legada (Modelo Antigo)

<details>
<summary> Ver épicos do modelo antigo (referência)</summary>

| Documento | Descrição |
|-----------|-----------|
| [PRD Original](./PRD.md) | Visão original do produto |
| [Requisitos Técnicos v1](./REQUISITOS_TECNICOS.md) | Stack e arquitetura original |

| Épico | Descrição | User Stories |
|-------|-----------|--------------|
| [EP01 - Cadastros](./epicos/EP01_CADASTROS.md) | Cadastro de empresa, veículos, escolas, rotas | 8 |
| [EP02 - Contratos](./epicos/EP02_CONTRATOS.md) | Templates, PDF e assinatura digital | 9 |
| [EP03 - Carnê](./epicos/EP03_CARNE_COMUNICACAO.md) | Carnês e WhatsApp | 11 |
| [EP04 - Contas Receber](./epicos/EP04_CONTAS_RECEBER.md) | Mensalidades, PIX | 11 |
| [EP05 - NFS-e](./epicos/EP05_NFSE.md) | Notas fiscais | 10 |
| [EP06 - Contas Pagar](./epicos/EP06_CONTAS_PAGAR.md) | Despesas | 11 |
| [EP07 - DRE](./epicos/EP07_DRE_RESULTADO.md) | Relatórios | 10 |
| [EP08 - Integrações](./epicos/EP08_INTEGRACOES.md) | APIs externas | 11 |

</details>

---

## Fluxo do Marketplace

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│    PAI      │     │ MARKETPLACE │     │  MOTORISTA  │
│  publica    │────│   conecta   │────│   oferece   │
│ necessidade │     │  e facilita │     │   serviço   │
└─────────────┘     └─────────────┘     └─────────────┘

1. Pai publica solicitação (filho + escola + turno)
2. Motoristas compatíveis são notificados
3. Motoristas fazem ofertas com valores
4. Pai compara ofertas e perfis
5. Pai aceita a melhor oferta
6. Contrato é gerado automaticamente
7. Pagamento mensal recorrente
8. Rastreamento em tempo real
```

---

## Modelo de Negócio

- **Taxa da plataforma**: 5% sobre cada transação
- **Pagamento**: PIX, Cartão de Crédito, Boleto (via Asaas)
- **Repasse**: D+2 para motoristas
- **Período de teste**: 7 dias com reembolso integral

---

## Stack Tecnológica

```
Mobile Apps:        React Native + Expo + TypeScript
Web Backoffice:     Next.js 14 + Tailwind + shadcn/ui
API:                Node.js + NestJS/Fastify + Prisma
Database:           PostgreSQL
Cache:              Redis
Real-time:          Socket.io
Pagamentos:         Asaas
Maps:               Google Maps API
Push:               Firebase Cloud Messaging
```

---

## Roadmap

| Fase | Duração | Entregas |
|------|---------|----------|
| **MVP** | 4 meses | Auth, Solicitações, Ofertas, Contratação, PIX, Chat |
| **Core** | 2 meses | Rastreamento GPS, Pagamentos recorrentes, Avaliações |
| **Scale** | 2 meses | Backoffice completo, Relatórios, Multi-região |

---

## KPIs Principais

| Métrica | Meta MVP | Meta 12 meses |
|---------|----------|---------------|
| Motoristas ativos | 50 | 500 |
| Pais cadastrados | 200 | 3.000 |
| Contratos ativos | 150 | 2.000 |
| GMV mensal | R$ 50k | R$ 700k |
| Taxa de conversão | 30% | 45% |

---

## Convenções

- **US** = User Story (História de Usuário)
- **EP** = Épico
- **RN** = Regra de Negócio
- **CA** = Critério de Aceitação

---

**Versão:** 2.0.0  
**Modelo:** Marketplace (inDrive-style)  
**Data:** Fevereiro/2026  
**Status:** Em desenvolvimento
