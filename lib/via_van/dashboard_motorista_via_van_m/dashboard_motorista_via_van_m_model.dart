import '/alunos/bts_aluno_adicionar/bts_aluno_adicionar_widget.dart';
import '/backend/supabase/supabase.dart';
import '/vivan/models/vivan_models.dart';
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

  /// Fetch dashboard data via Supabase RPC + direct queries
  Future<void> fetchDashboardData(int motoristaId) async {
    isLoadingDashboard = true;
    final mesRef = DateFormat('MM/yyyy').format(DateTime.now());
    try {
      final results = await Future.wait([
        _fetchResumo(motoristaId, mesRef),
        _fetchCapacidade(motoristaId),
      ]);
      dashboardResumo = results[0] as VivanDashboardResumo?;
      dashboardCapacidade = results[1] as VivanCapacidade?;
    } catch (e) {
      debugPrint('DashboardMotoristaViVan.fetchDashboardData: $e');
    }
    isLoadingDashboard = false;
  }

  Future<VivanDashboardResumo?> _fetchResumo(int motoristaId, String mesRef) async {
    try {
      final result = await SupaFlow.client.rpc(
        'vivan_dashboard_motorista_resumo',
        params: {'p_motorista_id': motoristaId, 'p_mes_referencia': mesRef},
      );
      if (result == null) return null;
      return VivanDashboardResumo.fromJson(Map<String, dynamic>.from(result as Map));
    } catch (e) {
      debugPrint('DashboardMotoristaViVan._fetchResumo: $e');
      return null;
    }
  }

  Future<VivanCapacidade?> _fetchCapacidade(int motoristaId) async {
    try {
      // Ocupação por turno: conta passageiros agrupados por domTurno em Dart
      final passRows = await SupaFlow.client
          .from('vivan_passageiros')
          .select('domTurno')
          .eq('idMotorista', motoristaId);
      final ocupacao = <String, int>{};
      for (final r in passRows as List) {
        final turno = (r as Map)['domTurno']?.toString() ?? 'Indefinido';
        ocupacao[turno] = (ocupacao[turno] ?? 0) + 1;
      }

      // Dados do veículo (tabela pode não existir — ignora se falhar)
      Map<String, dynamic>? veiculo;
      try {
        final veicRows = await SupaFlow.client
            .from('vivan_veiculos')
            .select('capacidade, placa')
            .eq('idMotorista', motoristaId)
            .limit(1);
        if ((veicRows as List).isNotEmpty) {
          veiculo = Map<String, dynamic>.from(veicRows.first as Map);
        }
      } catch (_) {}

      return VivanCapacidade(veiculo: veiculo, ocupacao: ocupacao);
    } catch (e) {
      debugPrint('DashboardMotoristaViVan._fetchCapacidade: $e');
      return null;
    }
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
