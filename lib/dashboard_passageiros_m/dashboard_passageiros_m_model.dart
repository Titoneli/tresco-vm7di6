import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/models/vivan_models.dart';
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
    hasError = false;
    try {
      final mesAtual = DateFormat('MM/yyyy').format(DateTime.now());

      final results = await Future.wait([
        SupaFlow.client
            .from('vivan_passageiros')
            .select('idPassageiro')
            .eq('idMotorista', motoristaId),
        SupaFlow.client
            .from('vivan_escolas')
            .select('idEscola')
            .eq('idMotorista', motoristaId),
        SupaFlow.client
            .from('vivan_mensalidades')
            .select()
            .eq('idMotorista', motoristaId)
            .inFilter('status', ['PENDENTE', 'ATRASADO'])
            .eq('mesReferencia', mesAtual)
            .order('dtVencimento')
            .limit(50),
      ]);

      totalPassageiros = (results[0] as List).length;
      totalEscolas     = (results[1] as List).length;

      final mens = results[2] as List;
      mensalidadesEmAberto = mens
          .map((r) => VivanMensalidade.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
      totalAReceber = mensalidadesEmAberto.fold(0.0, (s, m) => s + (m.valOriginal ?? 0));
    } catch (e) {
      debugPrint('DashboardPassageiros.fetchHomeData: $e');
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
