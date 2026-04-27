import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_colab_editar_widget.dart' show BtsColabEditarWidget;
import 'package:flutter/material.dart';

class BtsColabEditarModel extends FlutterFlowModel<BtsColabEditarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwCargo widget.
  String? ddwCargoValue;
  FormFieldController<String>? ddwCargoValueController;
  // State field(s) for cpfCnpj widget.
  FocusNode? cpfCnpjFocusNode;
  TextEditingController? cpfCnpjTextController;
  String? Function(BuildContext, String?)? cpfCnpjTextControllerValidator;
  String? _cpfCnpjTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for ddwTipoPessoa widget.
  String? ddwTipoPessoaValue;
  FormFieldController<String>? ddwTipoPessoaValueController;
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  String? _nomeTextControllerValidator(BuildContext context, String? val) {
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
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for swcLogin widget.
  bool? swcLoginValue;
  // State field(s) for swcAcesso widget.
  bool? swcAcessoValue;
  // State field(s) for edtLogin widget.
  FocusNode? edtLoginFocusNode;
  TextEditingController? edtLoginTextController;
  String? Function(BuildContext, String?)? edtLoginTextControllerValidator;
  String? _edtLoginTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Informar nova senha';
    }

    return null;
  }

  // State field(s) for confirmaSenha widget.
  FocusNode? confirmaSenhaFocusNode;
  TextEditingController? confirmaSenhaTextController;
  late bool confirmaSenhaVisibility;
  String? Function(BuildContext, String?)? confirmaSenhaTextControllerValidator;
  String? _confirmaSenhaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Confirmar nova senha';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<UsuarioRow>? apiResEditaSenhaExecutivo;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<UsuarioRow>? apiResExcluirConta;
  // State field(s) for edtMatriculaoCooperativa widget.
  FocusNode? edtMatriculaoCooperativaFocusNode;
  TextEditingController? edtMatriculaoCooperativaTextController;
  String? Function(BuildContext, String?)?
      edtMatriculaoCooperativaTextControllerValidator;
  // State field(s) for edtValAluno widget.
  FocusNode? edtValAlunoFocusNode;
  TextEditingController? edtValAlunoTextController;
  String? Function(BuildContext, String?)? edtValAlunoTextControllerValidator;
  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // State field(s) for edtDescontoCooperativa widget.
  FocusNode? edtDescontoCooperativaFocusNode;
  TextEditingController? edtDescontoCooperativaTextController;
  String? Function(BuildContext, String?)?
      edtDescontoCooperativaTextControllerValidator;
  // State field(s) for edtAdiantRepasse widget.
  FocusNode? edtAdiantRepasseFocusNode;
  TextEditingController? edtAdiantRepasseTextController;
  String? Function(BuildContext, String?)?
      edtAdiantRepasseTextControllerValidator;
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
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<UsuarioRow>? apiResEditaUsuario;

  @override
  void initState(BuildContext context) {
    cpfCnpjTextControllerValidator = _cpfCnpjTextControllerValidator;
    nomeTextControllerValidator = _nomeTextControllerValidator;
    telefoneTextControllerValidator = _telefoneTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    edtLoginTextControllerValidator = _edtLoginTextControllerValidator;
    confirmaSenhaVisibility = false;
    confirmaSenhaTextControllerValidator =
        _confirmaSenhaTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    cpfCnpjFocusNode?.dispose();
    cpfCnpjTextController?.dispose();

    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    edtLoginFocusNode?.dispose();
    edtLoginTextController?.dispose();

    confirmaSenhaFocusNode?.dispose();
    confirmaSenhaTextController?.dispose();

    edtMatriculaoCooperativaFocusNode?.dispose();
    edtMatriculaoCooperativaTextController?.dispose();

    edtValAlunoFocusNode?.dispose();
    edtValAlunoTextController?.dispose();

    edtDescontoCooperativaFocusNode?.dispose();
    edtDescontoCooperativaTextController?.dispose();

    edtAdiantRepasseFocusNode?.dispose();
    edtAdiantRepasseTextController?.dispose();

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
  }
}
