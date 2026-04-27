import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/index.dart';
import 'dashboard_associado_widget.dart' show DashboardAssociadoWidget;
import 'package:flutter/material.dart';

class DashboardAssociadoModel
    extends FlutterFlowModel<DashboardAssociadoWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for filterAluno widget.
  FocusNode? filterAlunoFocusNode;
  TextEditingController? filterAlunoTextController;
  String? Function(BuildContext, String?)? filterAlunoTextControllerValidator;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap2 = {};
  List<dynamic> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // Stores action output result for [Backend Call - Update Row(s)] action in Checkbox widget.
  List<AlunoRow>? actTrue;
  // Stores action output result for [Backend Call - Update Row(s)] action in Checkbox widget.
  List<AlunoRow>? actFalse;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel2;

  @override
  void initState(BuildContext context) {
    menuSideBarExpandidoModel1 =
        createModel(context, () => MenuSideBarExpandidoModel());
    menuSideBarExpandidoModel2 =
        createModel(context, () => MenuSideBarExpandidoModel());
  }

  @override
  void dispose() {
    menuSideBarExpandidoModel1.dispose();
    filterAlunoFocusNode?.dispose();
    filterAlunoTextController?.dispose();

    menuSideBarExpandidoModel2.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
