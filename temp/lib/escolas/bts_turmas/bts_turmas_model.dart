import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_turmas_widget.dart' show BtsTurmasWidget;
import 'package:flutter/material.dart';

class BtsTurmasModel extends FlutterFlowModel<BtsTurmasWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  String? _nomeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for ddwSerie widget.
  String? ddwSerieValue;
  FormFieldController<String>? ddwSerieValueController;
  // State field(s) for ddwTurno widget.
  String? ddwTurnoValue;
  FormFieldController<String>? ddwTurnoValueController;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  TurmaRow? apiResAdicionaTurno;

  @override
  void initState(BuildContext context) {
    nomeTextControllerValidator = _nomeTextControllerValidator;
  }

  @override
  void dispose() {
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();
  }
}
