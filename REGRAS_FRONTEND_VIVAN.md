# Regras de Frontend — Módulo ViVan (Flutter)

## Estrutura de Pastas

```
lib/
├── vivan/
│   ├── models/vivan_models.dart      # Todos os modelos tipados
│   ├── services/vivan_service.dart   # VivanLocator.service — camada tipada
│   ├── vivan_api_client.dart         # HTTP client com cookie auth
│   └── vivan.dart                    # Barrel export
│
├── via_van/                          # Telas e widgets do módulo
│   ├── passageiro_form_m/            # Wizard criação/edição passageiro
│   ├── passageiro_detalhe_m/         # Detalhe do passageiro
│   ├── contratos_lista_m/            # Lista de contratos
│   ├── gerar_contrato_m/             # Wizard de geração de contrato
│   ├── mensalidades_tab/             # Aba de mensalidades
│   ├── financeiro_tab/               # Aba financeira (despesas + mensalidades)
│   ├── renovar_mensalidades_m/       # Renovação de mensalidades
│   └── _vivan_http.dart              # Alias para VivanHttp
│
└── dashboard_passageiros_m/          # Dashboard principal do motorista
```

## Camadas e Acesso à API

### Dois clientes disponíveis

```dart
// 1. Serviço tipado (preferido para CRUD de entidades)
await VivanLocator.service.getPassageiro(id);
await VivanLocator.service.createContrato(c);
await VivanLocator.service.ativarContrato(id);

// 2. HTTP direto (para endpoints não cobertos pelo serviço)
await VivanHttp.post('/mensalidades', body);
await VivanHttp.get('/dashboard/resumo');
```

### Estado global do motorista logado
```dart
FFAppState().idUsuario    // int — ID do motorista
FFAppState().nomeUsuario  // String — nome do motorista
```

## Convenções de Código Dart

### Nomes
- **camelCase** para variáveis e funções: `nomePassageiro`, `fetchContratos()`
- **PascalCase** para classes e widgets: `PassageiroDetalheMWidget`
- **snake_case** para nomes de arquivos: `passageiro_detalhe_m_widget.dart`

### Padrão de tela customizada
```dart
class NomeMWidget extends StatefulWidget {
  const NomeMWidget({super.key, required this.passageiroId});
  final int passageiroId;

  @override
  State<NomeMWidget> createState() => _NomeMWidgetState();
}

class _NomeMWidgetState extends State<NomeMWidget> {
  // Getters de tema (evitar chamar FlutterFlowTheme muitas vezes no build)
  Color get _primary      => FlutterFlowTheme.of(context).primary;
  Color get _bg           => FlutterFlowTheme.of(context).primaryBackground;
  Color get _secondBg     => FlutterFlowTheme.of(context).secondaryBackground;
  Color get _primaryText  => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>(); // escuta mudanças globais
    // ...
  }
}
```

---

## Formato de Campos Críticos

### `mesReferencia` — SEMPRE `MM/yyyy`

**Correto:** `"05/2026"` | **Errado:** `"2026-05"`

```dart
// Em models com seleção de mês:
String get mesReferencia =>
    '${selectedMonth.toString().padLeft(2, '0')}/$selectedYear';

// Em loops de geração:
final mesRef = DateFormat('MM/yyyy').format(DateTime(ano, mes));
```

> ⚠️ Usar `yyyy-MM` faz a API retornar 0 resultados em todos os filtros de
> mensalidades e despesas. Já causou todas as telas financeiras mostrarem R$ 0,00.

### Campos do Passageiro — Mapeamento

| Campo no formulário | Campo na API | Tipo | Observação |
|---------------------|-------------|------|-----------|
| Turno / Período | `domTurno` | string | Não enviar `periodo` — a API ignora |
| Escola | `idEscola` | int | PUT exige `idEscola`, não `nomeEscola` |
| Sexo | ~~`domSexo`~~ | — | Campo não existe, não enviar |

**Como rastrear `idEscola` junto com o nome:**
```dart
final Map<String, int> _escolaIds = {};

void setEscolaNome(String? nome) {
  escolaNome = nome;
  escolaId = nome != null ? _escolaIds[nome] : null;
}
```

### Pagamento Manual — Campos obrigatórios
```dart
await VivanLocator.service.pagamentoManual(
  mensalidadeId,
  valorPago: 350.0,
  formaPagamento: 'PIX',
  dtPagamento: '2026-05-02',   // obrigatório — default: hoje
);
```
> `valPago` (correto) — não `valorPago`. `dtPagamento` é obrigatório.

---

## Fluxos de Contrato

### Wizard de passageiro (passageiro_form_m)
Usa `POST /passageiros/:id/contratos` — atômico, cria + ativa + gera mensalidades.
**Não chamar `/ativar` separado.**

### Tela "Gerar Contrato" (gerar_contrato_m)
```dart
// SEMPRE: criar + ativar em sequência
final criado = await VivanLocator.service.createContrato(c);
await VivanLocator.service.ativarContrato(criado.idContrato!);
```
Sem `/ativar`, o contrato fica RASCUNHO e as mensalidades nunca são geradas.

### Defaults obrigatórios ao montar VivanContrato
```dart
VivanContrato(
  idMotorista: FFAppState().idUsuario,
  idPassageiro: passageiroId,
  idResponsavel: responsavel?.idResponsavel,
  valMensal: valor,
  diaVencimento: diaVenc ?? 5,
  domFormaPagamento: 'OUTROS',
  domCondicaoPagamento: 'Mensal',
  percentualMulta: multa ?? 2.0,
  percentualJurosDia: jurosDia ?? 0.0333,
  dtInicio: '...',
  dtTermino: '...',
  status: 'RASCUNHO',
)
```

---

## Bugs Conhecidos da API

### Filtro `?passageiro=` em `/contratos` não funciona
A API ignora o parâmetro e retorna todos os contratos do motorista.
**Sempre filtrar client-side:**

```dart
contratos = result.data
    .where((c) => c.idPassageiro == passageiroId)
    .toList();
```

Aplicado em:
- `passageiro_detalhe_m_model.dart` → `fetchContratos()`
- `contratos_lista_m_model.dart` → `fetchContratos()`

---

## Status e Cores

### Status de Contratos
| Status | Cor | Significado |
|--------|-----|-------------|
| `RASCUNHO` | Cinza | Em elaboração — sem mensalidades |
| `PENDENTE_ASSINATURA` | Amarelo | Aguardando assinatura |
| `ATIVO` | Verde | Vigente — mensalidades geradas |
| `VENCENDO` | Laranja | Próximo do vencimento |
| `VENCIDO` | Vermelho | Expirado |
| `SUSPENSO` | Roxo | Temporariamente inativo |
| `CANCELADO` | Vermelho escuro | Cancelado — mensalidades excluídas |
| `RENOVADO` | Azul | Renovado (novo contrato gerado) |

### Status de Mensalidades
| Status | Cor | Significado |
|--------|-----|-------------|
| `AGUARDANDO` | Cinza | Ainda não venceu |
| `PENDENTE` | Amarelo | Vencida, aguardando pgto |
| `PAGO` | Verde | Pago em dia |
| `PAGO_ATRASO` | Verde claro | Pago com atraso |
| `ATRASADO` | Vermelho | Em atraso |
| `ABONADO` | Azul | Dispensado de pagamento |
| `ISENTO` | Azul claro | Isento |
| `CANCELADO` | Cinza escuro | Cancelado |

### Tipo de Presença
| Tipo | Cor | Label |
|------|-----|-------|
| `P` | Verde | Presente |
| `F` | Vermelho | Faltou |
| `J` | Amarelo | Justificado |

## Despesas — Tipos de Lançamento

| tipoLancamento | Cor | Label |
|----------------|-----|-------|
| `DESPESA` | Vermelho | Despesa |
| `ENTRADA` | Verde | Entrada |

### Campos de recorrência (quando `recorrente = true`):
- `diaVencimento`: dia do mês (1-31)
- `mesInicial`: formato `'MM/yyyy'`
- `mesFinal`: formato `'MM/yyyy'`

---

## Validações no Frontend

### Passageiro
- `nomePassageiro`: obrigatório, min 3 caracteres
- `endPassageiro`: obrigatório (pode ser string vazia `''`)

### Contrato
- `diaVencimento`: 1-28 (evitar 29-31 para meses curtos)
- `dtInicio` < `dtTermino`
- `valMensal` > 0

### Responsável
- `cpfResponsavel`: obrigatório
- `whatsAppResponsavel`: obrigatório

---

## Arquivos de Referência

| Arquivo | Propósito |
|---------|-----------|
| `REGRAS_DATABASE_VIVAN.md` | Schema, tabelas, convenções de nomes |
| `REGRAS_BACKEND_VIVAN.md` | Endpoints, formatos, bugs conhecidos |
| `CLAUDE.md` | Regras de desenvolvimento, deploy, armadilhas |
