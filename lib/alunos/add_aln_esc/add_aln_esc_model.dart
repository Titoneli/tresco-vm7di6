import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/cmp_header/cmp_header_widget.dart';
import '/index.dart';
import 'add_aln_esc_widget.dart' show AddAlnEscWidget;
import 'package:flutter/material.dart';

class AddAlnEscModel extends FlutterFlowModel<AddAlnEscWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for cmpHeader component.
  late CmpHeaderModel cmpHeaderModel;
  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  Stream<List<EscolaRow>>? ddwEscolaSupabaseStream;
  // State field(s) for ddwTurma widget.
  int? ddwTurmaValue;
  FormFieldController<int>? ddwTurmaValueController;
  // State field(s) for cpfCNPJ widget.
  FocusNode? cpfCNPJFocusNode;
  TextEditingController? cpfCNPJTextController;
  String? Function(BuildContext, String?)? cpfCNPJTextControllerValidator;
  String? _cpfCNPJTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for nomeLead widget.
  FocusNode? nomeLeadFocusNode;
  TextEditingController? nomeLeadTextController;
  String? Function(BuildContext, String?)? nomeLeadTextControllerValidator;
  // State field(s) for telefoneLead widget.
  FocusNode? telefoneLeadFocusNode;
  TextEditingController? telefoneLeadTextController;
  String? Function(BuildContext, String?)? telefoneLeadTextControllerValidator;
  String? _telefoneLeadTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  AlunoRow? apiResAdicionaAluno;
  // Stores action output result for [Backend Call - API (alertaNovoAluno)] action in Button widget.
  ApiCallResponse? actAlerta;

  @override
  void initState(BuildContext context) {
    cmpHeaderModel = createModel(context, () => CmpHeaderModel());
    cpfCNPJTextControllerValidator = _cpfCNPJTextControllerValidator;
    telefoneLeadTextControllerValidator = _telefoneLeadTextControllerValidator;
  }

  @override
  void dispose() {
    cmpHeaderModel.dispose();
    cpfCNPJFocusNode?.dispose();
    cpfCNPJTextController?.dispose();

    nomeLeadFocusNode?.dispose();
    nomeLeadTextController?.dispose();

    telefoneLeadFocusNode?.dispose();
    telefoneLeadTextController?.dispose();
  }
}
