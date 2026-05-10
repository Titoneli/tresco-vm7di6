import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'clausula_storage.dart';
import 'editar_clausula_m_widget.dart' show ClausulaVariavelChip;

class AdicionarClausulaMWidget extends StatefulWidget {
  const AdicionarClausulaMWidget({
    super.key,
    required this.clausulas,
  });

  final List<ClausulaModelo> clausulas;

  @override
  State<AdicionarClausulaMWidget> createState() =>
      _AdicionarClausulaMWidgetState();
}

class _AdicionarClausulaMWidgetState extends State<AdicionarClausulaMWidget> {
  String? _secaoSelecionada;
  final _ctrl = TextEditingController();
  bool _isSaving = false;

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _secondBg => FlutterFlowTheme.of(context).secondaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _secaoSelecionada != null && _ctrl.text.trim().isNotEmpty && !_isSaving;

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

  Future<void> _salvar() async {
    if (!_canSave) return;
    setState(() => _isSaving = true);
    try {
      final lista = await ClausulaStorage.load();
      final id = 'custom_${DateTime.now().millisecondsSinceEpoch}';
      lista.add(ClausulaModelo(
        id: id,
        secao: _secaoSelecionada!,
        texto: _ctrl.text.trim(),
        isCustom: true,
      ));
      await ClausulaStorage.save(lista);
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSecaoPicker() {
    int selectedIdx = _secaoSelecionada != null
        ? ClausulaStorage.secoes.indexOf(_secaoSelecionada!)
        : 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Text('Fechar',
                        style: TextStyle(color: _primary, fontSize: 16)),
                  ),
                  Text('Selecionar Seção',
                      style: TextStyle(
                          color: _primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () {
                      setState(() => _secaoSelecionada =
                          ClausulaStorage.secoes[selectedIdx]);
                      Navigator.pop(ctx);
                    },
                    child: Text('Selecionar',
                        style: TextStyle(
                            color: _primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            SizedBox(
              height: 220,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 44,
                physics: const FixedExtentScrollPhysics(),
                controller:
                    FixedExtentScrollController(initialItem: selectedIdx),
                onSelectedItemChanged: (i) => setSheet(() => selectedIdx = i),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: ClausulaStorage.secoes.length,
                  builder: (_, i) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        ClausulaStorage.secoes[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: selectedIdx == i ? _primary : _secondaryText,
                          fontWeight: selectedIdx == i
                              ? FontWeight.w700
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
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
                        'Selecione a seção e escreva o texto da nova cláusula. Use os chips para inserir variáveis automáticas.',
                        style: GoogleFonts.inter(
                            fontSize: 13, color: _secondaryText),
                      ),
                      const SizedBox(height: 20),
                      // Picker de seção
                      GestureDetector(
                        onTap: _showSecaoPicker,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: _secondBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _secaoSelecionada != null
                                  ? _primary
                                  : Colors.grey.shade200,
                              width: _secaoSelecionada != null ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _secaoSelecionada ?? 'Selecione a seção',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: _secaoSelecionada != null
                                        ? _primaryText
                                        : _secondaryText,
                                  ),
                                ),
                              ),
                              Icon(Icons.expand_more,
                                  color: _secondaryText, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Campo de texto
                      TextFormField(
                        controller: _ctrl,
                        maxLines: null,
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.inter(
                            fontSize: 14, color: _primaryText, height: 1.5),
                        decoration: InputDecoration(
                          hintText: 'Digite o texto da cláusula...',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 14, color: _secondaryText),
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
                        onPressed: _canSave ? _salvar : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          disabledBackgroundColor: Colors.grey.shade300,
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
              child: Text('Adicionar Cláusula',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }
}
