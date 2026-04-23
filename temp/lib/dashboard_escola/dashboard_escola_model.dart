import '/flutter_flow/flutter_flow_util.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/index.dart';
import 'dashboard_escola_widget.dart' show DashboardEscolaWidget;
import 'package:flutter/material.dart';

class DashboardEscolaModel extends FlutterFlowModel<DashboardEscolaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for filterMotorista widget.
  FocusNode? filterMotoristaFocusNode;
  TextEditingController? filterMotoristaTextController;
  String? Function(BuildContext, String?)?
      filterMotoristaTextControllerValidator;
  // State field(s) for filterEscola widget.
  FocusNode? filterEscolaFocusNode;
  TextEditingController? filterEscolaTextController;
  String? Function(BuildContext, String?)? filterEscolaTextControllerValidator;
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
    filterMotoristaFocusNode?.dispose();
    filterMotoristaTextController?.dispose();

    filterEscolaFocusNode?.dispose();
    filterEscolaTextController?.dispose();

    menuSideBarExpandidoModel2.dispose();
  }
}
