import '/flutter_flow/flutter_flow_util.dart';
import 'bts_filtro_widget.dart' show BtsFiltroWidget;
import 'package:flutter/material.dart';

class BtsFiltroModel extends FlutterFlowModel<BtsFiltroWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for SearchTextField widget.
  FocusNode? searchTextFieldFocusNode;
  TextEditingController? searchTextFieldTextController;
  String? Function(BuildContext, String?)?
      searchTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchTextFieldFocusNode?.dispose();
    searchTextFieldTextController?.dispose();
  }
}
