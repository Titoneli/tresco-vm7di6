import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'dashboard_endereco_widget.dart' show DashboardEnderecoWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
