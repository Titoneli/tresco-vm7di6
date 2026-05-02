# CLAUDE.md — Tresco Project Guidelines

## Visão Geral
App de serviços e agendamento desenvolvido com FlutterFlow + código customizado.
Repo: `titoneli/tresco-vm7di6`
Branch de trabalho: `develop`
Deploy: gerenciado pelo FlutterFlow via branch `main`

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
```

### Onde criar código customizado
Todo código novo deve ser criado nestas pastas:

```
lib/custom_code/
  ├── widgets/              # Novos widgets e telas customizadas
  ├── actions/              # Custom actions (lógica de negócio)
  └── functions/            # Funções utilitárias

lib/services/               # Integrações com APIs externas
lib/repositories/           # Camada de acesso a dados
lib/models/                 # Modelos de dados customizados
lib/utils/                  # Helpers e utilitários gerais
```

> Se a pasta não existir, crie-a. Nunca coloque código customizado fora dessas pastas.

---

## Arquitetura do Projeto

### Padrão atual
O projeto usa o padrão padrão do FlutterFlow (sem BLoC/Provider/Riverpod).
- State management: `FFAppState` (FlutterFlow) para estado global
- Para novos módulos customizados: use `StatefulWidget` com `setState` ou `ValueNotifier`
- Não introduzir novos packages de state management sem aprovação explícita

### Estrutura de uma nova tela customizada
Ao criar uma nova tela fora do FlutterFlow, siga este padrão:

```dart
// lib/custom_code/widgets/nome_da_tela_widget.dart

import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';   // OK usar o tema do FF
import '/flutter_flow/flutter_flow_util.dart';    // OK usar utilitários do FF

class NomeDaTelaWidget extends StatefulWidget {
  const NomeDaTelaWidget({super.key});

  @override
  State<NomeDaTelaWidget> createState() => _NomeDaTelaWidgetState();
}

class _NomeDaTelaWidgetState extends State<NomeDaTelaWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use FlutterFlowTheme para manter consistência visual
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      // ...
    );
  }
}
```

---

## Integrações com APIs Externas

### Onde criar
```
lib/services/nome_do_servico_service.dart
```

### Padrão de serviço
```dart
class NomeDoServicoService {
  static const String _baseUrl = 'https://api.exemplo.com';

  Future<Map<String, dynamic>> nomeDoMetodo(String param) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/endpoint'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Erro ${response.statusCode}');
    } catch (e) {
      throw Exception('Falha na requisição: $e');
    }
  }
}
```

### Packages permitidos para APIs
- `http` — já presente no projeto FlutterFlow
- `dio` — se precisar de interceptors/retry
- Sempre verificar se o package já está no `pubspec.yaml` antes de adicionar

---

## Fluxo de Trabalho Git

### Branches
- `develop` → sua branch de trabalho (sempre trabalhe aqui)
- `main` / `flutterflow` → exclusiva do FlutterFlow (nunca commitar direto)

### Commits
Use prefixos semânticos:
```
feat: nova tela de agendamento
fix: corrige validação do formulário de serviço
refactor: reorganiza serviço de pagamento
chore: atualiza dependências
```

### Antes de commitar, sempre verificar
- Nenhum arquivo de `lib/flutter_flow/`, `lib/pages/` ou `lib/main.dart` foi modificado
- O app compila sem erros: `flutter build apk --debug`
- Não há imports quebrados

---

## Contexto do Domínio — App de Agendamento

### Entidades principais (inferidas)
- **Serviço** — o que pode ser agendado
- **Prestador** — quem oferece o serviço
- **Cliente** — quem agenda
- **Agendamento** — vínculo entre cliente, prestador e serviço com data/hora
- **Disponibilidade** — horários disponíveis do prestador

### Convenções de nomenclatura
```
# Widgets/telas
ServicoDetalheWidget
AgendamentoFormWidget
PrestadorPerfilWidget

# Services
AgendamentoService
PrestadorService
NotificacaoService

# Models
ServicoModel
AgendamentoModel
PrestadorModel
```

---

## Modo de Operação — Plan antes de Agent

**Sempre que receber uma tarefa nova:**

1. **PLAN primeiro** — liste os arquivos que serão criados/modificados e por quê
2. **Aguarde aprovação** antes de executar qualquer escrita
3. **Confirme** que nenhum arquivo proibido está na lista
4. **Execute** somente após aprovação explícita

Exemplo de plan esperado:
```
Vou criar:
  ✅ lib/custom_code/widgets/agendamento_form_widget.dart (novo)
  ✅ lib/services/agendamento_service.dart (novo)
  ✅ lib/models/agendamento_model.dart (novo)

NÃO vou tocar em:
  🚫 lib/pages/ (FlutterFlow)
  🚫 lib/flutter_flow/ (FlutterFlow)
  🚫 lib/main.dart (FlutterFlow)
```

---

## Checklist Rápido para Novas Features

- [ ] Os arquivos novos estão em `lib/custom_code/` ou `lib/services/`?
- [ ] Nenhum arquivo gerado pelo FlutterFlow foi modificado?
- [ ] O tema usa `FlutterFlowTheme` para manter consistência visual?
- [ ] Foram adicionados novos packages ao `pubspec.yaml` somente se necessário?
- [ ] O commit está na branch `develop`?
- [ ] A mensagem de commit segue o padrão semântico?
