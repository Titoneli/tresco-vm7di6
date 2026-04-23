import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'passageiro_form_m_widget.dart' show PassageiroFormMWidget;
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

class PassageiroFormMModel extends FlutterFlowModel<PassageiroFormMWidget> {
  ///  Local state fields for this page.

  bool isLoading = false;
  bool isSaving = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  FocusNode? cpfFocusNode;
  TextEditingController? cpfTextController;
  FocusNode? escolaFocusNode;
  TextEditingController? escolaTextController;
  FocusNode? enderecoFocusNode;
  TextEditingController? enderecoTextController;
  String? fotoUrl;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();
    cpfFocusNode?.dispose();
    cpfTextController?.dispose();
    escolaFocusNode?.dispose();
    escolaTextController?.dispose();
    enderecoFocusNode?.dispose();
    enderecoTextController?.dispose();
  }

  Future<void> loadPassageiro(int passageiroId) async {
    isLoading = true;
    final response = await VivanPassageiroGetCall.call(
      passageiroId: passageiroId,
    );
    if (response.succeeded) {
      nomeTextController?.text =
          VivanPassageiroGetCall.nome(response.jsonBody) ?? '';
      cpfTextController?.text =
          VivanPassageiroGetCall.cpf(response.jsonBody) ?? '';
      escolaTextController?.text =
          VivanPassageiroGetCall.escola(response.jsonBody) ?? '';
      enderecoTextController?.text =
          VivanPassageiroGetCall.endereco(response.jsonBody) ?? '';
      fotoUrl = VivanPassageiroGetCall.foto(response.jsonBody);
    }
    isLoading = false;
  }

  Future<ApiCallResponse> savePassageiro(
      int motoristaId, int? passageiroId) async {
    isSaving = true;
    ApiCallResponse response;
    if (passageiroId != null) {
      response = await VivanPassageiroUpdateCall.call(
        passageiroId: passageiroId,
        nome: nomeTextController?.text,
        cpf: cpfTextController?.text,
        endereco: enderecoTextController?.text,
        foto: fotoUrl,
      );
    } else {
      response = await VivanPassageiroCreateCall.call(
        motoristaId: motoristaId,
        nome: nomeTextController?.text,
        cpf: cpfTextController?.text,
        endereco: enderecoTextController?.text,
        foto: fotoUrl,
      );
    }
    isSaving = false;
    return response;
  }
}
