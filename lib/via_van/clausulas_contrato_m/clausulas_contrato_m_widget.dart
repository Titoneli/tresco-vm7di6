import 'dart:io';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import '../_vivan_http.dart';
import 'clausula_storage.dart';
import 'editar_clausula_m_widget.dart';
import 'adicionar_clausula_m_widget.dart';
import 'preview_contrato_m_widget.dart';

class ClausulasContratoMWidget extends StatefulWidget {
  const ClausulasContratoMWidget({
    super.key,
    required this.passageiroId,
    required this.nomePassageiro,
    this.contrato,
  });

  final int passageiroId;
  final String nomePassageiro;
  final VivanContrato? contrato;

  @override
  State<ClausulasContratoMWidget> createState() =>
      _ClausulasContratoMWidgetState();
}

class _ClausulasContratoMWidgetState extends State<ClausulasContratoMWidget> {
  List<ClausulaModelo> _clausulas = [];
  bool _loading = true;

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _secondBg => FlutterFlowTheme.of(context).secondaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = await ClausulaStorage.load();
    if (mounted) setState(() { _clausulas = c; _loading = false; });
  }

  Future<void> _openPreview() async {
    final clausulas = await ClausulaStorage.load();
    final meta = await PdfStorage.getMeta(widget.passageiroId);
    final contrato = widget.contrato;

    if (!mounted) return;

    if (meta != null && await File(meta.filePath).exists()) {
      final stale = await PdfStorage.isStale(widget.passageiroId, clausulas);
      if (!mounted) return;
      if (stale) {
        final gerar = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Cláusulas alteradas',
                style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
            content: Text(
              'As cláusulas foram alteradas desde ${DateFormat('dd/MM/yyyy').format(meta.geradoEm)}. Deseja gerar um novo PDF com as cláusulas atuais?',
              style: GoogleFonts.inter(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Não, usar o antigo'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary),
                child: Text('Sim, gerar novo',
                    style: GoogleFonts.inter(color: Colors.white)),
              ),
            ],
          ),
        );
        if (!mounted) return;
        if (gerar == true) {
          _navigateToPreview(null, contrato);
        } else {
          _navigateToPreview(meta.filePath, contrato);
        }
      } else {
        _navigateToPreview(meta.filePath, contrato);
      }
    } else {
      _navigateToPreview(null, contrato);
    }
  }

  void _navigateToPreview(String? pdfPath, VivanContrato? contrato) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewContratoMWidget(
          passageiroId: widget.passageiroId,
          nomePassageiro: widget.nomePassageiro,
          pdfPath: pdfPath,
          nomeResponsavel: contrato?.nomeResponsavel ?? '',
          valMensal: contrato?.valMensal,
          dtInicio: contrato?.dtInicio != null
              ? DateTime.tryParse(contrato!.dtInicio!)
              : null,
          dtTermino: contrato?.dtTermino != null
              ? DateTime.tryParse(contrato!.dtTermino!)
              : null,
          diaVencimento: contrato?.diaVencimento,
        ),
      ),
    ).then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              if (_loading)
                Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                          color: _primary, strokeWidth: 2)),
                )
              else
                Expanded(child: _buildContent()),
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
              child: Text('Gerenciar Cláusulas',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          GestureDetector(
            onTap: _adicionarClausula,
            child: Text('Adicionar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: _primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Descrição + botões
        Container(
          color: _secondBg,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edite, adicione ou remova cláusulas. As alterações serão aplicadas nos próximos contratos gerados.',
                style: GoogleFonts.inter(fontSize: 13, color: _secondaryText),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _openPreview,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _primary,
                        side: BorderSide(color: _primary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text('Ver Modelo',
                          style: GoogleFonts.inter(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _showComoUsar,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _primaryText,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text('Como Usar?',
                          style: GoogleFonts.inter(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Seção financeira
        if (widget.contrato != null) _buildFinanceiroCard(),
        // Lista de cláusulas
        Expanded(child: _buildClausulasList()),
      ],
    );
  }

  Widget _buildFinanceiroCard() {
    final contrato = widget.contrato!;
    final valor = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        .format(contrato.valMensal ?? 0);
    final dia = contrato.diaVencimento ?? 5;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _secondBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: _primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dados Financeiros',
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _secondaryText)),
                const SizedBox(height: 2),
                Text('$valor · Vence dia $dia',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _primaryText)),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showEditarFinanceiro,
            child: Icon(Icons.edit_outlined, color: _primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildClausulasList() {
    final items = <Widget>[];

    for (final secao in ClausulaStorage.secoes) {
      // Cabeçalho da seção
      items.add(_SectionHeader(key: ValueKey('header_$secao'), secao: secao));

      final daSec = _clausulas.where((c) => c.secao == secao).toList();
      if (daSec.isEmpty) {
        items.add(_EmptySection(key: ValueKey('empty_$secao')));
      } else {
        for (final c in daSec) {
          items.add(_ClausulaRow(
            key: ValueKey(c.id),
            clausula: c,
            numero: ClausulaStorage.numeroGlobal(_clausulas, c),
            primary: _primary,
            primaryText: _primaryText,
            secondaryText: _secondaryText,
            onTap: () => _editarClausula(c),
          ));
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: items,
    );
  }

  Future<void> _adicionarClausula() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdicionarClausulaMWidget(clausulas: _clausulas),
      ),
    );
    await _load();
  }

  Future<void> _editarClausula(ClausulaModelo c) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarClausulaMWidget(
          clausula: c,
          todasClausulas: _clausulas,
        ),
      ),
    );
    await _load();
  }

  void _showComoUsar() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Como usar as cláusulas',
                style: GoogleFonts.interTight(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _primaryText)),
            const SizedBox(height: 16),
            Text(
              '• Toque em uma cláusula para editar o texto.\n\n'
              '• Use "Adicionar" para criar uma cláusula nova em qualquer seção.\n\n'
              '• Nas telas de edição, use os chips de variáveis (ex: [VALOR_TOTAL]) para inserir dados do contrato automaticamente.\n\n'
              '• Toque "Ver Modelo" para gerar e visualizar o PDF com as cláusulas atuais.\n\n'
              '• Para voltar ao modelo original, use "Voltar Modelo Padrão" na tela anterior.',
              style: GoogleFonts.inter(fontSize: 14, color: _secondaryText),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Text('Entendi',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditarFinanceiro() {
    final contrato = widget.contrato;
    if (contrato == null || contrato.idContrato == null) return;

    final valorCtrl = TextEditingController(
        text: contrato.valMensal?.toStringAsFixed(2) ?? '');
    int? diaVenc = contrato.diaVencimento;
    bool isSaving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.fromLTRB(
              24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dados Financeiros',
                  style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _primaryText)),
              const SizedBox(height: 16),
              Text('Valor Mensal (R\$)',
                  style: GoogleFonts.inter(fontSize: 13, color: _secondaryText)),
              const SizedBox(height: 6),
              TextFormField(
                controller: valorCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '0,00',
                  prefixText: 'R\$ ',
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _primary, width: 1.5)),
                ),
              ),
              const SizedBox(height: 16),
              Text('Dia de Vencimento',
                  style: GoogleFonts.inter(fontSize: 13, color: _secondaryText)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  int? temp = diaVenc;
                  await showModalBottomSheet(
                    context: ctx,
                    backgroundColor: _bg,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (_) => StatefulBuilder(
                      builder: (_, setD) => Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Dia de Vencimento',
                                style: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: _primaryText)),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 180,
                              child: ListWheelScrollView.useDelegate(
                                itemExtent: 44,
                                physics: const FixedExtentScrollPhysics(),
                                controller: FixedExtentScrollController(
                                    initialItem: (temp ?? 1) - 1),
                                onSelectedItemChanged: (i) =>
                                    setD(() => temp = i + 1),
                                childDelegate:
                                    ListWheelChildBuilderDelegate(
                                  childCount: 28,
                                  builder: (_, i) => Center(
                                    child: Text('Dia ${i + 1}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: temp == i + 1
                                                ? _primary
                                                : _secondaryText,
                                            fontWeight: temp == i + 1
                                                ? FontWeight.w700
                                                : FontWeight.normal)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                setSheet(() => diaVenc = temp ?? 1);
                                Navigator.pop(ctx);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _primary,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: const Text('Confirmar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    diaVenc != null ? 'Dia $diaVenc de cada mês' : 'Selecionar',
                    style: GoogleFonts.inter(
                        color: diaVenc != null ? _primaryText : _secondaryText),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        final valor = double.tryParse(
                            valorCtrl.text.replaceAll(',', '.'));
                        if (valor == null) return;
                        setSheet(() => isSaving = true);
                        try {
                          await VivanHttp.put(
                              '/contratos/${contrato.idContrato}', {
                            'valMensal': valor,
                            if (diaVenc != null) 'diaVencimento': diaVenc,
                          });
                          if (ctx.mounted) Navigator.pop(ctx);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text('Contrato atualizado!'),
                                backgroundColor: _primary));
                          }
                        } catch (e) {
                          setSheet(() => isSaving = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                content: Text(
                                    'Erro: ${e.toString().replaceFirst('Exception: ', '')}')));
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Salvar',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({super.key, required this.secao});
  final String secao;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        secao,
        style: GoogleFonts.interTight(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: FlutterFlowTheme.of(context).primaryText,
            letterSpacing: 0.5),
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(
        'Nenhuma cláusula nesta seção',
        style: GoogleFonts.inter(
            fontSize: 13,
            color: FlutterFlowTheme.of(context).secondaryText,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}

class _ClausulaRow extends StatelessWidget {
  const _ClausulaRow({
    super.key,
    required this.clausula,
    required this.numero,
    required this.primary,
    required this.primaryText,
    required this.secondaryText,
    required this.onTap,
  });

  final ClausulaModelo clausula;
  final int numero;
  final Color primary;
  final Color primaryText;
  final Color secondaryText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cláusula $numero${clausula.isCustom ? ' ·' : ''}',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: primary),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    clausula.texto,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: secondaryText, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }
}
