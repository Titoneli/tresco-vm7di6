import '/backend/supabase/supabase.dart';
import '/escolas/bts_turmas/bts_turmas_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/bts_selecione/bts_selecione_widget.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/via_van/bts_via_van_assinante_editar_m/bts_via_van_assinante_editar_m_widget.dart';
import 'dart:io';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'dashboard_resp_via_van_m_widget.dart' show DashboardRespViaVanMWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
