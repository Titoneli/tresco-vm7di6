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

  Future<void> _abrirForm({_Escola? escola}) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => _EscolaFormPage(escola: escola)),
    );
    if (result == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final primary = FlutterFlowTheme.of(context).primary;
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Voltar',
              style: GoogleFonts.inter(
                  color: primary, fontWeight: FontWeight.w500)),
        ),
        leadingWidth: 80,
        title: Text('Minhas Escolas',
            style: GoogleFonts.interTight(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: primary)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _abrirForm(),
            child: Text('+',
                style: GoogleFonts.inter(
                    fontSize: 24,
                    color: primary,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(color: primary, strokeWidth: 2))
          : _escolas.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.school_outlined,
                          size: 52,
                          color:
                              FlutterFlowTheme.of(context).secondaryText),
                      const SizedBox(height: 12),
                      Text('Nenhuma escola cadastrada',
                          style: GoogleFonts.inter(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryText,
                              fontSize: 15)),
                      const SizedBox(height: 6),
                      Text('Toque em + para adicionar',
                          style: GoogleFonts.inter(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryText,
                              fontSize: 13)),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: _escolas.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: Colors.grey.shade200),
                  itemBuilder: (context, i) {
                    final escola = _escolas[i];
                    return InkWell(
                      onTap: () => _abrirForm(escola: escola),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                escola.nome,
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText),
                              ),
                            ),
                            Icon(Icons.chevron_right_rounded,
                                size: 20,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

// ── Tela de formulário (add / edit) ──────────────────────────────────────────

class _EscolaFormPage extends StatefulWidget {
  const _EscolaFormPage({this.escola});
  final _Escola? escola;

  @override
  State<_EscolaFormPage> createState() => _EscolaFormPageState();
}

class _EscolaFormPageState extends State<_EscolaFormPage> {
  late final TextEditingController _ctrl;
  bool _saving = false;

  bool get _isEdit => widget.escola != null;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.escola?.nome ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    final nome = _ctrl.text.trim();
    if (nome.isEmpty) return;
    setState(() => _saving = true);
    try {
      final motoristaId = FFAppState().idUsuario;
      if (_isEdit) {
        await SupaFlow.client
            .from('vivan_escolas')
            .update({'nomeEscola': nome})
            .eq('idEscola', widget.escola!.id);
      } else {
        await SupaFlow.client.from('vivan_escolas').insert({
          'idMotorista': motoristaId,
          'nomeEscola': nome,
        });
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      debugPrint('_EscolaFormPage._salvar: $e');
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao salvar escola')));
      }
    }
  }

  void _confirmarDeletar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Deletar Escola?',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
        content: const Text('Deseja realmente deletar essa escola?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Não',
                style: GoogleFonts.inter(
                    color: FlutterFlowTheme.of(context).primary,
                    fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _deletar();
            },
            child: Text('Sim',
                style: GoogleFonts.inter(
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<void> _deletar() async {
    try {
      await SupaFlow.client
          .from('vivan_escolas')
          .delete()
          .eq('idEscola', widget.escola!.id);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      debugPrint('_EscolaFormPage._deletar: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao deletar escola')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = FlutterFlowTheme.of(context).primary;
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Voltar',
              style: GoogleFonts.inter(
                  color: primary, fontWeight: FontWeight.w500)),
        ),
        leadingWidth: 80,
        title: Text(
          _isEdit ? 'Editar Escola' : 'Nova Escola',
          style: GoogleFonts.interTight(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: FlutterFlowTheme.of(context).primaryText),
        ),
        centerTitle: true,
        actions: _isEdit
            ? [
                TextButton(
                  onPressed: _confirmarDeletar,
                  child: Text('Deletar',
                      style: GoogleFonts.inter(
                          color: Colors.red.shade400,
                          fontWeight: FontWeight.w500)),
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Escola',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: FlutterFlowTheme.of(context).secondaryText)),
            const SizedBox(height: 8),
            TextField(
              controller: _ctrl,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              style: GoogleFonts.inter(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Nome da escola',
                hintStyle: GoogleFonts.inter(
                    color: FlutterFlowTheme.of(context).secondaryText),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primary, width: 1.5)),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : Text('Salvar',
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Modelo local ──────────────────────────────────────────────────────────────

class _Escola {
  final int id;
  final String nome;
  const _Escola({required this.id, required this.nome});
}
