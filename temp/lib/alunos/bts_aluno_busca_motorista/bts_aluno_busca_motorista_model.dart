import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_aluno_busca_motorista_widget.dart'
    show BtsAlunoBuscaMotoristaWidget;
import 'package:flutter/material.dart';

class BtsAlunoBuscaMotoristaModel
    extends FlutterFlowModel<BtsAlunoBuscaMotoristaWidget> {
  ///  Local state fields for this component.

  int pageNum = 1;

  ///  State fields for stateful widgets in this component.

  // State field(s) for filterAluno widget.
  FocusNode? filterAlunoFocusNode;
  TextEditingController? filterAlunoTextController;
  String? Function(BuildContext, String?)? filterAlunoTextControllerValidator;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    filterAlunoFocusNode?.dispose();
    filterAlunoTextController?.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
