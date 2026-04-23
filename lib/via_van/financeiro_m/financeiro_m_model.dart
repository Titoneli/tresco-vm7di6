import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'financeiro_m_widget.dart' show FinanceiroMWidget;
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

class FinanceiroMModel extends FlutterFlowModel<FinanceiroMWidget> {
  int tabIndex = 0;

  // Mensalidades
  bool isLoadingMensalidades = true;
  ApiCallResponse? mensalidadesResponse;
  List<dynamic> get mensalidades =>
      VivanMensalidadesListCall.mensalidades(mensalidadesResponse?.jsonBody) ?? [];
  double get totalMensalidades =>
      VivanMensalidadesListCall.totalValor(mensalidadesResponse?.jsonBody) ?? 0.0;

  // Despesas
  bool isLoadingDespesas = true;
  ApiCallResponse? despesasResponse;
  List<dynamic> get despesas =>
      VivanDespesasListCall.despesas(despesasResponse?.jsonBody) ?? [];
  double get totalDespesas =>
      VivanDespesasListCall.totalValor(despesasResponse?.jsonBody) ?? 0.0;

  // Tab controller
  TabController? tabBarController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }

  Future<void> fetchMensalidades(int motoristaId, {String? mes, String? status}) async {
    isLoadingMensalidades = true;
    mensalidadesResponse = await VivanMensalidadesListCall.call(
      motoristaId: motoristaId, mes: mes, status: status,
    );
    isLoadingMensalidades = false;
  }

  Future<void> fetchDespesas(int motoristaId, {String? mes}) async {
    isLoadingDespesas = true;
    despesasResponse = await VivanDespesasListCall.call(
      motoristaId: motoristaId, mes: mes,
    );
    isLoadingDespesas = false;
  }
}
