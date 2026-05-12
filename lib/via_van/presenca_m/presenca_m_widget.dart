import '/vivan/models/vivan_models.dart';
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
import 'presenca_m_model.dart';
export 'presenca_m_model.dart';

class PresencaMWidget extends StatefulWidget {
  const PresencaMWidget({super.key});

  static String routeName = 'presencaM';
  static String routePath = '/presenca';

  @override
  State<PresencaMWidget> createState() => _PresencaMWidgetState();
}

class _PresencaMWidgetState extends State<PresencaMWidget>
    with SingleTickerProviderStateMixin {
  late PresencaMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PresencaMModel());
    _tabController = TabController(length: 2, vsync: this);

    _model.dataInicioTextController ??= TextEditingController();
    _model.dataInicioFocusNode ??= FocusNode();
    _model.dataFimTextController ??= TextEditingController();
    _model.dataFimFocusNode ??= FocusNode();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().idEmpresa == 0) {
        context.pushNamed(LoginWidget.routeName);
        return;
      }
      // Get geolocation
      try {
        // Use geolocator if available, fallback to null
        // import 'package:geolocator/geolocator.dart';
        // final position = await Geolocator.getCurrentPosition();
        // _model.latitude = position.latitude;
        // _model.longitude = position.longitude;
      } catch (_) {}

      await _model.fetchPresencasHoje(FFAppState().idUsuario);
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _tabController.dispose();
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
          title: Text('Presença',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
              color: FlutterFlowTheme.of(context).info, fontSize: 20.0, letterSpacing: 0.0,
            ),
          ),
          centerTitle: true, elevation: 0.0,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: FlutterFlowTheme.of(context).info,
            labelColor: FlutterFlowTheme.of(context).info,
            unselectedLabelColor: FlutterFlowTheme.of(context).info.withValues(alpha: 0.6),
            tabs: [
              Tab(text: 'Hoje'),
              Tab(text: 'Histórico'),
            ],
          ),
        ),
        body: SafeArea(
          top: true,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTodayTab(context),
              _buildHistoricoTab(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayTab(BuildContext context) {
    if (_model.isLoading) {
      return Center(child: SpinKitPulse(color: FlutterFlowTheme.of(context).primary, size: 50.0));
    }

    // Get active passengers from API response (they may come with status or need to be listed)
    final passageiros = _model.presencas;

    return Column(
      children: [
        // Summary bar
        Container(
          width: double.infinity, margin: EdgeInsets.all(16.0), padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600), letterSpacing: 0.0,
                    ),
                  ),
                  Text('Data', style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                  )),
                ],
              ),
              Column(
                children: [
                  Text('${_model.presencaMap.values.where((v) => v == 'P').length}',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: Color(0xFF39D2C0), letterSpacing: 0.0,
                    ),
                  ),
                  Text('Presentes', style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                  )),
                ],
              ),
              Column(
                children: [
                  Text('${_model.presencaMap.values.where((v) => v == 'F').length}',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: Color(0xFFFF5963), letterSpacing: 0.0,
                    ),
                  ),
                  Text('Faltas', style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                  )),
                ],
              ),
            ],
          ),
        ),
        // Mark all buttons
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
          child: Row(
            children: [
              Expanded(
                child: FFButtonWidget(
                  onPressed: () {
                    for (final p in passageiros) {
                      final id = p.idPassageiro;
                      if (id != null) _model.presencaMap[id] = 'P';
                    }
                    safeSetState(() {});
                  },
                  text: 'Todos Presentes',
                  options: FFButtonOptions(
                    height: 36.0,
                    color: Color(0xFF39D2C0),
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
                  onPressed: () {
                    for (final p in passageiros) {
                      final id = p.idPassageiro;
                      if (id != null) _model.presencaMap[id] = 'F';
                    }
                    safeSetState(() {});
                  },
                  text: 'Todos Falta',
                  options: FFButtonOptions(
                    height: 36.0,
                    color: Color(0xFFFF5963),
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
        // List
        Expanded(
          child: passageiros.isEmpty
              ? Center(child: Text('Nenhum passageiro ativo para hoje',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                  )))
              : ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 100.0),
                  itemCount: passageiros.length,
                  itemBuilder: (context, index) {
                    final p = passageiros[index];
                    final passageiroId = p.idPassageiro as int?;
                    final nome = p.nomePassageiro;
                    final status = passageiroId != null ? (_model.presencaMap[passageiroId] ?? 'F') : 'F';
                    final isPresente = status == 'P';

                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          if (passageiroId != null) {
                            _model.togglePresenca(passageiroId);
                            safeSetState(() {});
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: isPresente ? Color(0xFF39D2C0) : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.0, height: 40.0,
                                  decoration: BoxDecoration(
                                    color: isPresente
                                        ? Color(0xFF39D2C0).withValues(alpha: 0.2)
                                        : Color(0xFFFF5963).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Icon(
                                    isPresente ? Icons.check : Icons.close,
                                    color: isPresente ? Color(0xFF39D2C0) : Color(0xFFFF5963),
                                    size: 20.0,
                                  ),
                                ),
                                SizedBox(width: 12.0),
                                Expanded(
                                  child: Text(nome ?? '',
                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.inter(fontWeight: FontWeight.w500), letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                Text(isPresente ? 'P' : 'F',
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                    color: isPresente ? Color(0xFF39D2C0) : Color(0xFFFF5963),
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        // Send button
        if (passageiros.isNotEmpty)
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FFButtonWidget(
              onPressed: _model.isSending ? null : () async {
                final response = await _model.enviarPresencasLote(FFAppState().idUsuario);
                safeSetState(() {});
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Presenças registradas com sucesso!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao registrar presenças')),
                  );
                }
              },
              text: _model.isSending ? 'Enviando...' : 'Enviar Presenças',
              options: FFButtonOptions(
                width: double.infinity, height: 52.0,
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  color: Colors.white, letterSpacing: 0.0,
                ),
                elevation: 0.0, borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHistoricoTab(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _model.dataInicioTextController,
                  focusNode: _model.dataInicioFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Data Início',
                    hintText: 'YYYY-MM-DD',
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight), letterSpacing: 0.0,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _model.dataFimTextController,
                  focusNode: _model.dataFimFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Data Fim',
                    hintText: 'YYYY-MM-DD',
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight), letterSpacing: 0.0,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              FlutterFlowIconButton(
                borderRadius: 12.0, buttonSize: 48.0,
                fillColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(Icons.search, color: FlutterFlowTheme.of(context).info, size: 24.0),
                onPressed: () async {
                  if (_model.dataInicioTextController!.text.isNotEmpty &&
                      _model.dataFimTextController!.text.isNotEmpty) {
                    await _model.fetchHistorico(
                      FFAppState().idUsuario,
                      _model.dataInicioTextController!.text,
                      _model.dataFimTextController!.text,
                    );
                    safeSetState(() {});
                  }
                },
              ),
            ],
          ),
        ),
        if (_model.isLoading)
          Expanded(child: Center(child: SpinKitPulse(color: FlutterFlowTheme.of(context).primary, size: 50.0)))
        else
          Expanded(
            child: _model.presencas.isEmpty
                ? Center(child: Text('Busque por período para ver o histórico',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                      color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
                    )))
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 80.0),
                    itemCount: _model.presencas.length,
                    itemBuilder: (context, index) {
                      final p = _model.presencas[index];
                      final nome = p.nomePassageiro;
                      final data = p.dtPresenca;
                      final isPresente = p.isPresente;

                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 2.0, 16.0, 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  isPresente ? Icons.check_circle : Icons.cancel,
                                  color: isPresente ? Color(0xFF39D2C0) : Color(0xFFFF5963),
                                  size: 20.0,
                                ),
                                SizedBox(width: 12.0),
                                Expanded(child: Text(nome ?? '',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.w500), letterSpacing: 0.0,
                                  ),
                                )),
                                Text(data ?? '',
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                                    color: FlutterFlowTheme.of(context).secondaryText, letterSpacing: 0.0,
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
      ],
    );
  }
}
