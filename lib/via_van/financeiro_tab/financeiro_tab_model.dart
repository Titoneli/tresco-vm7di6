import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/vivan/models/vivan_models.dart';
import 'package:intl/intl.dart';

class FinanceiroTabModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  int filterYear = DateTime.now().year;

  List<VivanDespesa> lancamentos = [];
  List<VivanMensalidade> mensalidades = [];

  final searchController = TextEditingController();

  String get mesReferencia =>
      '${selectedMonth.toString().padLeft(2, '0')}/$selectedYear';

  // ── Summary getters ────────────────────────────────

  double get totalMensalidadesRecebidas => mensalidades
      .where((m) => m.isPago)
      .fold(0.0, (sum, m) => sum + (m.valPago ?? m.valOriginal ?? 0));

  double get totalMensalidadesAReceber => mensalidades
      .where((m) => !m.isPago)
      .fold(0.0, (sum, m) => sum + (m.valOriginal ?? 0));

  double get totalOutrasEntradas => lancamentos
      .where((d) => d.tipoLancamento.toUpperCase() == 'ENTRADA')
      .fold(0.0, (sum, d) => sum + d.valor.abs());

  double get totalDespesas => lancamentos
      .where((d) => d.tipoLancamento.toUpperCase() == 'DESPESA')
      .fold(0.0, (sum, d) => sum + d.valor.abs());

  double get saldo =>
      totalMensalidadesRecebidas + totalOutrasEntradas - totalDespesas;

  // ── Month navigation ───────────────────────────────

  void changeMonth(int month) {
    selectedMonth = month;
    notifyListeners();
  }

  void applyFilters(int year) {
    filterYear = year;
    selectedYear = year;
    notifyListeners();
  }

  // ── Data loading ───────────────────────────────────

  Future<void> loadLancamentos(int motoristaId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        SupaFlow.client
            .from('vivan_mensalidades')
            .select()
            .eq('idMotorista', motoristaId)
            .eq('mesReferencia', mesReferencia),
        SupaFlow.client
            .from('vivan_despesas')
            .select()
            .eq('idMotorista', motoristaId)
            .eq('mesReferencia', mesReferencia)
            .order('dtDespesa', ascending: true),
      ]);
      mensalidades = (results[0] as List)
          .map((r) => VivanMensalidade.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
      lancamentos = (results[1] as List)
          .map((r) => VivanDespesa.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('FinanceiroTab.loadLancamentos: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  // ── Despesas CRUD ──────────────────────────────────

  Future<void> createDespesa(VivanDespesa d) async {
    final body = d.toJson()..remove('idDespesa');
    await SupaFlow.client.from('vivan_despesas').insert(body);
  }

  Future<void> updateDespesa(int idDespesa, VivanDespesa d) async {
    final body = d.toJson()..remove('idDespesa');
    await SupaFlow.client
        .from('vivan_despesas')
        .update(body)
        .eq('idDespesa', idDespesa)
        .eq('idMotorista', FFAppState().idUsuario);
  }

  Future<void> deleteDespesa(int idDespesa) async {
    await SupaFlow.client
        .from('vivan_despesas')
        .delete()
        .eq('idDespesa', idDespesa)
        .eq('idMotorista', FFAppState().idUsuario);
  }

  // ── Helpers ────────────────────────────────────────

  String formatCurrency(double value) {
    final f = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return f.format(value);
  }

  String formatDate(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
