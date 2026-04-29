import '/vivan/vivan.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'passageiros_lista_m_model.dart';
export 'passageiros_lista_m_model.dart';

class PassageirosListaMWidget extends StatefulWidget {
  const PassageirosListaMWidget({super.key});

  static String routeName = 'passageirosListaM';
  static String routePath = '/passageirosLista';

  @override
  State<PassageirosListaMWidget> createState() =>
      _PassageirosListaMWidgetState();
}

class _PassageirosListaMWidgetState extends State<PassageirosListaMWidget> {
  late PassageirosListaMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PassageirosListaMModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().idEmpresa == 0) {
        context.pushNamed(LoginWidget.routeName);
        return;
      }
      await _model.fetchPassageiros(FFAppState().idUsuario);
      safeSetState(() {});
    });

    _model.searchFieldTextController ??= TextEditingController();
    _model.searchFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          leading: FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).info,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Passageiros',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.w600,
                    fontStyle: FlutterFlowTheme.of(context)
                        .headlineMedium
                        .fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).info,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.description_outlined,
                color: FlutterFlowTheme.of(context).info,
                size: 24.0,
              ),
              onPressed: () async {
                context.pushNamed('contratosListaM');
              },
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
              child: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.add,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                onPressed: () async {
                  await context.pushNamed('passageiroFormM');
                  if (mounted) {
                    await _model.fetchPassageiros(FFAppState().idUsuario);
                    safeSetState(() {});
                  }
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
            mainAxisSize: MainAxisSize.max,
            children: [
              // Search bar
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                child: TextFormField(
                  controller: _model.searchFieldTextController,
                  focusNode: _model.searchFieldFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.searchFieldTextController',
                    Duration(milliseconds: 500),
                    () async {
                      await _model.fetchPassageiros(
                        FFAppState().idUsuario,
                        busca: _model.searchFieldTextController!.text,
                      );
                      safeSetState(() {});
                    },
                  ),
                  decoration: InputDecoration(
                    labelText: 'Buscar passageiro...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                    suffixIcon:
                        _model.searchFieldTextController!.text.isNotEmpty
                            ? InkWell(
                                onTap: () async {
                                  _model.searchFieldTextController?.clear();
                                  await _model.fetchPassageiros(
                                      FFAppState().idUsuario);
                                  safeSetState(() {});
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                              )
                            : null,
                    filled: true,
                    fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              // List
              Expanded(
                child: _model.isLoading
                    ? Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitPulse(
                            color:
                                FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      )
                    : _model.passageiros.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 64.0,
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Nenhum passageiro encontrado',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.normal,
                                        ),
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
                              await _model.fetchPassageiros(
                                FFAppState().idUsuario,
                                busca:
                                    _model.searchFieldTextController?.text,
                              );
                              safeSetState(() {});
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 80.0),
                              itemCount: _model.passageiros.length,
                              itemBuilder: (context, index) {
                                final passageiro = _model.passageiros[index];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 4.0, 16.0, 4.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () async {
                                      await context.pushNamed(
                                        'passageiroDetalheM',
                                        queryParameters: {
                                          'passageiroId': serializeParam(
                                            passageiro.idPassageiro,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                      if (mounted) {
                                        await _model.fetchPassageiros(FFAppState().idUsuario);
                                        safeSetState(() {});
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 48.0,
                                              height: 48.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .primary
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  passageiro.inicial,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12.0),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    passageiro.nomePassageiro,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Text(
                                                    passageiro.nomeEscola ?? 'Sem escola',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 4.0),
                                              decoration: BoxDecoration(
                                                color: passageiro.ativo
                                                    ? Color(0xFF39D2C0)
                                                        .withOpacity(0.2)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .alternate
                                                        .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Text(
                                                passageiro.ativo ? 'ATIVO' : 'INATIVO',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      color: passageiro.ativo
                                                          ? Color(0xFF39D2C0)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(width: 8.0),
                                            Icon(
                                              Icons.chevron_right,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
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
}
