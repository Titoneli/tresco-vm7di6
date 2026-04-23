/// Camada de serviço ViVan — orquestra chamadas HTTP via [VivanApiClient]
/// e retorna modelos tipados.
///
/// Segue os mesmos endpoints do backend (vivan.routes.ts).

import '../core/vivan_api_client.dart';
import '../models/vivan_models.dart';

class VivanService {
  final VivanApiClient _client;

  VivanService(this._client);

  // --------------------------------------------------
  // AUTH
  // --------------------------------------------------

  Future<bool> login(String email, String senha) => _client.login(email, senha);

  // --------------------------------------------------
  // DASHBOARD
  // --------------------------------------------------

  Future<VivanDashboardResumo> getDashboardResumo(
      int motorista, String mesReferencia) async {
    final json = await _client.get('/dashboard/resumo', queryParams: {
      'motorista': motorista.toString(),
      'mesReferencia': mesReferencia,
    });
    return VivanDashboardResumo.fromJson(json as Map<String, dynamic>);
  }

  Future<VivanCapacidade> getCapacidade(int motorista) async {
    final json = await _client.get('/dashboard/capacidade', queryParams: {
      'motorista': motorista.toString(),
    });
    return VivanCapacidade.fromJson(json as Map<String, dynamic>);
  }

  // --------------------------------------------------
  // PASSAGEIROS
  // --------------------------------------------------

  Future<VivanPaginatedResponse<VivanPassageiro>> getPassageiros({
    required int motorista,
    String? busca,
    String? status,
    String? turno,
    int? escola,
    int page = 1,
    int limit = 20,
  }) async {
    final params = <String, String>{
      'motorista': motorista.toString(),
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (busca?.isNotEmpty == true) params['busca'] = busca!;
    if (status?.isNotEmpty == true) params['status'] = status!;
    if (turno?.isNotEmpty == true) params['turno'] = turno!;
    if (escola != null) params['escola'] = escola.toString();

    final json = await _client.get('/passageiros', queryParams: params);
    final map = json as Map<String, dynamic>;
    final list = (map['data'] as List)
        .map((e) => VivanPassageiro.fromJson(e as Map<String, dynamic>))
        .toList();
    return VivanPaginatedResponse(data: list, total: map['total'] as int? ?? list.length);
  }

  Future<VivanPassageiro> getPassageiro(int id) async {
    final json = await _client.get('/passageiros/$id');
    return VivanPassageiro.fromJson(json as Map<String, dynamic>);
  }

  Future<VivanPassageiro> createPassageiro(VivanPassageiro p) async {
    final json = await _client.post('/passageiros', body: p.toJson());
    return VivanPassageiro.fromJson(json as Map<String, dynamic>);
  }

  Future<VivanPassageiro> updatePassageiro(int id, VivanPassageiro p) async {
    final json = await _client.put('/passageiros/$id', body: p.toJson());
    return VivanPassageiro.fromJson(json as Map<String, dynamic>);
  }

  Future<void> deletePassageiro(int id) async {
    await _client.delete('/passageiros/$id');
  }

  // --------------------------------------------------
  // RESPONSÁVEIS
  // --------------------------------------------------

  Future<List<VivanResponsavel>> getResponsaveis(int passageiroId) async {
    final json = await _client.get('/passageiros/$passageiroId/responsaveis');
    final list = json as List;
    return list
        .map((e) => VivanResponsavel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<VivanResponsavel> createResponsavel(
      int passageiroId, VivanResponsavel r) async {
    final json = await _client.post('/passageiros/$passageiroId/responsaveis',
        body: r.toJson());
    return VivanResponsavel.fromJson(json as Map<String, dynamic>);
  }

  Future<VivanResponsavel> updateResponsavel(
      int passageiroId, int responsavelId, VivanResponsavel r) async {
    final json = await _client.put(
        '/passageiros/$passageiroId/responsaveis/$responsavelId',
        body: r.toJson());
    return VivanResponsavel.fromJson(json as Map<String, dynamic>);
  }

  Future<void> deleteResponsavel(int passageiroId, int responsavelId) async {
    await _client.delete(
        '/passageiros/$passageiroId/responsaveis/$responsavelId');
  }

  // --------------------------------------------------
  // CONTRATOS
  // --------------------------------------------------

  Future<VivanPaginatedResponse<VivanContrato>> getContratos({
    required int motorista,
    String? status,
    int? passageiro,
    int page = 1,
    int limit = 20,
  }) async {
    final params = <String, String>{
      'motorista': motorista.toString(),
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (status?.isNotEmpty == true) params['status'] = status!;
    if (passageiro != null) params['passageiro'] = passageiro.toString();

    final json = await _client.get('/contratos', queryParams: params);
    final map = json as Map<String, dynamic>;
    final list = (map['data'] as List)
        .map((e) => VivanContrato.fromJson(e as Map<String, dynamic>))
        .toList();
    return VivanPaginatedResponse(data: list, total: map['total'] as int? ?? list.length);
  }

  Future<VivanContrato> getContrato(int id) async {
    final json = await _client.get('/contratos/$id');
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  Future<VivanContrato> createContrato(VivanContrato c) async {
    final json = await _client.post('/contratos', body: c.toJson());
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  Future<VivanContrato> updateContrato(int id, VivanContrato c) async {
    final json = await _client.put('/contratos/$id', body: c.toJson());
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  Future<void> deleteContrato(int id) async {
    await _client.delete('/contratos/$id');
  }

  /// Envia contrato para assinatura (RASCUNHO → PENDENTE_ASSINATURA)
  Future<VivanContrato> enviarParaAssinatura(int id) async {
    final json = await _client.post('/contratos/$id/enviar-assinatura');
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  /// Ativa contrato (PENDENTE_ASSINATURA → ATIVO)
  Future<VivanContrato> ativarContrato(int id) async {
    final json = await _client.post('/contratos/$id/ativar');
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  /// Suspende contrato (ATIVO → SUSPENSO)
  Future<VivanContrato> suspenderContrato(int id, String motivo) async {
    final json = await _client
        .post('/contratos/$id/suspender', body: {'motivo': motivo});
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  /// Cancela contrato (→ CANCELADO)
  Future<VivanContrato> cancelarContrato(int id, String motivo) async {
    final json = await _client
        .post('/contratos/$id/cancelar', body: {'motivo': motivo});
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  /// Reativa contrato (SUSPENSO → ATIVO)
  Future<VivanContrato> reativarContrato(int id) async {
    final json = await _client.post('/contratos/$id/reativar');
    return VivanContrato.fromJson(json as Map<String, dynamic>);
  }

  /// Histórico de alterações do contrato
  Future<List<VivanContratoHistorico>> getContratoHistorico(int id) async {
    final json = await _client.get('/contratos/$id/historico');
    final list = json as List;
    return list
        .map((e) => VivanContratoHistorico.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // --------------------------------------------------
  // MENSALIDADES
  // --------------------------------------------------

  Future<VivanPaginatedResponse<VivanMensalidade>> getMensalidades({
    required int motorista,
    String? mesReferencia,
    String? status,
    int? passageiro,
    int page = 1,
    int limit = 50,
  }) async {
    final params = <String, String>{
      'motorista': motorista.toString(),
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (mesReferencia?.isNotEmpty == true) params['mesReferencia'] = mesReferencia!;
    if (status?.isNotEmpty == true) params['status'] = status!;
    if (passageiro != null) params['passageiro'] = passageiro.toString();

    final json = await _client.get('/mensalidades', queryParams: params);
    final map = json as Map<String, dynamic>;
    final list = (map['data'] as List)
        .map((e) => VivanMensalidade.fromJson(e as Map<String, dynamic>))
        .toList();
    return VivanPaginatedResponse(data: list, total: map['total'] as int? ?? list.length);
  }

  /// Pagamento manual de mensalidade
  Future<VivanMensalidade> pagamentoManual(int id, {
    required double valorPago,
    required String formaPagamento,
    String? comprovanteUrl,
    String? observacoes,
  }) async {
    final json = await _client.post('/mensalidades/$id/pagamento-manual', body: {
      'valorPago': valorPago,
      'formaPagamento': formaPagamento,
      if (comprovanteUrl != null) 'comprovanteUrl': comprovanteUrl,
      if (observacoes != null) 'observacoes': observacoes,
    });
    return VivanMensalidade.fromJson(json as Map<String, dynamic>);
  }

  /// Abonar mensalidade
  Future<VivanMensalidade> abonarMensalidade(int id, String motivo) async {
    final json = await _client
        .post('/mensalidades/$id/abonar', body: {'motivo': motivo});
    return VivanMensalidade.fromJson(json as Map<String, dynamic>);
  }

  /// Cancelar abono
  Future<VivanMensalidade> cancelarAbono(int id) async {
    final json = await _client.post('/mensalidades/$id/cancelar-abono');
    return VivanMensalidade.fromJson(json as Map<String, dynamic>);
  }

  /// Gerar cobrança PIX via Asaas
  Future<VivanMensalidade> gerarPix(int id) async {
    final json = await _client.post('/mensalidades/$id/gerar-pix');
    return VivanMensalidade.fromJson(json as Map<String, dynamic>);
  }

  // --------------------------------------------------
  // DESPESAS
  // --------------------------------------------------

  Future<VivanPaginatedResponse<VivanDespesa>> getDespesas({
    required int motorista,
    String? mesReferencia,
    String? categoria,
    int page = 1,
    int limit = 50,
  }) async {
    final params = <String, String>{
      'motorista': motorista.toString(),
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (mesReferencia?.isNotEmpty == true) params['mesReferencia'] = mesReferencia!;
    if (categoria?.isNotEmpty == true) params['categoria'] = categoria!;

    final json = await _client.get('/despesas', queryParams: params);
    final map = json as Map<String, dynamic>;
    final list = (map['data'] as List)
        .map((e) => VivanDespesa.fromJson(e as Map<String, dynamic>))
        .toList();
    return VivanPaginatedResponse(data: list, total: map['total'] as int? ?? list.length);
  }

  Future<VivanDespesa> createDespesa(VivanDespesa d) async {
    final json = await _client.post('/despesas', body: d.toJson());
    return VivanDespesa.fromJson(json as Map<String, dynamic>);
  }

  Future<VivanDespesa> updateDespesa(int id, VivanDespesa d) async {
    final json = await _client.put('/despesas/$id', body: d.toJson());
    return VivanDespesa.fromJson(json as Map<String, dynamic>);
  }

  Future<void> deleteDespesa(int id) async {
    await _client.delete('/despesas/$id');
  }

  // --------------------------------------------------
  // PRESENÇA
  // --------------------------------------------------

  Future<VivanPaginatedResponse<VivanPresenca>> getPresencas({
    required int motorista,
    String? dtPresenca,
    String? turno,
    int? passageiro,
    int page = 1,
    int limit = 100,
  }) async {
    final params = <String, String>{
      'motorista': motorista.toString(),
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (dtPresenca?.isNotEmpty == true) params['dtPresenca'] = dtPresenca!;
    if (turno?.isNotEmpty == true) params['turno'] = turno!;
    if (passageiro != null) params['passageiro'] = passageiro.toString();

    final json = await _client.get('/presencas', queryParams: params);
    final map = json as Map<String, dynamic>;
    final list = (map['data'] as List)
        .map((e) => VivanPresenca.fromJson(e as Map<String, dynamic>))
        .toList();
    return VivanPaginatedResponse(data: list, total: map['total'] as int? ?? list.length);
  }

  Future<VivanPresenca> createPresenca(VivanPresenca p) async {
    final json = await _client.post('/presencas', body: p.toJson());
    return VivanPresenca.fromJson(json as Map<String, dynamic>);
  }

  /// Enviar presenças em lote
  Future<List<VivanPresenca>> enviarPresencasLote(
      List<VivanPresenca> registros) async {
    final json = await _client.post('/presencas/lote', body: {
      'registros': registros.map((r) => r.toJson()).toList(),
    });
    final list = json as List;
    return list
        .map((e) => VivanPresenca.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
