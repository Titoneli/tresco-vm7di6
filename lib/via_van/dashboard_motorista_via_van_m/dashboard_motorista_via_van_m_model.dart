import '/alunos/bts_aluno_adicionar/bts_aluno_adicionar_widget.dart';
import '/backend/supabase/supabase.dart';
import '/backend/api_requests/api_calls.dart';
import '/escolas/bts_turmas/bts_turmas_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/bts_nav_aluno_float/bts_nav_aluno_float_widget.dart';
import '/frame_work/bts_selecione/bts_selecione_widget.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/via_van/bts_via_van_motorista_editar_m/bts_via_van_motorista_editar_m_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'dashboard_motorista_via_van_m_widget.dart'
    show DashboardMotoristaViaVanMWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardMotoristaViaVanMModel
    extends FlutterFlowModel<DashboardMotoristaViaVanMWidget> {
  ///  Local state fields for this page.

  int? paginaAtiva;

  // ViVan API response data
  ApiCallResponse? dashboardResumoResponse;
  ApiCallResponse? dashboardCapacidadeResponse;
  bool isLoadingDashboard = true;

  // Computed fields from API
  int get totalPassageiros => VivanDashboardResumoCall.totalPassageiros(dashboardResumoResponse?.jsonBody) ?? 0;
  int get totalAtivos => VivanDashboardResumoCall.totalAtivos(dashboardResumoResponse?.jsonBody) ?? 0;
  int get totalContratos => VivanDashboardResumoCall.totalContratos(dashboardResumoResponse?.jsonBody) ?? 0;
  double get receitaMensal => VivanDashboardResumoCall.receitaMensal(dashboardResumoResponse?.jsonBody) ?? 0.0;
  double get despesaMensal => VivanDashboardResumoCall.despesaMensal(dashboardResumoResponse?.jsonBody) ?? 0.0;
  double get saldoMensal => VivanDashboardResumoCall.saldoMensal(dashboardResumoResponse?.jsonBody) ?? 0.0;
  int get mensalidadesPendentes => VivanDashboardResumoCall.mensalidadesPendentes(dashboardResumoResponse?.jsonBody) ?? 0;
  int get presencasHoje => VivanDashboardResumoCall.presencasHoje(dashboardResumoResponse?.jsonBody) ?? 0;
  List<dynamic> get escolasCapacidade => VivanDashboardCapacidadeCall.escolas(dashboardCapacidadeResponse?.jsonBody) ?? [];
  int get capacidadeTotal => VivanDashboardCapacidadeCall.capacidadeTotal(dashboardCapacidadeResponse?.jsonBody) ?? 0;
  int get ocupacaoTotal => VivanDashboardCapacidadeCall.ocupacaoTotal(dashboardCapacidadeResponse?.jsonBody) ?? 0;

  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
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
