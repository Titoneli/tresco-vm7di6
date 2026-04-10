import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'bts_a_t_f_adicionar_passageiro_widget.dart'
    show BtsATFAdicionarPassageiroWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsATFAdicionarPassageiroModel
    extends FlutterFlowModel<BtsATFAdicionarPassageiroWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
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
  String? _nomeLeadTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

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
  AtfPassageiroRow? apiResAdicionaPassageiro;

  @override
  void initState(BuildContext context) {
    cpfCNPJTextControllerValidator = _cpfCNPJTextControllerValidator;
    nomeLeadTextControllerValidator = _nomeLeadTextControllerValidator;
    telefoneLeadTextControllerValidator = _telefoneLeadTextControllerValidator;
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
