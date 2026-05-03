# Regras de Backend — Módulo ViVan

## Arquitetura (dashboard-tresco)

| Camada | Arquivo | Responsabilidade |
|--------|---------|-----------------|
| Routes | `src/routes/vivan.ts` | Definição de rotas + middleware RBAC |
| Controller | `src/controllers/vivan.controller.ts` | Parsing de request, delegação ao service, response |
| Service | `src/services/vivan.service.ts` | Lógica de negócio + queries SQL |

## Base URL da API

```
https://app.coopertransmig.com.br/api/vivan
```

## Autenticação

Cookie-based (não Bearer token). O cliente Flutter faz login em `POST /auth/login`,
recebe cookie `access_token`, e todas as requisições subsequentes enviam esse cookie.
O `idMotorista` é extraído do token no backend — não enviar `idMotorista` via header.

> O `idMotorista` SÍ deve ser enviado como query param em GETs e body em POSTs
> quando o endpoint exige filtragem explícita (ex: `GET /contratos?motorista=:id`).

## Endpoints Disponíveis

### Passageiros
| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/passageiros` | Listar (filtros: busca, status, turno, escola, motorista) |
| POST | `/passageiros` | Criar passageiro |
| PUT | `/passageiros/:id` | Atualizar passageiro |
| DELETE | `/passageiros/:id` | Excluir (soft delete) |
| GET | `/passageiros/:id/responsaveis` | Listar responsáveis |
| POST | `/passageiros/:id/responsaveis` | Criar responsável |
| PUT | `/passageiros/:id/responsaveis/:idResp` | Atualizar responsável |
| DELETE | `/passageiros/:id/responsaveis/:idResp` | Excluir responsável |

**Campos importantes no POST/PUT de passageiro:**

| Campo | Tipo | Observação |
|-------|------|-----------|
| `nomePassageiro` | string | obrigatório |
| `domTurno` | string | turno: `'Manhã'`, `'Tarde'`, `'Integral'`, `'Noite'` |
| `idEscola` | int | **usar `idEscola`, não `nomeEscola`** no PUT |
| ~~`domSexo`~~ | — | campo não existe, não enviar |

### Contratos
| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/contratos` | Listar contratos |
| POST | `/contratos` | Criar contrato (sempre RASCUNHO) |
| GET | `/contratos/:id` | Buscar por ID |
| PUT | `/contratos/:id` | Atualizar (só RASCUNHO) |
| DELETE | `/contratos/:id` | Excluir (só RASCUNHO) |
| POST | `/contratos/:id/enviar-assinatura` | Transição → PENDENTE_ASSINATURA |
| POST | `/contratos/:id/ativar` | Transição → ATIVO + gera mensalidades |
| POST | `/contratos/:id/suspender` | Transição → SUSPENSO (body: `{ motivo }`) |
| POST | `/contratos/:id/cancelar` | Transição → CANCELADO (body: `{ motivo }`) |
| POST | `/contratos/:id/reativar` | SUSPENSO → ATIVO |
| GET | `/contratos/:id/historico` | Histórico de alterações |
| POST | `/passageiros/:id/contratos` | **Criar + ativar + gerar mensalidades (atômico)** |

**⚠️ Bug conhecido:** `GET /contratos?passageiro=:id` não filtra — retorna todos os
contratos do motorista. Filtrar client-side por `c.idPassageiro == passageiroId`.

**Campos obrigatórios/recomendados ao criar contrato:**

```json
{
  "idMotorista": 1,
  "idPassageiro": 42,
  "idResponsavel": 7,
  "valMensal": 350.00,
  "diaVencimento": 5,
  "dtInicio": "2026-01-01",
  "dtTermino": "2026-12-31",
  "domFormaPagamento": "OUTROS",
  "domCondicaoPagamento": "Mensal",
  "percentualMulta": 2.0,
  "percentualJurosDia": 0.0333,
  "status": "RASCUNHO"
}
```

### Mensalidades
| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/mensalidades` | Listar (filtros: motorista, mesReferencia, status, passageiro) |
| POST | `/mensalidades` | Criar mensalidade avulsa |
| POST | `/mensalidades/:id/pagamento-manual` | Registrar pagamento |
| POST | `/mensalidades/:id/abonar` | Abonar mensalidade |
| POST | `/mensalidades/:id/cancelar-abono` | Cancelar abono |

**Campos obrigatórios em `POST /mensalidades/:id/pagamento-manual`:**
```json
{
  "valPago": 350.00,
  "formaPagamento": "PIX",
  "dtPagamento": "2026-05-02"
}
```
> `valorPago` (errado) → `valPago` (correto). `dtPagamento` é obrigatório.

### Despesas
| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/despesas` | Listar despesas |
| POST | `/despesas` | Criar despesa/entrada |
| PUT | `/despesas/:id` | Atualizar |
| DELETE | `/despesas/:id` | Excluir (hard delete) |

### Presença
| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/presencas` | Listar presenças |
| POST | `/presencas` | Lançar presença individual |
| POST | `/presencas/lote` | Lançar presença em lote |

### Dashboard
| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/dashboard/resumo` | Resumo financeiro do mês |
| GET | `/dashboard/capacidade` | Ocupação por veículo/turno |

### Escolas
| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/escolas` | Listar escolas do motorista |
| POST | `/escolas` | Criar escola |

---

## Formato de `mesReferencia`

**Formato correto em toda a API: `MM/yyyy`** (ex: `"05/2026"`)

Usado em:
- `GET /mensalidades?mesReferencia=05/2026`
- `GET /despesas?mesReferencia=05/2026`
- Campo `mesReferencia` em `POST /mensalidades`

> ⚠️ O formato `yyyy-MM` (ex: `"2026-05"`) **não funciona** — a API ignora e retorna
> 0 resultados. Isso já causou todas as telas financeiras mostrarem R$ 0,00.

---

## Fluxo de Transição de Status — Contratos

```
RASCUNHO → PENDENTE_ASSINATURA → ATIVO → VENCENDO → VENCIDO
                                    ↓                    ↓
                                 SUSPENSO            RENOVADO
                                    ↓
                                CANCELADO
```

### Campos setados automaticamente por transição:

| Novo Status | Campos Atualizados |
|-------------|-------------------|
| `PENDENTE_ASSINATURA` | `"dtEnvioAssinatura"` = NOW() |
| `ATIVO` | `"dtAtivacao"` = NOW() + **gera mensalidades** |
| `SUSPENSO` | `"dtSuspensao"` = NOW(), `"motivoSuspensao"` |
| `CANCELADO` | `"dtCancelamento"` = NOW(), `"motivoCancelamento"` |

---

## Geração de Mensalidades

Ao ativar um contrato (`POST /contratos/:id/ativar`):
1. Calcula meses entre `dtInicio` e `dtTermino`
2. Para cada mês cria registro com:
   - `"mesReferencia"` no formato `"MM/yyyy"` (ex: `"05/2026"`)
   - `"dtVencimento"` = primeiro dia do mês com `diaVencimento`
   - `"valOriginal"` = `valMensal` do contrato
   - `"status"` = `'AGUARDANDO'`

> Se o contrato for cancelado, as mensalidades associadas são **excluídas** do banco.
> Cuidado ao cancelar contratos em ambiente de teste.

---

## Bugs Conhecidos

### `numContrato` — conflito 409
O backend usa `MAX(numContrato)+1` para gerar o número do contrato (não é uma
sequence atômica). Em criações rápidas consecutivas pode ocorrer conflito 409.
**Solução de backend:** usar `SEQUENCE` do PostgreSQL. Sem solução no frontend.

### Filtro `?passageiro=` em `/contratos` não filtra
`GET /contratos?motorista=X&passageiro=Y` retorna todos os contratos do motorista.
**Workaround frontend:** filtrar client-side após receber a lista.

---

## Despesas — Tipos de Lançamento

| Campo | Valores | Default |
|-------|---------|---------|
| `"tipoLancamento"` | `'DESPESA'`, `'ENTRADA'` | `'DESPESA'` |
| `recorrente` | `true`, `false` | `false` |
| `"diaVencimento"` | 1-31 ou NULL | NULL |
| `"mesInicial"` | `'MM/yyyy'` ou NULL | NULL |
| `"mesFinal"` | `'MM/yyyy'` ou NULL | NULL |

---

## Presença — Upsert

Lançar presença usa ON CONFLICT para upsert:
- Chave: `("idPassageiro", "dtPresenca", "domTurno")`
- Se já existe: atualiza `"tipoPresenca"`, `"justificativa"`, `"dtRegistro"`
