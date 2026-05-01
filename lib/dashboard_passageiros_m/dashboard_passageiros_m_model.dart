import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dashboard_passageiros_m_widget.dart'
    show DashboardPassageirosMWidget;

class DashboardPassageirosMModel
    extends FlutterFlowModel<DashboardPassageirosMWidget> {
  final unfocusNode = FocusNode();
  int paginaAtiva = 0;
  bool isLoading = true;
  PageController? pageViewController;

  // Home tab data
  VivanDashboardResumo? homeResumo;
  int totalEscolas = 0;
  List<VivanMensalidade> mensalidadesEmAberto = [];
  bool isLoadingHome = false;

  int get totalPassageiros => homeResumo?.totalPassageiros ?? 0;
  double get totalAReceber => homeResumo?.totalAReceber ?? 0;

  String get mesReferenciaAtual =>
      DateFormat('yyyy-MM').format(DateTime.now());
  String get mesReferenciaApiFormat =>
      DateFormat('MM/yyyy').format(DateTime.now());

  Future<void> fetchHomeData(int motoristaId) async {
    isLoadingHome = true;
    try {
      final results = await Future.wait([
        VivanLocator.service.getDashboardResumo(motoristaId, mesReferenciaApiFormat),
        VivanLocator.service.getEscolas(motoristaId),
        VivanLocator.service.getMensalidades(
          motorista: motoristaId,
          mesReferencia: mesReferenciaAtual,
        ),
      ]);
      homeResumo = results[0] as VivanDashboardResumo;
      totalEscolas = (results[1] as List<VivanEscola>).length;
      final allMens = (results[2] as VivanPaginatedResponse<VivanMensalidade>).data;
      mensalidadesEmAberto = allMens.where((m) => !m.isPago && !m.isAbonado).toList();
    } catch (e) {
      debugPrint('Erro fetchHomeData: $e');
    }
    isLoadingHome = false;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    pageViewController?.dispose();
  }
}
