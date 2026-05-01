import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'package:flutter/material.dart';
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
      '${selectedYear}-${selectedMonth.toString().padLeft(2, '0')}';

  // ── Summary getters ────────────────────────────────

  double get totalMensalidadesRecebidas => mensalidades
      .where((m) => m.isPago)
      .fold(0.0, (sum, m) => sum + (m.valPago ?? m.valOriginal ?? 0));

  double get totalMensalidadesAReceber => mensalidades
      .where((m) => !m.isPago)
      .fold(0.0, (sum, m) => sum + (m.valOriginal ?? 0));

  double get totalOutrasEntradas => lancamentos
      .where((d) => d.tipoLancamento.toUpperCase() == 'ENTRADA')
      .fold(0.0, (sum, d) => sum + d.valor);

  double get totalDespesas => lancamentos
      .where((d) => d.tipoLancamento.toUpperCase() == 'DESPESA')
      .fold(0.0, (sum, d) => sum + d.valor);

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
        VivanLocator.service.getMensalidades(
          motorista: motoristaId,
          mesReferencia: mesReferencia,
        ),
        VivanLocator.service.getDespesas(
          motorista: motoristaId,
          mesReferencia: mesReferencia,
        ),
      ]);
      mensalidades = (results[0] as VivanPaginatedResponse<VivanMensalidade>).data;
      lancamentos = (results[1] as VivanPaginatedResponse<VivanDespesa>).data;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
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
