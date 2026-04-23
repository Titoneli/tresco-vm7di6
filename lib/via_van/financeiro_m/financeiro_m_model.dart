import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'financeiro_m_widget.dart' show FinanceiroMWidget;
import 'package:flutter/material.dart';

class FinanceiroMModel extends FlutterFlowModel<FinanceiroMWidget> {
  int tabIndex = 0;

  // Mensalidades
  bool isLoadingMensalidades = true;
  List<VivanMensalidade> mensalidades = [];
  double get totalMensalidades =>
      mensalidades.fold(0.0, (sum, m) => sum + m.valorLiquido);

  // Despesas
  bool isLoadingDespesas = true;
  List<VivanDespesa> despesas = [];
  double get totalDespesas =>
      despesas.fold(0.0, (sum, d) => sum + d.valor);

  // Tab controller
  TabController? tabBarController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }

  Future<void> fetchMensalidades(int motoristaId, {String? mes, String? status}) async {
    isLoadingMensalidades = true;
    try {
      final result = await VivanLocator.service.getMensalidades(
        motorista: motoristaId,
        mesReferencia: mes,
        status: status,
      );
      mensalidades = result.data;
    } catch (e) {
      debugPrint('Erro ao buscar mensalidades: $e');
      mensalidades = [];
    }
    isLoadingMensalidades = false;
  }

  Future<void> fetchDespesas(int motoristaId, {String? mes}) async {
    isLoadingDespesas = true;
    try {
      final result = await VivanLocator.service.getDespesas(
        motorista: motoristaId,
        mesReferencia: mes,
      );
      despesas = result.data;
    } catch (e) {
      debugPrint('Erro ao buscar despesas: $e');
      despesas = [];
    }
    isLoadingDespesas = false;
  }

  Future<bool> pagarManual(int mensalidadeId, double valor, String forma) async {
    try {
      await VivanLocator.service.pagamentoManual(
        mensalidadeId,
        valorPago: valor,
        formaPagamento: forma,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> abonar(int mensalidadeId, String motivo) async {
    try {
      await VivanLocator.service.abonarMensalidade(mensalidadeId, motivo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDespesa(int despesaId) async {
    try {
      await VivanLocator.service.deleteDespesa(despesaId);
      despesas.removeWhere((d) => d.idDespesa == despesaId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
