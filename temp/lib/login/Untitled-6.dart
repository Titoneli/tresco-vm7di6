// ...existing code...

// Adicione estas rotas dentro do GoRouter routes:

GoRoute(
  name: 'atf_lista',
  path: '/atfs',
  builder: (context, state) => const AtfListaWidget(),
),
GoRoute(
  name: 'atf_form',
  path: '/atfs/form',
  builder: (context, state) => AtfFormWidget(
    atfId: state.uri.queryParameters['atf_id'],
  ),
),

// ...existing code...