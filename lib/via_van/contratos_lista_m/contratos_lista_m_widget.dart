import 'dart:io';
import '/flutter_flow/flutter_flow_util.dart';
import '/via_van/gerar_contrato_m/gerar_contrato_m_widget.dart';
import '/via_van/clausulas_contrato_m/clausulas_contrato_m_widget.dart';
import '/via_van/clausulas_contrato_m/clausula_storage.dart';
import '/via_van/clausulas_contrato_m/preview_contrato_m_widget.dart';
import '/vivan/vivan.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contratos_lista_m_model.dart';
export 'contratos_lista_m_model.dart';

class ContratosListaMWidget extends StatefulWidget {
  const ContratosListaMWidget({
    super.key,
    this.passageiroId = 0,
    this.nomePassageiro = '',
  });

  final int passageiroId;
  final String nomePassageiro;

  static String routeName = 'contratosListaM';
  static String routePath = '/contratosLista';

  @override
  State<ContratosListaMWidget> createState() => _ContratosListaMWidgetState();
}

class _ContratosListaMWidgetState extends State<ContratosListaMWidget> {
  late ContratosListaMModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContratosListaMModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.fetchContratos(
        FFAppState().idUsuario,
        passageiro: widget.passageiroId > 0 ? widget.passageiroId : null,
      );
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crie contratos do seu transporte escolar de forma rápida e segura, direto pelo ViVan.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 16, color: _secondaryText),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Nesta etapa, você pode:',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _primaryText),
                      ),
                      const SizedBox(height: 12),
                      _bullet('Visualizar como está o seu modelo de contrato'),
                      _bullet(
                          'Visualizar a lista de contratos já gerados para seus passageiros'),
                      _bullet('Ajustar cláusulas conforme sua necessidade'),
                      _bullet(
                          'Voltar ao modelo padrão do ViVan quando precisar'),
                      const SizedBox(height: 16),
                      Text(
                        'Depois de gerar o contrato, é só enviar o link para o responsável assinar digitalmente. Simples e sem papelada.',
                        style: GoogleFonts.inter(
                            fontSize: 14, color: _secondaryText),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GerarContratoMWidget(
                                  passageiroId: widget.passageiroId,
                                  nomePassageiro: widget.nomePassageiro,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Novo Contrato',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: _openVerModelo,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryText,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Ver Modelo Atual',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: _showEditarContratoSheet,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryText,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Editar Contrato',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () => _confirmRestoreDefault(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryText,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Voltar Modelo Padrão',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
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
              child: Text('Gerar Contrato',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          GestureDetector(
            onTap: () => _showTutorial(),
            child: Text('Como Usar?',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: _primary)),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: GoogleFonts.inter(
                    fontSize: 14, color: _secondaryText)),
          ),
        ],
      ),
    );
  }

  Future<void> _openVerModelo() async {
    final contrato = _model.contratoAtivo;
    final clausulas = await ClausulaStorage.load();
    final meta = contrato != null
        ? await PdfStorage.getMeta(widget.passageiroId)
        : null;

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
              'As cláusulas foram alteradas desde ${DateFormat('dd/MM/yyyy').format(meta.geradoEm)}. Deseja gerar um novo PDF?',
              style: GoogleFonts.inter(fontSize: 14),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Não, usar o antigo')),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(backgroundColor: _primary),
                child: Text('Sim, gerar novo',
                    style: GoogleFonts.inter(color: Colors.white)),
              ),
            ],
          ),
        );
        if (!mounted) return;
        _navigateToPreview(gerar == true ? null : meta.filePath, contrato);
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
    );
  }

  void _showEditarContratoSheet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClausulasContratoMWidget(
          passageiroId: widget.passageiroId,
          nomePassageiro: widget.nomePassageiro,
          contrato: _model.contratoAtivo,
        ),
      ),
    ).then((_) async {
      await _model.fetchContratos(
        FFAppState().idUsuario,
        passageiro: widget.passageiroId > 0 ? widget.passageiroId : null,
      );
      if (mounted) safeSetState(() {});
    });
  }

  void _showTutorial() {
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
            Text('Como Usar os Contratos',
                style: GoogleFonts.interTight(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _primaryText)),
            const SizedBox(height: 16),
            Text(
              '1. Toque em "Novo Contrato" para iniciar o assistente de criação.\n\n'
              '2. Preencha as informações do motorista, passageiro, responsável e valores.\n\n'
              '3. Assine digitalmente na etapa final e gere o contrato.\n\n'
              '4. Compartilhe o link com o responsável para que ele assine digitalmente.\n\n'
              '5. Use "Ver Modelo Atual" para revisar o modelo antes de gerar.',
              style: GoogleFonts.inter(fontSize: 14, color: _secondaryText),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Entendi',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRestoreDefault() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Voltar Modelo Padrão',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
        content: Text(
            'Deseja restaurar o modelo padrão do ViVan? Todas as suas alterações de cláusulas serão perdidas.',
            style: GoogleFonts.inter(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ClausulaStorage.resetToDefaults();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Modelo padrão restaurado com sucesso'),
                    backgroundColor: _primary));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: _primary),
            child: Text('Confirmar',
                style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
