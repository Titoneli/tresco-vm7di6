import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EscolasMWidget extends StatefulWidget {
  const EscolasMWidget({super.key});

  @override
  State<EscolasMWidget> createState() => _EscolasMWidgetState();
}

class _EscolasMWidgetState extends State<EscolasMWidget> {
  bool _loading = true;
  List<_Escola> _escolas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final motoristaId = FFAppState().idUsuario;
      final rows = await SupaFlow.client
          .from('vivan_escolas')
          .select('idEscola, nomeEscola')
          .eq('idMotorista', motoristaId)
          .order('nomeEscola', ascending: true) as List;

      _escolas = rows.map((r) {
        final m = r as Map;
        return _Escola(
          id: (m['idEscola'] as int?) ?? 0,
          nome: m['nomeEscola']?.toString() ?? '',
        );
      }).toList();
    } catch (e) {
      debugPrint('EscolasMWidget._load: $e');
      _escolas = [];
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _adicionar(String nome) async {
    try {
      final motoristaId = FFAppState().idUsuario;
      await SupaFlow.client.from('vivan_escolas').insert({
        'idMotorista': motoristaId,
        'nomeEscola': nome.trim(),
      });
      await _load();
    } catch (e) {
      debugPrint('EscolasMWidget._adicionar: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao adicionar escola')));
      }
    }
  }

  Future<void> _editar(int idEscola, String novoNome) async {
    try {
      await SupaFlow.client
          .from('vivan_escolas')
          .update({'nomeEscola': novoNome.trim()})
          .eq('idEscola', idEscola);
      await _load();
    } catch (e) {
      debugPrint('EscolasMWidget._editar: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao editar escola')));
      }
    }
  }

  Future<void> _excluir(int idEscola) async {
    try {
      await SupaFlow.client
          .from('vivan_escolas')
          .delete()
          .eq('idEscola', idEscola);
      await _load();
    } catch (e) {
      debugPrint('EscolasMWidget._excluir: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao excluir escola')));
      }
    }
  }

  void _showEscolaDialog({_Escola? escola}) {
    final ctrl = TextEditingController(text: escola?.nome ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          escola == null ? 'Nova Escola' : 'Editar Escola',
          style: GoogleFonts.interTight(fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Nome da escola',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancelar',
                style: GoogleFonts.inter(
                    color: FlutterFlowTheme.of(context).secondaryText)),
          ),
          TextButton(
            onPressed: () {
              final nome = ctrl.text.trim();
              if (nome.isEmpty) return;
              Navigator.pop(ctx);
              if (escola == null) {
                _adicionar(nome);
              } else {
                _editar(escola.id, nome);
              }
            },
            child: Text('Salvar',
                style: GoogleFonts.inter(
                    color: FlutterFlowTheme.of(context).primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _confirmarExclusao(_Escola escola) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Excluir escola',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
        content: Text('Deseja excluir "${escola.nome}"?',
            style: GoogleFonts.inter()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancelar',
                style: GoogleFonts.inter(
                    color: FlutterFlowTheme.of(context).secondaryText)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _excluir(escola.id);
            },
            child: Text('Excluir',
                style: GoogleFonts.inter(
                    color: Colors.red.shade400, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Voltar',
              style: GoogleFonts.inter(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w500)),
        ),
        leadingWidth: 80,
        title: Text('Minhas Escolas',
            style: GoogleFonts.interTight(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: FlutterFlowTheme.of(context).primaryText)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEscolaDialog(),
        backgroundColor: FlutterFlowTheme.of(context).primary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primary, strokeWidth: 2))
          : _escolas.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.school_outlined,
                          size: 52,
                          color: FlutterFlowTheme.of(context).secondaryText),
                      const SizedBox(height: 12),
                      Text('Nenhuma escola cadastrada',
                          style: GoogleFonts.inter(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 15)),
                      const SizedBox(height: 6),
                      Text('Toque em + para adicionar',
                          style: GoogleFonts.inter(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 13)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                  itemCount: _escolas.length,
                  itemBuilder: (context, i) {
                    final escola = _escolas[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => _showEscolaDialog(escola: escola),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.school_rounded,
                                      size: 20,
                                      color:
                                          FlutterFlowTheme.of(context).primary),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    escola.nome,
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit_outlined,
                                      size: 18,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText),
                                  onPressed: () =>
                                      _showEscolaDialog(escola: escola),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outline_rounded,
                                      size: 18, color: Colors.red.shade300),
                                  onPressed: () => _confirmarExclusao(escola),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class _Escola {
  final int id;
  final String nome;
  const _Escola({required this.id, required this.nome});
}
