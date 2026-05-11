import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import 'passageiros_lista_m_widget.dart' show PassageirosListaMWidget;

class PassageiroItem {
  final int id;
  final String nome;
  final String? escola;
  final String? periodo;
  final String? foto;

  PassageiroItem({
    required this.id,
    required this.nome,
    this.escola,
    this.periodo,
    this.foto,
  });

  factory PassageiroItem.fromJson(Map<String, dynamic> j) => PassageiroItem(
        id: int.tryParse(j['idPassageiro']?.toString() ?? '0') ?? 0,
        nome: j['nomePassageiro']?.toString() ?? '',
        escola: j['nomeEscola']?.toString(),
        periodo: j['periodo']?.toString(),
        foto: j['fotoPassageiro']?.toString(),
      );

  String get iniciais {
    final partes = nome.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (partes.isEmpty) return '?';
    if (partes.length == 1) return partes[0][0].toUpperCase();
    return '${partes[0][0]}${partes[partes.length - 1][0]}'.toUpperCase();
  }
}

class PassageirosListaMModel
    extends FlutterFlowModel<PassageirosListaMWidget> {
  bool isLoading = false;
  String? erro;

  List<PassageiroItem> _todos = [];

  String _busca = '';
  String? periodoFiltro;
  String? escolaFiltro;

  final searchCtrl = TextEditingController();
  final searchFocus = FocusNode();

  List<PassageiroItem> get lista {
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

  void setBusca(String v) => _busca = v;

  bool get temFiltroAtivo => periodoFiltro != null || escolaFiltro != null;

  void limparFiltros() {
    periodoFiltro = null;
    escolaFiltro = null;
  }

  // Consulta Supabase diretamente para garantir filtro real por idMotorista.
  // A API ViVan usa sessão da conta de serviço (398) e não filtra corretamente.
  Future<void> carregar() async {
    isLoading = true;
    erro = null;
    try {
      final rows = await SupaFlow.client
          .from('vivan_passageiros')
          .select('idPassageiro, nomePassageiro, domTurno, vivan_escolas(nomeEscola)')
          .eq('idMotorista', FFAppState().idUsuario)
          .order('nomePassageiro');
      _todos = (rows as List).map((r) {
        final escolaMap = r['vivan_escolas'] as Map?;
        return PassageiroItem(
          id: r['idPassageiro'] as int,
          nome: r['nomePassageiro']?.toString() ?? '',
          escola: escolaMap?['nomeEscola']?.toString(),
          periodo: r['domTurno']?.toString(),
        );
      }).toList();
    } catch (e) {
      debugPrint('PassageirosLista.carregar: $e');
      erro = 'Erro ao carregar passageiros';
    }
    isLoading = false;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchCtrl.dispose();
    searchFocus.dispose();
  }
}
