import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'passageiro_form_m_widget.dart' show PassageiroFormMWidget;
import 'package:flutter/material.dart';

class PassageiroFormMModel extends FlutterFlowModel<PassageiroFormMWidget> {
  ///  Local state fields for this page.

  bool isLoading = false;
  bool isSaving = false;
  String? errorMessage;

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
    try {
      final p = await VivanLocator.service.getPassageiro(passageiroId);
      nomeTextController?.text = p.nomePassageiro;
      cpfTextController?.text = p.cpfPassageiro ?? '';
      escolaTextController?.text = p.nomeEscola ?? '';
      enderecoTextController?.text = p.enderecoCompleto;
      fotoUrl = p.urlFoto;
    } catch (e) {
      debugPrint('Erro ao carregar passageiro: $e');
    }
    isLoading = false;
  }

  Future<bool> savePassageiro(int motoristaId, int? passageiroId) async {
    isSaving = true;
    errorMessage = null;
    try {
      final p = VivanPassageiro(
        idMotorista: motoristaId,
        nomePassageiro: nomeTextController?.text ?? '',
        cpfPassageiro: cpfTextController?.text,
        endPassageiro: enderecoTextController?.text ?? '',
        urlFoto: fotoUrl,
      );
      if (passageiroId != null) {
        await VivanLocator.service.updatePassageiro(passageiroId, p);
      } else {
        await VivanLocator.service.createPassageiro(p);
      }
      isSaving = false;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isSaving = false;
      return false;
    }
  }
}
