import '/flutter_flow/flutter_flow_util.dart';
import 'bts_colab_lista_widget.dart' show BtsColabListaWidget;
import 'package:flutter/material.dart';

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
