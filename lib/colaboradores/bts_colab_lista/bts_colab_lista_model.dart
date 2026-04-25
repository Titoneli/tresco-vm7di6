import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/colaboradores/bts_colab_editar/bts_colab_editar_widget.dart';
import '/colaboradores/bts_colab_novo/bts_colab_novo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'bts_colab_lista_widget.dart' show BtsColabListaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsColabListaModel extends FlutterFlowModel<BtsColabListaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for filterUsuario widget.
  FocusNode? filterUsuarioFocusNode;
  TextEditingController? filterUsuarioTextController;
  String? Function(BuildContext, String?)? filterUsuarioTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    filterUsuarioFocusNode?.dispose();
    filterUsuarioTextController?.dispose();
  }
}
