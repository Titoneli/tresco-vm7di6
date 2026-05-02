import '/vivan/vivan.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExtratoPassageiroMWidget extends StatefulWidget {
  const ExtratoPassageiroMWidget({
    super.key,
    required this.passageiroId,
    required this.nomePassageiro,
    this.urlFoto,
  });

  final int passageiroId;
  final String nomePassageiro;
  final String? urlFoto;

  @override
  State<ExtratoPassageiroMWidget> createState() =>
      _ExtratoPassageiroMWidgetState();
}

class _ExtratoPassageiroMWidgetState extends State<ExtratoPassageiroMWidget> {
  List<VivanMensalidade> _mensalidades = [];
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
    setState(() => _loading = true);
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
      debugPrint('ExtratoPassageiro._load: $e');
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
              _buildPassageiroCard(),
              Expanded(child: _buildList()),
              _buildSaveButton(),
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
              child: Text('Extrato',
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
          Text('Selecione o período desejado para visualizar o extrato',
              style: GoogleFonts.inter(fontSize: 12, color: _secondaryText)),
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

  Widget _buildPassageiroCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: _primary.withValues(alpha: 0.1),
            backgroundImage: widget.urlFoto != null
                ? NetworkImage(widget.urlFoto!)
                : null,
            child: widget.urlFoto == null
                ? Icon(Icons.person, color: _primary, size: 22)
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            widget.nomePassageiro.toUpperCase(),
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: _primaryText),
          ),
        ],
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
          child: Text('Nenhuma mensalidade encontrada',
              style: GoogleFonts.inter(color: _secondaryText)));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _mensalidades.length + 1,
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text('Mensalidades',
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                      color: _primaryText)),
          );
        }
        return _buildMensalidadeRow(_mensalidades[i - 1]);
      },
    );
  }

  Widget _buildMensalidadeRow(VivanMensalidade m) {
    final venc = m.dtVencimento != null
        ? DateFormat('dd/MM/yyyy').format(DateTime.parse(m.dtVencimento!))
        : m.mesReferencia ?? '';
    final valor =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(
            m.valOriginal ?? 0);
    final status = m.status.toUpperCase();
    final isAtrasado = status == 'ATRASADO' || status == 'VENCIDO';
    final isPago = status == 'PAGO';

    final statusColor = isAtrasado
        ? const Color(0xFFF56565)
        : isPago
            ? const Color(0xFF48BB78)
            : Colors.grey;
    final statusIcon = isAtrasado
        ? Icons.warning_rounded
        : isPago
            ? Icons.check_circle_outline
            : Icons.access_time;
    final statusLabel = isAtrasado
        ? 'em atraso'
        : isPago
            ? 'pago'
            : 'a vencer';

    return InkWell(
      onTap: () {},
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(venc,
                  style: GoogleFonts.inter(
                      fontSize: 14, color: _primaryText)),
            ),
            Text(valor,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _primaryText)),
            const SizedBox(width: 12),
            Icon(statusIcon, size: 16, color: statusColor),
            const SizedBox(width: 4),
            Text(statusLabel,
                style: GoogleFonts.inter(
                    fontSize: 12, color: statusColor)),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 16, color: _secondaryText),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Exportação — em breve')));
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: _primary,
          side: BorderSide(color: _primary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size(double.infinity, 48),
        ),
        child: const Text('Salvar extrato',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
