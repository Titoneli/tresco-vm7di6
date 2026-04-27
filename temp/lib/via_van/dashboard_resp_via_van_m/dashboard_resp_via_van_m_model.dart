import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/index.dart';
import 'dashboard_resp_via_van_m_widget.dart' show DashboardRespViaVanMWidget;
import 'package:flutter/material.dart';

class DashboardRespViaVanMModel
    extends FlutterFlowModel<DashboardRespViaVanMWidget> {
  ///  Local state fields for this page.

  int? paginaAtiva;

  bool avoidTolls = false;

  String? staticDurationText;

  bool showContainerRoute = false;

  String? distanceText;

  String? durationText;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for PlacePickerOrigin widget.
  FFPlace placePickerOriginValue = FFPlace();
  // State field(s) for PlacePickerDestination widget.
  FFPlace placePickerDestinationValue = FFPlace();
  // State field(s) for SwitchListTileAvoidTolls widget.
  bool? switchListTileAvoidTollsValue;
  // State field(s) for ddwTurma widget.
  int? ddwTurmaValue;
  FormFieldController<int>? ddwTurmaValueController;
  // State field(s) for filterAluno widget.
  FocusNode? filterAlunoFocusNode;
  TextEditingController? filterAlunoTextController;
  String? Function(BuildContext, String?)? filterAlunoTextControllerValidator;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  @override
  void initState(BuildContext context) {
    menuSideBarExpandidoModel =
        createModel(context, () => MenuSideBarExpandidoModel());
  }

  @override
  void dispose() {
    menuSideBarExpandidoModel.dispose();
    filterAlunoFocusNode?.dispose();
    filterAlunoTextController?.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
