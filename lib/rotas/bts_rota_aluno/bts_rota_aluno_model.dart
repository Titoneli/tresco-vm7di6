import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'bts_rota_aluno_widget.dart' show BtsRotaAlunoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsRotaAlunoModel extends FlutterFlowModel<BtsRotaAlunoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // Stores action output result for [Backend Call - Query Rows] action in ddwEscola widget.
  List<EscolaRow>? apiResBuscaEscola;
  // State field(s) for ddwVeiculo widget.
  int? ddwVeiculoValue;
  FormFieldController<int>? ddwVeiculoValueController;
  // Stores action output result for [Backend Call - Query Rows] action in ddwVeiculo widget.
  List<VeiculoRow>? apiResBuscaVeiculo;
  // Stores action output result for [Backend Call - Query Rows] action in ddwVeiculo widget.
  List<AlunoRow>? apiResAlunos;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
