import '/alunos/bts_aluno_adicionar/bts_aluno_adicionar_widget.dart';
import '/backend/supabase/supabase.dart';
import '/vivan/vivan.dart';
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
  VivanDashboardResumo? dashboardResumo;
  VivanCapacidade? dashboardCapacidade;
  bool isLoadingDashboard = true;

  // Computed fields from API
  int get totalPassageiros => dashboardResumo?.totalPassageiros ?? 0;
  int get totalAtivos => dashboardResumo?.passageirosAtivos ?? 0;
  int get totalContratos => dashboardResumo?.totalContratos ?? 0;
  double get receitaMensal => dashboardResumo?.totalRecebido ?? 0.0;
  double get despesaMensal => dashboardResumo?.totalDespesas ?? 0.0;
  double get saldoMensal => dashboardResumo?.saldoMes ?? 0.0;
  int get mensalidadesPendentes => dashboardResumo?.mensalidadesPendentes ?? 0;
  int get mensalidadesAtrasadas => dashboardResumo?.mensalidadesAtrasadas ?? 0;
  int get capacidadeTotal => dashboardCapacidade?.capacidadeVeiculo ?? 0;
  String get placaVeiculo => dashboardCapacidade?.placaVeiculo ?? '';
  Map<String, int> get ocupacaoPorTurno => dashboardCapacidade?.ocupacao ?? {};

  /// Fetch dashboard data from API
  Future<void> fetchDashboardData(int motoristaId) async {
    isLoadingDashboard = true;
    final mesRef = DateFormat('MM/yyyy').format(DateTime.now());
    try {
      final results = await Future.wait([
        VivanLocator.service.getDashboardResumo(motoristaId, mesRef),
        VivanLocator.service.getCapacidade(motoristaId),
      ]);
      dashboardResumo = results[0] as VivanDashboardResumo;
      dashboardCapacidade = results[1] as VivanCapacidade;
    } catch (e) {
      debugPrint('Erro ao buscar dashboard: $e');
    }
    isLoadingDashboard = false;
  }

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
