import '/alunos/bts_aluno_adicionar/bts_aluno_adicionar_widget.dart';
import '/alunos/bts_aluno_editar/bts_aluno_editar_widget.dart';
import '/alunos/bts_aluno_motorista/bts_aluno_motorista_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'bts_aluno_busca_motorista_escola_widget.dart'
    show BtsAlunoBuscaMotoristaEscolaWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsAlunoBuscaMotoristaEscolaModel
    extends FlutterFlowModel<BtsAlunoBuscaMotoristaEscolaWidget> {
  ///  Local state fields for this component.

  int pageNum = 1;

  ///  State fields for stateful widgets in this component.

  // State field(s) for filterAluno widget.
  FocusNode? filterAlunoFocusNode;
  TextEditingController? filterAlunoTextController;
  String? Function(BuildContext, String?)? filterAlunoTextControllerValidator;
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
