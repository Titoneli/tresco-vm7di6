import '/alunos/bts_aluno_busca/bts_aluno_busca_widget.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'bts_aluno_motorista_widget.dart' show BtsAlunoMotoristaWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsAlunoMotoristaModel extends FlutterFlowModel<BtsAlunoMotoristaWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
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
  // State field(s) for chkConfirmaMotorista widget.
  bool? chkConfirmaMotoristaValue;
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
