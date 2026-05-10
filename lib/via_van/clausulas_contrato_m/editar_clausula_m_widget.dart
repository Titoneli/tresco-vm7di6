import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'clausula_storage.dart';

class EditarClausulaMWidget extends StatefulWidget {
  const EditarClausulaMWidget({
    super.key,
    required this.clausula,
    required this.todasClausulas,
  });

  final ClausulaModelo clausula;
  final List<ClausulaModelo> todasClausulas;

  @override
  State<EditarClausulaMWidget> createState() => _EditarClausulaMWidgetState();
}

class _EditarClausulaMWidgetState extends State<EditarClausulaMWidget> {
  late final TextEditingController _ctrl;
  bool _isSaving = false;

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _secondBg => FlutterFlowTheme.of(context).secondaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.clausula.texto);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  int get _numero =>
      ClausulaStorage.numeroGlobal(widget.todasClausulas, widget.clausula);

  Future<void> _salvar() async {
    final texto = _ctrl.text.trim();
    if (texto.isEmpty) return;
    setState(() => _isSaving = true);
    try {
      final lista = await ClausulaStorage.load();
      final idx = lista.indexWhere((c) => c.id == widget.clausula.id);
      if (idx >= 0) {
        lista[idx].texto = texto;
        lista[idx].isCustom = true;
      }
      await ClausulaStorage.save(lista);
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _apagar() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Apagar cláusula',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
        content: Text(
            'Tem certeza que deseja apagar a Cláusula $_numero? Esta ação não pode ser desfeita.',
            style: GoogleFonts.inter(fontSize: 14)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600),
            child: const Text('Apagar',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    final lista = await ClausulaStorage.load();
    lista.removeWhere((c) => c.id == widget.clausula.id);
    await ClausulaStorage.save(lista);
    if (mounted) Navigator.pop(context);
  }

  void _inserirVariavel(String variavel) {
    final sel = _ctrl.selection;
    final text = _ctrl.text;
    final pos = sel.isValid ? sel.baseOffset : text.length;
    final newText = text.substring(0, pos) + variavel + text.substring(pos);
    _ctrl.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: pos + variavel.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edite o texto da cláusula. Use os chips abaixo para inserir variáveis que serão substituídas automaticamente no PDF.',
                        style: GoogleFonts.inter(
                            fontSize: 13, color: _secondaryText),
                      ),
                      const SizedBox(height: 16),
                      _infoRow('Seção', widget.clausula.secao),
                      const SizedBox(height: 6),
                      _infoRow('Número', 'Cláusula $_numero'),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _ctrl,
                        maxLines: null,
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.inter(
                            fontSize: 14, color: _primaryText, height: 1.5),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: _secondBg,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: _primary, width: 1.5)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Inserir variável',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _secondaryText)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: ClausulaStorage.variaveis
                            .map((v) => ClausulaVariavelChip(
                                  label: v,
                                  primary: _primary,
                                  onTap: () => _inserirVariavel(v),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _isSaving ? null : _salvar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Text('Salvar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Voltar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      color: _primary)),
          ),
          Expanded(
            child: Center(
              child: Text('Editar Cláusula',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          GestureDetector(
            onTap: _apagar,
            child: Text('Apagar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: Colors.red.shade600)),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _secondaryText),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _primaryText),
          ),
        ],
      ),
    );
  }
}

class ClausulaVariavelChip extends StatelessWidget {
  const ClausulaVariavelChip({
    super.key,
    required this.label,
    required this.primary,
    required this.onTap,
  });

  final String label;
  final Color primary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primary.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: primary),
        ),
      ),
    );
  }
}
