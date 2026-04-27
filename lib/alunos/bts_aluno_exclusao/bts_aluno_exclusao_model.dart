import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_aluno_exclusao_widget.dart' show BtsAlunoExclusaoWidget;
import 'package:flutter/material.dart';

class BtsAlunoExclusaoModel extends FlutterFlowModel<BtsAlunoExclusaoWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  // State field(s) for ddwExclusaoEscola widget.
  String? ddwExclusaoEscolaValue;
  FormFieldController<String>? ddwExclusaoEscolaValueController;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AlunoRow>? apiResAlunoMotorista;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();
  }
}
