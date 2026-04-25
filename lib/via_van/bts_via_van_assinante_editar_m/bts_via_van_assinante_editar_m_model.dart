import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'bts_via_van_assinante_editar_m_widget.dart'
    show BtsViaVanAssinanteEditarMWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsViaVanAssinanteEditarMModel
    extends FlutterFlowModel<BtsViaVanAssinanteEditarMWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwTipoPessoa widget.
  String? ddwTipoPessoaValue;
  FormFieldController<String>? ddwTipoPessoaValueController;
  // State field(s) for cpfCnpj widget.
  FocusNode? cpfCnpjFocusNode;
  TextEditingController? cpfCnpjTextController;
  String? Function(BuildContext, String?)? cpfCnpjTextControllerValidator;
  String? _cpfCnpjTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'CPF/CNPJ é obrigatório';
    }

    return null;
  }

  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  String? _nomeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Nome completo é obrigatório';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Informe um email válido';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Informe um email válido';
    }
    return null;
  }

  // State field(s) for telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  String? _telefoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Whatsapp é obrigatório';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? form2Validation;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<UsuarioRow>? apiResEditaUsuario;
  // State field(s) for edtLogin widget.
  FocusNode? edtLoginFocusNode;
  TextEditingController? edtLoginTextController;
  String? Function(BuildContext, String?)? edtLoginTextControllerValidator;
  // State field(s) for confirmaSenha widget.
  FocusNode? confirmaSenhaFocusNode;
  TextEditingController? confirmaSenhaTextController;
  late bool confirmaSenhaVisibility;
  String? Function(BuildContext, String?)? confirmaSenhaTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<UsuarioRow>? apiResEditaSenhaExecutivo;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<UsuarioRow>? apiResExcluirConta;

  @override
  void initState(BuildContext context) {
    cpfCnpjTextControllerValidator = _cpfCnpjTextControllerValidator;
    nomeTextControllerValidator = _nomeTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    telefoneTextControllerValidator = _telefoneTextControllerValidator;
    confirmaSenhaVisibility = false;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    cpfCnpjFocusNode?.dispose();
    cpfCnpjTextController?.dispose();

    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    edtLoginFocusNode?.dispose();
    edtLoginTextController?.dispose();

    confirmaSenhaFocusNode?.dispose();
    confirmaSenhaTextController?.dispose();
  }
}
