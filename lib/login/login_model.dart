import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/frame_work/cmp_header/cmp_header_widget.dart';
import '/via_van/bts_via_van_assinante_adicionar/bts_via_van_assinante_adicionar_widget.dart';
import '/via_van/bts_via_van_motorista_adicionar/bts_via_van_motorista_adicionar_widget.dart';
import '/via_van/bts_via_van_motorista_editar_m/bts_via_van_motorista_editar_m_widget.dart';
import 'dart:convert';
import 'dart:ui';
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for cmpHeader component.
  late CmpHeaderModel cmpHeaderModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for emailAddress_Login widget.
  final emailAddressLoginKey = GlobalKey();
  FocusNode? emailAddressLoginFocusNode;
  TextEditingController? emailAddressLoginTextController;
  String? emailAddressLoginSelectedOption;
  String? Function(BuildContext, String?)?
      emailAddressLoginTextControllerValidator;
  // State field(s) for password_Login widget.
  final passwordLoginKey = GlobalKey();
  FocusNode? passwordLoginFocusNode;
  TextEditingController? passwordLoginTextController;
  String? passwordLoginSelectedOption;
  late bool passwordLoginVisibility;
  String? Function(BuildContext, String?)? passwordLoginTextControllerValidator;
  // Stores action output result for [Backend Call - API (WHVALIDAUSUARIO)] action in password_Login widget.
  ApiCallResponse? apiResValidaUsuarioEnter;
  // Stores action output result for [Backend Call - API (WHVALIDAUSUARIO)] action in Button-Login widget.
  ApiCallResponse? apiResValidaUsuario;
  // State field(s) for mrgCadMotorista widget.
  bool mrgCadMotoristaHovered = false;
  // State field(s) for mrgCadAlunoResp widget.
  bool mrgCadAlunoRespHovered = false;

  @override
  void initState(BuildContext context) {
    cmpHeaderModel = createModel(context, () => CmpHeaderModel());
    passwordLoginVisibility = false;
  }

  @override
  void dispose() {
    cmpHeaderModel.dispose();
    emailAddressLoginFocusNode?.dispose();

    passwordLoginFocusNode?.dispose();
  }
}
