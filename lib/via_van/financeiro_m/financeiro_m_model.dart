import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/models/vivan_models.dart';
import '/backend/supabase/supabase.dart';
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
      var query = SupaFlow.client
          .from('vivan_mensalidades')
          .select()
          .eq('idMotorista', motoristaId);
      if (mes != null) query = query.eq('mesReferencia', mes);
      if (status != null) query = query.eq('status', status);
      final rows = await query.order('dtVencimento').limit(500);
      mensalidades = (rows as List)
          .map((r) => VivanMensalidade.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      debugPrint('FinanceiroM.fetchMensalidades: $e');
      mensalidades = [];
    }
    isLoadingMensalidades = false;
  }

  Future<void> fetchDespesas(int motoristaId, {String? mes}) async {
    isLoadingDespesas = true;
    try {
      var query = SupaFlow.client
          .from('vivan_despesas')
          .select()
          .eq('idMotorista', motoristaId);
      if (mes != null) query = query.eq('mesReferencia', mes);
      final rows = await query.order('dtVencimento').limit(500);
      despesas = (rows as List)
          .map((r) => VivanDespesa.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      debugPrint('FinanceiroM.fetchDespesas: $e');
      despesas = [];
    }
    isLoadingDespesas = false;
  }

  Future<bool> pagarManual(int mensalidadeId, double valor, String forma, {String? dtVencimento}) async {
    try {
      final hoje = DateTime.now();
      final venc = dtVencimento != null ? DateTime.tryParse(dtVencimento) : null;
      final statusPgto = (venc != null && hoje.isAfter(venc)) ? 'PAGO_ATRASO' : 'PAGO';
      await SupaFlow.client.from('vivan_mensalidades').update({
        'valPago': valor,
        'formaPagamento': forma,
        'dtPagamento': DateFormat('yyyy-MM-dd').format(hoje),
        'status': statusPgto,
      }).eq('idMensalidade', mensalidadeId).eq('idMotorista', FFAppState().idUsuario);
      return true;
    } catch (e) {
      debugPrint('FinanceiroM.pagarManual: $e');
      return false;
    }
  }

  Future<bool> abonar(int mensalidadeId, String motivo) async {
    try {
      await SupaFlow.client.from('vivan_mensalidades').update({
        'status': 'ABONADO',
        'motivoAbono': motivo,
      }).eq('idMensalidade', mensalidadeId).eq('idMotorista', FFAppState().idUsuario);
      return true;
    } catch (e) {
      debugPrint('FinanceiroM.abonar: $e');
      return false;
    }
  }

  Future<bool> cancelarAbono(int mensalidadeId) async {
    try {
      await SupaFlow.client.from('vivan_mensalidades').update({
        'status': 'PENDENTE',
        'motivoAbono': null,
      }).eq('idMensalidade', mensalidadeId).eq('idMotorista', FFAppState().idUsuario);
      return true;
    } catch (e) {
      debugPrint('FinanceiroM.cancelarAbono: $e');
      return false;
    }
  }

  Future<bool> deleteDespesa(int despesaId) async {
    try {
      await SupaFlow.client.from('vivan_despesas').delete()
          .eq('idDespesa', despesaId)
          .eq('idMotorista', FFAppState().idUsuario);
      despesas.removeWhere((d) => d.idDespesa == despesaId);
      return true;
    } catch (e) {
      debugPrint('FinanceiroM.deleteDespesa: $e');
      return false;
    }
  }
}
