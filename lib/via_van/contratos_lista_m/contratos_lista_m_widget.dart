import '/flutter_flow/flutter_flow_util.dart';
import '/via_van/gerar_contrato_m/gerar_contrato_m_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contratos_lista_m_model.dart';
export 'contratos_lista_m_model.dart';

class ContratosListaMWidget extends StatefulWidget {
  const ContratosListaMWidget({
    super.key,
    required this.passageiroId,
    required this.nomePassageiro,
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
                        'Crie contratos do seu transporte escolar de forma rápida e segura, direto pelo Smartvan.',
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
                          'Voltar ao modelo padrão do Smartvan quando precisar'),
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Em breve')));
                          },
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Em breve')));
                          },
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
            'Deseja restaurar o modelo padrão do Smartvan? As personalizações serão perdidas.',
            style: GoogleFonts.inter(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Modelo padrão restaurado')));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary),
            child: Text('Confirmar',
                style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
