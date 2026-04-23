/// ViVan Module — Gestão de Passageiros / Transporte Escolar
///
/// Módulo isolado que pode se tornar um app separado no futuro.
/// Toda lógica, API, modelos e UI ficam dentro deste pacote.
///
/// Arquitetura:
///   vivan/
///     core/           → Config, constantes, auth, API client
///     models/         → Modelos de dados (match com DB schema)
///     services/       → Camada de serviço (abstrai API calls)
///     ui/             → Telas organizadas por feature
///       dashboard/
///       passageiros/
///       contratos/
///       financeiro/
///       presenca/
///     widgets/        → Componentes reutilizáveis do módulo
library vivan;

export 'core/vivan_config.dart';
export 'core/vivan_api_client.dart';
export 'core/vivan_locator.dart';
export 'models/vivan_models.dart';
export 'services/vivan_service.dart';
