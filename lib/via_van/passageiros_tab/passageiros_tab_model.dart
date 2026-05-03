import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/via_van/_vivan_http.dart';

class PassageiroTabItem {
  final int id;
  final String nome;
  final String? escola;
  final String? periodo;
  final String? foto;

  PassageiroTabItem({
    required this.id,
    required this.nome,
    this.escola,
    this.periodo,
    this.foto,
  });

  factory PassageiroTabItem.fromJson(Map<String, dynamic> j) =>
      PassageiroTabItem(
        id: int.tryParse(j['idPassageiro']?.toString() ?? '0') ?? 0,
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

  Future<void> carregar() async {
    isLoading = true;
    erro = null;
    notifyListeners();
    try {
      final json = await VivanHttp.get('/passageiros?motorista=${FFAppState().idUsuario}');
      final data = (json is Map ? json['data'] : json) as List? ?? [];
      _todos = data
          .map((e) => PassageiroTabItem.fromJson(e as Map<String, dynamic>))
          .toList();
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
