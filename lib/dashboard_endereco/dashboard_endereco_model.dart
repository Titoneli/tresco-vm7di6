import '/flutter_flow/flutter_flow_util.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import 'dashboard_endereco_widget.dart' show DashboardEnderecoWidget;
import 'package:flutter/material.dart';

class DashboardEnderecoModel extends FlutterFlowModel<DashboardEnderecoWidget> {
  ///  Local state fields for this page.

  String? durationText;

  String? distanceText;

  bool showContainerRoute = false;

  bool avoidTolls = false;

  String? staticDurationText;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for PlacePickerOrigin widget.
  FFPlace placePickerOriginValue = FFPlace();
  // State field(s) for PlacePickerDestination widget.
  FFPlace placePickerDestinationValue = FFPlace();
  // State field(s) for SwitchListTileAvoidTolls widget.
  bool? switchListTileAvoidTollsValue;
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
    menuSideBarExpandidoModel2.dispose();
  }
}
