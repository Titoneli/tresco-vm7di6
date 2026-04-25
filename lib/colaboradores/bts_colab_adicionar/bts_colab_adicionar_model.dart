import '/backend/supabase/supabase.dart';
import '/colaboradores/bts_colab_lista/bts_colab_lista_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'bts_colab_adicionar_widget.dart' show BtsColabAdicionarWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsColabAdicionarModel extends FlutterFlowModel<BtsColabAdicionarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for ddwCargo widget.
  String? ddwCargoValue;
  FormFieldController<String>? ddwCargoValueController;
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

  // State field(s) for emailLead widget.
  FocusNode? emailLeadFocusNode;
  TextEditingController? emailLeadTextController;
  String? Function(BuildContext, String?)? emailLeadTextControllerValidator;
  String? _emailLeadTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  UsuarioRow? apiResAdicionaColab;

  @override
  void initState(BuildContext context) {
    cpfCNPJTextControllerValidator = _cpfCNPJTextControllerValidator;
    telefoneLeadTextControllerValidator = _telefoneLeadTextControllerValidator;
    emailLeadTextControllerValidator = _emailLeadTextControllerValidator;
  }

  @override
  void dispose() {
    cpfCNPJFocusNode?.dispose();
    cpfCNPJTextController?.dispose();

    nomeLeadFocusNode?.dispose();
    nomeLeadTextController?.dispose();

    telefoneLeadFocusNode?.dispose();
    telefoneLeadTextController?.dispose();

    emailLeadFocusNode?.dispose();
    emailLeadTextController?.dispose();
  }
}
