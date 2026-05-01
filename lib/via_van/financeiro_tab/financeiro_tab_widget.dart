import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vivan/vivan.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'financeiro_tab_model.dart';
export 'financeiro_tab_model.dart';

class FinanceiroTabWidget extends StatefulWidget {
  const FinanceiroTabWidget({super.key});
  @override
  State<FinanceiroTabWidget> createState() => _FinanceiroTabWidgetState();
}

class _FinanceiroTabWidgetState extends State<FinanceiroTabWidget> {
  late FinanceiroTabModel _model;
  static const _r = 8.0;

  static const _despesaCategorias = [
    ('Salário', Icons.wallet),
    ('Combustível', Icons.local_gas_station),
    ('Manutenção do veículo', Icons.build),
    ('Vistorias', Icons.fact_check),
    ('Despesas gerais', Icons.calculate),
    ('Documento do veículo', Icons.badge),
  ];

  static const _entradaCategorias = [
    ('Transporte eventual', Icons.directions_bus),
    ('Fretamento', Icons.place),
    ('Salário', Icons.payments),
    ('Multa contratual', Icons.description),
    ('Atividades esportivas', Icons.sports_soccer),
    ('Outros', Icons.account_balance_wallet),
  ];

  IconData _iconForCategoria(String? cat) {
    for (final c in _despesaCategorias) {
      if (c.$1 == cat) return c.$2;
    }
    for (final c in _entradaCategorias) {
      if (c.$1 == cat) return c.$2;
    }
    return Icons.attach_money;
  }

  @override
  void initState() {
    super.initState();
    _model = FinanceiroTabModel();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reload());
  }

  @override
  void dispose() { _model.dispose(); super.dispose(); }

  void _reload() => _model.loadLancamentos(FFAppState().idUsuario);

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _model,
      builder: (context, _) => Column(children: [
        _buildMonthTabs(),
        Expanded(
          child: _model.isLoading
              ? Center(child: CircularProgressIndicator(color: _primary))
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(height: 12),
                    _buildSummaryCard(),
                    const SizedBox(height: 16),
                    _buildAddButton(),
                    const SizedBox(height: 16),
                    _buildLancamentosList(),
                    const SizedBox(height: 24),
                  ]),
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
    final green = const Color(0xFF48BB78);
    final red = const Color(0xFFF56565);
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF2D3748), borderRadius: BorderRadius.circular(_r)),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _summaryLine('Mensalidades Recebidas', _model.totalMensalidadesRecebidas, green),
        const SizedBox(height: 8),
        _summaryLine('Mensalidades à Receber', _model.totalMensalidadesAReceber, Colors.white),
        const SizedBox(height: 8),
        _summaryLine('Outras Entradas', _model.totalOutrasEntradas, green),
        Divider(height: 24, color: Colors.white24),
        _summaryLine('Despesas', _model.totalDespesas, red),
        Divider(height: 24, color: Colors.white24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Saldo', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
          Text(_model.formatCurrency(_model.saldo),
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700,
                  color: _model.saldo >= 0 ? green : red)),
        ]),
      ]),
    );
  }

  Widget _summaryLine(String label, double value, Color valueColor) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
      Text(_model.formatCurrency(value), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: valueColor)),
    ]);
  }

  Widget _buildAddButton() {
    return FFButtonWidget(
      onPressed: () => _showLancamentoForm(null),
      text: 'Adicionar Lançamento',
      icon: const Icon(Icons.add, size: 20, color: Colors.white),
      options: FFButtonOptions(width: double.infinity, height: 48,
        color: _primary,
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        elevation: 0, borderRadius: BorderRadius.circular(_r)),
    );
  }

  Widget _buildLancamentosList() {
    if (_model.lancamentos.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(child: Text('Nenhum lançamento encontrado no período',
            style: GoogleFonts.inter(color: FlutterFlowTheme.of(context).secondaryText))),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Todos Lançamentos',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700,
              color: FlutterFlowTheme.of(context).primaryText)),
      const SizedBox(height: 8),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _model.lancamentos.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (ctx, i) {
          final d = _model.lancamentos[i];
          final isDespesa = d.tipoLancamento.toUpperCase() == 'DESPESA';
          final iconColor = isDespesa ? const Color(0xFFF56565) : const Color(0xFF48BB78);
          final dateStr = d.dtDespesa.isNotEmpty
              ? _formatDisplayDate(d.dtDespesa)
              : (d.dtVencimento != null ? _formatDisplayDate(d.dtVencimento!) : '');
          return InkWell(
            onTap: () => _showLancamentoDetalhe(d),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_iconForCategoria(d.categoria), size: 22, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(d.categoria.isNotEmpty ? d.categoria : (d.descricao.isNotEmpty ? d.descricao : '—'),
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                  if (d.descricao.isNotEmpty && d.descricao != d.categoria)
                    Text(d.descricao,
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText)),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('${isDespesa ? "- " : "+ "}${_model.formatCurrency(d.valor)}',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: iconColor)),
                  if (dateStr.isNotEmpty)
                    Text(dateStr,
                        style: GoogleFonts.inter(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText)),
                ]),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, size: 18, color: FlutterFlowTheme.of(context).secondaryText),
              ]),
            ),
          );
        },
      ),
    ]);
  }

  String _formatDisplayDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    } catch (_) {
      return iso;
    }
  }

  void _showLancamentoDetalhe(VivanDespesa d) {
    final isDespesa = d.tipoLancamento.toUpperCase() == 'DESPESA';
    final valueColor = isDespesa ? const Color(0xFFF56565) : const Color(0xFF48BB78);
    final dateStr = d.dtDespesa.isNotEmpty
        ? _formatDisplayDate(d.dtDespesa)
        : (d.dtVencimento != null ? _formatDisplayDate(d.dtVencimento!) : '—');

    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: _bg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(ctx).viewInsets.bottom + 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              color: valueColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(_iconForCategoria(d.categoria), size: 36, color: valueColor),
          ),
          const SizedBox(height: 16),
          Text(d.categoria.isNotEmpty ? d.categoria : '—',
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          if (d.descricao.isNotEmpty && d.descricao != d.categoria)
            Text(d.descricao, textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 14, color: FlutterFlowTheme.of(context).secondaryText)),
          const SizedBox(height: 12),
          Text('${isDespesa ? "- " : "+ "}${_model.formatCurrency(d.valor)}',
              style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: valueColor)),
          const SizedBox(height: 4),
          Text(dateStr, style: GoogleFonts.inter(fontSize: 14, color: FlutterFlowTheme.of(context).secondaryText)),
          const SizedBox(height: 32),
          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () { Navigator.pop(ctx); _showLancamentoForm(d); },
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text('Editar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _primary, side: BorderSide(color: _primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_r)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () { Navigator.pop(ctx); _confirmarApagar(d); },
                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.white),
                label: const Text('Apagar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF56565), foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_r)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  void _confirmarApagar(VivanDespesa d) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Apagar lançamento', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        content: Text('Deseja realmente apagar este lançamento?', style: GoogleFonts.inter(fontSize: 15)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Não', style: GoogleFonts.inter(fontWeight: FontWeight.w600,
                color: FlutterFlowTheme.of(context).secondaryText)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await VivanLocator.service.deleteDespesa(d.idDespesa!);
                _reload();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Lançamento apagado.'),
                      backgroundColor: FlutterFlowTheme.of(context).success));
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Erro ao apagar: $e'),
                      backgroundColor: Colors.red));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF56565), foregroundColor: Colors.white, elevation: 0,
              textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
            ),
            child: const Text('Sim, apagar'),
          ),
        ],
      ),
    );
  }

  void _showLancamentoForm(VivanDespesa? editing) {
    final isEdit = editing != null;
    bool isDespesa = isEdit ? editing.tipoLancamento.toUpperCase() == 'DESPESA' : true;
    String? selectedCategoria = isEdit ? editing.categoria : null;
    bool isRecorrente = isEdit ? editing.recorrente : false;
    int mesInicial = _model.selectedMonth;
    int mesFinal = _model.selectedMonth;
    int diaVencimento = isEdit ? (editing.diaVencimento ?? 10) : 10;
    DateTime dataPagamento = isEdit && editing.dtDespesa.isNotEmpty
        ? (DateTime.tryParse(editing.dtDespesa) ?? DateTime.now())
        : DateTime.now();
    final valorCtrl = TextEditingController(
        text: isEdit ? editing.valor.toStringAsFixed(2).replaceAll('.', ',') : '');
    final descricaoCtrl = TextEditingController(
        text: isEdit ? editing.descricao : '');

    bool isSaving = false;
    String? erroSalvar;

    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: _bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(_r * 2))),
      builder: (ctx) => StatefulBuilder(builder: (ctx, setSheetState) {
        final categorias = isDespesa ? _despesaCategorias : _entradaCategorias;
        return DraggableScrollableSheet(
          initialChildSize: 0.9, maxChildSize: 0.95, minChildSize: 0.5, expand: false,
          builder: (ctx, scrollCtrl) => SingleChildScrollView(
            controller: scrollCtrl,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: Text(isEdit ? 'Editar Lançamento' : 'Adicionar Lançamento',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700))),
              const SizedBox(height: 16),
              Container(
                height: 44, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(22)),
                child: Row(children: [
                  Expanded(child: GestureDetector(
                    onTap: () => setSheetState(() { isDespesa = true; selectedCategoria = null; }),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: isDespesa ? _primary : Colors.transparent, borderRadius: BorderRadius.circular(22)),
                      child: Text('Despesa (-)', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                          color: isDespesa ? Colors.white : FlutterFlowTheme.of(context).secondaryText)),
                    ),
                  )),
                  Expanded(child: GestureDetector(
                    onTap: () => setSheetState(() { isDespesa = false; selectedCategoria = null; }),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: !isDespesa ? _primary : Colors.transparent, borderRadius: BorderRadius.circular(22)),
                      child: Text('Entrada (+)', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                          color: !isDespesa ? Colors.white : FlutterFlowTheme.of(context).secondaryText)),
                    ),
                  )),
                ]),
              ),
              const SizedBox(height: 16),
              Text('Selecione o tipo da despesa', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 3, shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1.1,
                children: categorias.map((cat) {
                  final isSelected = selectedCategoria == cat.$1;
                  return GestureDetector(
                    onTap: () => setSheetState(() => selectedCategoria = cat.$1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? _primary.withOpacity(0.1) : _bg,
                        border: Border.all(color: isSelected ? _primary : Colors.grey.shade300, width: isSelected ? 2 : 1),
                        borderRadius: BorderRadius.circular(_r)),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(cat.$2, size: 28, color: isSelected ? _primary : FlutterFlowTheme.of(context).secondaryText),
                        const SizedBox(height: 6),
                        Text(cat.$1, textAlign: TextAlign.center,
                            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500,
                                color: isSelected ? _primary : FlutterFlowTheme.of(context).primaryText)),
                      ]),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text('Informe o valor total do lançamento', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              TextField(
                controller: valorCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: GoogleFonts.inter(fontSize: 16),
                decoration: InputDecoration(
                  hintText: '0,00', hintStyle: GoogleFonts.inter(fontSize: 16, color: FlutterFlowTheme.of(context).secondaryText),
                  prefixText: 'R\$ ', prefixStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                  filled: true, fillColor: _bg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(_r), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(_r), borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
              ),
              const SizedBox(height: 16),
              Text('Frequência', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Container(
                height: 44, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(22)),
                child: Row(children: [
                  Expanded(child: GestureDetector(
                    onTap: () => setSheetState(() => isRecorrente = false),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: !isRecorrente ? _primary : Colors.transparent, borderRadius: BorderRadius.circular(22)),
                      child: Text('Única', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                          color: !isRecorrente ? Colors.white : FlutterFlowTheme.of(context).secondaryText)),
                    ),
                  )),
                  Expanded(child: GestureDetector(
                    onTap: () => setSheetState(() => isRecorrente = true),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: isRecorrente ? _primary : Colors.transparent, borderRadius: BorderRadius.circular(22)),
                      child: Text('Recorrente', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                          color: isRecorrente ? Colors.white : FlutterFlowTheme.of(context).secondaryText)),
                    ),
                  )),
                ]),
              ),
              const SizedBox(height: 16),
              if (isRecorrente) ...[
                Row(children: [
                  Expanded(child: _pickerField('Mês Inicial', _monthLabel(mesInicial), () {
                    _showMonthPicker(ctx, mesInicial, (v) => setSheetState(() => mesInicial = v));
                  })),
                  const SizedBox(width: 12),
                  Expanded(child: _pickerField('Mês Final', _monthLabel(mesFinal), () {
                    _showMonthPicker(ctx, mesFinal, (v) => setSheetState(() => mesFinal = v));
                  })),
                ]),
                const SizedBox(height: 12),
                _pickerField('Dia de vencimento', '$diaVencimento', () {
                  _showDayPicker(ctx, diaVencimento, (v) => setSheetState(() => diaVencimento = v));
                }),
              ] else ...[
                _pickerField('Data do Pagamento', _formatDisplayDate(dataPagamento.toIso8601String()), () async {
                  final picked = await showDatePicker(context: ctx, initialDate: dataPagamento,
                    firstDate: DateTime(2020), lastDate: DateTime(2035));
                  if (picked != null) setSheetState(() => dataPagamento = picked);
                }),
              ],
              const SizedBox(height: 16),
              Text('Descrição do lançamento', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              TextField(
                controller: descricaoCtrl, maxLines: 3,
                style: GoogleFonts.inter(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Descreva o lançamento...', hintStyle: GoogleFonts.inter(fontSize: 14, color: FlutterFlowTheme.of(context).secondaryText),
                  filled: true, fillColor: _bg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(_r), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(_r), borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
              ),
              const SizedBox(height: 16),
              if (erroSalvar != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(_r),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(erroSalvar!, style: GoogleFonts.inter(fontSize: 13, color: Colors.red.shade800)),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity, height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (selectedCategoria != null && valorCtrl.text.isNotEmpty && !isSaving)
                        ? _primary
                        : _primary.withOpacity(0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_r)),
                    elevation: 0,
                  ),
                  onPressed: (selectedCategoria == null || valorCtrl.text.isEmpty || isSaving)
                      ? null
                      : () async {
                          final rawValor = valorCtrl.text.replaceAll('.', '').replaceAll(',', '.');
                          final valor = double.tryParse(rawValor) ?? 0;
                          final tipo = isDespesa ? 'DESPESA' : 'ENTRADA';
                          setSheetState(() { isSaving = true; erroSalvar = null; });
                          try {
                            if (isEdit) {
                              final mesRef = '${_model.selectedYear}-${_model.selectedMonth.toString().padLeft(2, '0')}';
                              await VivanLocator.service.updateDespesa(editing.idDespesa!, VivanDespesa(
                                idDespesa: editing.idDespesa,
                                idMotorista: editing.idMotorista ?? FFAppState().idUsuario,
                                tipoLancamento: tipo, categoria: selectedCategoria!,
                                descricao: descricaoCtrl.text, valor: valor, mesReferencia: mesRef,
                                dtVencimento: dataPagamento.toIso8601String().substring(0, 10),
                                dtDespesa: dataPagamento.toIso8601String().substring(0, 10),
                                recorrente: isRecorrente, diaVencimento: isRecorrente ? diaVencimento : null,
                              ));
                            } else if (isRecorrente) {
                              for (int m = mesInicial; m <= mesFinal; m++) {
                                final mesRef = '${_model.selectedYear}-${m.toString().padLeft(2, '0')}';
                                final dtVenc = DateTime(_model.selectedYear, m, diaVencimento);
                                await VivanLocator.service.createDespesa(VivanDespesa(
                                  idMotorista: FFAppState().idUsuario, tipoLancamento: tipo, categoria: selectedCategoria!,
                                  descricao: descricaoCtrl.text, valor: valor, mesReferencia: mesRef,
                                  dtVencimento: dtVenc.toIso8601String().substring(0, 10),
                                  dtDespesa: DateTime.now().toIso8601String().substring(0, 10),
                                  recorrente: true, diaVencimento: diaVencimento,
                                ));
                              }
                            } else {
                              final mesRef = '${_model.selectedYear}-${_model.selectedMonth.toString().padLeft(2, '0')}';
                              await VivanLocator.service.createDespesa(VivanDespesa(
                                idMotorista: FFAppState().idUsuario, tipoLancamento: tipo, categoria: selectedCategoria!,
                                descricao: descricaoCtrl.text, valor: valor, mesReferencia: mesRef,
                                dtVencimento: dataPagamento.toIso8601String().substring(0, 10),
                                dtDespesa: DateTime.now().toIso8601String().substring(0, 10),
                              ));
                            }
                            if (ctx.mounted) Navigator.pop(ctx);
                            _reload();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(isEdit ? 'Lançamento atualizado!' : 'Lançamento salvo!'),
                                backgroundColor: FlutterFlowTheme.of(context).success));
                            }
                          } catch (e) {
                            final msg = e.toString().replaceFirst('Exception: ', '');
                            setSheetState(() { isSaving = false; erroSalvar = msg; });
                          }
                        },
                  child: isSaving
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(isEdit ? 'Atualizar' : 'Salvar',
                          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }

  void showFilters() {
    int tempYear = _model.filterYear;
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: _bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(_r * 2))),
      builder: (ctx) => StatefulBuilder(builder: (ctx, setSheetState) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(onTap: () => Navigator.pop(ctx),
                child: Text('Fechar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: _primary))),
            Text('Filtrar', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(width: 60),
          ]),
          Divider(height: 24, color: _primary.withOpacity(0.3)),
          const SizedBox(height: 8),
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
          const SizedBox(height: 24),
          FFButtonWidget(
            onPressed: () {
              _model.applyFilters(tempYear);
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
      )));
  }

  Widget _pickerField(String label, String value, VoidCallback onTap) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
      const SizedBox(height: 4),
      GestureDetector(
        onTap: onTap,
        child: Container(height: 48, width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(_r)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(value, style: GoogleFonts.inter(fontSize: 15)),
            Icon(Icons.keyboard_arrow_down, color: FlutterFlowTheme.of(context).secondaryText),
          ])),
      ),
    ]);
  }

  String _monthLabel(int m) {
    const months = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
    return months[m - 1];
  }

  void _showMonthPicker(BuildContext ctx, int current, ValueChanged<int> onSelected) {
    int temp = current;
    showCupertinoModalPopup(context: ctx, builder: (_) => Container(height: 250, color: _bg,
      child: Column(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 44,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(onTap: () => Navigator.pop(ctx),
                child: Text('Fechar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500))),
            GestureDetector(onTap: () { onSelected(temp); Navigator.pop(ctx); },
                child: Text('Selecionar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: _primary))),
          ])),
        Expanded(child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: current - 1),
            itemExtent: 40, onSelectedItemChanged: (i) => temp = i + 1,
            children: List.generate(12, (i) => Center(child: Text(_monthLabel(i + 1), style: GoogleFonts.inter(fontSize: 18)))))),
      ])));
  }

  void _showDayPicker(BuildContext ctx, int current, ValueChanged<int> onSelected) {
    int temp = current;
    showCupertinoModalPopup(context: ctx, builder: (_) => Container(height: 250, color: _bg,
      child: Column(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 44,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(onTap: () => Navigator.pop(ctx),
                child: Text('Fechar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500))),
            GestureDetector(onTap: () { onSelected(temp); Navigator.pop(ctx); },
                child: Text('Selecionar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: _primary))),
          ])),
        Expanded(child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: current - 1),
            itemExtent: 40, onSelectedItemChanged: (i) => temp = i + 1,
            children: List.generate(31, (i) => Center(child: Text('${i + 1}', style: GoogleFonts.inter(fontSize: 18)))))),
      ])));
  }
}
