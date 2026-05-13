# CLAUDE.md — Tresco Project Guidelines

## Visão Geral
App de transporte escolar desenvolvido com FlutterFlow + código customizado (módulo ViVan).
Repo: `titoneli/tresco-vm7di6`
Branch de trabalho: `vivan`
Deploy: gerenciado pelo FlutterFlow via merge `vivan → main`

---

## ⚠️ Regras Críticas — Leia Antes de Qualquer Ação

### Arquivos que NUNCA devem ser editados
Estes arquivos são gerados e sobrescritos automaticamente pelo FlutterFlow:

```
lib/flutter_flow/           # NÃO TOCAR — gerado pelo FlutterFlow
lib/pages/                  # NÃO TOCAR — telas geradas pelo FlutterFlow
lib/app_state.dart          # NÃO TOCAR — estado global do FlutterFlow
lib/index.dart              # NÃO TOCAR — gerado automaticamente
lib/main.dart               # NÃO TOCAR — gerado automaticamente
lib/routing/                # NÃO TOCAR — rotas geradas pelo FlutterFlow
pubspec.yaml                # NÃO TOCAR — versão gerenciada pelo FlutterFlow
ios/                        # NÃO TOCAR — configuração gerenciada pelo FF/Xcode
```

> **CRÍTICO:** Nunca alterar manualmente a `version:` no `pubspec.yaml`. O FlutterFlow
> controla o build number para cada envio ao TestFlight. Alterar manualmente causa
> conflito de merge quando o FF tenta fazer push `vivan → main` e o deploy falha com
> "Push to FlutterFlow failed".

### Onde está o código customizado do módulo ViVan
O código customizado real do projeto está nestas pastas:

```
lib/vivan/
  ├── models/vivan_models.dart      # Todos os modelos de dados (VivanContrato, VivanPassageiro...)
  ├── services/vivan_service.dart   # Camada de serviço tipada (VivanLocator.service)
  ├── vivan_api_client.dart         # Cliente HTTP com autenticação por cookie
  └── vivan.dart                    # Barrel export

lib/via_van/                        # Telas e widgets customizados do módulo
  ├── passageiro_form_m/            # Wizard de criação/edição de passageiro
  ├── passageiro_detalhe_m/         # Detalhe do passageiro
  ├── contratos_lista_m/            # Lista de contratos
  ├── gerar_contrato_m/             # Wizard de geração de contrato
  ├── mensalidades_tab/             # Aba de mensalidades
  ├── financeiro_tab/               # Aba financeira
  ├── renovar_mensalidades_m/       # Renovação de mensalidades
  └── ...

lib/dashboard_passageiros_m/        # Dashboard principal do motorista
```

---

## Fluxo de Trabalho Git

### Branches
- `vivan` → branch de trabalho (sempre trabalhe aqui)
- `main` → exclusiva do FlutterFlow (NUNCA commitar direto)

### Como o deploy funciona (FlutterFlow)
1. Você faz push das alterações para `origin/vivan`
2. No painel do FlutterFlow, você clica em **Deploy → iOS → Submit to TestFlight**
3. O FF pega o `vivan`, mescla com o código gerado por ele, cria um merge commit no `main`
4. FF compila e envia ao TestFlight

O `main` sempre terá commits de merge que o `vivan` não tem (código gerado pelo FF).
Isso é **normal** — não tente alinhar manualmente.

### Verificar se há commits não deployados
```bash
git fetch origin
git log origin/main..origin/vivan --oneline
```
Se a saída tiver commits, eles ainda não foram para o TestFlight.

### Antes de solicitar deploy
```bash
# 1. Confirmar que working tree está limpo
git status

# 2. Confirmar que tudo foi pushed
git push origin vivan

# 3. Confirmar que não há commits locais pendentes
git log origin/vivan..HEAD --oneline
```

### Commits
Use prefixos semânticos:
```
feat: nova funcionalidade
fix: correção de bug
refactor: refatoração sem mudança de comportamento
chore: atualização de dependências, configs
docs: atualização de documentação
```

---

## Armadilhas Conhecidas — Deploy

### "Push to FlutterFlow failed"
**Causa mais comum:** `pubspec.yaml` com versão alterada manualmente.
**Diagnóstico:** `git diff origin/main origin/vivan -- pubspec.yaml`
**Solução:** Reverter `pubspec.yaml` para a mesma versão que está no `main`.

### Branches desalinhados após "Push failed"
O `main` pode ter merge commits que o `vivan` não tem — isso é normal.
Nunca tente fazer `git merge main` no `vivan` para alinhar.
O alinhamento acontece quando o FF faz o próximo deploy com sucesso.

---

## Arquitetura do Módulo ViVan

### Camadas
```
Widget (lib/via_van/*/widget.dart)
    ↓
Model  (lib/via_van/*/model.dart)   ← lógica de estado e chamadas ao serviço
    ↓
VivanLocator.service                 ← tipado, usa VivanApiClient
    ↓
VivanApiClient / VivanHttp           ← HTTP com cookie de autenticação
    ↓
API (https://app.coopertransmig.com.br/api/vivan)
```

### Estado global
- `FFAppState().idUsuario` → ID do motorista logado
- `FFAppState().nomeUsuario` → nome do motorista

### Padrão de widget customizado
```dart
class NomeMWidget extends StatefulWidget {
  const NomeMWidget({super.key, required this.algumParam});
  final int algumParam;

  @override
  State<NomeMWidget> createState() => _NomeMWidgetState();
}

class _NomeMWidgetState extends State<NomeMWidget> {
  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg     => FlutterFlowTheme.of(context).primaryBackground;

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    // ...
  }
}
```

---

## Bugs Conhecidos da API ViVan

### Filtro `?passageiro=` em `/contratos` não funciona
`GET /contratos?motorista=X&passageiro=Y` retorna TODOS os contratos do motorista,
ignorando o filtro de passageiro. **Solução: filtrar client-side.**

```dart
// Em qualquer model que lista contratos por passageiro:
contratos = result.data
    .where((c) => c.idPassageiro == passageiroId)
    .toList();
```

### `numContrato` com conflito 409
O backend gera `numContrato` via `MAX()+1` (não é uma sequence atômica).
Em criações rápidas consecutivas pode gerar 409 Conflict. Não tem solução no frontend —
é um bug de backend. Workaround: aguardar entre criações em testes.

---

## Formato de Campos Críticos

### `mesReferencia`
**Formato correto:** `MM/yyyy` (ex: `"05/2026"`)
**Formato ERRADO:** `yyyy-MM` (ex: `"2026-05"`) — a API ignora ou retorna 0 resultados

```dart
// CORRETO
String get mesReferencia =>
    '${selectedMonth.toString().padLeft(2, '0')}/$selectedYear';

// Para geração em loop
final mesRef = DateFormat('MM/yyyy').format(DateTime(ano, mes));
```

### Campos do Passageiro
| Campo no app | Campo na API | Observação |
|---|---|---|
| `periodo` / turno | `domTurno` | Nunca enviar `periodo` — a API ignora |
| nome da escola | `idEscola` (int) | PUT exige `idEscola`, não `nomeEscola` |
| sexo | ~~`domSexo`~~ | Campo não existe na API, não enviar |

### Campos de Pagamento Manual (`POST /mensalidades/:id/pagamento-manual`)
Campos obrigatórios:
```json
{
  "valPago": 150.00,
  "formaPagamento": "PIX",
  "dtPagamento": "2026-05-02"
}
```
> `valorPago` (errado) → `valPago` (correto). `dtPagamento` é obrigatório.

---

## Fluxos de Contrato

### Wizard de passageiro (passageiro_form_m)
Usa `POST /passageiros/:id/contratos` — cria contrato + ativa + gera mensalidades
atomicamente em uma única chamada. **Não precisa chamar `/ativar` separado.**

### Tela "Gerar Contrato" (gerar_contrato_m)
Usa `POST /contratos` (cria RASCUNHO) + `POST /contratos/:id/ativar`.
**Sempre chamar `/ativar` após criar** — sem isso o contrato fica como RASCUNHO
e as mensalidades nunca são geradas.

```dart
final criado = await VivanLocator.service.createContrato(c);
await VivanLocator.service.ativarContrato(criado.idContrato!);
```

### Campos defaults obrigatórios ao criar contrato
```dart
VivanContrato(
  idMotorista: FFAppState().idUsuario,
  idPassageiro: passageiroId,
  idResponsavel: responsavel?.idResponsavel,   // se disponível
  valMensal: valor,
  diaVencimento: diaVenc,                      // default: 5
  domFormaPagamento: 'OUTROS',                 // obrigatório ter valor
  domCondicaoPagamento: 'Mensal',              // obrigatório ter valor
  percentualMulta: multa ?? 2.0,               // default: 2%
  percentualJurosDia: jurosDia ?? 0.0333,      // default: 0.0333%/dia
  dtInicio: '...',
  dtTermino: '...',
  status: 'RASCUNHO',
)
```

---

## Checklist Rápido para Novas Features

- [ ] O código novo está em `lib/via_van/` ou `lib/vivan/`?
- [ ] Nenhum arquivo gerado pelo FlutterFlow foi modificado?
- [ ] `pubspec.yaml` não foi alterado?
- [ ] O tema usa `FlutterFlowTheme` para manter consistência visual?
- [ ] O commit está na branch `vivan`?
- [ ] `git push origin vivan` foi executado?
- [ ] `mesReferencia` usa formato `MM/yyyy` (não `yyyy-MM`)?
- [ ] Contratos criados via `POST /contratos` têm chamada a `/ativar` logo após?
