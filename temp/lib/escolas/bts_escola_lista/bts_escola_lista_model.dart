import '/flutter_flow/flutter_flow_util.dart';
import 'bts_escola_lista_widget.dart' show BtsEscolaListaWidget;
import 'package:flutter/material.dart';

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
