import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'bts_escola_adicionar_widget.dart' show BtsEscolaAdicionarWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsEscolaAdicionarModel
    extends FlutterFlowModel<BtsEscolaAdicionarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for ddwCargo widget.
  String? ddwCargoValue;
  FormFieldController<String>? ddwCargoValueController;
  // State field(s) for nomeEscola widget.
  FocusNode? nomeEscolaFocusNode;
  TextEditingController? nomeEscolaTextController;
  String? Function(BuildContext, String?)? nomeEscolaTextControllerValidator;
  String? _nomeEscolaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for whatsappEscola widget.
  FocusNode? whatsappEscolaFocusNode;
  TextEditingController? whatsappEscolaTextController;
  String? Function(BuildContext, String?)?
      whatsappEscolaTextControllerValidator;
  String? _whatsappEscolaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for emailEscola widget.
  FocusNode? emailEscolaFocusNode;
  TextEditingController? emailEscolaTextController;
  String? Function(BuildContext, String?)? emailEscolaTextControllerValidator;
  String? _emailEscolaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  EscolaRow? apiResAdicionaEscola;

  @override
  void initState(BuildContext context) {
    nomeEscolaTextControllerValidator = _nomeEscolaTextControllerValidator;
    whatsappEscolaTextControllerValidator =
        _whatsappEscolaTextControllerValidator;
    emailEscolaTextControllerValidator = _emailEscolaTextControllerValidator;
  }

  @override
  void dispose() {
    nomeEscolaFocusNode?.dispose();
    nomeEscolaTextController?.dispose();

    whatsappEscolaFocusNode?.dispose();
    whatsappEscolaTextController?.dispose();

    emailEscolaFocusNode?.dispose();
    emailEscolaTextController?.dispose();
  }
}
