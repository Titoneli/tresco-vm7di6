import 'dart:convert';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'presenca_m_widget.dart' show PresencaMWidget;
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

class PresencaMModel extends FlutterFlowModel<PresencaMWidget> {
  bool isLoading = true;
  bool isSending = false;
  ApiCallResponse? presencasResponse;

  List<dynamic> get presencas =>
      VivanPresencasListCall.presencas(presencasResponse?.jsonBody) ?? [];
  int get totalPresentes =>
      VivanPresencasListCall.totalPresentes(presencasResponse?.jsonBody) ?? 0;
  int get totalFaltas =>
      VivanPresencasListCall.totalFaltas(presencasResponse?.jsonBody) ?? 0;

  // Mapa: passageiroId -> status (P ou F)
  Map<int, String> presencaMap = {};

  // Geolocalização
  double? latitude;
  double? longitude;

  // Filtro para histórico
  FocusNode? dataInicioFocusNode;
  TextEditingController? dataInicioTextController;
  FocusNode? dataFimFocusNode;
  TextEditingController? dataFimTextController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    dataInicioFocusNode?.dispose();
    dataInicioTextController?.dispose();
    dataFimFocusNode?.dispose();
    dataFimTextController?.dispose();
  }

  Future<void> fetchPresencasHoje(int motoristaId) async {
    isLoading = true;
    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    presencasResponse = await VivanPresencasListCall.call(
      motoristaId: motoristaId,
      data: hoje,
    );
    // Initialize presencaMap from existing records
    for (final p in presencas) {
      final id = getJsonField(p, r'''$.passageiro_id''');
      final status = getJsonField(p, r'''$.status''')?.toString();
      if (id != null && status != null) {
        presencaMap[id] = status;
      }
    }
    isLoading = false;
  }

  Future<void> fetchHistorico(int motoristaId, String dataInicio, String dataFim) async {
    isLoading = true;
    presencasResponse = await VivanPresencasListCall.call(
      motoristaId: motoristaId,
      dataInicio: dataInicio,
      dataFim: dataFim,
    );
    isLoading = false;
  }

  Future<ApiCallResponse> enviarPresencasLote(int motoristaId) async {
    isSending = true;
    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final presencasList = presencaMap.entries.map((e) => {
      'passageiro_id': e.key,
      'status': e.value,
    }).toList();

    final response = await VivanPresencaLoteCall.call(
      motoristaId: motoristaId,
      data: hoje,
      latitude: latitude,
      longitude: longitude,
      presencasJson: json.encode(presencasList),
    );
    isSending = false;
    return response;
  }

  void togglePresenca(int passageiroId) {
    final current = presencaMap[passageiroId];
    if (current == null || current == 'F') {
      presencaMap[passageiroId] = 'P';
    } else {
      presencaMap[passageiroId] = 'F';
    }
  }
}
