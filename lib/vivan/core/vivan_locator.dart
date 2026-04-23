/// Locator / provider global do módulo ViVan.
///
/// Fornece uma instância singleton de [VivanService] pré-configurada.
/// Widgets importam apenas `package:vivan/vivan.dart` e usam
/// `VivanLocator.service` para acessar qualquer operação.

import 'vivan_api_client.dart';
import '../services/vivan_service.dart';
import 'vivan_config.dart';

class VivanLocator {
  VivanLocator._();

  static VivanApiClient? _client;
  static VivanService? _service;

  /// Retorna a instância singleton do [VivanApiClient].
  static VivanApiClient get client {
    _client ??= VivanApiClient(baseUrl: VivanConfig.baseUrl);
    return _client!;
  }

  /// Retorna a instância singleton do [VivanService].
  static VivanService get service {
    _service ??= VivanService(client);
    return _service!;
  }

  /// Reseta instâncias (útil em logout).
  static void reset() {
    _client = null;
    _service = null;
  }
}
