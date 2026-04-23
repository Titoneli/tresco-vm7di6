import '/vivan/vivan.dart';
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
import 'financeiro_m_model.dart';
export 'financeiro_m_model.dart';

class FinanceiroMWidget extends StatefulWidget {
  const FinanceiroMWidget({super.key});

  static String routeName = 'financeiroM';
  static String routePath = '/financeiro';

  @override
  State<FinanceiroMWidget> createState() => _FinanceiroMWidgetState();
}

class _FinanceiroMWidgetState extends State<FinanceiroMWidget>
    with SingleTickerProviderStateMixin {
  late FinanceiroMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FinanceiroMModel());
    _model.tabBarController = TabController(length: 2, vsync: this);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().idEmpresa == 0) {
        context.pushNamed(LoginWidget.routeName);
        return;
      }
      await Future.wait([
        _model.fetchMensalidades(FFAppState().idUsuario),
        _model.fetchDespesas(FFAppState().idUsuario),
      ]);
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
          title: Text('Financeiro',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
              color: FlutterFlowTheme.of(context).info, fontSize: 20.0, letterSpacing: 0.0,
            ),
          ),
          centerTitle: true, elevation: 0.0,
          bottom: TabBar(
            controller: _model.tabBarController,
            indicatorColor: FlutterFlowTheme.of(context).info,
            labelColor: FlutterFlowTheme.of(context).info,
            unselectedLabelColor: FlutterFlowTheme.of(context).info.withOpacity(0.6),
            tabs: [
              Tab(text: 'Mensalidades'),
              Tab(text: 'Despesas'),
            ],
          ),
        ),
        body: SafeArea(
          top: true,
          child: TabBarView(
            controller: _model.tabBarController,
            children: [
              _buildMensalidadesTab(context),
              _buildDespesasTab(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMensalidadesTab(BuildContext context) {
    if (_model.isLoadingMensalidades) {
      return Center(child: SpinKitPulse(color: FlutterFlowTheme.of(context).primary, size: 50.0));
    }
    return Column(
      children: [
        // Total card
        Container(
          width: double.infinity, margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Text('Total Mensalidades', style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
              )),
              SizedBox(height: 4.0),
              Text('R\$ ${_model.totalMensalidades.toStringAsFixed(2)}',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                  font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                  color: FlutterFlowTheme.of(context).primary, letterSpacing: 0.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _model.mensalidades.isEmpty
              ? Center(child: Text('Nenhuma mensalidade encontrada',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                  )))
              : RefreshIndicator(
                  onRefresh: () async {
                    await _model.fetchMensalidades(FFAppState().idUsuario);
                    safeSetState(() {});
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 80.0),
                    itemCount: _model.mensalidades.length,
                    itemBuilder: (context, index) {
                      final m = _model.mensalidades[index];
                      final status = m.status;
                      final isPago = status.toUpperCase() == 'PAGO';
                      final isAbonado = status.toUpperCase() == 'ABONADO';

                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(m.nomePassageiro,
                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600), letterSpacing: 0.0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: isPago ? Color(0xFF39D2C0).withOpacity(0.2)
                                            : isAbonado ? Color(0xFFF9CF58).withOpacity(0.2)
                                            : Color(0xFFFF5963).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Text(status,
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                          color: isPago ? Color(0xFF39D2C0) : isAbonado ? Color(0xFFF9CF58) : Color(0xFFFF5963),
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('R\$ ${m.valorLiquido}',
                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                        color: FlutterFlowTheme.of(context).primary, letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text('Venc: ${m.dtVencimento}',
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                                        color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                                      ),
                                    ),
                                  ],
                                ),
                                if (!isPago && !isAbonado)
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await _showPagamentoManualDialog(context, m.idMensalidade);
                                            },
                                            text: 'Pag. Manual',
                                            options: FFButtonOptions(
                                              height: 36.0,
                                              color: FlutterFlowTheme.of(context).primary,
                                              textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                color: Colors.white, letterSpacing: 0.0,
                                              ),
                                              elevation: 0.0, borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await _showAbonoDialog(context, m.idMensalidade);
                                            },
                                            text: 'Abonar',
                                            options: FFButtonOptions(
                                              height: 36.0,
                                              color: Color(0xFFF9CF58),
                                              textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                color: Colors.white, letterSpacing: 0.0,
                                              ),
                                              elevation: 0.0, borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        FlutterFlowIconButton(
                                          borderRadius: 8.0, buttonSize: 36.0,
                                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                          icon: Icon(Icons.qr_code, color: FlutterFlowTheme.of(context).primary, size: 20.0),
                                          onPressed: () async {
                                            final pixUrl = m.asaasPixCopiaECola;
                                            final pixQr = m.asaasPixQrCode;
                                            if (pixUrl != null || pixQr != null) {
                                              await _showPixDialog(context, pixUrl, pixQr);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                if (isAbonado)
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await VivanLocator.service.cancelarAbono(m.idMensalidade!);
                                        await _model.fetchMensalidades(FFAppState().idUsuario);
                                        safeSetState(() {});
                                      },
                                      text: 'Cancelar Abono',
                                      options: FFButtonOptions(
                                        height: 36.0,
                                        color: FlutterFlowTheme.of(context).error,
                                        textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                          color: Colors.white, letterSpacing: 0.0,
                                        ),
                                        elevation: 0.0, borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildDespesasTab(BuildContext context) {
    if (_model.isLoadingDespesas) {
      return Center(child: SpinKitPulse(color: FlutterFlowTheme.of(context).primary, size: 50.0));
    }
    return Column(
      children: [
        Container(
          width: double.infinity, margin: EdgeInsets.all(16.0), padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFFF5963).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Text('Total Despesas', style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
              )),
              SizedBox(height: 4.0),
              Text('R\$ ${_model.totalDespesas.toStringAsFixed(2)}',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                  font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                  color: Color(0xFFFF5963), letterSpacing: 0.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _model.despesas.isEmpty
              ? Center(child: Text('Nenhuma despesa encontrada',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                  )))
              : RefreshIndicator(
                  onRefresh: () async {
                    await _model.fetchDespesas(FFAppState().idUsuario);
                    safeSetState(() {});
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 80.0),
                    itemCount: _model.despesas.length,
                    itemBuilder: (context, index) {
                      final d = _model.despesas[index];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.0, height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF5963).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Icon(Icons.receipt_long, color: Color(0xFFFF5963), size: 20.0),
                                ),
                                SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(d.categoria,
                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                          font: GoogleFonts.inter(fontWeight: FontWeight.w600), letterSpacing: 0.0,
                                        ),
                                      ),
                                      Text(d.descricao,
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                                          color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                                        ),
                                      ),
                                      Text(d.dtDespesa,
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                                          color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text('R\$ ${d.valor}',
                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                    color: Color(0xFFFF5963), letterSpacing: 0.0,
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (value) async {
                                    if (value == 'excluir') {
                                      await _model.deleteDespesa(d.idDespesa!);
                                      await _model.fetchDespesas(FFAppState().idUsuario);
                                      safeSetState(() {});
                                    }
                                  },
                                  itemBuilder: (ctx) => [
                                    PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _showPagamentoManualDialog(BuildContext context, int? mensalidadeId) async {
    final formaController = TextEditingController();
    final obsController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pagamento Manual'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: formaController, decoration: InputDecoration(labelText: 'Forma de pagamento')),
            SizedBox(height: 8.0),
            TextField(controller: obsController, decoration: InputDecoration(labelText: 'Observação'), maxLines: 2),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Cancelar')),
          TextButton(
            onPressed: () async {
              await _model.pagarManual(
                mensalidadeId!,
                double.tryParse(valorController.text) ?? 0,
                formaController.text,
              );
              Navigator.of(ctx).pop();
              await _model.fetchMensalidades(FFAppState().idUsuario);
              safeSetState(() {});
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAbonoDialog(BuildContext context, int? mensalidadeId) async {
    final motivoController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Abonar Mensalidade'),
        content: TextField(controller: motivoController, decoration: InputDecoration(labelText: 'Motivo'), maxLines: 2),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Cancelar')),
          TextButton(
            onPressed: () async {
              await _model.abonar(mensalidadeId!, motivoController.text);
              Navigator.of(ctx).pop();
              await _model.fetchMensalidades(FFAppState().idUsuario);
              safeSetState(() {});
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPixDialog(BuildContext context, String? pixUrl, String? pixQrCode) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('PIX - QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pixQrCode != null && pixQrCode.isNotEmpty)
              Image.network(pixQrCode, width: 200, height: 200,
                errorBuilder: (c, e, s) => Icon(Icons.error, size: 64.0)),
            if (pixUrl != null && pixUrl.isNotEmpty) ...[
              SizedBox(height: 12.0),
              SelectableText(pixUrl, style: TextStyle(fontSize: 12.0)),
            ],
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Fechar')),
        ],
      ),
    );
  }
}
