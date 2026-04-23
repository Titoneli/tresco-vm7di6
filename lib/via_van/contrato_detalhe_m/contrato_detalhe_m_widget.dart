import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contrato_detalhe_m_model.dart';
export 'contrato_detalhe_m_model.dart';

class ContratoDetalheMWidget extends StatefulWidget {
  const ContratoDetalheMWidget({super.key, this.contratoId});
  final int? contratoId;

  static String routeName = 'contratoDetalheM';
  static String routePath = '/contratoDetalhe';

  @override
  State<ContratoDetalheMWidget> createState() => _ContratoDetalheMWidgetState();
}

class _ContratoDetalheMWidgetState extends State<ContratoDetalheMWidget> {
  late ContratoDetalheMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isNewContrato => widget.contratoId == null;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContratoDetalheMModel());

    _model.valorTextController ??= TextEditingController();
    _model.valorFocusNode ??= FocusNode();
    _model.condicoesTextController ??= TextEditingController();
    _model.condicoesFocusNode ??= FocusNode();
    _model.dataInicioTextController ??= TextEditingController();
    _model.dataInicioFocusNode ??= FocusNode();
    _model.dataFimTextController ??= TextEditingController();
    _model.dataFimFocusNode ??= FocusNode();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!isNewContrato) {
        await _model.fetchContrato(widget.contratoId!);
        safeSetState(() {});
      } else {
        _model.isLoading = false;
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color _statusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'ATIVO': return Color(0xFF39D2C0);
      case 'RASCUNHO': return Color(0xFF9E9E9E);
      case 'SUSPENSO': return Color(0xFFF9CF58);
      case 'CANCELADO': return Color(0xFFFF5963);
      default: return Color(0xFF9E9E9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          leading: FlutterFlowIconButton(
            borderRadius: 8.0, buttonSize: 40.0,
            icon: Icon(Icons.arrow_back, color: FlutterFlowTheme.of(context).info, size: 24.0),
            onPressed: () async => context.safePop(),
          ),
          title: Text(
            isNewContrato ? 'Novo Contrato' : 'Contrato',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
              color: FlutterFlowTheme.of(context).info, fontSize: 20.0, letterSpacing: 0.0,
            ),
          ),
          centerTitle: true, elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: _model.isLoading
              ? Center(child: SpinKitPulse(color: FlutterFlowTheme.of(context).primary, size: 50.0))
              : isNewContrato
                  ? _buildCreateForm(context)
                  : _buildDetailView(context),
        ),
      ),
    );
  }

  Widget _buildCreateForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selecione um passageiro, defina valor e condições do contrato.',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
              ),
            ),
            SizedBox(height: 24.0),
            _buildField(context, 'Valor Mensal (R\$)', _model.valorTextController!, _model.valorFocusNode!,
                keyboardType: TextInputType.numberWithOptions(decimal: true)),
            SizedBox(height: 16.0),
            _buildField(context, 'Data Início (YYYY-MM-DD)', _model.dataInicioTextController!, _model.dataInicioFocusNode!),
            SizedBox(height: 16.0),
            _buildField(context, 'Data Fim (YYYY-MM-DD)', _model.dataFimTextController!, _model.dataFimFocusNode!),
            SizedBox(height: 16.0),
            _buildField(context, 'Condições', _model.condicoesTextController!, _model.condicoesFocusNode!, maxLines: 4),
            SizedBox(height: 32.0),
            FFButtonWidget(
              onPressed: () async {
                final response = await VivanContratoCreateCall.call(
                  motoristaId: FFAppState().idUsuario,
                  passageiroId: _model.selectedPassageiroId,
                  valorMensal: double.tryParse(_model.valorTextController!.text),
                  dataInicio: _model.dataInicioTextController!.text,
                  dataFim: _model.dataFimTextController!.text,
                  condicoes: _model.condicoesTextController!.text,
                );
                if (response.succeeded) {
                  context.safePop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao criar contrato')),
                  );
                }
              },
              text: 'Criar Contrato',
              options: FFButtonOptions(
                width: double.infinity, height: 48.0,
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  color: Colors.white, letterSpacing: 0.0,
                ),
                elevation: 0.0, borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailView(BuildContext context) {
    final statusColor = _statusColor(_model.status);
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(_model.status,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        color: statusColor, letterSpacing: 0.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(_model.passageiroNome,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w600), letterSpacing: 0.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('R\$ ${_model.valorMensal.toStringAsFixed(2)}/mês',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                      color: FlutterFlowTheme.of(context).primary, letterSpacing: 0.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('${_model.dataInicio} - ${_model.dataFim}',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                      color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          // Condições
          if (_model.condicoes.isNotEmpty)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Condições', style: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.inter(fontWeight: FontWeight.w600), letterSpacing: 0.0,
                      )),
                      SizedBox(height: 8.0),
                      Text(_model.condicoes, style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(fontWeight: FontWeight.normal), letterSpacing: 0.0,
                      )),
                    ],
                  ),
                ),
              ),
            ),
          // Actions
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ações', style: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.w600), letterSpacing: 0.0,
                )),
                SizedBox(height: 12.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    if (_model.status == 'RASCUNHO') ...[
                      _buildActionButton(context, 'Enviar Assinatura', Icons.send, FlutterFlowTheme.of(context).primary, () async {
                        await _model.enviarAssinatura(widget.contratoId!);
                        await _model.fetchContrato(widget.contratoId!);
                        safeSetState(() {});
                      }),
                      _buildActionButton(context, 'Ativar', Icons.check_circle, Color(0xFF39D2C0), () async {
                        await _model.ativar(widget.contratoId!);
                        await _model.fetchContrato(widget.contratoId!);
                        safeSetState(() {});
                      }),
                    ],
                    if (_model.status == 'ATIVO') ...[
                      _buildActionButton(context, 'Suspender', Icons.pause_circle, Color(0xFFF9CF58), () async {
                        await _model.suspender(widget.contratoId!);
                        await _model.fetchContrato(widget.contratoId!);
                        safeSetState(() {});
                      }),
                      _buildActionButton(context, 'Cancelar', Icons.cancel, Color(0xFFFF5963), () async {
                        final motivo = await _showMotivoDialog(context);
                        if (motivo != null) {
                          await _model.cancelar(widget.contratoId!, motivo);
                          await _model.fetchContrato(widget.contratoId!);
                          safeSetState(() {});
                        }
                      }),
                    ],
                    if (_model.status == 'SUSPENSO')
                      _buildActionButton(context, 'Reativar', Icons.play_circle, Color(0xFF39D2C0), () async {
                        await _model.ativar(widget.contratoId!);
                        await _model.fetchContrato(widget.contratoId!);
                        safeSetState(() {});
                      }),
                  ],
                ),
              ],
            ),
          ),
          // Histórico
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Histórico', style: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.w600), letterSpacing: 0.0,
                )),
                SizedBox(height: 12.0),
                if (_model.historico.isEmpty)
                  Text('Sem histórico', style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                  ))
                else
                  ...List.generate(_model.historico.length, (i) {
                    final h = _model.historico[i];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.history, color: FlutterFlowTheme.of(context).secondaryText, size: 20.0),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getJsonField(h, r'''$.acao''')?.toString() ?? '',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.w500), letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(getJsonField(h, r'''$.data''')?.toString() ?? '',
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                                        color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              ],
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: _model.isActionLoading ? null : onPressed,
      icon: Icon(icon, size: 18.0, color: Colors.white),
      label: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13.0)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
    );
  }

  Widget _buildField(BuildContext context, String label, TextEditingController controller, FocusNode focusNode,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller, focusNode: focusNode, maxLines: maxLines, keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label, filled: true,
        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
        font: GoogleFonts.inter(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight), letterSpacing: 0.0,
      ),
    );
  }

  Future<String?> _showMotivoDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Motivo do Cancelamento'),
        content: TextField(controller: controller, maxLines: 3, decoration: InputDecoration(hintText: 'Informe o motivo...')),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Voltar')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(controller.text), child: Text('Confirmar')),
        ],
      ),
    );
  }
}
