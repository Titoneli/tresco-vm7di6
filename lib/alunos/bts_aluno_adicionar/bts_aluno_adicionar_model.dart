import '/backend/supabase/supabase.dart';
import '/escolas/bts_turmas/bts_turmas_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'bts_aluno_adicionar_widget.dart' show BtsAlunoAdicionarWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsAlunoAdicionarModel extends FlutterFlowModel<BtsAlunoAdicionarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for cpfCNPJ widget.
  FocusNode? cpfCNPJFocusNode;
  TextEditingController? cpfCNPJTextController;
  String? Function(BuildContext, String?)? cpfCNPJTextControllerValidator;
  // State field(s) for nomeLead widget.
  FocusNode? nomeLeadFocusNode;
  TextEditingController? nomeLeadTextController;
  String? Function(BuildContext, String?)? nomeLeadTextControllerValidator;
  String? _nomeLeadTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Informe o Nome do Aluno';
    }

    return null;
  }

  // State field(s) for telefoneLead widget.
  FocusNode? telefoneLeadFocusNode;
  TextEditingController? telefoneLeadTextController;
  String? Function(BuildContext, String?)? telefoneLeadTextControllerValidator;
  // State field(s) for ddwMotorista widget.
  int? ddwMotoristaValue;
  FormFieldController<int>? ddwMotoristaValueController;
  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // State field(s) for ddwSerie widget.
  String? ddwSerieValue;
  FormFieldController<String>? ddwSerieValueController;
  // State field(s) for ddwTurno widget.
  String? ddwTurnoValue;
  FormFieldController<String>? ddwTurnoValueController;
  // State field(s) for ddwTurma widget.
  int? ddwTurmaValue;
  FormFieldController<int>? ddwTurmaValueController;
  // State field(s) for ddwTipoAluno widget.
  String? ddwTipoAlunoValue;
  FormFieldController<String>? ddwTipoAlunoValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AlunoRow>? apiResBuscaAluno;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  AlunoRow? apiResAdicionaAluno;

  @override
  void initState(BuildContext context) {
    nomeLeadTextControllerValidator = _nomeLeadTextControllerValidator;
  }

  @override
  void dispose() {
    cpfCNPJFocusNode?.dispose();
    cpfCNPJTextController?.dispose();

    nomeLeadFocusNode?.dispose();
    nomeLeadTextController?.dispose();

    telefoneLeadFocusNode?.dispose();
    telefoneLeadTextController?.dispose();
  }
}
