import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';

class PassageiroTabItem {
  final int id;
  final int? idMotorista;
  final String nome;
  final String? escola;
  final String? periodo;
  final String? foto;

  PassageiroTabItem({
    required this.id,
    this.idMotorista,
    required this.nome,
    this.escola,
    this.periodo,
    this.foto,
  });

  factory PassageiroTabItem.fromJson(Map<String, dynamic> j) =>
      PassageiroTabItem(
        id: int.tryParse(j['idPassageiro']?.toString() ?? '0') ?? 0,
        idMotorista: int.tryParse(j['idMotorista']?.toString() ?? ''),
        nome: j['nomePassageiro']?.toString() ?? '',
        escola: j['nomeEscola']?.toString(),
        periodo: j['periodo']?.toString(),
        foto: j['fotoPassageiro']?.toString(),
      );

  String get iniciais {
    final partes =
        nome.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (partes.isEmpty) return '?';
    if (partes.length == 1) return partes[0][0].toUpperCase();
    return '${partes[0][0]}${partes[partes.length - 1][0]}'.toUpperCase();
  }
}

class PassageirosTabModel extends ChangeNotifier {
  bool isLoading = false;
  String? erro;

  List<PassageiroTabItem> _todos = [];
  String _busca = '';
  String? periodoFiltro;
  String? escolaFiltro;

  final searchCtrl = TextEditingController();
  final searchFocus = FocusNode();

  List<PassageiroTabItem> get lista {
    var result = _todos;
    if (_busca.isNotEmpty) {
      final q = _busca.toLowerCase();
      result = result.where((p) => p.nome.toLowerCase().contains(q)).toList();
    }
    if (periodoFiltro != null) {
      result = result.where((p) => p.periodo == periodoFiltro).toList();
    }
    if (escolaFiltro != null) {
      result = result.where((p) => p.escola == escolaFiltro).toList();
    }
    return result;
  }

  int get total => lista.length;

  List<String> get periodosDisponiveis =>
      _todos.map((p) => p.periodo).whereType<String>().toSet().toList()..sort();

  List<String> get escolasDisponiveis =>
      _todos.map((p) => p.escola).whereType<String>().toSet().toList()..sort();

  bool get temFiltroAtivo => periodoFiltro != null || escolaFiltro != null;

  void setBusca(String v) {
    _busca = v;
    notifyListeners();
  }

  void setFiltroPeriodo(String? v) {
    periodoFiltro = v;
    notifyListeners();
  }

  void setFiltroEscola(String? v) {
    escolaFiltro = v;
    notifyListeners();
  }

  void limparFiltros() {
    periodoFiltro = null;
    escolaFiltro = null;
    notifyListeners();
  }

  // Consulta Supabase diretamente para garantir filtro real por idMotorista.
  // A API ViVan usa sessão da conta de serviço (398) e não filtra corretamente.
  Future<void> carregar() async {
    isLoading = true;
    erro = null;
    notifyListeners();
    try {
      final rows = await SupaFlow.client
          .from('vivan_passageiros')
          .select('idPassageiro, nomePassageiro, idMotorista, domTurno, vivan_escolas(nomeEscola)')
          .eq('idMotorista', FFAppState().idUsuario)
          .order('nomePassageiro');
      _todos = (rows as List).map((r) {
        final escolaMap = r['vivan_escolas'] as Map?;
        return PassageiroTabItem(
          id: r['idPassageiro'] as int,
          idMotorista: r['idMotorista'] as int?,
          nome: r['nomePassageiro']?.toString() ?? '',
          escola: escolaMap?['nomeEscola']?.toString(),
          periodo: r['domTurno']?.toString(),
        );
      }).toList();
    } catch (e) {
      debugPrint('PassageirosTab.carregar: $e');
      erro = 'Erro ao carregar passageiros';
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}
