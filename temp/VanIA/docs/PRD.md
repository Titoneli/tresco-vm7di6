# PRD — Sistema de Gestão para Transporte Escolar (VanIA)

## 1. Visão do Produto

Plataforma completa para transportadores escolares (PJ/cooperativa) gerirem toda a operação:

-  Cadastro de alunos/responsáveis
-  Contrato automático (PDF + assinatura opcional)
-  Carnê virtual e envio por WhatsApp/e-mail
-  Contas a receber (PIX, cartão recorrente, dinheiro)
-  Contas a pagar e controle de despesas
-  Emissão de NFS-e
-  Demonstração de Resultado (DRE simplificada)
-  Exportação fiscal/XML + relatórios
-  Integração com contabilidade

---

## 2. Objetivos (KPIs)

| Objetivo | Métrica | Meta |
|----------|---------|------|
| Reduzir inadimplência | Taxa de inadimplência | < 5% |
| Agilizar contratos | Tempo do fechamento ao contrato assinado | < 10 minutos |
| Organização fiscal | Exportações mensais realizadas | 100% |
| Conversão | Lead → Contrato → Cobrança | < 30 minutos |
| Controle financeiro | Despesas categorizadas | 100% |

---

## 3. Personas

### 3.1 Prestador/Transportador (Admin)

**Quem é:** Motorista autônomo, MEI ou empresa de transporte escolar

**Objetivos:**
- Cadastrar alunos e responsáveis
- Gerar contratos automaticamente
- Cobrar via PIX/cartão recorrente
- Emitir notas fiscais
- Controlar despesas e ver o lucro real
- Enviar dados para contabilidade

**Dores:**
- Planilhas manuais desorganizadas
- Esquece de cobrar ou emitir nota
- Não sabe o lucro real do mês
- Dificuldade com inadimplência

---

### 3.2 Responsável/Pai do Aluno

**Quem é:** Pai, mãe ou responsável legal do aluno transportado

**Objetivos:**
- Receber boletos/PIX pelo WhatsApp
- Acessar contrato e comprovantes
- Ter histórico de pagamentos
- Receber lembretes de vencimento

**Dores:**
- Boletos perdidos
- Não sabe quanto deve
- Dificuldade para pagar

---

### 3.3 Contador

**Quem é:** Profissional contábil que atende o transportador

**Objetivos:**
- Receber exportação fiscal mensal
- Ter acesso a comprovantes de despesas
- Conferir receitas e despesas
- Enviar guias de impostos de volta

**Dores:**
- Documentos desorganizados
- Informações incompletas
- Retrabalho manual

---

## 4. Escopo do MVP

### Incluído no MVP (V1)

| Módulo | Funcionalidades |
|--------|-----------------|
| **Cadastros** | Alunos, responsáveis, rotas, veículos, escolas |
| **Contratos** | Template, geração PDF, envio por e-mail |
| **Carnê** | Geração de parcelas, envio WhatsApp/e-mail |
| **Contas a Receber** | PIX (copia/cola), baixa manual, lembretes |
| **Contas a Pagar** | Cadastro de despesas, categorias, status |
| **NFS-e** | Emissão manual via integração |
| **Resultado** | DRE simplificada por período |
| **Exportação** | Excel/PDF para contabilidade |

### Futuro (V2+)

- Assinatura digital (Clicksign/DocuSign)
- PIX automático com webhook
- Cartão recorrente
- OCR para comprovantes
- App mobile nativo
- Multi-empresa

---

## 5. Requisitos Não-Funcionais

| Requisito | Especificação |
|-----------|---------------|
| **Disponibilidade** | 99.5% uptime |
| **Performance** | < 2s tempo de resposta |
| **Segurança** | LGPD compliant, dados criptografados |
| **Escalabilidade** | Suportar 10.000 alunos/empresa |
| **Mobile** | Responsivo (mobile-first) |
| **Backup** | Diário, retenção 30 dias |

---

## 6. Integrações

| Sistema | Propósito | Prioridade |
|---------|-----------|------------|
| WhatsApp Business API | Envio de cobranças e lembretes | Alta |
| E-mail (SMTP/SendGrid) | Contratos e notificações | Alta |
| Gateway de pagamento (Asaas/PagSeguro) | PIX e boleto | Alta |
| Prefeitura (NFS-e) | Emissão de nota fiscal | Média |
| Clicksign/DocuSign | Assinatura digital | Baixa (V2) |

---

## 7. Cronograma Macro

| Fase | Duração | Entregas |
|------|---------|----------|
| **Fase 1 - Foundation** | 4 semanas | Cadastros + Contratos |
| **Fase 2 - Financeiro** | 4 semanas | Carnê + Contas a Receber |
| **Fase 3 - Despesas** | 3 semanas | Contas a Pagar + DRE |
| **Fase 4 - Fiscal** | 3 semanas | NFS-e + Exportações |
| **Fase 5 - Integração** | 2 semanas | WhatsApp + Pagamentos |

---

## 8. Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| API WhatsApp indisponível | Média | Alto | Fallback para SMS/e-mail |
| Integração NFS-e complexa | Alta | Médio | Usar serviço agregador (NFE.io, Enotas) |
| Resistência do usuário | Média | Alto | Onboarding guiado, suporte dedicado |
| LGPD | Baixa | Alto | Termos de uso, consentimento explícito |

---

## 9. Métricas de Sucesso

### Métricas de Produto
- NPS > 50
- Retenção mensal > 90%
- Churn < 5%

### Métricas de Negócio
- 100 transportadores ativos em 6 meses
- R$ 50k MRR em 12 meses

---

**Aprovação:**

| Papel | Nome | Data |
|-------|------|------|
| Product Owner | | |
| Tech Lead | | |
| Stakeholder | | |
