import '/flutter_flow/flutter_flow_util.dart';
import 'bts_veiculo_lista_widget.dart' show BtsVeiculoListaWidget;
import 'package:flutter/material.dart';

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
