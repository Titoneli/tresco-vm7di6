import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/vivan/models/vivan_models.dart';
import 'package:intl/intl.dart';

class MensalidadesTabModel extends ChangeNotifier {
  // ── State ────────────────────────────────────
  bool isLoading = false;
  String? errorMessage;
  List<VivanMensalidade> mensalidades = [];
  List<VivanMensalidade> get filteredMensalidades {
    var list = mensalidades.where((m) {
      if (_searchQuery.isNotEmpty) {
        final nome = m.nomePassageiro?.toLowerCase() ?? '';
        if (!nome.contains(_searchQuery.toLowerCase())) return false;
      }
      return true;
    }).toList();
    return list;
  }

  // ── Month navigation ────────────────────────
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  String get selectedMonthLabel {
    final months = ['JAN','FEV','MAR','ABR','MAI','JUN','JUL','AGO','SET','OUT','NOV','DEZ'];
    return months[selectedMonth - 1];
  }

  String get mesReferencia =>
      '${selectedMonth.toString().padLeft(2, '0')}/$selectedYear';

  // ── Search ──────────────────────────────────
  String _searchQuery = '';
  TextEditingController searchController = TextEditingController();
  void updateSearch(String query) { _searchQuery = query; notifyListeners(); }

  // ── Filters ─────────────────────────────────
  int filterYear = DateTime.now().year;
  Set<String> filterStatus = {'PAGO', 'PENDENTE', 'ATRASADO', 'ABONADO', 'AGUARDANDO', 'PAGO_ATRASO'};
  Set<String> filterPeriodo = {'Manhã', 'Tarde', 'Noite', 'Integral'};

  // ── Summary ─────────────────────────────────
  double get totalAcumulado => mensalidades.fold(0, (s, m) => s + (m.valOriginal ?? 0));
  int get totalMensalidades => mensalidades.length;
  int get qtdPagas => mensalidades.where((m) => m.isPago).length;
  double get valPagas => mensalidades.where((m) => m.isPago).fold(0, (s, m) => s + (m.valPago ?? m.valOriginal ?? 0));
  int get qtdAVencer => mensalidades.where((m) => m.isPendente).length;
  double get valAVencer => mensalidades.where((m) => m.isPendente).fold(0, (s, m) => s + (m.valOriginal ?? 0));
  int get qtdVencidas => mensalidades.where((m) => m.isAtrasado).length;
  double get valVencidas => mensalidades.where((m) => m.isAtrasado).fold(0, (s, m) => s + (m.valOriginal ?? 0));
  int get qtdAbonadas => mensalidades.where((m) => m.isAbonado).length;
  double get valAbonadas => mensalidades.where((m) => m.isAbonado).fold(0, (s, m) => s + (m.valOriginal ?? 0));

  // ── Data loading ────────────────────────────
  Future<void> loadMensalidades(int motoristaId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      // Query principal sem JOINs — evita erro caso FKs não estejam configuradas
      final rows = await SupaFlow.client
          .from('vivan_mensalidades')
          .select()
          .eq('idMotorista', motoristaId)
          .eq('mesReferencia', mesReferencia)
          .order('idMensalidade');

      final rawList = (rows as List)
          .map((r) => Map<String, dynamic>.from(r as Map))
          .toList();

      // Busca nomes dos passageiros em paralelo (query separada, mais segura)
      final passIds = rawList
          .map((r) => r['idPassageiro'] as int?)
          .whereType<int>()
          .toSet()
          .toList();
      if (passIds.isNotEmpty) {
        try {
          final passRows = await SupaFlow.client
              .from('vivan_passageiros')
              .select('idPassageiro, nomePassageiro')
              .inFilter('idPassageiro', passIds);
          final Map<int, String> nomes = {};
          for (final r in passRows as List) {
            final id = r['idPassageiro'] as int?;
            final nome = r['nomePassageiro']?.toString();
            if (id != null && nome != null) nomes[id] = nome;
          }
          for (final r in rawList) {
            final passId = r['idPassageiro'] as int?;
            if (passId != null && nomes.containsKey(passId)) {
              r['nomePassageiro'] = nomes[passId];
            }
          }
        } catch (_) {}
      }

      mensalidades = rawList
          .map((r) => VivanMensalidade.fromJson(r))
          .toList();
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('MensalidadesTab.loadMensalidades: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  // ── Pagamento manual ────────────────────────
  Future<void> pagamentoManual(
    int mensalidadeId, {
    required double valorPago,
    required String formaPagamento,
    String? dtVencimento,
  }) async {
    final hoje = DateTime.now();
    final dtPagamento = DateFormat('yyyy-MM-dd').format(hoje);
    String status = 'PAGO';
    if (dtVencimento != null) {
      final venc = DateTime.tryParse(dtVencimento);
      if (venc != null && hoje.isAfter(venc)) status = 'PAGO_ATRASO';
    }
    await SupaFlow.client
        .from('vivan_mensalidades')
        .update({
          'valPago': valorPago,
          'formaPagamento': formaPagamento,
          'dtPagamento': dtPagamento,
          'status': status,
        })
        .eq('idMensalidade', mensalidadeId)
        .eq('idMotorista', FFAppState().idUsuario);
  }

  void changeMonth(int month) {
    selectedMonth = month;
    notifyListeners();
  }

  void applyFilters(int year, Set<String> status, Set<String> periodo) {
    filterYear = year;
    filterStatus = status;
    filterPeriodo = periodo;
    selectedYear = year;
    notifyListeners();
  }

  // ── Format helpers ──────────────────────────
  String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(dt);
    } catch (_) {
      return dateStr;
    }
  }

  String statusLabel(VivanMensalidade m) {
    if (m.isPago) return 'paga';
    if (m.isAbonado) return 'abonada';
    if (m.isAtrasado) return 'vencida';
    return 'a vencer';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
