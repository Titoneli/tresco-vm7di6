import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'contrato_detalhe_m_widget.dart' show ContratoDetalheMWidget;
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

class ContratoDetalheMModel extends FlutterFlowModel<ContratoDetalheMWidget> {
  bool isLoading = true;
  bool isActionLoading = false;
  ApiCallResponse? contratoResponse;
  ApiCallResponse? historicoResponse;

  // Computed
  int? get id => VivanContratoGetCall.id(contratoResponse?.jsonBody);
  String get status => VivanContratoGetCall.status(contratoResponse?.jsonBody) ?? '';
  double get valorMensal => VivanContratoGetCall.valorMensal(contratoResponse?.jsonBody) ?? 0.0;
  String get passageiroNome => VivanContratoGetCall.passageiroNome(contratoResponse?.jsonBody) ?? '';
  String get dataInicio => VivanContratoGetCall.dataInicio(contratoResponse?.jsonBody) ?? '';
  String get dataFim => VivanContratoGetCall.dataFim(contratoResponse?.jsonBody) ?? '';
  String get condicoes => VivanContratoGetCall.condicoes(contratoResponse?.jsonBody) ?? '';
  List<dynamic> get historico => VivanContratoHistoricoCall.historico(historicoResponse?.jsonBody) ?? [];

  // Form fields for creation
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  FocusNode? condicoesFocusNode;
  TextEditingController? condicoesTextController;
  FocusNode? dataInicioFocusNode;
  TextEditingController? dataInicioTextController;
  FocusNode? dataFimFocusNode;
  TextEditingController? dataFimTextController;
  int? selectedPassageiroId;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    valorFocusNode?.dispose();
    valorTextController?.dispose();
    condicoesFocusNode?.dispose();
    condicoesTextController?.dispose();
    dataInicioFocusNode?.dispose();
    dataInicioTextController?.dispose();
    dataFimFocusNode?.dispose();
    dataFimTextController?.dispose();
  }

  Future<void> fetchContrato(int contratoId) async {
    isLoading = true;
    final results = await Future.wait([
      VivanContratoGetCall.call(contratoId: contratoId),
      VivanContratoHistoricoCall.call(contratoId: contratoId),
    ]);
    contratoResponse = results[0];
    historicoResponse = results[1];
    isLoading = false;
  }

  Future<ApiCallResponse> ativar(int contratoId) async {
    isActionLoading = true;
    final r = await VivanContratoAtivarCall.call(contratoId: contratoId);
    isActionLoading = false;
    return r;
  }

  Future<ApiCallResponse> suspender(int contratoId) async {
    isActionLoading = true;
    final r = await VivanContratoSuspenderCall.call(contratoId: contratoId);
    isActionLoading = false;
    return r;
  }

  Future<ApiCallResponse> cancelar(int contratoId, String motivo) async {
    isActionLoading = true;
    final r = await VivanContratoCancelarCall.call(contratoId: contratoId, motivo: motivo);
    isActionLoading = false;
    return r;
  }

  Future<ApiCallResponse> enviarAssinatura(int contratoId) async {
    isActionLoading = true;
    final r = await VivanContratoEnviarAssinaturaCall.call(contratoId: contratoId);
    isActionLoading = false;
    return r;
  }
}
