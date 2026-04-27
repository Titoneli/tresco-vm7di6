import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/index.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (refreshViews)] action in dashboard widget.
  ApiCallResponse? apiResRefresh;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for filterEscola widget.
  FocusNode? filterEscolaFocusNode1;
  TextEditingController? filterEscolaTextController1;
  String? Function(BuildContext, String?)? filterEscolaTextController1Validator;
  // State field(s) for filterMotorista widget.
  FocusNode? filterMotoristaFocusNode;
  TextEditingController? filterMotoristaTextController;
  String? Function(BuildContext, String?)?
      filterMotoristaTextControllerValidator;
  // State field(s) for filterEscola widget.
  FocusNode? filterEscolaFocusNode2;
  TextEditingController? filterEscolaTextController2;
  String? Function(BuildContext, String?)? filterEscolaTextController2Validator;
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
    filterEscolaFocusNode1?.dispose();
    filterEscolaTextController1?.dispose();

    filterMotoristaFocusNode?.dispose();
    filterMotoristaTextController?.dispose();

    filterEscolaFocusNode2?.dispose();
    filterEscolaTextController2?.dispose();

    menuSideBarExpandidoModel2.dispose();
  }
}
