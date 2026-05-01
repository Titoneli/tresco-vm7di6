import '/vivan/vivan.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../_vivan_http.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GestaoMensalidadesMWidget extends StatefulWidget {
  const GestaoMensalidadesMWidget({
    super.key,
    required this.passageiroId,
    required this.nomePassageiro,
  });

  final int passageiroId;
  final String nomePassageiro;

  @override
  State<GestaoMensalidadesMWidget> createState() =>
      _GestaoMensalidadesMWidgetState();
}

class _GestaoMensalidadesMWidgetState
    extends State<GestaoMensalidadesMWidget> {
  List<VivanMensalidade> _mensalidades = [];
  final Set<int> _selecionadas = {};
  bool _loading = false;

  late DateTime _dataInicio;
  late DateTime _dataFim;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dataInicio = DateTime(now.year, 1, 1);
    _dataFim = DateTime(now.year, 12, 31);
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _selecionadas.clear();
    });
    try {
      final result = await VivanLocator.service.getMensalidades(
        motorista: FFAppState().idUsuario,
        passageiro: widget.passageiroId,
        limit: 200,
      );
      final all = result.data;
      setState(() {
        _mensalidades = all.where((m) {
          if (m.dtVencimento == null) return true;
          try {
            final dt = DateTime.parse(m.dtVencimento!);
            return !dt.isBefore(_dataInicio) && !dt.isAfter(_dataFim);
          } catch (_) {
            return true;
          }
        }).toList();
        _loading = false;
      });
    } catch (e) {
      debugPrint('GestaoMensalidades._load: $e');
      setState(() => _loading = false);
    }
  }

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

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
              _buildFilterRow(),
              Expanded(child: _buildList()),
              _buildFooter(),
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
              child: Text('Gestão de Mensalidades',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: FlutterFlowTheme.of(context).secondaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informe o período desejado para visualizar as mensalidades',
            style: GoogleFonts.inter(fontSize: 12, color: _secondaryText),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _dateChip(_dataInicio, (d) => _dataInicio = d)),
              const SizedBox(width: 8),
              Expanded(child: _dateChip(_dataFim, (d) => _dataFim = d)),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _load,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                ),
                child: const Text('Filtrar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateChip(DateTime date, void Function(DateTime) onPicked) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
        );
        if (picked != null) setState(() => onPicked(picked));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: _bg,
        ),
        child: Text(
          DateFormat('dd/MM/yyyy').format(date),
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 13, fontWeight: FontWeight.w500, color: _primaryText),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_loading) {
      return Center(
          child: CircularProgressIndicator(color: _primary, strokeWidth: 2));
    }
    if (_mensalidades.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Nenhuma mensalidade encontrada para o período selecionado',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: _secondaryText),
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text(
            'Selecione abaixo as mensalidades para editar',
            style: GoogleFonts.inter(fontSize: 13, color: _secondaryText),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: _mensalidades.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Colors.grey.shade100),
            itemBuilder: (ctx, i) => _buildRow(_mensalidades[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(VivanMensalidade m) {
    final id = m.idMensalidade ?? 0;
    final selected = _selecionadas.contains(id);
    final venc = m.dtVencimento != null
        ? DateFormat('dd/MM/yyyy').format(DateTime.parse(m.dtVencimento!))
        : '';
    final mes = m.mesReferencia ?? '';
    final valor = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        .format(m.valOriginal ?? 0);

    return InkWell(
      onTap: () {
        setState(() {
          if (selected) {
            _selecionadas.remove(id);
          } else {
            _selecionadas.add(id);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? _primary : _secondaryText,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(venc,
                  style: GoogleFonts.inter(
                      fontSize: 14, color: _primaryText)),
            ),
            Text(mes,
                style: GoogleFonts.inter(
                    fontSize: 13, color: _secondaryText)),
            const SizedBox(width: 12),
            Text(valor,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _primaryText)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${_selecionadas.length} Mensalidade${_selecionadas.length == 1 ? '' : 's'} Selecionada${_selecionadas.length == 1 ? '' : 's'}',
            style: GoogleFonts.inter(
                fontSize: 13, color: _secondaryText),
          ),
          if (_selecionadas.isNotEmpty) ...[
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _showEditarSelecionadas,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Editar Selecionadas',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showEditarSelecionadas() async {
    final valorCtrl = TextEditingController();
    bool isSaving = false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
              Text(
                'Editar ${_selecionadas.length} mensalidade${_selecionadas.length == 1 ? '' : 's'}',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                      color: _primaryText),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: valorCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Novo valor R\$',
                  prefixText: 'R\$ ',
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
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
              ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        final novoValor = double.tryParse(
                            valorCtrl.text.replaceAll(',', '.'));
                        if (novoValor == null) return;
                        setSheet(() => isSaving = true);
                        try {
                          for (final id in _selecionadas) {
                            await VivanHttp.put('/mensalidades/$id', {
                              'valOriginal': novoValor,
                            });
                          }
                          if (ctx.mounted) Navigator.pop(ctx);
                          await _load();
                        } catch (e) {
                          setSheet(() => isSaving = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                content: Text(
                                    'Erro ao salvar: ${e.toString().replaceFirst('Exception: ', '')}')));
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
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
