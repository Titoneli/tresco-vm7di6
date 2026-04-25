import '/backend/api_requests/api_calls.dart';
import '/escolas/bts_escola_adicionar/bts_escola_adicionar_widget.dart';
import '/escolas/bts_escola_editar/bts_escola_editar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'bts_escola_lista_widget.dart' show BtsEscolaListaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsEscolaListaModel extends FlutterFlowModel<BtsEscolaListaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for filterEscola widget.
  FocusNode? filterEscolaFocusNode;
  TextEditingController? filterEscolaTextController;
  String? Function(BuildContext, String?)? filterEscolaTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    filterEscolaFocusNode?.dispose();
    filterEscolaTextController?.dispose();
  }
}
