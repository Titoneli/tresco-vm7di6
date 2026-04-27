import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_colab_editar_m_widget.dart' show BtsColabEditarMWidget;
import 'package:flutter/material.dart';

class BtsColabEditarMModel extends FlutterFlowModel<BtsColabEditarMWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for nome widget.
  FocusNode? nomeFocusNode1;
  TextEditingController? nomeTextController1;
  String? Function(BuildContext, String?)? nomeTextController1Validator;
  String? _nomeTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode1;
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
  String? _emailTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for ddwTipoPessoa widget.
  String? ddwTipoPessoaValue;
  FormFieldController<String>? ddwTipoPessoaValueController;
  // State field(s) for cpfCnpj widget.
  FocusNode? cpfCnpjFocusNode;
  TextEditingController? cpfCnpjTextController;
  String? Function(BuildContext, String?)? cpfCnpjTextControllerValidator;
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode2;
  TextEditingController? nomeTextController2;
  String? Function(BuildContext, String?)? nomeTextController2Validator;
  String? _nomeTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  String? _telefoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode2;
  TextEditingController? emailTextController2;
  String? Function(BuildContext, String?)? emailTextController2Validator;
  String? _emailTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for codNIS widget.
  FocusNode? codNISFocusNode;
  TextEditingController? codNISTextController;
  String? Function(BuildContext, String?)? codNISTextControllerValidator;
  // State field(s) for qtdeDependentes widget.
  FocusNode? qtdeDependentesFocusNode;
  TextEditingController? qtdeDependentesTextController;
  String? Function(BuildContext, String?)?
      qtdeDependentesTextControllerValidator;
  // State field(s) for chavePIX widget.
  FocusNode? chavePIXFocusNode;
  TextEditingController? chavePIXTextController;
  String? Function(BuildContext, String?)? chavePIXTextControllerValidator;
  // State field(s) for ddwTipoChavePIX widget.
  String? ddwTipoChavePIXValue;
  FormFieldController<String>? ddwTipoChavePIXValueController;
  // State field(s) for codPermPrefeitura widget.
  FocusNode? codPermPrefeituraFocusNode;
  TextEditingController? codPermPrefeituraTextController;
  String? Function(BuildContext, String?)?
      codPermPrefeituraTextControllerValidator;
  // State field(s) for dtPermPrefeitura widget.
  FocusNode? dtPermPrefeituraFocusNode;
  TextEditingController? dtPermPrefeituraTextController;
  String? Function(BuildContext, String?)?
      dtPermPrefeituraTextControllerValidator;
  // State field(s) for codPermDER widget.
  FocusNode? codPermDERFocusNode;
  TextEditingController? codPermDERTextController;
  String? Function(BuildContext, String?)? codPermDERTextControllerValidator;
  // State field(s) for dtPermDER widget.
  FocusNode? dtPermDERFocusNode;
  TextEditingController? dtPermDERTextController;
  String? Function(BuildContext, String?)? dtPermDERTextControllerValidator;
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
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<UsuarioRow>? apiResEditaUsuario;

  @override
  void initState(BuildContext context) {
    nomeTextController1Validator = _nomeTextController1Validator;
    emailTextController1Validator = _emailTextController1Validator;
    nomeTextController2Validator = _nomeTextController2Validator;
    telefoneTextControllerValidator = _telefoneTextControllerValidator;
    emailTextController2Validator = _emailTextController2Validator;
    confirmaSenhaVisibility = false;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    nomeFocusNode1?.dispose();
    nomeTextController1?.dispose();

    emailFocusNode1?.dispose();
    emailTextController1?.dispose();

    cpfCnpjFocusNode?.dispose();
    cpfCnpjTextController?.dispose();

    nomeFocusNode2?.dispose();
    nomeTextController2?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    emailFocusNode2?.dispose();
    emailTextController2?.dispose();

    codNISFocusNode?.dispose();
    codNISTextController?.dispose();

    qtdeDependentesFocusNode?.dispose();
    qtdeDependentesTextController?.dispose();

    chavePIXFocusNode?.dispose();
    chavePIXTextController?.dispose();

    codPermPrefeituraFocusNode?.dispose();
    codPermPrefeituraTextController?.dispose();

    dtPermPrefeituraFocusNode?.dispose();
    dtPermPrefeituraTextController?.dispose();

    codPermDERFocusNode?.dispose();
    codPermDERTextController?.dispose();

    dtPermDERFocusNode?.dispose();
    dtPermDERTextController?.dispose();

    edtLoginFocusNode?.dispose();
    edtLoginTextController?.dispose();

    confirmaSenhaFocusNode?.dispose();
    confirmaSenhaTextController?.dispose();
  }
}
