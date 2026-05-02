/// Configuração central do módulo ViVan.
/// Quando virar app separado, basta alterar estes valores.
class VivanConfig {
  VivanConfig._();

  /// Base URL da API
  static const String baseUrl = 'https://app.coopertransmig.com.br/api';

  /// Prefixo das rotas ViVan
  static const String vivanPrefix = '/vivan';

  /// URL completa da API ViVan
  static String get vivanUrl => '$baseUrl$vivanPrefix';

  /// Auth endpoint
  static const String authLoginUrl = '$baseUrl/auth/login';
  static const String authRefreshUrl = '$baseUrl/auth/refresh';
  static const String authLogoutUrl = '$baseUrl/auth/logout';

  /// Credenciais fixas do motorista para autenticação automática
  static const String usuario = 'gustavo';
  static const String senha = 'gustavo';

  /// Timeout padrão em segundos
  static const int timeoutSeconds = 30;

  /// Versão do módulo
  static const String version = '1.0.0';

  /// Categorias de despesas disponíveis
  static const List<String> categoriasDespesa = [
    'Combustível',
    'Manutenção',
    'Seguro',
    'IPVA',
    'Licenciamento',
    'Multas',
    'Pneus',
    'Lavagem',
    'Pedágio',
    'Estacionamento',
    'Outros',
  ];

  /// Status de contratos
  static const Map<String, String> statusContratoLabels = {
    'RASCUNHO': 'Rascunho',
    'PENDENTE_ASSINATURA': 'Pendente Assinatura',
    'ATIVO': 'Ativo',
    'VENCENDO': 'Vencendo',
    'VENCIDO': 'Vencido',
    'SUSPENSO': 'Suspenso',
    'CANCELADO': 'Cancelado',
    'RENOVADO': 'Renovado',
  };

  /// Status de mensalidades
  static const Map<String, String> statusMensalidadeLabels = {
    'AGUARDANDO': 'Aguardando',
    'PENDENTE': 'Pendente',
    'PAGO': 'Pago',
    'PAGO_ATRASO': 'Pago com Atraso',
    'ATRASADO': 'Atrasado',
    'ABONADO': 'Abonado',
  };

  /// Turnos
  static const List<String> turnos = ['MANHÃ', 'TARDE', 'NOITE', 'INTEGRAL'];

  /// Parentescos
  static const List<String> parentescos = [
    'Pai',
    'Mãe',
    'Avô',
    'Avó',
    'Tio(a)',
    'Irmão(ã)',
    'Padrasto',
    'Madrasta',
    'Responsável Legal',
    'Outro',
  ];
}
