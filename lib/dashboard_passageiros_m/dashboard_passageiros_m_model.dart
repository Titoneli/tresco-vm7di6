import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'package:flutter/material.dart';
import 'dashboard_passageiros_m_widget.dart'
    show DashboardPassageirosMWidget;

class DashboardPassageirosMModel
    extends FlutterFlowModel<DashboardPassageirosMWidget> {
  final unfocusNode = FocusNode();
  int paginaAtiva = 0;
  PageController? pageViewController;

  // Home tab data
  int totalEscolas = 0;
  int totalPassageiros = 0;
  double totalAReceber = 0.0;
  List<VivanMensalidade> mensalidadesEmAberto = [];
  bool isLoadingHome = true;
  bool hasError = false;

  Future<void> fetchHomeData(int motoristaId) async {
    if (motoristaId == 0) motoristaId = FFAppState().idUsuario;
    if (motoristaId == 0) { isLoadingHome = false; return; }
    isLoadingHome = true;
    try {
      hasError = false;

      final raw = await SupaFlow.client.rpc(
        'vivan_dashboard_home',
        params: {'p_motorista_id': motoristaId},
      );
      final data = (raw is List ? raw.first : raw) as Map<String, dynamic>;

      totalPassageiros = (data['passageiros_ativos'] as num?)?.toInt() ?? 0;
      totalEscolas     = (data['total_escolas']      as num?)?.toInt() ?? 0;
      totalAReceber    = (data['total_a_receber']    as num?)?.toDouble() ?? 0.0;

      final mensRaw = data['mensalidades'] as List<dynamic>? ?? [];
      mensalidadesEmAberto = mensRaw
          .map((e) => VivanMensalidade.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Erro fetchHomeData RPC: $e');
      hasError = true;
    } finally {
      isLoadingHome = false;
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    pageViewController?.dispose();
  }
}
