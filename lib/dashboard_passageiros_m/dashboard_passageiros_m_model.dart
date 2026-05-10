import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'package:flutter/material.dart';
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
  int totalPassageiros = 0;
  List<VivanMensalidade> mensalidadesEmAberto = [];
  bool isLoadingHome = false;

  double get totalAReceber =>
      mensalidadesEmAberto.fold(0.0, (sum, m) => sum + (m.valOriginal ?? 0));

  String get mesReferenciaApiFormat =>
      DateFormat('MM/yyyy').format(DateTime.now());

  Future<void> fetchHomeData(int motoristaId) async {
    if (motoristaId == 0) motoristaId = FFAppState().idUsuario;
    if (motoristaId == 0) return;
    isLoadingHome = true;
    try {
      final results = await Future.wait([
        VivanLocator.service.getDashboardResumo(motoristaId, mesReferenciaApiFormat),
        VivanLocator.service.getEscolas(motoristaId),
        VivanLocator.service.getMensalidades(
          motorista: motoristaId,
          mesReferencia: mesReferenciaApiFormat,
        ),
        VivanLocator.service.getPassageiros(motorista: motoristaId, limit: 200),
      ]);
      homeResumo = results[0] as VivanDashboardResumo;
      totalEscolas = (results[1] as List<VivanEscola>).length;
      final allMens = (results[2] as VivanPaginatedResponse<VivanMensalidade>).data;
      mensalidadesEmAberto = allMens.where((m) => !m.isPago && !m.isAbonado).toList();
      totalPassageiros = (results[3] as VivanPaginatedResponse<VivanPassageiro>).data.length;
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
