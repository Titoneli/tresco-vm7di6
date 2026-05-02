import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vivan/vivan.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mensalidades_tab_model.dart';
export 'mensalidades_tab_model.dart';

class MensalidadesTabWidget extends StatefulWidget {
  const MensalidadesTabWidget({super.key});
  @override
  State<MensalidadesTabWidget> createState() => _MensalidadesTabWidgetState();
}

class _MensalidadesTabWidgetState extends State<MensalidadesTabWidget> {
  late MensalidadesTabModel _model;
  static const _r = 8.0;

  @override
  void initState() {
    super.initState();
    _model = MensalidadesTabModel();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reload());
  }

  @override
  void dispose() { _model.dispose(); super.dispose(); }

  void _reload() => _model.loadMensalidades(FFAppState().idUsuario);

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _model,
      builder: (context, _) => Column(children: [
        // Month tabs
        _buildMonthTabs(),
        // Search
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _model.searchController,
            onChanged: _model.updateSearch,
            style: GoogleFonts.inter(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Buscar passageiro', hintStyle: GoogleFonts.inter(fontSize: 14, color: FlutterFlowTheme.of(context).secondaryText),
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true, fillColor: _bg,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(_r), borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(_r), borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
          ),
        ),
        // Summary card
        _buildSummaryCard(),
        // List
        Expanded(
          child: _model.isLoading
              ? Center(child: CircularProgressIndicator(color: _primary))
              : _model.filteredMensalidades.isEmpty
                  ? Center(child: Text('Nenhuma mensalidade encontrada', style: GoogleFonts.inter(color: FlutterFlowTheme.of(context).secondaryText)))
                  : RefreshIndicator(
                      color: _primary,
                      onRefresh: () async => _reload(),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: _model.filteredMensalidades.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (ctx, i) => _buildMensalidadeItem(_model.filteredMensalidades[i]),
                      ),
                    ),
        ),
      ]),
    );
  }

  Widget _buildMonthTabs() {
    final months = ['JAN','FEV','MAR','ABR','MAI','JUN','JUL','AGO','SET','OUT','NOV','DEZ'];
    return SizedBox(height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, itemCount: 12,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (ctx, i) {
          final isSelected = i + 1 == _model.selectedMonth;
          return GestureDetector(
            onTap: () { _model.changeMonth(i + 1); _reload(); },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(border: isSelected ? Border(bottom: BorderSide(color: _primary, width: 2)) : null),
              child: Text(months[i], style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).secondaryText)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF2D3748), borderRadius: BorderRadius.circular(_r)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_model.formatCurrency(_model.totalAcumulado), style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              Text('VALOR ACUMULADO', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
            ])),
            Container(width: 1, height: 40, color: Colors.white24),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${_model.totalMensalidades}', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              Text('MENSALIDADES', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
            ]),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF4A5568), borderRadius: BorderRadius.vertical(bottom: Radius.circular(_r))),
          child: Column(children: [
            _summaryRow('Pagas', _model.qtdPagas, _model.valPagas),
            const SizedBox(height: 4),
            _summaryRow('A Vencer', _model.qtdAVencer, _model.valAVencer),
            const SizedBox(height: 4),
            _summaryRow('Vencidas', _model.qtdVencidas, _model.valVencidas),
            const SizedBox(height: 4),
            _summaryRow('Abonadas', _model.qtdAbonadas, _model.valAbonadas),
          ]),
        ),
      ]),
    );
  }

  Widget _summaryRow(String label, int qty, double value) {
    return Row(children: [
      Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 14, color: Colors.white))),
      Text('$qty', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      const SizedBox(width: 24),
      Text(_model.formatCurrency(value), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
    ]);
  }

  Widget _buildMensalidadeItem(VivanMensalidade m) {
    final statusText = _model.statusLabel(m);
    final isPago = m.isPago;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(isPago ? Icons.check_circle : Icons.access_time, size: 24,
              color: isPago ? FlutterFlowTheme.of(context).success : FlutterFlowTheme.of(context).secondaryText),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(m.nomePassageiro ?? '', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                child: Text(statusText, style: GoogleFonts.inter(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText))),
              if (m.formaPagamento != null) ...[
                const SizedBox(width: 6),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                  child: Text(m.formaPagamento!.toLowerCase(), style: GoogleFonts.inter(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText))),
              ],
            ]),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Row(children: [
              Text(_model.formatCurrency(m.valOriginal ?? 0), style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, size: 20),
            ]),
            Text(_model.formatDate(m.dtVencimento), style: GoogleFonts.inter(fontSize: 13, color: FlutterFlowTheme.of(context).secondaryText)),
          ]),
        ]),
        if (!isPago) ...[
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: FFButtonWidget(
              onPressed: () => _showLembreteOptions(m),
              text: 'Lembrete',
              options: FFButtonOptions(height: 40,
                color: _bg,
                textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: _primary),
                elevation: 0, borderSide: BorderSide(color: _primary, width: 1.5),
                borderRadius: BorderRadius.circular(20)),
            )),
            const SizedBox(width: 12),
            Expanded(child: FFButtonWidget(
              onPressed: () => _showPagouBottomSheet(m),
              text: 'Pagou',
              options: FFButtonOptions(height: 40,
                color: _primary,
                textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                elevation: 0, borderRadius: BorderRadius.circular(20)),
            )),
          ]),
        ],
      ]),
    );
  }

  // ── PAGOU BOTTOM SHEET ─────────────────────────────
  void _showPagouBottomSheet(VivanMensalidade m) {
    String? selectedForma;
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: _bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(_r * 2))),
      builder: (ctx) => StatefulBuilder(builder: (ctx, setSheetState) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Informar Pagamento', style: GoogleFonts.inter(fontSize: 16, color: FlutterFlowTheme.of(context).secondaryText)),
          const SizedBox(height: 12),
          Text(m.nomePassageiro ?? '', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700)),
          Text('Vencimento: ${_model.formatDate(m.dtVencimento)}', style: GoogleFonts.inter(fontSize: 14, color: FlutterFlowTheme.of(context).secondaryText)),
          const SizedBox(height: 8),
          Text(_model.formatCurrency(m.valOriginal ?? 0), style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(height: 48, width: 200,
              decoration: BoxDecoration(border: Border.all(color: _primary, width: 1.5), borderRadius: BorderRadius.circular(_r)),
              alignment: Alignment.center,
              child: Text('Hoje', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: _primary))),
          ),
          const SizedBox(height: 16),
          Text('Como foi o pago?', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: ['Pix', 'Dinheiro', 'Cartão de Crédito', 'Cartão de Débito', 'Boleto', 'Outro'].map((forma) {
            final isSelected = selectedForma == forma;
            return GestureDetector(
              onTap: () => setSheetState(() => selectedForma = forma),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? _primary : _bg,
                  border: Border.all(color: _primary, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
                child: Text(forma, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : _primary)),
              ),
            );
          }).toList()),
          const SizedBox(height: 20),
          FFButtonWidget(
            onPressed: selectedForma == null ? null : () async {
              try {
                await VivanLocator.service.pagamentoManual(m.idMensalidade!,
                    valorPago: m.valOriginal ?? 0,
                    formaPagamento: selectedForma!);
                if (ctx.mounted) Navigator.pop(ctx);
                _reload();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Pagamento registrado!'), backgroundColor: FlutterFlowTheme.of(context).success));
                }
              } catch (e) {
                if (ctx.mounted) ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Erro: $e')));
              }
            },
            text: 'Confirmar pagamento',
            options: FFButtonOptions(width: double.infinity, height: 48,
              color: selectedForma != null ? _primary : _primary.withValues(alpha: 0.4),
              textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              elevation: 0, borderRadius: BorderRadius.circular(_r)),
          ),
        ]),
      )));
  }

  // ── LEMBRETE ───────────────────────────────────────
  void _showLembreteOptions(VivanMensalidade m) {
    final msg ='Olá! Lembrete de mensalidade do transporte escolar.\n'
        'Passageiro: ${m.nomePassageiro}\n'
        'Valor: ${_model.formatCurrency(m.valOriginal ?? 0)}\n'
        'Vencimento: ${_model.formatDate(m.dtVencimento)}';
    final encodedMsg = Uri.encodeComponent(msg);
    final url = 'https://wa.me/?text=$encodedMsg';
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  // ── FILTROS BOTTOM SHEET ───────────────────────────
  void showFilters() {
    int tempYear = _model.filterYear;
    final tempStatus = Set<String>.from(_model.filterStatus);
    final tempPeriodo = Set<String>.from(_model.filterPeriodo);
    final statusOptions = [
      ('Mensalidades Pagas', 'PAGO'),
      ('Mensalidades A Vencer', 'PENDENTE'),
      ('Mensalidades Vencidas', 'ATRASADO'),
      ('Mensalidades Abonadas', 'ABONADO'),
    ];
    final periodoOptions = ['Manhã', 'Tarde', 'Noite', 'Integral'];

    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: _bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(_r * 2))),
      builder: (ctx) => StatefulBuilder(builder: (ctx, setSheetState) => DraggableScrollableSheet(
        initialChildSize: 0.85, maxChildSize: 0.95, minChildSize: 0.5, expand: false,
        builder: (ctx, scrollCtrl) => SingleChildScrollView(
          controller: scrollCtrl,
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(onTap: () => Navigator.pop(ctx),
                  child: Text('Fechar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: _primary))),
              Text('Filtrar', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(width: 60),
            ]),
            Divider(height: 24, color: _primary.withValues(alpha: 0.3)),
            Text('Selecione as opções abaixo para mudar a visão da tela de mensalidades.',
                style: GoogleFonts.inter(fontSize: 14, color: FlutterFlowTheme.of(context).secondaryText), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text('Ano Base de Exibição', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                int tempYearPick = tempYear;
                showCupertinoModalPopup(context: ctx, builder: (_) => Container(height: 250, color: _bg,
                  child: Column(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 44,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        GestureDetector(onTap: () => Navigator.pop(ctx),
                            child: Text('Fechar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500))),
                        GestureDetector(onTap: () { setSheetState(() => tempYear = tempYearPick); Navigator.pop(ctx); },
                            child: Text('Selecionar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: _primary))),
                      ])),
                    Expanded(child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(initialItem: tempYear - 2020),
                        itemExtent: 40, onSelectedItemChanged: (i) => tempYearPick = 2020 + i,
                        children: List.generate(16, (i) => Center(child: Text('${2020 + i}', style: GoogleFonts.inter(fontSize: 18)))))),
                  ])));
              },
              child: Container(height: 48, width: double.infinity,
                decoration: BoxDecoration(border: Border.all(color: _primary, width: 1.5), borderRadius: BorderRadius.circular(_r)),
                alignment: Alignment.center,
                child: Text('$tempYear', style: GoogleFonts.inter(fontSize: 16, color: _primary))),
            ),
            Divider(height: 32, color: Colors.grey.shade300),
            Text('Status da Mensalidade', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...statusOptions.map((opt) => Column(children: [
              InkWell(
                onTap: () => setSheetState(() { tempStatus.contains(opt.$2) ? tempStatus.remove(opt.$2) : tempStatus.add(opt.$2); }),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(opt.$1, style: GoogleFonts.inter(fontSize: 15)),
                    if (tempStatus.contains(opt.$2)) Icon(Icons.check, color: _primary),
                  ])),
              ),
              Divider(height: 1, color: Colors.grey.shade200),
            ])),
            Divider(height: 32, color: Colors.grey.shade300),
            Text('Período', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...periodoOptions.map((p) => Column(children: [
              InkWell(
                onTap: () => setSheetState(() { tempPeriodo.contains(p) ? tempPeriodo.remove(p) : tempPeriodo.add(p); }),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(p, style: GoogleFonts.inter(fontSize: 15)),
                    if (tempPeriodo.contains(p)) Icon(Icons.check, color: _primary),
                  ])),
              ),
              Divider(height: 1, color: Colors.grey.shade200),
            ])),
            const SizedBox(height: 16),
            FFButtonWidget(
              onPressed: () {
                _model.applyFilters(tempYear, tempStatus, tempPeriodo);
                Navigator.pop(ctx);
                _reload();
              },
              text: 'Aplicar Filtros',
              options: FFButtonOptions(width: double.infinity, height: 48,
                color: _primary,
                textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                elevation: 0, borderRadius: BorderRadius.circular(_r)),
            ),
          ]),
        ),
      )));
  }
}
