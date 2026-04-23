import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'contratos_lista_m_widget.dart' show ContratosListaMWidget;
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

class ContratosListaMModel extends FlutterFlowModel<ContratosListaMWidget> {
  bool isLoading = true;
  ApiCallResponse? contratosResponse;
  String? filtroStatus;

  List<dynamic> get contratos =>
      VivanContratosListCall.contratos(contratosResponse?.jsonBody) ?? [];
  int get total =>
      VivanContratosListCall.total(contratosResponse?.jsonBody) ?? 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchContratos(int motoristaId, {String? status}) async {
    isLoading = true;
    filtroStatus = status;
    contratosResponse = await VivanContratosListCall.call(
      motoristaId: motoristaId,
      status: status,
    );
    isLoading = false;
  }
}
