import '/vivan/models/vivan_models.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
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
      final rows = await SupaFlow.client
          .from('vivan_mensalidades')
          .select()
          .eq('idMotorista', FFAppState().idUsuario)
          .eq('idPassageiro', widget.passageiroId)
          .order('dtVencimento')
          .limit(500);
      final all = (rows as List)
          .map((r) => VivanMensalidade.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
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

    // Mapeamento completo de cores/ícones/labels per REGRAS_FRONTEND_VIVAN.md
    final Color statusColor;
    final IconData statusIcon;
    final String statusLabel;
    switch (status) {
      case 'ATRASADO':
      case 'VENCIDO':
        statusColor = const Color(0xFFF56565);
        statusIcon = Icons.warning_rounded;
        statusLabel = 'em atraso';
        break;
      case 'PENDENTE':
        statusColor = const Color(0xFFD69E2E);
        statusIcon = Icons.access_time;
        statusLabel = 'pendente';
        break;
      case 'PAGO':
        statusColor = const Color(0xFF48BB78);
        statusIcon = Icons.check_circle_outline;
        statusLabel = 'pago';
        break;
      case 'PAGO_ATRASO':
        statusColor = const Color(0xFF68D391);
        statusIcon = Icons.check_circle_outline;
        statusLabel = 'pago c/ atraso';
        break;
      case 'ABONADO':
        statusColor = const Color(0xFF4299E1);
        statusIcon = Icons.volunteer_activism_outlined;
        statusLabel = 'abonado';
        break;
      case 'ISENTO':
        statusColor = const Color(0xFF76E4F7);
        statusIcon = Icons.remove_circle_outline;
        statusLabel = 'isento';
        break;
      case 'CANCELADO':
        statusColor = const Color(0xFF718096);
        statusIcon = Icons.cancel_outlined;
        statusLabel = 'cancelado';
        break;
      default: // AGUARDANDO
        statusColor = Colors.grey;
        statusIcon = Icons.access_time;
        statusLabel = 'a vencer';
    }

    return InkWell(
      onTap: () => _showPagamentoSheet(m),
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

  void _showPagamentoSheet(VivanMensalidade m) {
    // Bloquear para status finais ou que não precisam de pagamento manual
    final s = m.status.toUpperCase();
    if (m.isPago || m.isAbonado || s == 'ISENTO' || s == 'CANCELADO') return;
    String? selectedForma;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.fromLTRB(
              20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Informar Pagamento',
                  style: GoogleFonts.inter(
                      fontSize: 16, color: _secondaryText)),
              const SizedBox(height: 8),
              Text(
                widget.nomePassageiro,
                style: GoogleFonts.interTight(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                'Vencimento: ${m.dtVencimento != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(m.dtVencimento!)) : '—'}',
                style: GoogleFonts.inter(
                    fontSize: 13, color: _secondaryText),
              ),
              const SizedBox(height: 4),
              Text(
                NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                    .format(m.valOriginal ?? 0),
                style: GoogleFonts.inter(
                    fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Text('Como foi o pagamento?',
                  style: GoogleFonts.inter(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Pix', 'Dinheiro', 'Cartão de Crédito',
                  'Cartão de Débito', 'Boleto', 'Outro'
                ]
                    .map((forma) {
                      final sel = selectedForma == forma;
                      return GestureDetector(
                        onTap: () => setSheet(() => selectedForma = forma),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: sel ? _primary : _bg,
                            border: Border.all(
                                color: _primary, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(forma,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: sel
                                      ? Colors.white
                                      : _primary)),
                        ),
                      );
                    })
                    .toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedForma == null
                    ? null
                    : () async {
                        try {
                          final hoje = DateTime.now();
                          final venc = m.dtVencimento != null
                              ? DateTime.tryParse(m.dtVencimento!)
                              : null;
                          final statusPgto = (venc != null && hoje.isAfter(venc))
                              ? 'PAGO_ATRASO'
                              : 'PAGO';
                          await SupaFlow.client
                              .from('vivan_mensalidades')
                              .update({
                            'valPago': m.valOriginal ?? 0,
                            'formaPagamento': selectedForma!,
                            'dtPagamento': DateFormat('yyyy-MM-dd').format(hoje),
                            'status': statusPgto,
                          })
                              .eq('idMensalidade', m.idMensalidade!)
                              .eq('idMotorista', FFAppState().idUsuario);
                          if (ctx.mounted) Navigator.pop(ctx);
                          await _load();
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: const Text(
                                        'Pagamento registrado!'),
                                    backgroundColor: _primary));
                          }
                        } catch (e) {
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                content: Text('Erro: $e')));
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  disabledBackgroundColor:
                      _primary.withValues(alpha: 0.4),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirmar pagamento',
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
