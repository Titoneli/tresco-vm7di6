import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/veiculos/bts_veiculo_adicionar/bts_veiculo_adicionar_widget.dart';
import '/veiculos/bts_veiculo_editar/bts_veiculo_editar_widget.dart';
import 'dart:ui';
import 'bts_veiculo_lista_widget.dart' show BtsVeiculoListaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsVeiculoListaModel extends FlutterFlowModel<BtsVeiculoListaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for filterVeiculo widget.
  FocusNode? filterVeiculoFocusNode;
  TextEditingController? filterVeiculoTextController;
  String? Function(BuildContext, String?)? filterVeiculoTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    filterVeiculoFocusNode?.dispose();
    filterVeiculoTextController?.dispose();
  }
}
