import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_via_van_motorista_editar_m_widget.dart'
    show BtsViaVanMotoristaEditarMWidget;
import 'package:flutter/material.dart';

class BtsViaVanMotoristaEditarMModel
    extends FlutterFlowModel<BtsViaVanMotoristaEditarMWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
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
      return 'Apelido é obrigatório';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode1;
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
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
  FocusNode? nomeFocusNode2;
  TextEditingController? nomeTextController2;
  String? Function(BuildContext, String?)? nomeTextController2Validator;
  String? _nomeTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Nome completo é obrigatório';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode2;
  TextEditingController? emailTextController2;
  String? Function(BuildContext, String?)? emailTextController2Validator;
  String? _emailTextController2Validator(BuildContext context, String? val) {
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
  bool? form1Validation;
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
    nomeTextController1Validator = _nomeTextController1Validator;
    cpfCnpjTextControllerValidator = _cpfCnpjTextControllerValidator;
    nomeTextController2Validator = _nomeTextController2Validator;
    emailTextController2Validator = _emailTextController2Validator;
    telefoneTextControllerValidator = _telefoneTextControllerValidator;
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

    emailFocusNode2?.dispose();
    emailTextController2?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    edtLoginFocusNode?.dispose();
    edtLoginTextController?.dispose();

    confirmaSenhaFocusNode?.dispose();
    confirmaSenhaTextController?.dispose();
  }
}
