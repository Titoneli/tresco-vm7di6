import '/backend/supabase/supabase.dart';
import '/escolas/bts_turmas/bts_turmas_widget.dart';
import '/escolas/bts_turmas_editar/bts_turmas_editar_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'bts_escola_editar_widget.dart' show BtsEscolaEditarWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsEscolaEditarModel extends FlutterFlowModel<BtsEscolaEditarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwTipoEscola widget.
  String? ddwTipoEscolaValue;
  FormFieldController<String>? ddwTipoEscolaValueController;
  // State field(s) for nomeEscola widget.
  FocusNode? nomeEscolaFocusNode1;
  TextEditingController? nomeEscolaTextController1;
  String? Function(BuildContext, String?)? nomeEscolaTextController1Validator;
  String? _nomeEscolaTextController1Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for nomeEscola widget.
  FocusNode? nomeEscolaFocusNode2;
  TextEditingController? nomeEscolaTextController2;
  String? Function(BuildContext, String?)? nomeEscolaTextController2Validator;
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

  // State field(s) for cep widget.
  FocusNode? cepFocusNode;
  TextEditingController? cepTextController;
  String? Function(BuildContext, String?)? cepTextControllerValidator;
  // State field(s) for logradouro widget.
  FocusNode? logradouroFocusNode;
  TextEditingController? logradouroTextController;
  String? Function(BuildContext, String?)? logradouroTextControllerValidator;
  // State field(s) for numero widget.
  FocusNode? numeroFocusNode;
  TextEditingController? numeroTextController;
  String? Function(BuildContext, String?)? numeroTextControllerValidator;
  // State field(s) for comp widget.
  FocusNode? compFocusNode;
  TextEditingController? compTextController;
  String? Function(BuildContext, String?)? compTextControllerValidator;
  // State field(s) for bairro widget.
  FocusNode? bairroFocusNode;
  TextEditingController? bairroTextController;
  String? Function(BuildContext, String?)? bairroTextControllerValidator;
  // State field(s) for cidade widget.
  FocusNode? cidadeFocusNode;
  TextEditingController? cidadeTextController;
  String? Function(BuildContext, String?)? cidadeTextControllerValidator;
  // State field(s) for uf widget.
  FocusNode? ufFocusNode;
  TextEditingController? ufTextController;
  String? Function(BuildContext, String?)? ufTextControllerValidator;
  // State field(s) for lat widget.
  FocusNode? latFocusNode;
  TextEditingController? latTextController;
  String? Function(BuildContext, String?)? latTextControllerValidator;
  // State field(s) for long widget.
  FocusNode? longFocusNode;
  TextEditingController? longTextController;
  String? Function(BuildContext, String?)? longTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<EscolaRow>? apiResEditaEscola;

  @override
  void initState(BuildContext context) {
    nomeEscolaTextController1Validator = _nomeEscolaTextController1Validator;
    whatsappEscolaTextControllerValidator =
        _whatsappEscolaTextControllerValidator;
    emailEscolaTextControllerValidator = _emailEscolaTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    nomeEscolaFocusNode1?.dispose();
    nomeEscolaTextController1?.dispose();

    nomeEscolaFocusNode2?.dispose();
    nomeEscolaTextController2?.dispose();

    whatsappEscolaFocusNode?.dispose();
    whatsappEscolaTextController?.dispose();

    emailEscolaFocusNode?.dispose();
    emailEscolaTextController?.dispose();

    cepFocusNode?.dispose();
    cepTextController?.dispose();

    logradouroFocusNode?.dispose();
    logradouroTextController?.dispose();

    numeroFocusNode?.dispose();
    numeroTextController?.dispose();

    compFocusNode?.dispose();
    compTextController?.dispose();

    bairroFocusNode?.dispose();
    bairroTextController?.dispose();

    cidadeFocusNode?.dispose();
    cidadeTextController?.dispose();

    ufFocusNode?.dispose();
    ufTextController?.dispose();

    latFocusNode?.dispose();
    latTextController?.dispose();

    longFocusNode?.dispose();
    longTextController?.dispose();
  }
}
