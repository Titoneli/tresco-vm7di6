import '/alunos/bts_aluno_busca/bts_aluno_busca_widget.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_aluno_busca_widget.dart' show BtsAlunoBuscaWidget;
import 'package:flutter/material.dart';

class BtsAlunoBuscaModel extends FlutterFlowModel<BtsAlunoBuscaWidget> {
  ///  Local state fields for this component.

  int pageNum = 1;

  ///  State fields for stateful widgets in this component.

  // State field(s) for filterAluno widget.
  FocusNode? filterAlunoFocusNode;
  TextEditingController? filterAlunoTextController;
  String? Function(BuildContext, String?)? filterAlunoTextControllerValidator;
  // State field(s) for choiceSituacao widget.
  FormFieldController<List<String>>? choiceSituacaoValueController;
  String? get choiceSituacaoValue =>
      choiceSituacaoValueController?.value?.firstOrNull;
  set choiceSituacaoValue(String? val) =>
      choiceSituacaoValueController?.value = val != null ? [val] : [];
  // State field(s) for choiceRespMotorista widget.
  FormFieldController<List<String>>? choiceRespMotoristaValueController;
  String? get choiceRespMotoristaValue =>
      choiceRespMotoristaValueController?.value?.firstOrNull;
  set choiceRespMotoristaValue(String? val) =>
      choiceRespMotoristaValueController?.value = val != null ? [val] : [];
  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap = {};
  List<dynamic> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Backend Call - Update Row(s)] action in Checkbox widget.
  List<AlunoRow>? actTrue;
  // Stores action output result for [Backend Call - Update Row(s)] action in Checkbox widget.
  List<AlunoRow>? actFalse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    filterAlunoFocusNode?.dispose();
    filterAlunoTextController?.dispose();
  }
}
