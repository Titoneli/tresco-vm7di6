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
import 'contratos_lista_m_model.dart';
export 'contratos_lista_m_model.dart';

class ContratosListaMWidget extends StatefulWidget {
  const ContratosListaMWidget({super.key});

  static String routeName = 'contratosListaM';
  static String routePath = '/contratosLista';

  @override
  State<ContratosListaMWidget> createState() => _ContratosListaMWidgetState();
}

class _ContratosListaMWidgetState extends State<ContratosListaMWidget> {
  late ContratosListaMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContratosListaMModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().idEmpresa == 0) {
        context.pushNamed(LoginWidget.routeName);
        return;
      }
      await _model.fetchContratos(FFAppState().idUsuario);
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color _statusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'ATIVO':
        return Color(0xFF39D2C0);
      case 'RASCUNHO':
        return Color(0xFF9E9E9E);
      case 'SUSPENSO':
        return Color(0xFFF9CF58);
      case 'CANCELADO':
        return Color(0xFFFF5963);
      default:
        return Color(0xFF9E9E9E);
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
            borderRadius: 8.0,
            buttonSize: 40.0,
            icon: Icon(Icons.arrow_back,
                color: FlutterFlowTheme.of(context).info, size: 24.0),
            onPressed: () async => context.safePop(),
          ),
          title: Text(
            'Contratos',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                  color: FlutterFlowTheme.of(context).info,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
              child: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: Icon(Icons.add,
                    color: FlutterFlowTheme.of(context).info, size: 24.0),
                onPressed: () async {
                  context.pushNamed('contratoDetalheM');
                },
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    _buildFilterChip(context, 'Todos', null),
                    SizedBox(width: 8.0),
                    _buildFilterChip(context, 'Ativos', 'ATIVO'),
                    SizedBox(width: 8.0),
                    _buildFilterChip(context, 'Rascunho', 'RASCUNHO'),
                    SizedBox(width: 8.0),
                    _buildFilterChip(context, 'Suspensos', 'SUSPENSO'),
                    SizedBox(width: 8.0),
                    _buildFilterChip(context, 'Cancelados', 'CANCELADO'),
                  ],
                ),
              ),
              Expanded(
                child: _model.isLoading
                    ? Center(
                        child: SpinKitPulse(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0))
                    : _model.contratos.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.description_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 64.0),
                                SizedBox(height: 16.0),
                                Text(
                                  'Nenhum contrato encontrado',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.inter(
                                            fontWeight: FontWeight.normal),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await _model.fetchContratos(
                                  FFAppState().idUsuario,
                                  status: _model.filtroStatus);
                              safeSetState(() {});
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 80.0),
                              itemCount: _model.contratos.length,
                              itemBuilder: (context, index) {
                                final contrato = _model.contratos[index];
                                final status = getJsonField(
                                        contrato, r'''$.status''')
                                    ?.toString();
                                final statusColor = _statusColor(status);

                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 4.0, 16.0, 4.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () async {
                                      context.pushNamed(
                                        'contratoDetalheM',
                                        queryParameters: {
                                          'contratoId': serializeParam(
                                            getJsonField(
                                                contrato, r'''$.id'''),
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border(
                                          left: BorderSide(
                                            color: statusColor,
                                            width: 4.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    getJsonField(contrato,
                                                                r'''$.passageiro_nome''')
                                                            ?.toString() ??
                                                        'Passageiro',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    color: statusColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Text(
                                                    status ?? '',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                          color: statusColor,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'R\$ ${getJsonField(contrato, r'''$.valor_mensal''')?.toString() ?? '0,00'}/mês',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                Icon(Icons.chevron_right,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0),
                                              ],
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '${getJsonField(contrato, r'''$.data_inicio''')?.toString() ?? ''} - ${getJsonField(contrato, r'''$.data_fim''')?.toString() ?? ''}',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
      BuildContext context, String label, String? status) {
    final isSelected = _model.filtroStatus == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) async {
        await _model.fetchContratos(FFAppState().idUsuario,
            status: selected ? status : null);
        safeSetState(() {});
      },
      selectedColor: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
      checkmarkColor: FlutterFlowTheme.of(context).primary,
      labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
            font: GoogleFonts.inter(fontWeight: FontWeight.w500),
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).secondaryText,
            letterSpacing: 0.0,
          ),
    );
  }
}
