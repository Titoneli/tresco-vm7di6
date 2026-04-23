import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'passageiro_detalhe_m_widget.dart' show PassageiroDetalheMWidget;
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

class PassageiroDetalheMModel
    extends FlutterFlowModel<PassageiroDetalheMWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;
  ApiCallResponse? passageiroResponse;

  // Computed fields
  String get nome =>
      VivanPassageiroGetCall.nome(passageiroResponse?.jsonBody) ?? '';
  String get cpf =>
      VivanPassageiroGetCall.cpf(passageiroResponse?.jsonBody) ?? '';
  String get escola =>
      VivanPassageiroGetCall.escola(passageiroResponse?.jsonBody) ?? '';
  String get endereco =>
      VivanPassageiroGetCall.endereco(passageiroResponse?.jsonBody) ?? '';
  String get foto =>
      VivanPassageiroGetCall.foto(passageiroResponse?.jsonBody) ?? '';
  String get status =>
      VivanPassageiroGetCall.status(passageiroResponse?.jsonBody) ?? '';
  List<dynamic> get responsaveis =>
      VivanPassageiroGetCall.responsaveis(passageiroResponse?.jsonBody) ?? [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchPassageiro(int passageiroId) async {
    isLoading = true;
    passageiroResponse = await VivanPassageiroGetCall.call(
      passageiroId: passageiroId,
    );
    isLoading = false;
  }
}
