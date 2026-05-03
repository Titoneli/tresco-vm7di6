import '/vivan/vivan.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../_vivan_http.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RenovarMensalidadesMWidget extends StatefulWidget {
  const RenovarMensalidadesMWidget({
    super.key,
    required this.passageiroId,
    required this.nomePassageiro,
  });

  final int passageiroId;
  final String nomePassageiro;

  @override
  State<RenovarMensalidadesMWidget> createState() =>
      _RenovarMensalidadesMWidgetState();
}

class _RenovarMensalidadesMWidgetState
    extends State<RenovarMensalidadesMWidget> {
  bool _isSaving = false;

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined,
                          size: 80, color: Color(0xFF4A5568)),
                      const SizedBox(height: 24),
                      Text(
                        'Renovar as mensalidades\ndo(a) passageiro(a)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 16, color: _secondaryText),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.nomePassageiro,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.interTight(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _primaryText),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Leia com atenção os pontos abaixo:',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _primaryText),
                      ),
                      const SizedBox(height: 16),
                      _bullet(
                          'As mensalidades serão criadas para os meses até dezembro do ano atual.'),
                      _bullet(
                          'O valor e o dia de vencimento das novas mensalidades seguem o padrão das mensalidades atuais.'),
                      _bullet(
                          'As mensalidades serão criadas somente para meses que ainda não tenham mensalidades.'),
                      _bullet(
                          'Em breve disponibilizaremos novas funcionalidades para gestão de mensalidades.'),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _isSaving ? null : _renovar,
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
                            : const Text(
                                'Renovar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
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
              child: Text('Renovar Mensalidades',
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

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: _primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style:
                    GoogleFonts.inter(fontSize: 14, color: _secondaryText)),
          ),
        ],
      ),
    );
  }

  Future<void> _renovar() async {
    setState(() => _isSaving = true);
    try {
      // Busca contrato ativo do passageiro
      final contratos = await VivanLocator.service.getContratos(
        motorista: FFAppState().idUsuario,
        passageiro: widget.passageiroId,
        limit: 20,
      );
      final ativo = contratos.data.where(
          (c) => c.status.toUpperCase() == 'ATIVO').toList();

      if (ativo.isEmpty) {
        if (mounted) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Sem contrato ativo'),
              content: const Text(
                  'Este passageiro não possui contrato ativo. Crie ou ative um contrato primeiro.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Ok'))
              ],
            ),
          );
        }
        setState(() => _isSaving = false);
        return;
      }

      final contrato = ativo.first;
      final diaVenc = contrato.diaVencimento ?? 5;
      final valor = contrato.valMensal ?? 0;

      // Busca mensalidades existentes para não duplicar
      final existentes = await VivanLocator.service.getMensalidades(
        motorista: FFAppState().idUsuario,
        passageiro: widget.passageiroId,
        limit: 200,
      );
      final mesesExistentes = existentes.data
          .where((m) => m.mesReferencia != null)
          .map((m) => m.mesReferencia!)
          .toSet();

      // Gera mensalidades para meses restantes do ano atual
      final now = DateTime.now();
      int criadas = 0;
      for (int mes = now.month; mes <= 12; mes++) {
        final mesRef = DateFormat('MM/yyyy').format(DateTime(now.year, mes));
        if (mesesExistentes.contains(mesRef)) continue;
        await VivanHttp.post('/mensalidades', {
          'idContrato': contrato.idContrato,
          'idPassageiro': widget.passageiroId,
          'idMotorista': FFAppState().idUsuario,
          'mesReferencia': mesRef,
          'dtVencimento':
              DateFormat('yyyy-MM-dd').format(DateTime(now.year, mes, diaVenc)),
          'valOriginal': valor,
          'status': 'PENDENTE',
        });
        criadas++;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(criadas > 0
              ? '$criadas mensalidade${criadas == 1 ? '' : 's'} criada${criadas == 1 ? '' : 's'} com sucesso!'
              : 'Todas as mensalidades já estão em dia.'),
          backgroundColor: _primary,
        ));
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('RenovarMensalidades._renovar: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Erro: ${e.toString().replaceFirst('Exception: ', '')}'),
          backgroundColor: Colors.red.shade400,
        ));
      }
    }
    setState(() => _isSaving = false);
  }
}
