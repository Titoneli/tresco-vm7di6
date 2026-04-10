import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/frame_work/menu_side_bar_reduzido/menu_side_bar_reduzido_widget.dart';
import '/frame_work/menu_side_bar_tablet/menu_side_bar_tablet_widget.dart';
import 'dart:convert';
import 'dart:ui';
import '/index.dart';
import 'dashboard_mensagens_widget.dart' show DashboardMensagensWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardMensagensModel
    extends FlutterFlowModel<DashboardMensagensWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarTablet component.
  late MenuSideBarTabletModel menuSideBarTabletModel;
  // Model for menuSideBarReduzido component.
  late MenuSideBarReduzidoModel menuSideBarReduzidoModel;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for txtMensagem widget.
  FocusNode? txtMensagemFocusNode1;
  TextEditingController? txtMensagemTextController1;
  String? Function(BuildContext, String?)? txtMensagemTextController1Validator;
  // State field(s) for ddwMotorista widget.
  int? ddwMotoristaValue;
  FormFieldController<int>? ddwMotoristaValueController;
  // Stores action output result for [Backend Call - API (EnviarComunicadoZap)] action in Button widget.
  ApiCallResponse? apiResEnviarMensagem;
  // State field(s) for txtMensagem widget.
  FocusNode? txtMensagemFocusNode2;
  TextEditingController? txtMensagemTextController2;
  String? Function(BuildContext, String?)? txtMensagemTextController2Validator;
  // State field(s) for ddwDestino widget.
  String? ddwDestinoValue;
  FormFieldController<String>? ddwDestinoValueController;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  CorComunicadoRow? apiResEnviaComunicado;
  // Stores action output result for [Backend Call - API (EnviarComunicadoZap)] action in Button widget.
  ApiCallResponse? apiResEnviarComunicado;
  // Stores action output result for [Backend Call - Delete Row(s)] action in IconButton widget.
  List<CorComunicadoRow>? apiResExcluirComunicado;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel2;

  @override
  void initState(BuildContext context) {
    menuSideBarTabletModel =
        createModel(context, () => MenuSideBarTabletModel());
    menuSideBarReduzidoModel =
        createModel(context, () => MenuSideBarReduzidoModel());
    menuSideBarExpandidoModel1 =
        createModel(context, () => MenuSideBarExpandidoModel());
    menuSideBarExpandidoModel2 =
        createModel(context, () => MenuSideBarExpandidoModel());
  }

  @override
  void dispose() {
    menuSideBarTabletModel.dispose();
    menuSideBarReduzidoModel.dispose();
    menuSideBarExpandidoModel1.dispose();
    tabBarController?.dispose();
    txtMensagemFocusNode1?.dispose();
    txtMensagemTextController1?.dispose();

    txtMensagemFocusNode2?.dispose();
    txtMensagemTextController2?.dispose();

    menuSideBarExpandidoModel2.dispose();
  }
}
