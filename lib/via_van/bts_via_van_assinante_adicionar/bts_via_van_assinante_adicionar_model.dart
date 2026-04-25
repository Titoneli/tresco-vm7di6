import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'bts_via_van_assinante_adicionar_widget.dart'
    show BtsViaVanAssinanteAdicionarWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsViaVanAssinanteAdicionarModel
    extends FlutterFlowModel<BtsViaVanAssinanteAdicionarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for ddwCargo widget.
  String? ddwCargoValue;
  FormFieldController<String>? ddwCargoValueController;
  // State field(s) for cpfCNPJ widget.
  FocusNode? cpfCNPJFocusNode;
  TextEditingController? cpfCNPJTextController;
  String? Function(BuildContext, String?)? cpfCNPJTextControllerValidator;
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
      return 'WhatsApp é obrigatório';
    }

    return null;
  }

  // State field(s) for emailLead widget.
  FocusNode? emailLeadFocusNode;
  TextEditingController? emailLeadTextController;
  String? Function(BuildContext, String?)? emailLeadTextControllerValidator;
  // State field(s) for novaSenha widget.
  FocusNode? novaSenhaFocusNode;
  TextEditingController? novaSenhaTextController;
  late bool novaSenhaVisibility;
  String? Function(BuildContext, String?)? novaSenhaTextControllerValidator;
  String? _novaSenhaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Senha é obrigatório';
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
      return 'Confirme sua Senha é obrigatório';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  UsuarioRow? apiResAdicionaColab;

  @override
  void initState(BuildContext context) {
    telefoneLeadTextControllerValidator = _telefoneLeadTextControllerValidator;
    novaSenhaVisibility = false;
    novaSenhaTextControllerValidator = _novaSenhaTextControllerValidator;
    confirmaSenhaVisibility = false;
    confirmaSenhaTextControllerValidator =
        _confirmaSenhaTextControllerValidator;
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

    novaSenhaFocusNode?.dispose();
    novaSenhaTextController?.dispose();

    confirmaSenhaFocusNode?.dispose();
    confirmaSenhaTextController?.dispose();
  }
}
