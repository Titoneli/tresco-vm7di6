import '/alunos/bts_aluno_busca/bts_aluno_busca_widget.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'bts_aluno_obs_motorista_m_widget.dart' show BtsAlunoObsMotoristaMWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsAlunoObsMotoristaMModel
    extends FlutterFlowModel<BtsAlunoObsMotoristaMWidget> {
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
