import '/alunos/bts_aluno_busca/bts_aluno_busca_widget.dart';
import '/alunos/bts_aluno_busca_escola/bts_aluno_busca_escola_widget.dart';
import '/alunos/bts_aluno_busca_motorista_escola/bts_aluno_busca_motorista_escola_widget.dart';
import '/alunos/bts_aluno_editar/bts_aluno_editar_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/colaboradores/bts_colab_lista/bts_colab_lista_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/bts_aguarde/bts_aguarde_widget.dart';
import '/frame_work/bts_selecione/bts_selecione_widget.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/frame_work/menu_side_bar_reduzido/menu_side_bar_reduzido_widget.dart';
import '/frame_work/menu_side_bar_tablet/menu_side_bar_tablet_widget.dart';
import '/frame_work/row_aluno_vazio/row_aluno_vazio_widget.dart';
import '/frame_work/row_escola_vazio/row_escola_vazio_widget.dart';
import '/frame_work/row_motorista_vazio/row_motorista_vazio_widget.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard_admin_model.dart';
export 'dashboard_admin_model.dart';

class DashboardAdminWidget extends StatefulWidget {
  const DashboardAdminWidget({super.key});

  static String routeName = 'dashboardAdmin';
  static String routePath = '/dashAdmin';

  @override
  State<DashboardAdminWidget> createState() => _DashboardAdminWidgetState();
}

class _DashboardAdminWidgetState extends State<DashboardAdminWidget>
    with TickerProviderStateMixin {
  late DashboardAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardAdminModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().idEmpresa == 0) {
        FFAppState().nomeEmpresa = '';
        FFAppState().nomeUsuario = '';
        FFAppState().cargoUsuario = '';
        FFAppState().usuario = '';
        FFAppState().idEmpresa = 0;
        FFAppState().idUsuario = 0;
        safeSetState(() {});

        context.pushNamed(LoginWidget.routeName);
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.filterTextController ??= TextEditingController();
    _model.filterFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 400.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 500.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 400.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 500.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 100.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 500.0.ms,
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });

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
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 0.0,
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: wrapWithModel(
              model: _model.menuSideBarExpandidoModel2,
              updateCallback: () => safeSetState(() {}),
              child: MenuSideBarExpandidoWidget(),
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
                desktop: false,
              ))
                wrapWithModel(
                  model: _model.menuSideBarTabletModel,
                  updateCallback: () => safeSetState(() {}),
                  child: MenuSideBarTabletWidget(),
                ),
              if ((FFAppState().menuExpandido == false) &&
                  responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                    tabletLandscape: false,
                  ))
                wrapWithModel(
                  model: _model.menuSideBarReduzidoModel,
                  updateCallback: () => safeSetState(() {}),
                  child: MenuSideBarReduzidoWidget(),
                ),
              if (FFAppState().menuExpandido &&
                  responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                    tabletLandscape: false,
                  ))
                wrapWithModel(
                  model: _model.menuSideBarExpandidoModel1,
                  updateCallback: () => safeSetState(() {}),
                  child: MenuSideBarExpandidoWidget(),
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primary,
                            FlutterFlowTheme.of(context).alternate
                          ],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(-1.0, 0.0),
                          end: AlignmentDirectional(1.0, 0),
                        ),
                        borderRadius: BorderRadius.only(),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          width: 0.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (responsiveVisibility(
                              context: context,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      tablet: false,
                                      tabletLandscape: false,
                                      desktop: false,
                                    ))
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          scaffoldKey.currentState!
                                              .openDrawer();
                                        },
                                        child: Icon(
                                          Icons.menu_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 35.0,
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                    ))
                                      FaIcon(
                                        FontAwesomeIcons.bell,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        size: 24.0,
                                      ),
                                  ],
                                ),
                              ),
                            Expanded(
                              flex: 10,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      '${FFAppState().nomeEmpresa} :: Painel de Controle',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
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
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0.0, 0),
                            child: TabBar(
                              labelColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              unselectedLabelColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              unselectedLabelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              indicatorColor:
                                  FlutterFlowTheme.of(context).primary,
                              tabs: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 16.0, 0.0),
                                      child: Icon(
                                        FFIcons.klistSearch,
                                      ),
                                    ),
                                    Tab(
                                      text: MediaQuery.sizeOf(context).width >
                                              600.0
                                          ? 'Visão Geral'
                                          : ' ',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 16.0, 0.0),
                                      child: Icon(
                                        FFIcons.kcalendar2Week,
                                      ),
                                    ),
                                    Tab(
                                      text: MediaQuery.sizeOf(context).width >
                                              600.0
                                          ? 'Gestão de Pagamentos'
                                          : ' ',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 16.0, 0.0),
                                      child: Icon(
                                        FFIcons.ktableLight,
                                        size: 30.0,
                                      ),
                                    ),
                                    Tab(
                                      text: MediaQuery.sizeOf(context).width >
                                              600.0
                                          ? 'Gestão de Fechamentos'
                                          : ' ',
                                    ),
                                  ],
                                ),
                              ],
                              controller: _model.tabBarController,
                              onTap: (i) async {
                                [() async {}, () async {}, () async {}][i]();
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _model.tabBarController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                KeepAliveWidgetWrapper(
                                  builder: (context) => Visibility(
                                    visible: responsiveVisibility(
                                      context: context,
                                      tablet: false,
                                      tabletLandscape: false,
                                    ),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (responsiveVisibility(
                                            context: context,
                                            tabletLandscape: false,
                                            desktop: false,
                                          ))
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: Wrap(
                                                  spacing: 0.0,
                                                  runSpacing: 0.0,
                                                  alignment:
                                                      WrapAlignment.center,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  direction: Axis.horizontal,
                                                  runAlignment:
                                                      WrapAlignment.center,
                                                  verticalDirection:
                                                      VerticalDirection.down,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  8.0,
                                                                  8.0,
                                                                  8.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      BtsColabListaWidget(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                        child: Container(
                                                          width: 210.0,
                                                          height: 210.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          16.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/instructor_12809790.png',
                                                                          width:
                                                                              55.0,
                                                                          height:
                                                                              55.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: FutureBuilder<
                                                                          List<
                                                                              VeiculoRow>>(
                                                                        future:
                                                                            VeiculoTable().queryRows(
                                                                          queryFn: (q) =>
                                                                              q.eqOrNull(
                                                                            'idEmpresa',
                                                                            FFAppState().idEmpresa.toString(),
                                                                          ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 50.0,
                                                                                height: 50.0,
                                                                                child: SpinKitPulse(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  size: 50.0,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          List<VeiculoRow>
                                                                              textVeiculoRowList =
                                                                              snapshot.data!;

                                                                          return Text(
                                                                            textVeiculoRowList.length.toString().maybeHandleOverflow(
                                                                                  maxChars: 3,
                                                                                  replacement: '…',
                                                                                ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 23.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  lineHeight: 1.0,
                                                                                ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'containerOnPageLoadAnimation1']!),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  8.0,
                                                                  8.0,
                                                                  8.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      BtsAlunoBuscaWidget(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                        child: Container(
                                                          width: 210.0,
                                                          height: 210.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          16.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/graduation_12631742.png',
                                                                          width:
                                                                              55.0,
                                                                          height:
                                                                              55.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: FutureBuilder<
                                                                          List<
                                                                              RettotalunosativosRow>>(
                                                                        future:
                                                                            RettotalunosativosTable().querySingleRow(
                                                                          queryFn: (q) =>
                                                                              q,
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 50.0,
                                                                                height: 50.0,
                                                                                child: SpinKitPulse(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  size: 50.0,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          List<RettotalunosativosRow>
                                                                              textRettotalunosativosRowList =
                                                                              snapshot.data!;

                                                                          final textRettotalunosativosRow = textRettotalunosativosRowList.isNotEmpty
                                                                              ? textRettotalunosativosRowList.first
                                                                              : null;

                                                                          return Text(
                                                                            valueOrDefault<String>(
                                                                              textRettotalunosativosRow?.count?.toString(),
                                                                              '0',
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 23.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  lineHeight: 1.0,
                                                                                ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'containerOnPageLoadAnimation2']!),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                            tabletLandscape: false,
                                          ))
                                            Expanded(
                                              flex: 1,
                                              child: Wrap(
                                                spacing: 0.0,
                                                runSpacing: 0.0,
                                                alignment: WrapAlignment.start,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                direction: Axis.vertical,
                                                runAlignment:
                                                    WrapAlignment.start,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                clipBehavior: Clip.none,
                                                children: [
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                    tabletLandscape: false,
                                                  ))
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Wrap(
                                                          spacing: 0.0,
                                                          runSpacing: 0.0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .center,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.75,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  1.0,
                                                              constraints:
                                                                  BoxConstraints(
                                                                minWidth: 350.0,
                                                                minHeight: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.9,
                                                                maxHeight: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.9,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            3.0,
                                                                            0.0,
                                                                            3.0,
                                                                            0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              40.0,
                                                                          height:
                                                                              40.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).iconsBG,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Visibility(
                                                                            visible:
                                                                                responsiveVisibility(
                                                                              context: context,
                                                                              phone: false,
                                                                              tablet: false,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                              child: Container(
                                                                                width: 100.0,
                                                                                height: 60.0,
                                                                                decoration: BoxDecoration(),
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.asset(
                                                                                    'assets/images/building_5416643.png',
                                                                                    width: 25.0,
                                                                                    height: 25.0,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                                              height: 90.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                              ),
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 300.0,
                                                                                    constraints: BoxConstraints(
                                                                                      minWidth: 300.0,
                                                                                    ),
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        FlutterFlowRadioButton(
                                                                                          options: [
                                                                                            'Escola',
                                                                                            'Motorista',
                                                                                            'Aluno'
                                                                                          ].toList(),
                                                                                          onChanged: (val) => safeSetState(() {}),
                                                                                          controller: _model.rdgFiltroValueController ??= FormFieldController<String>('Escola'),
                                                                                          optionHeight: 32.0,
                                                                                          textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                              ),
                                                                                          selectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                          buttonPosition: RadioButtonPosition.left,
                                                                                          direction: Axis.horizontal,
                                                                                          radioButtonColor: FlutterFlowTheme.of(context).primary,
                                                                                          inactiveRadioButtonColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                          toggleable: false,
                                                                                          horizontalAlignment: WrapAlignment.start,
                                                                                          verticalAlignment: WrapCrossAlignment.start,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                          child: TextFormField(
                                                                                            controller: _model.filterTextController,
                                                                                            focusNode: _model.filterFocusNode,
                                                                                            onChanged: (_) => EasyDebounce.debounce(
                                                                                              '_model.filterTextController',
                                                                                              Duration(milliseconds: 2000),
                                                                                              () => safeSetState(() {}),
                                                                                            ),
                                                                                            autofocus: true,
                                                                                            obscureText: false,
                                                                                            decoration: InputDecoration(
                                                                                              alignLabelWithHint: false,
                                                                                              hintText: 'Pesquisar...',
                                                                                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                  ),
                                                                                              enabledBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                                borderRadius: const BorderRadius.only(
                                                                                                  topLeft: Radius.circular(4.0),
                                                                                                  topRight: Radius.circular(4.0),
                                                                                                ),
                                                                                              ),
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                                borderRadius: const BorderRadius.only(
                                                                                                  topLeft: Radius.circular(4.0),
                                                                                                  topRight: Radius.circular(4.0),
                                                                                                ),
                                                                                              ),
                                                                                              errorBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                                borderRadius: const BorderRadius.only(
                                                                                                  topLeft: Radius.circular(4.0),
                                                                                                  topRight: Radius.circular(4.0),
                                                                                                ),
                                                                                              ),
                                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                                borderRadius: const BorderRadius.only(
                                                                                                  topLeft: Radius.circular(4.0),
                                                                                                  topRight: Radius.circular(4.0),
                                                                                                ),
                                                                                              ),
                                                                                              filled: true,
                                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              prefixIcon: Icon(
                                                                                                FFIcons.ksearch,
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                size: 16.0,
                                                                                              ),
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.inter(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: Colors.black,
                                                                                                  fontSize: 12.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                            validator: _model.filterTextControllerValidator.asValidator(context),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Container(
                                                                              width: double.infinity,
                                                                              height: 35.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 6,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 100.0,
                                                                                        height: 100.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          ),
                                                                                        ),
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  'Escola',
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.inter(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  if (responsiveVisibility(
                                                                                    context: context,
                                                                                    phone: false,
                                                                                    tablet: false,
                                                                                  ))
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          height: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            ),
                                                                                          ),
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if (responsiveVisibility(
                                                                                    context: context,
                                                                                    phone: false,
                                                                                    tablet: false,
                                                                                  ))
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          height: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            ),
                                                                                          ),
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              'Alunos',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if (responsiveVisibility(
                                                                                    context: context,
                                                                                    phone: false,
                                                                                    tablet: false,
                                                                                  ))
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          height: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            ),
                                                                                          ),
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              'A Receber R\$',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if (responsiveVisibility(
                                                                                    context: context,
                                                                                    phone: false,
                                                                                    tablet: false,
                                                                                  ))
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          height: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            ),
                                                                                          ),
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              'A Pagar R\$',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if (responsiveVisibility(
                                                                                    context: context,
                                                                                    phone: false,
                                                                                    tablet: false,
                                                                                    tabletLandscape: false,
                                                                                  ))
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          height: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            ),
                                                                                          ),
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, -1.0),
                                                                              child: FutureBuilder<ApiCallResponse>(
                                                                                future: SearchEscolaListaCall.call(
                                                                                  searchString: _model.rdgFiltroValue == 'Escola' ? _model.filterTextController.text : '',
                                                                                ),
                                                                                builder: (context, snapshot) {
                                                                                  // Customize what your widget looks like when it's loading.
                                                                                  if (!snapshot.hasData) {
                                                                                    return Center(
                                                                                      child: SizedBox(
                                                                                        width: 50.0,
                                                                                        height: 50.0,
                                                                                        child: SpinKitPulse(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          size: 50.0,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                  final lstEscolasSearchEscolaListaResponse = snapshot.data!;

                                                                                  return Builder(
                                                                                    builder: (context) {
                                                                                      final escolasLista = lstEscolasSearchEscolaListaResponse.jsonBody.toList();
                                                                                      if (escolasLista.isEmpty) {
                                                                                        return RowEscolaVazioWidget();
                                                                                      }

                                                                                      return ListView.builder(
                                                                                        padding: EdgeInsets.zero,
                                                                                        shrinkWrap: true,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        itemCount: escolasLista.length,
                                                                                        itemBuilder: (context, escolasListaIndex) {
                                                                                          final escolasListaItem = escolasLista[escolasListaIndex];
                                                                                          return Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                                child: Container(
                                                                                                  width: double.infinity,
                                                                                                  height: 30.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: escolasListaIndex.floor().isEven ? FlutterFlowTheme.of(context).alternate : FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Expanded(
                                                                                                        flex: 6,
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                          child: Container(
                                                                                                            width: 100.0,
                                                                                                            height: 60.0,
                                                                                                            decoration: BoxDecoration(),
                                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              children: [
                                                                                                                Padding(
                                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                  child: InkWell(
                                                                                                                    splashColor: Colors.transparent,
                                                                                                                    focusColor: Colors.transparent,
                                                                                                                    hoverColor: Colors.transparent,
                                                                                                                    highlightColor: Colors.transparent,
                                                                                                                    onTap: () async {
                                                                                                                      await showModalBottomSheet(
                                                                                                                        isScrollControlled: true,
                                                                                                                        backgroundColor: Colors.transparent,
                                                                                                                        enableDrag: false,
                                                                                                                        context: context,
                                                                                                                        builder: (context) {
                                                                                                                          return GestureDetector(
                                                                                                                            onTap: () {
                                                                                                                              FocusScope.of(context).unfocus();
                                                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                            },
                                                                                                                            child: Padding(
                                                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                                                              child: BtsAlunoBuscaEscolaWidget(
                                                                                                                                idAluno: 0,
                                                                                                                                domSitAluno: 'Ativo',
                                                                                                                                idEscolaDash: getJsonField(
                                                                                                                                  escolasListaItem,
                                                                                                                                  r'''$.idEscola''',
                                                                                                                                ),
                                                                                                                                nomeEscola: getJsonField(
                                                                                                                                  escolasListaItem,
                                                                                                                                  r'''$.nomeEscola''',
                                                                                                                                ).toString(),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        },
                                                                                                                      ).then((value) => safeSetState(() {}));

                                                                                                                      FFAppState().idEscolaUsuario = SearchEscolaListaCall.idEscola(
                                                                                                                        lstEscolasSearchEscolaListaResponse.jsonBody,
                                                                                                                      )!;
                                                                                                                    },
                                                                                                                    child: Text(
                                                                                                                      '${getJsonField(
                                                                                                                        escolasListaItem,
                                                                                                                        r'''$.siglaEscola''',
                                                                                                                      ).toString()}-${getJsonField(
                                                                                                                        escolasListaItem,
                                                                                                                        r'''$.nomeEscola''',
                                                                                                                      ).toString()}',
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.inter(
                                                                                                                              fontWeight: FontWeight.w600,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            color: Colors.black,
                                                                                                                            fontSize: 12.0,
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w600,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      if (responsiveVisibility(
                                                                                                        context: context,
                                                                                                        phone: false,
                                                                                                        tablet: false,
                                                                                                      ))
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 100.0,
                                                                                                              height: 60.0,
                                                                                                              decoration: BoxDecoration(),
                                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      if (responsiveVisibility(
                                                                                                        context: context,
                                                                                                        phone: false,
                                                                                                        tablet: false,
                                                                                                      ))
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 100.0,
                                                                                                              height: 60.0,
                                                                                                              decoration: BoxDecoration(),
                                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                              child: Padding(
                                                                                                                padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                child: InkWell(
                                                                                                                  splashColor: Colors.transparent,
                                                                                                                  focusColor: Colors.transparent,
                                                                                                                  hoverColor: Colors.transparent,
                                                                                                                  highlightColor: Colors.transparent,
                                                                                                                  onTap: () async {
                                                                                                                    await showModalBottomSheet(
                                                                                                                      isScrollControlled: true,
                                                                                                                      backgroundColor: Colors.transparent,
                                                                                                                      enableDrag: false,
                                                                                                                      context: context,
                                                                                                                      builder: (context) {
                                                                                                                        return GestureDetector(
                                                                                                                          onTap: () {
                                                                                                                            FocusScope.of(context).unfocus();
                                                                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                          },
                                                                                                                          child: Padding(
                                                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                                                            child: BtsAlunoBuscaEscolaWidget(
                                                                                                                              idAluno: 0,
                                                                                                                              domSitAluno: 'Ativo',
                                                                                                                              idEscolaDash: getJsonField(
                                                                                                                                escolasListaItem,
                                                                                                                                r'''$.idEscola''',
                                                                                                                              ),
                                                                                                                              nomeEscola: getJsonField(
                                                                                                                                escolasListaItem,
                                                                                                                                r'''$.nomeEscola''',
                                                                                                                              ).toString(),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      },
                                                                                                                    ).then((value) => safeSetState(() {}));

                                                                                                                    FFAppState().idEscolaUsuario = SearchEscolaListaCall.idEscola(
                                                                                                                      lstEscolasSearchEscolaListaResponse.jsonBody,
                                                                                                                    )!;
                                                                                                                  },
                                                                                                                  child: Text(
                                                                                                                    valueOrDefault<String>(
                                                                                                                      getJsonField(
                                                                                                                        escolasListaItem,
                                                                                                                        r'''$.alunosmotorista ''',
                                                                                                                      )?.toString(),
                                                                                                                      '-',
                                                                                                                    ),
                                                                                                                    textAlign: TextAlign.end,
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FontWeight.w300,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          color: Colors.black,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.w300,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      if (responsiveVisibility(
                                                                                                        context: context,
                                                                                                        phone: false,
                                                                                                        tablet: false,
                                                                                                      ))
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 100.0,
                                                                                                              height: 60.0,
                                                                                                              decoration: BoxDecoration(),
                                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                              child: Padding(
                                                                                                                padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                child: Text(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    getJsonField(
                                                                                                                      escolasListaItem,
                                                                                                                      r'''$.valalunosmotorista ''',
                                                                                                                    )?.toString(),
                                                                                                                    '-',
                                                                                                                  ),
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.w300,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        color: Colors.black,
                                                                                                                        fontSize: 12.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w300,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      if (responsiveVisibility(
                                                                                                        context: context,
                                                                                                        phone: false,
                                                                                                        tablet: false,
                                                                                                      ))
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 100.0,
                                                                                                              height: 60.0,
                                                                                                              decoration: BoxDecoration(),
                                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                              child: Padding(
                                                                                                                padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                child: Text(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    getJsonField(
                                                                                                                      escolasListaItem,
                                                                                                                      r'''$.valalunosapagar''',
                                                                                                                    )?.toString(),
                                                                                                                    '-',
                                                                                                                  ),
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.w300,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        color: Colors.black,
                                                                                                                        fontSize: 12.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w300,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      if (responsiveVisibility(
                                                                                                        context: context,
                                                                                                        phone: false,
                                                                                                        tablet: false,
                                                                                                      ))
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Container(
                                                                                                            width: 100.0,
                                                                                                            height: 35.0,
                                                                                                            decoration: BoxDecoration(),
                                                                                                            alignment: AlignmentDirectional(0.0, -1.0),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              children: [
                                                                                                                InkWell(
                                                                                                                  splashColor: Colors.transparent,
                                                                                                                  focusColor: Colors.transparent,
                                                                                                                  hoverColor: Colors.transparent,
                                                                                                                  highlightColor: Colors.transparent,
                                                                                                                  onTap: () async {
                                                                                                                    showModalBottomSheet(
                                                                                                                      isScrollControlled: true,
                                                                                                                      backgroundColor: Colors.transparent,
                                                                                                                      enableDrag: false,
                                                                                                                      context: context,
                                                                                                                      builder: (context) {
                                                                                                                        return GestureDetector(
                                                                                                                          onTap: () {
                                                                                                                            FocusScope.of(context).unfocus();
                                                                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                          },
                                                                                                                          child: Padding(
                                                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                                                            child: BtsAguardeWidget(),
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      },
                                                                                                                    ).then((value) => safeSetState(() {}));

                                                                                                                    _model.apiResGeraListaAlunosEsc = await RetListagemAlunosMotEscCall.call(
                                                                                                                      idEscola: getJsonField(
                                                                                                                        escolasListaItem,
                                                                                                                        r'''$.idEscola''',
                                                                                                                      ).toString(),
                                                                                                                      idMotorista: '0',
                                                                                                                    );

                                                                                                                    await launchURL(getJsonField(
                                                                                                                      (_model.apiResGeraListaAlunosEsc?.jsonBody ?? ''),
                                                                                                                      r'''$.urlArquivo''',
                                                                                                                    ).toString());
                                                                                                                    Navigator.pop(context);
                                                                                                                    unawaited(
                                                                                                                      () async {}(),
                                                                                                                    );

                                                                                                                    safeSetState(() {});
                                                                                                                  },
                                                                                                                  child: Icon(
                                                                                                                    FFIcons.kqueueList,
                                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                ToggleIcon(
                                                                                                                  onPressed: () async {
                                                                                                                    safeSetState(() => FFAppState().boExpEscola = !FFAppState().boExpEscola);
                                                                                                                  },
                                                                                                                  value: FFAppState().boExpEscola,
                                                                                                                  onIcon: Icon(
                                                                                                                    Icons.keyboard_arrow_down,
                                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                                    size: 26.0,
                                                                                                                  ),
                                                                                                                  offIcon: Icon(
                                                                                                                    Icons.keyboard_arrow_right_sharp,
                                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                                    size: 30.0,
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
                                                                                              if (FFAppState().boExpEscola)
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: 35.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    ),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          flex: 8,
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 100.0,
                                                                                                              height: 100.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                border: Border.all(
                                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                ),
                                                                                                              ),
                                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                children: [
                                                                                                                  Expanded(
                                                                                                                    flex: 1,
                                                                                                                    child: Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                      child: Text(
                                                                                                                        'Motorista',
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.inter(
                                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 12.0,
                                                                                                                              letterSpacing: 0.0,
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        if (responsiveVisibility(
                                                                                                          context: context,
                                                                                                          phone: false,
                                                                                                          tablet: false,
                                                                                                        ))
                                                                                                          Expanded(
                                                                                                            flex: 2,
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 100.0,
                                                                                                                height: 100.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  border: Border.all(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                                child: Padding(
                                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                  child: Text(
                                                                                                                    'Alunos',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        if (responsiveVisibility(
                                                                                                          context: context,
                                                                                                          phone: false,
                                                                                                          tablet: false,
                                                                                                        ))
                                                                                                          Expanded(
                                                                                                            flex: 2,
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 100.0,
                                                                                                                height: 100.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  border: Border.all(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                                child: Padding(
                                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                  child: Text(
                                                                                                                    'Valor R\$',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        if (responsiveVisibility(
                                                                                                          context: context,
                                                                                                          phone: false,
                                                                                                          tablet: false,
                                                                                                          tabletLandscape: false,
                                                                                                        ))
                                                                                                          Expanded(
                                                                                                            flex: 2,
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 100.0,
                                                                                                                height: 100.0,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  border: Border.all(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              if (FFAppState().boExpEscola)
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 8.0),
                                                                                                    child: FutureBuilder<ApiCallResponse>(
                                                                                                      future: SearchEscolaMotoristaListaCall.call(
                                                                                                        searchEscola: getJsonField(
                                                                                                          escolasListaItem,
                                                                                                          r'''$.idEscola''',
                                                                                                        ).toString(),
                                                                                                        searchString: _model.rdgFiltroValue == 'Motorista' ? _model.filterTextController.text : '',
                                                                                                      ),
                                                                                                      builder: (context, snapshot) {
                                                                                                        // Customize what your widget looks like when it's loading.
                                                                                                        if (!snapshot.hasData) {
                                                                                                          return Center(
                                                                                                            child: SizedBox(
                                                                                                              width: 50.0,
                                                                                                              height: 50.0,
                                                                                                              child: SpinKitPulse(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                size: 50.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        }
                                                                                                        final lstMotoristaSearchEscolaMotoristaListaResponse = snapshot.data!;

                                                                                                        return Builder(
                                                                                                          builder: (context) {
                                                                                                            final motoristaLista = lstMotoristaSearchEscolaMotoristaListaResponse.jsonBody.toList();
                                                                                                            if (motoristaLista.isEmpty) {
                                                                                                              return RowMotoristaVazioWidget();
                                                                                                            }

                                                                                                            return ListView.builder(
                                                                                                              padding: EdgeInsets.zero,
                                                                                                              shrinkWrap: true,
                                                                                                              scrollDirection: Axis.vertical,
                                                                                                              itemCount: motoristaLista.length,
                                                                                                              itemBuilder: (context, motoristaListaIndex) {
                                                                                                                final motoristaListaItem = motoristaLista[motoristaListaIndex];
                                                                                                                return Column(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  children: [
                                                                                                                    Container(
                                                                                                                      width: double.infinity,
                                                                                                                      height: 30.0,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        color: motoristaListaIndex.floor().isEven ? Color(0xFFBBDDBB) : FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                      ),
                                                                                                                      child: Row(
                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                        children: [
                                                                                                                          Expanded(
                                                                                                                            flex: 8,
                                                                                                                            child: Padding(
                                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                                              child: Container(
                                                                                                                                width: 100.0,
                                                                                                                                height: 60.0,
                                                                                                                                decoration: BoxDecoration(),
                                                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                                                child: Row(
                                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                                  children: [
                                                                                                                                    Padding(
                                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                                      child: InkWell(
                                                                                                                                        splashColor: Colors.transparent,
                                                                                                                                        focusColor: Colors.transparent,
                                                                                                                                        hoverColor: Colors.transparent,
                                                                                                                                        highlightColor: Colors.transparent,
                                                                                                                                        onTap: () async {
                                                                                                                                          await showModalBottomSheet(
                                                                                                                                            isScrollControlled: true,
                                                                                                                                            backgroundColor: Colors.transparent,
                                                                                                                                            enableDrag: false,
                                                                                                                                            context: context,
                                                                                                                                            builder: (context) {
                                                                                                                                              return GestureDetector(
                                                                                                                                                onTap: () {
                                                                                                                                                  FocusScope.of(context).unfocus();
                                                                                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                                                },
                                                                                                                                                child: Padding(
                                                                                                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                                  child: BtsAlunoBuscaMotoristaEscolaWidget(
                                                                                                                                                    parUsuario: getJsonField(
                                                                                                                                                      motoristaListaItem,
                                                                                                                                                      r'''$.idUsuario''',
                                                                                                                                                    ),
                                                                                                                                                    idEscolaDash: getJsonField(
                                                                                                                                                      motoristaListaItem,
                                                                                                                                                      r'''$.idEscola''',
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              );
                                                                                                                                            },
                                                                                                                                          ).then((value) => safeSetState(() {}));

                                                                                                                                          FFAppState().idEscolaUsuario = SearchEscolaListaCall.idEscola(
                                                                                                                                            lstEscolasSearchEscolaListaResponse.jsonBody,
                                                                                                                                          )!;
                                                                                                                                        },
                                                                                                                                        child: Text(
                                                                                                                                          getJsonField(
                                                                                                                                            motoristaListaItem,
                                                                                                                                            r'''$.nomeUsuario''',
                                                                                                                                          ).toString(),
                                                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                                font: GoogleFonts.inter(
                                                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                ),
                                                                                                                                                color: Color(0xFF020202),
                                                                                                                                                fontSize: 12.0,
                                                                                                                                                letterSpacing: 0.0,
                                                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                              ),
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          if (responsiveVisibility(
                                                                                                                            context: context,
                                                                                                                            tablet: false,
                                                                                                                          ))
                                                                                                                            Expanded(
                                                                                                                              flex: 2,
                                                                                                                              child: Padding(
                                                                                                                                padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                                                child: Container(
                                                                                                                                  width: 100.0,
                                                                                                                                  height: 60.0,
                                                                                                                                  decoration: BoxDecoration(),
                                                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                                                  child: Padding(
                                                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                                    child: Text(
                                                                                                                                      '${valueOrDefault<String>(
                                                                                                                                        getJsonField(
                                                                                                                                          motoristaListaItem,
                                                                                                                                          r'''$.assentosocupados''',
                                                                                                                                        )?.toString(),
                                                                                                                                        '-',
                                                                                                                                      )}',
                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                            font: GoogleFonts.inter(
                                                                                                                                              fontWeight: FontWeight.w300,
                                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                            ),
                                                                                                                                            color: Color(0xFF020202),
                                                                                                                                            fontSize: 10.0,
                                                                                                                                            letterSpacing: 0.0,
                                                                                                                                            fontWeight: FontWeight.w300,
                                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                          ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          if (responsiveVisibility(
                                                                                                                            context: context,
                                                                                                                            tablet: false,
                                                                                                                          ))
                                                                                                                            Expanded(
                                                                                                                              flex: 2,
                                                                                                                              child: Padding(
                                                                                                                                padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                                                child: Container(
                                                                                                                                  width: 100.0,
                                                                                                                                  height: 60.0,
                                                                                                                                  decoration: BoxDecoration(),
                                                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                                                  child: Padding(
                                                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                                                    child: Text(
                                                                                                                                      '${valueOrDefault<String>(
                                                                                                                                        getJsonField(
                                                                                                                                          motoristaListaItem,
                                                                                                                                          r'''$.valormensal''',
                                                                                                                                        )?.toString(),
                                                                                                                                        '-',
                                                                                                                                      )}',
                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                            font: GoogleFonts.inter(
                                                                                                                                              fontWeight: FontWeight.w300,
                                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                            ),
                                                                                                                                            color: Color(0xFF020202),
                                                                                                                                            fontSize: 10.0,
                                                                                                                                            letterSpacing: 0.0,
                                                                                                                                            fontWeight: FontWeight.w300,
                                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                          ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          if (responsiveVisibility(
                                                                                                                            context: context,
                                                                                                                            tablet: false,
                                                                                                                          ))
                                                                                                                            Expanded(
                                                                                                                              flex: 2,
                                                                                                                              child: Padding(
                                                                                                                                padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                                                child: Container(
                                                                                                                                  width: 100.0,
                                                                                                                                  height: 60.0,
                                                                                                                                  decoration: BoxDecoration(),
                                                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                                  child: Row(
                                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                                    children: [
                                                                                                                                      InkWell(
                                                                                                                                        splashColor: Colors.transparent,
                                                                                                                                        focusColor: Colors.transparent,
                                                                                                                                        hoverColor: Colors.transparent,
                                                                                                                                        highlightColor: Colors.transparent,
                                                                                                                                        onTap: () async {
                                                                                                                                          showModalBottomSheet(
                                                                                                                                            isScrollControlled: true,
                                                                                                                                            backgroundColor: Colors.transparent,
                                                                                                                                            enableDrag: false,
                                                                                                                                            context: context,
                                                                                                                                            builder: (context) {
                                                                                                                                              return GestureDetector(
                                                                                                                                                onTap: () {
                                                                                                                                                  FocusScope.of(context).unfocus();
                                                                                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                                                },
                                                                                                                                                child: Padding(
                                                                                                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                                  child: BtsAguardeWidget(),
                                                                                                                                                ),
                                                                                                                                              );
                                                                                                                                            },
                                                                                                                                          ).then((value) => safeSetState(() {}));

                                                                                                                                          _model.apiResGeraDemonstrativo = await WhgeradempfpjCall.call(
                                                                                                                                            idEscola: getJsonField(
                                                                                                                                              escolasListaItem,
                                                                                                                                              r'''$.idEscola''',
                                                                                                                                            ).toString(),
                                                                                                                                            idMotorista: getJsonField(
                                                                                                                                              motoristaListaItem,
                                                                                                                                              r'''$.idUsuario''',
                                                                                                                                            ).toString(),
                                                                                                                                          );

                                                                                                                                          await launchURL(getJsonField(
                                                                                                                                            (_model.apiResGeraDemonstrativo?.jsonBody ?? ''),
                                                                                                                                            r'''$.urlArquivo''',
                                                                                                                                          ).toString());
                                                                                                                                          Navigator.pop(context);
                                                                                                                                          unawaited(
                                                                                                                                            () async {}(),
                                                                                                                                          );

                                                                                                                                          safeSetState(() {});
                                                                                                                                        },
                                                                                                                                        child: Icon(
                                                                                                                                          FFIcons.kfileDollar,
                                                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                                                          size: 24.0,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                      Padding(
                                                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                                                        child: InkWell(
                                                                                                                                          splashColor: Colors.transparent,
                                                                                                                                          focusColor: Colors.transparent,
                                                                                                                                          hoverColor: Colors.transparent,
                                                                                                                                          highlightColor: Colors.transparent,
                                                                                                                                          onTap: () async {
                                                                                                                                            showModalBottomSheet(
                                                                                                                                              isScrollControlled: true,
                                                                                                                                              backgroundColor: Colors.transparent,
                                                                                                                                              enableDrag: false,
                                                                                                                                              context: context,
                                                                                                                                              builder: (context) {
                                                                                                                                                return GestureDetector(
                                                                                                                                                  onTap: () {
                                                                                                                                                    FocusScope.of(context).unfocus();
                                                                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                                                  },
                                                                                                                                                  child: Padding(
                                                                                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                                    child: BtsAguardeWidget(),
                                                                                                                                                  ),
                                                                                                                                                );
                                                                                                                                              },
                                                                                                                                            ).then((value) => safeSetState(() {}));

                                                                                                                                            _model.apiResGeraFatSinteticoMot = await RetFaturamentoSinteticoMotCall.call(
                                                                                                                                              idMotorista: getJsonField(
                                                                                                                                                motoristaListaItem,
                                                                                                                                                r'''$.idUsuario''',
                                                                                                                                              ).toString(),
                                                                                                                                              idEscola: getJsonField(
                                                                                                                                                escolasListaItem,
                                                                                                                                                r'''$.idEscola''',
                                                                                                                                              ).toString(),
                                                                                                                                            );

                                                                                                                                            await launchURL(getJsonField(
                                                                                                                                              (_model.apiResGeraFatSinteticoMot?.jsonBody ?? ''),
                                                                                                                                              r'''$.urlArquivo''',
                                                                                                                                            ).toString());
                                                                                                                                            Navigator.pop(context);
                                                                                                                                            unawaited(
                                                                                                                                              () async {}(),
                                                                                                                                            );

                                                                                                                                            safeSetState(() {});
                                                                                                                                          },
                                                                                                                                          child: Icon(
                                                                                                                                            FFIcons.kuserDollar,
                                                                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                                                                            size: 24.0,
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                      Padding(
                                                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                                                        child: InkWell(
                                                                                                                                          splashColor: Colors.transparent,
                                                                                                                                          focusColor: Colors.transparent,
                                                                                                                                          hoverColor: Colors.transparent,
                                                                                                                                          highlightColor: Colors.transparent,
                                                                                                                                          onTap: () async {
                                                                                                                                            showModalBottomSheet(
                                                                                                                                              isScrollControlled: true,
                                                                                                                                              backgroundColor: Colors.transparent,
                                                                                                                                              enableDrag: false,
                                                                                                                                              context: context,
                                                                                                                                              builder: (context) {
                                                                                                                                                return GestureDetector(
                                                                                                                                                  onTap: () {
                                                                                                                                                    FocusScope.of(context).unfocus();
                                                                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                                                  },
                                                                                                                                                  child: Padding(
                                                                                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                                    child: BtsAguardeWidget(),
                                                                                                                                                  ),
                                                                                                                                                );
                                                                                                                                              },
                                                                                                                                            ).then((value) => safeSetState(() {}));

                                                                                                                                            _model.apiResGeraListaAlunos = await RetListagemAlunosMotEscCall.call(
                                                                                                                                              idMotorista: getJsonField(
                                                                                                                                                motoristaListaItem,
                                                                                                                                                r'''$.idUsuario''',
                                                                                                                                              ).toString(),
                                                                                                                                              idEscola: getJsonField(
                                                                                                                                                escolasListaItem,
                                                                                                                                                r'''$.idEscola''',
                                                                                                                                              ).toString(),
                                                                                                                                            );

                                                                                                                                            await launchURL(getJsonField(
                                                                                                                                              (_model.apiResGeraListaAlunos?.jsonBody ?? ''),
                                                                                                                                              r'''$.urlArquivo''',
                                                                                                                                            ).toString());
                                                                                                                                            Navigator.pop(context);
                                                                                                                                            unawaited(
                                                                                                                                              () async {}(),
                                                                                                                                            );

                                                                                                                                            safeSetState(() {});
                                                                                                                                          },
                                                                                                                                          child: Icon(
                                                                                                                                            FFIcons.kqueueList,
                                                                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                                                                            size: 24.0,
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                      if (_model.rdgFiltroValue == 'Aluno')
                                                                                                                                        Align(
                                                                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                                          child: ToggleIcon(
                                                                                                                                            onPressed: () async {
                                                                                                                                              safeSetState(() => FFAppState().boExpMotorista = !FFAppState().boExpMotorista);
                                                                                                                                            },
                                                                                                                                            value: FFAppState().boExpMotorista,
                                                                                                                                            onIcon: Icon(
                                                                                                                                              Icons.keyboard_arrow_down,
                                                                                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                                                                                              size: 30.0,
                                                                                                                                            ),
                                                                                                                                            offIcon: Icon(
                                                                                                                                              Icons.keyboard_arrow_right,
                                                                                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                                                                                              size: 26.0,
                                                                                                                                            ),
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                    ],
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    if (FFAppState().boExpMotorista)
                                                                                                                      Padding(
                                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                                                                                                        child: Container(
                                                                                                                          width: double.infinity,
                                                                                                                          height: 40.0,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                            border: Border.all(
                                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                              width: 5.0,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          child: Row(
                                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                                            children: [
                                                                                                                              Expanded(
                                                                                                                                flex: 8,
                                                                                                                                child: Container(
                                                                                                                                  decoration: BoxDecoration(),
                                                                                                                                  child: Padding(
                                                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                                                                    child: Row(
                                                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                      children: [
                                                                                                                                        Expanded(
                                                                                                                                          flex: 1,
                                                                                                                                          child: Padding(
                                                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                                                                                                                            child: AutoSizeText(
                                                                                                                                              'Nome do Aluno',
                                                                                                                                              textAlign: TextAlign.start,
                                                                                                                                              minFontSize: 8.0,
                                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                                    font: GoogleFonts.inter(
                                                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                    ),
                                                                                                                                                    color: Colors.black,
                                                                                                                                                    fontSize: 12.0,
                                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                  ),
                                                                                                                                            ),
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Expanded(
                                                                                                                                flex: 2,
                                                                                                                                child: Container(
                                                                                                                                  decoration: BoxDecoration(),
                                                                                                                                  child: Padding(
                                                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                                                                    child: Row(
                                                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                      children: [
                                                                                                                                        Expanded(
                                                                                                                                          flex: 1,
                                                                                                                                          child: AutoSizeText(
                                                                                                                                            'Turno',
                                                                                                                                            textAlign: TextAlign.start,
                                                                                                                                            minFontSize: 8.0,
                                                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                                  font: GoogleFonts.inter(
                                                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                  ),
                                                                                                                                                  color: Colors.black,
                                                                                                                                                  fontSize: 12.0,
                                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                ),
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Expanded(
                                                                                                                                flex: 2,
                                                                                                                                child: Container(
                                                                                                                                  decoration: BoxDecoration(),
                                                                                                                                  child: Padding(
                                                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                                                                    child: Row(
                                                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                      children: [
                                                                                                                                        Expanded(
                                                                                                                                          flex: 1,
                                                                                                                                          child: AutoSizeText(
                                                                                                                                            'Valor R\$',
                                                                                                                                            textAlign: TextAlign.start,
                                                                                                                                            minFontSize: 8.0,
                                                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                                  font: GoogleFonts.inter(
                                                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                  ),
                                                                                                                                                  color: Colors.black,
                                                                                                                                                  fontSize: 12.0,
                                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                ),
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              if (responsiveVisibility(
                                                                                                                                context: context,
                                                                                                                                phone: false,
                                                                                                                                tablet: false,
                                                                                                                                tabletLandscape: false,
                                                                                                                              ))
                                                                                                                                Expanded(
                                                                                                                                  flex: 2,
                                                                                                                                  child: Padding(
                                                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                                                    child: Container(
                                                                                                                                      width: 100.0,
                                                                                                                                      height: 100.0,
                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                        border: Border.all(
                                                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    if (FFAppState().boExpMotorista)
                                                                                                                      Expanded(
                                                                                                                        flex: 1,
                                                                                                                        child: Padding(
                                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                                                                                                          child: FutureBuilder<ApiCallResponse>(
                                                                                                                            future: SearchEscolaMotoristaAlunoCall.call(
                                                                                                                              searchString: _model.rdgFiltroValue == 'Aluno' ? _model.filterTextController.text : '',
                                                                                                                              searchMotorista: getJsonField(
                                                                                                                                motoristaListaItem,
                                                                                                                                r'''$.idUsuario''',
                                                                                                                              ),
                                                                                                                              searchEscola: getJsonField(
                                                                                                                                escolasListaItem,
                                                                                                                                r'''$.idEscola''',
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            builder: (context, snapshot) {
                                                                                                                              // Customize what your widget looks like when it's loading.
                                                                                                                              if (!snapshot.hasData) {
                                                                                                                                return Center(
                                                                                                                                  child: SizedBox(
                                                                                                                                    width: 50.0,
                                                                                                                                    height: 50.0,
                                                                                                                                    child: SpinKitPulse(
                                                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                      size: 50.0,
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                );
                                                                                                                              }
                                                                                                                              final wrpAlunosSearchEscolaMotoristaAlunoResponse = snapshot.data!;

                                                                                                                              return Builder(
                                                                                                                                builder: (context) {
                                                                                                                                  final alunosListaWrap = wrpAlunosSearchEscolaMotoristaAlunoResponse.jsonBody.toList();
                                                                                                                                  if (alunosListaWrap.isEmpty) {
                                                                                                                                    return RowAlunoVazioWidget();
                                                                                                                                  }

                                                                                                                                  return Wrap(
                                                                                                                                    spacing: 0.0,
                                                                                                                                    runSpacing: 0.0,
                                                                                                                                    alignment: WrapAlignment.start,
                                                                                                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                                                                                                    direction: Axis.horizontal,
                                                                                                                                    runAlignment: WrapAlignment.start,
                                                                                                                                    verticalDirection: VerticalDirection.down,
                                                                                                                                    clipBehavior: Clip.none,
                                                                                                                                    children: List.generate(alunosListaWrap.length, (alunosListaWrapIndex) {
                                                                                                                                      final alunosListaWrapItem = alunosListaWrap[alunosListaWrapIndex];
                                                                                                                                      return Column(
                                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                                        children: [
                                                                                                                                          Container(
                                                                                                                                            width: double.infinity,
                                                                                                                                            height: 40.0,
                                                                                                                                            decoration: BoxDecoration(
                                                                                                                                              color: alunosListaWrapIndex.floor().isEven ? Color(0xFFBABAD2) : FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                              border: Border.all(
                                                                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                                                width: 5.0,
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                                                                            child: Row(
                                                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                                                              children: [
                                                                                                                                                Icon(
                                                                                                                                                  FFIcons.kcheckFatFill,
                                                                                                                                                  color: getJsonField(
                                                                                                                                                    alunosListaWrapItem,
                                                                                                                                                    r'''$.domCheckAluno''',
                                                                                                                                                  )
                                                                                                                                                      ? FlutterFlowTheme.of(context).primary
                                                                                                                                                      : FlutterFlowTheme.of(context).error,
                                                                                                                                                  size: 24.0,
                                                                                                                                                ),
                                                                                                                                                Expanded(
                                                                                                                                                  flex: 8,
                                                                                                                                                  child: Container(
                                                                                                                                                    decoration: BoxDecoration(),
                                                                                                                                                    child: Padding(
                                                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                                                                                      child: Row(
                                                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                                        children: [
                                                                                                                                                          Expanded(
                                                                                                                                                            flex: 1,
                                                                                                                                                            child: InkWell(
                                                                                                                                                              splashColor: Colors.transparent,
                                                                                                                                                              focusColor: Colors.transparent,
                                                                                                                                                              hoverColor: Colors.transparent,
                                                                                                                                                              highlightColor: Colors.transparent,
                                                                                                                                                              onTap: () async {
                                                                                                                                                                await showModalBottomSheet(
                                                                                                                                                                  isScrollControlled: true,
                                                                                                                                                                  backgroundColor: Colors.transparent,
                                                                                                                                                                  enableDrag: false,
                                                                                                                                                                  context: context,
                                                                                                                                                                  builder: (context) {
                                                                                                                                                                    return GestureDetector(
                                                                                                                                                                      onTap: () {
                                                                                                                                                                        FocusScope.of(context).unfocus();
                                                                                                                                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                                                                      },
                                                                                                                                                                      child: Padding(
                                                                                                                                                                        padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                                                        child: BtsAlunoEditarWidget(
                                                                                                                                                                          idAluno: getJsonField(
                                                                                                                                                                            alunosListaWrapItem,
                                                                                                                                                                            r'''$.idAluno''',
                                                                                                                                                                          ),
                                                                                                                                                                        ),
                                                                                                                                                                      ),
                                                                                                                                                                    );
                                                                                                                                                                  },
                                                                                                                                                                ).then((value) => safeSetState(() {}));

                                                                                                                                                                FFAppState().idEscolaUsuario = SearchEscolaListaCall.idEscola(
                                                                                                                                                                  lstEscolasSearchEscolaListaResponse.jsonBody,
                                                                                                                                                                )!;
                                                                                                                                                              },
                                                                                                                                                              child: AutoSizeText(
                                                                                                                                                                getJsonField(
                                                                                                                                                                  alunosListaWrapItem,
                                                                                                                                                                  r'''$.nomeAluno''',
                                                                                                                                                                ).toString(),
                                                                                                                                                                textAlign: TextAlign.start,
                                                                                                                                                                minFontSize: 8.0,
                                                                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                                                      font: GoogleFonts.inter(
                                                                                                                                                                        fontWeight: FontWeight.w300,
                                                                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                                      ),
                                                                                                                                                                      color: Colors.black,
                                                                                                                                                                      fontSize: 12.0,
                                                                                                                                                                      letterSpacing: 0.0,
                                                                                                                                                                      fontWeight: FontWeight.w300,
                                                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                                    ),
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                        ],
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                                Expanded(
                                                                                                                                                  flex: 2,
                                                                                                                                                  child: Container(
                                                                                                                                                    decoration: BoxDecoration(),
                                                                                                                                                    child: Padding(
                                                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                                                                                      child: Row(
                                                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                        children: [
                                                                                                                                                          Expanded(
                                                                                                                                                            flex: 1,
                                                                                                                                                            child: AutoSizeText(
                                                                                                                                                              getJsonField(
                                                                                                                                                                alunosListaWrapItem,
                                                                                                                                                                r'''$.domTurno''',
                                                                                                                                                              ).toString(),
                                                                                                                                                              textAlign: TextAlign.start,
                                                                                                                                                              minFontSize: 8.0,
                                                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                                                    font: GoogleFonts.inter(
                                                                                                                                                                      fontWeight: FontWeight.w300,
                                                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                                    ),
                                                                                                                                                                    color: Colors.black,
                                                                                                                                                                    fontSize: 10.0,
                                                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                                                    fontWeight: FontWeight.w300,
                                                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                                  ),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                        ],
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                                Expanded(
                                                                                                                                                  flex: 2,
                                                                                                                                                  child: Container(
                                                                                                                                                    decoration: BoxDecoration(),
                                                                                                                                                    child: Padding(
                                                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                                                                                      child: Row(
                                                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                        children: [
                                                                                                                                                          Expanded(
                                                                                                                                                            flex: 1,
                                                                                                                                                            child: AutoSizeText(
                                                                                                                                                              '${valueOrDefault<String>(
                                                                                                                                                                getJsonField(
                                                                                                                                                                  alunosListaWrapItem,
                                                                                                                                                                  r'''$.valalunomotorista''',
                                                                                                                                                                )?.toString(),
                                                                                                                                                                '0,00',
                                                                                                                                                              )}',
                                                                                                                                                              textAlign: TextAlign.start,
                                                                                                                                                              minFontSize: 8.0,
                                                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                                                    font: GoogleFonts.inter(
                                                                                                                                                                      fontWeight: FontWeight.w300,
                                                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                                    ),
                                                                                                                                                                    color: Colors.black,
                                                                                                                                                                    fontSize: 10.0,
                                                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                                                    fontWeight: FontWeight.w300,
                                                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                                                  ),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                        ],
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                                Expanded(
                                                                                                                                                  flex: 2,
                                                                                                                                                  child: Container(
                                                                                                                                                    width: 100.0,
                                                                                                                                                    height: 100.0,
                                                                                                                                                    decoration: BoxDecoration(),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              ],
                                                                                                                                            ),
                                                                                                                                          ),
                                                                                                                                        ],
                                                                                                                                      );
                                                                                                                                    }),
                                                                                                                                  );
                                                                                                                                },
                                                                                                                              );
                                                                                                                            },
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                  ],
                                                                                                                );
                                                                                                              },
                                                                                                            );
                                                                                                          },
                                                                                                        );
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                            FutureBuilder<List<TotvalalunosescolasRow>>(
                                                                              future: TotvalalunosescolasTable().querySingleRow(
                                                                                queryFn: (q) => q,
                                                                              ),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 50.0,
                                                                                      height: 50.0,
                                                                                      child: SpinKitPulse(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        size: 50.0,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                List<TotvalalunosescolasRow> containerTotvalalunosescolasRowList = snapshot.data!;

                                                                                final containerTotvalalunosescolasRow = containerTotvalalunosescolasRowList.isNotEmpty ? containerTotvalalunosescolasRowList.first : null;

                                                                                return Container(
                                                                                  width: double.infinity,
                                                                                  height: 35.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(24.0),
                                                                                      bottomRight: Radius.circular(24.0),
                                                                                    ),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 6,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                child: Container(
                                                                                                  width: 100.0,
                                                                                                  height: 100.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    border: Border.all(
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    ),
                                                                                                  ),
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              phone: false,
                                                                                              tablet: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 100.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              phone: false,
                                                                                              tablet: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 100.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          containerTotvalalunosescolasRow?.alunosescola?.toString(),
                                                                                                          '0',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              fontSize: 12.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              phone: false,
                                                                                              tablet: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 100.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          containerTotvalalunosescolasRow?.valalunosmotorista,
                                                                                                          'R\$ 0,00',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              fontSize: 12.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              phone: false,
                                                                                              tablet: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 100.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          containerTotvalalunosescolasRow?.valalunosapagar,
                                                                                                          'R\$ 0,00',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              fontSize: 12.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              phone: false,
                                                                                              tablet: false,
                                                                                              tabletLandscape: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 100.0,
                                                                                                    height: 100.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ).animateOnPageLoad(
                                                                animationsMap[
                                                                    'containerOnPageLoadAnimation3']!),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                KeepAliveWidgetWrapper(
                                  builder: (context) => Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        1.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 16.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 60.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Filtros',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize: isAndroid ||
                                                                              isiOS
                                                                          ? 8.0
                                                                          : 18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        3.0,
                                                                        0.0,
                                                                        3.0),
                                                            child: FutureBuilder<
                                                                List<
                                                                    VretfichamentomesbaseRow>>(
                                                              future:
                                                                  VretfichamentomesbaseTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          SpinKitPulse(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        size:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<VretfichamentomesbaseRow>
                                                                    ddwMesBaseVretfichamentomesbaseRowList =
                                                                    snapshot
                                                                        .data!;

                                                                return FlutterFlowDropDown<
                                                                    String>(
                                                                  controller: _model
                                                                          .ddwMesBaseValueController ??=
                                                                      FormFieldController<
                                                                              String>(
                                                                          null),
                                                                  options: List<String>.from(ddwMesBaseVretfichamentomesbaseRowList
                                                                      .map((e) =>
                                                                          e.mesbase)
                                                                      .withoutNulls
                                                                      .toList()),
                                                                  optionLabels: ddwMesBaseVretfichamentomesbaseRowList
                                                                      .map((e) =>
                                                                          e.mesbase)
                                                                      .withoutNulls
                                                                      .toList(),
                                                                  onChanged:
                                                                      (val) async {
                                                                    safeSetState(() =>
                                                                        _model.ddwMesBaseValue =
                                                                            val);
                                                                    safeSetState(() =>
                                                                        _model.requestCompleter =
                                                                            null);
                                                                    await _model
                                                                        .waitForRequestCompleted();
                                                                  },
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: 50.0,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  hintText:
                                                                      'Data Base Fechamento',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_rounded,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    size: 24.0,
                                                                  ),
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  elevation:
                                                                      2.0,
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                  borderWidth:
                                                                      1.0,
                                                                  borderRadius:
                                                                      8.0,
                                                                  margin: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          4.0,
                                                                          16.0,
                                                                          4.0),
                                                                  hidesUnderline:
                                                                      true,
                                                                  isSearchable:
                                                                      false,
                                                                  isMultiSelect:
                                                                      false,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        width: 100.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Visibility(
                                                          visible:
                                                              responsiveVisibility(
                                                            context: context,
                                                            phone: false,
                                                            tablet: false,
                                                            tabletLandscape:
                                                                false,
                                                            desktop: false,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        6.0,
                                                                        3.0,
                                                                        6.0,
                                                                        3.0),
                                                            child: FutureBuilder<
                                                                List<
                                                                    EscolaRow>>(
                                                              future:
                                                                  EscolaTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q
                                                                        .eqOrNull(
                                                                          'idEmpresa',
                                                                          FFAppState()
                                                                              .idEmpresa,
                                                                        )
                                                                        .order(
                                                                            'nomeEscola',
                                                                            ascending:
                                                                                true),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          SpinKitPulse(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        size:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<EscolaRow>
                                                                    ddwEscolaPgtoEscolaRowList =
                                                                    snapshot
                                                                        .data!;

                                                                return FlutterFlowDropDown<
                                                                    int>(
                                                                  controller: _model
                                                                          .ddwEscolaPgtoValueController ??=
                                                                      FormFieldController<
                                                                          int>(
                                                                    _model.ddwEscolaPgtoValue ??=
                                                                        0,
                                                                  ),
                                                                  options: List<
                                                                          int>.from(
                                                                      ddwEscolaPgtoEscolaRowList
                                                                          .map((e) =>
                                                                              e.idEscola)
                                                                          .toList()),
                                                                  optionLabels: ddwEscolaPgtoEscolaRowList
                                                                      .map((e) =>
                                                                          e.nomeEscola)
                                                                      .withoutNulls
                                                                      .toList(),
                                                                  onChanged:
                                                                      (val) async {
                                                                    safeSetState(() =>
                                                                        _model.ddwEscolaPgtoValue =
                                                                            val);
                                                                    safeSetState(() =>
                                                                        _model.requestCompleter =
                                                                            null);
                                                                    await _model
                                                                        .waitForRequestCompleted();
                                                                  },
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: 50.0,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  hintText:
                                                                      'Escola',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_rounded,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    size: 24.0,
                                                                  ),
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  elevation:
                                                                      2.0,
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                  borderWidth:
                                                                      1.0,
                                                                  borderRadius:
                                                                      8.0,
                                                                  margin: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          4.0,
                                                                          16.0,
                                                                          4.0),
                                                                  hidesUnderline:
                                                                      true,
                                                                  isSearchable:
                                                                      false,
                                                                  isMultiSelect:
                                                                      false,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          safeSetState(() =>
                                                              _model.requestCompleter =
                                                                  null);
                                                          await _model
                                                              .waitForRequestCompleted();
                                                        },
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Visibility(
                                                            visible:
                                                                responsiveVisibility(
                                                              context: context,
                                                              phone: false,
                                                              tablet: false,
                                                              tabletLandscape:
                                                                  false,
                                                              desktop: false,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          3.0),
                                                              child: FutureBuilder<
                                                                  List<
                                                                      UsuarioRow>>(
                                                                future:
                                                                    UsuarioTable()
                                                                        .queryRows(
                                                                  queryFn: (q) => q
                                                                      .eqOrNull(
                                                                        'domCargo',
                                                                        'Motorista',
                                                                      )
                                                                      .order('nomeUsuario', ascending: true),
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitPulse(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<UsuarioRow>
                                                                      ddwMotoristaPgtoUsuarioRowList =
                                                                      snapshot
                                                                          .data!;

                                                                  return FlutterFlowDropDown<
                                                                      int>(
                                                                    controller: _model
                                                                            .ddwMotoristaPgtoValueController ??=
                                                                        FormFieldController<
                                                                            int>(
                                                                      _model.ddwMotoristaPgtoValue ??=
                                                                          0,
                                                                    ),
                                                                    options: List<int>.from(ddwMotoristaPgtoUsuarioRowList
                                                                        .map((e) =>
                                                                            e.idUsuario)
                                                                        .toList()),
                                                                    optionLabels: ddwMotoristaPgtoUsuarioRowList
                                                                        .map((e) =>
                                                                            e.nomeUsuario)
                                                                        .withoutNulls
                                                                        .toList(),
                                                                    onChanged: (val) =>
                                                                        safeSetState(() =>
                                                                            _model.ddwMotoristaPgtoValue =
                                                                                val),
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        50.0,
                                                                    searchHintTextStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    searchTextStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Motorista',
                                                                    searchHintText:
                                                                        'Pesquisar...',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    elevation:
                                                                        2.0,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderWidth:
                                                                        1.0,
                                                                    borderRadius:
                                                                        8.0,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            4.0,
                                                                            16.0,
                                                                            4.0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isSearchable:
                                                                        true,
                                                                    isMultiSelect:
                                                                        false,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        child: Container(
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                        ),
                                                      ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        child: Container(
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: double.infinity,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Ações',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              'Nome do Motorista',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              'Escola',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              'Situação',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              'Data Confirmação',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              'Mês Referente',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Text(
                                                              'Valor',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: FutureBuilder<
                                                          List<
                                                              FinfechconfirmadoRow>>(
                                                        future: (_model
                                                                    .requestCompleter ??=
                                                                Completer<
                                                                    List<
                                                                        FinfechconfirmadoRow>>()
                                                                  ..complete(
                                                                      FinfechconfirmadoTable()
                                                                          .queryRows(
                                                                    queryFn: (q) => q
                                                                        .eqOrNull(
                                                                          'mesbase',
                                                                          _model.ddwMesBaseValue != null && _model.ddwMesBaseValue != ''
                                                                              ? _model.ddwMesBaseValue
                                                                              : '',
                                                                        )
                                                                        .order('nomeusuario', ascending: true)
                                                                        .order('nomeescola', ascending: true)
                                                                        .order('valconfusuario'),
                                                                  )))
                                                            .future,
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitPulse(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<FinfechconfirmadoRow>
                                                              lstGestaoPagtoFinfechconfirmadoRowList =
                                                              snapshot.data!;

                                                          if (lstGestaoPagtoFinfechconfirmadoRowList
                                                              .isEmpty) {
                                                            return Center(
                                                              child:
                                                                  BtsSelecioneWidget(),
                                                            );
                                                          }

                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                lstGestaoPagtoFinfechconfirmadoRowList
                                                                    .length,
                                                            itemBuilder: (context,
                                                                lstGestaoPagtoIndex) {
                                                              final lstGestaoPagtoFinfechconfirmadoRow =
                                                                  lstGestaoPagtoFinfechconfirmadoRowList[
                                                                      lstGestaoPagtoIndex];
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: lstGestaoPagtoFinfechconfirmadoRow
                                                                              .domsitpagamento ==
                                                                          'Pagamento agendado'
                                                                      ? Color(
                                                                          0xFFF2FDC4)
                                                                      : (lstGestaoPagtoFinfechconfirmadoRow.domsitpagamento ==
                                                                              'Pagamento realizado'
                                                                          ? Color(
                                                                              0xFFD1FFC7)
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryBackground),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          3.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              if ((lstGestaoPagtoFinfechconfirmadoRow.domsitpagamento == 'Pagamento agendado') || (lstGestaoPagtoFinfechconfirmadoRow.domsitpagamento == 'Pagamento em análise'))
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      var confirmDialogResponse = await showDialog<bool>(
                                                                                            context: context,
                                                                                            builder: (alertDialogContext) {
                                                                                              return AlertDialog(
                                                                                                title: Text('Excluir confirmação de pagamento?'),
                                                                                                content: Text('Confimar exclusão?'),
                                                                                                actions: [
                                                                                                  TextButton(
                                                                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                    child: Text('Não'),
                                                                                                  ),
                                                                                                  TextButton(
                                                                                                    onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                    child: Text('Sim'),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            },
                                                                                          ) ??
                                                                                          false;
                                                                                      if (confirmDialogResponse) {
                                                                                        _model.apiResExcluirConfirmacao = await FinfechconfirmadoTable().delete(
                                                                                          matchingRows: (rows) => rows.eqOrNull(
                                                                                            'idfechamento',
                                                                                            lstGestaoPagtoFinfechconfirmadoRow.idfechamento,
                                                                                          ),
                                                                                          returnRows: true,
                                                                                        );
                                                                                        safeSetState(() => _model.requestCompleter = null);
                                                                                        await _model.waitForRequestCompleted();
                                                                                      }

                                                                                      safeSetState(() {});
                                                                                    },
                                                                                    child: Icon(
                                                                                      FFIcons.kxCloseDelete,
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      size: 26.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if ((lstGestaoPagtoFinfechconfirmadoRow.domsitpagamento == 'Pagamento em análise') &&
                                                                                  responsiveVisibility(
                                                                                    context: context,
                                                                                    phone: false,
                                                                                    tablet: false,
                                                                                    tabletLandscape: false,
                                                                                    desktop: false,
                                                                                  ))
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await FinfechconfirmadoTable().update(
                                                                                        data: {
                                                                                          'dtsitpagamento': supaSerialize<DateTime>(dateTimeFromSecondsSinceEpoch(getCurrentTimestamp.secondsSinceEpoch)),
                                                                                          'domsitpagamento': 'Pagamento agendado',
                                                                                        },
                                                                                        matchingRows: (rows) => rows.eqOrNull(
                                                                                          'idfechamento',
                                                                                          lstGestaoPagtoFinfechconfirmadoRow.idfechamento,
                                                                                        ),
                                                                                      );
                                                                                      safeSetState(() => _model.requestCompleter = null);
                                                                                      await _model.waitForRequestCompleted();
                                                                                    },
                                                                                    child: Icon(
                                                                                      FFIcons.ktimerBold,
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      size: 26.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if ((lstGestaoPagtoFinfechconfirmadoRow.domsitpagamento == 'Pagamento agendado') || (lstGestaoPagtoFinfechconfirmadoRow.domsitpagamento == 'Pagamento em análise'))
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await FinfechconfirmadoTable().update(
                                                                                        data: {
                                                                                          'dtsitpagamento': supaSerialize<DateTime>(dateTimeFromSecondsSinceEpoch(getCurrentTimestamp.secondsSinceEpoch)),
                                                                                          'domsitpagamento': 'Pagamento realizado',
                                                                                        },
                                                                                        matchingRows: (rows) => rows.eqOrNull(
                                                                                          'idfechamento',
                                                                                          lstGestaoPagtoFinfechconfirmadoRow.idfechamento,
                                                                                        ),
                                                                                      );
                                                                                      safeSetState(() => _model.requestCompleter = null);
                                                                                      await _model.waitForRequestCompleted();
                                                                                    },
                                                                                    child: Icon(
                                                                                      FFIcons.kreceipt2,
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      size: 26.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              lstGestaoPagtoFinfechconfirmadoRow.nomeusuario,
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              lstGestaoPagtoFinfechconfirmadoRow.nomeescola,
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              lstGestaoPagtoFinfechconfirmadoRow.domsitpagamento,
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "d/M/y",
                                                                                lstGestaoPagtoFinfechconfirmadoRow.dtconfusuario,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              lstGestaoPagtoFinfechconfirmadoRow.mesbase,
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                formatNumber(
                                                                                  lstGestaoPagtoFinfechconfirmadoRow.valconfusuario,
                                                                                  formatType: FormatType.decimal,
                                                                                  decimalType: DecimalType.commaDecimal,
                                                                                  currency: 'R\$ ',
                                                                                ),
                                                                                '-',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                KeepAliveWidgetWrapper(
                                  builder: (context) => Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        1.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 90.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                    border: Border.all(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    16.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 300.0,
                                                          constraints:
                                                              BoxConstraints(
                                                            minWidth: 300.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Arquivar Fechamento Mensal',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        var confirmDialogResponse = await showDialog<bool>(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return AlertDialog(
                                                                                  title: Text('Arquivar Fechamento Mensal'),
                                                                                  content: Text('Finalizar o Fechamento Mensal e arquivar? Atenção: Todos os fechamentos já salvos para o período serão substituídos, essa operação não poderá ser desfeita.'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                      child: Text('Não'),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                      child: Text('Sim'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ) ??
                                                                            false;
                                                                        if (confirmDialogResponse) {
                                                                          _model.apiResWHINSERTFINFECHAMENTO =
                                                                              await WhgravarfechamentoCall.call(
                                                                            tipoFechamento:
                                                                                getCurrentTimestamp.toString(),
                                                                          );

                                                                          if ((_model.apiResWHINSERTFINFECHAMENTO?.succeeded ??
                                                                              true)) {
                                                                            await showDialog(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return AlertDialog(
                                                                                  title: Text('Arquivar Fechamento Mensal'),
                                                                                  content: Text('Fechamento Mensal finalizado e arquivado com sucesso'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext),
                                                                                      child: Text('Ok'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          } else {
                                                                            await showDialog(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return AlertDialog(
                                                                                  title: Text('Arquivar Fechamento Mensal'),
                                                                                  content: Text('${(_model.apiResWHINSERTFINFECHAMENTO?.bodyText ?? '')}'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext),
                                                                                      child: Text('Ok'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          }
                                                                        }

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      text:
                                                                          'Salvar Fechamento',
                                                                      icon:
                                                                          Icon(
                                                                        FFIcons
                                                                            .ksave,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        height:
                                                                            40.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.interTight(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: Colors.white,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                        elevation:
                                                                            3.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.transparent,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(24.0),
                                                                      ),
                                                                    ),
                                                                  ],
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
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 16.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 60.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Filtros',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize: isAndroid ||
                                                                              isiOS
                                                                          ? 8.0
                                                                          : 18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        3.0,
                                                                        0.0,
                                                                        3.0),
                                                            child: FutureBuilder<
                                                                List<
                                                                    VretfichamentomesbaseRow>>(
                                                              future:
                                                                  VretfichamentomesbaseTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          SpinKitPulse(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        size:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<VretfichamentomesbaseRow>
                                                                    ddwMesBaseFechamentoVretfichamentomesbaseRowList =
                                                                    snapshot
                                                                        .data!;

                                                                return FlutterFlowDropDown<
                                                                    String>(
                                                                  controller: _model
                                                                          .ddwMesBaseFechamentoValueController ??=
                                                                      FormFieldController<
                                                                              String>(
                                                                          null),
                                                                  options: List<String>.from(ddwMesBaseFechamentoVretfichamentomesbaseRowList
                                                                      .map((e) =>
                                                                          e.mesbase)
                                                                      .withoutNulls
                                                                      .toList()),
                                                                  optionLabels: ddwMesBaseFechamentoVretfichamentomesbaseRowList
                                                                      .map((e) =>
                                                                          e.mesbase)
                                                                      .withoutNulls
                                                                      .toList(),
                                                                  onChanged: (val) =>
                                                                      safeSetState(() =>
                                                                          _model.ddwMesBaseFechamentoValue =
                                                                              val),
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: 50.0,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  hintText:
                                                                      'Data Base Fechamento',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_rounded,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    size: 24.0,
                                                                  ),
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  elevation:
                                                                      2.0,
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                  borderWidth:
                                                                      1.0,
                                                                  borderRadius:
                                                                      8.0,
                                                                  margin: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          4.0,
                                                                          16.0,
                                                                          4.0),
                                                                  hidesUnderline:
                                                                      true,
                                                                  isSearchable:
                                                                      false,
                                                                  isMultiSelect:
                                                                      false,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Visibility(
                                                            visible:
                                                                responsiveVisibility(
                                                              context: context,
                                                              tabletLandscape:
                                                                  false,
                                                              desktop: false,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          6.0,
                                                                          3.0,
                                                                          6.0,
                                                                          3.0),
                                                              child: FutureBuilder<
                                                                  List<
                                                                      EscolaRow>>(
                                                                future:
                                                                    EscolaTable()
                                                                        .queryRows(
                                                                  queryFn: (q) => q
                                                                      .eqOrNull(
                                                                        'idEmpresa',
                                                                        FFAppState()
                                                                            .idEmpresa,
                                                                      )
                                                                      .order('nomeEscola', ascending: true),
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitPulse(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<EscolaRow>
                                                                      ddwEscolaEscolaRowList =
                                                                      snapshot
                                                                          .data!;

                                                                  return FlutterFlowDropDown<
                                                                      int>(
                                                                    controller: _model
                                                                            .ddwEscolaValueController ??=
                                                                        FormFieldController<
                                                                            int>(
                                                                      _model.ddwEscolaValue ??=
                                                                          0,
                                                                    ),
                                                                    options: List<int>.from(ddwEscolaEscolaRowList
                                                                        .map((e) =>
                                                                            e.idEscola)
                                                                        .toList()),
                                                                    optionLabels: ddwEscolaEscolaRowList
                                                                        .map((e) =>
                                                                            e.nomeEscola)
                                                                        .withoutNulls
                                                                        .toList(),
                                                                    onChanged: (val) =>
                                                                        safeSetState(() =>
                                                                            _model.ddwEscolaValue =
                                                                                val),
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        50.0,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Escola',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    elevation:
                                                                        2.0,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderWidth:
                                                                        1.0,
                                                                    borderRadius:
                                                                        8.0,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            4.0,
                                                                            16.0,
                                                                            4.0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isSearchable:
                                                                        false,
                                                                    isMultiSelect:
                                                                        false,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Visibility(
                                                            visible:
                                                                responsiveVisibility(
                                                              context: context,
                                                              tabletLandscape:
                                                                  false,
                                                              desktop: false,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          3.0),
                                                              child: FutureBuilder<
                                                                  List<
                                                                      UsuarioRow>>(
                                                                future:
                                                                    UsuarioTable()
                                                                        .queryRows(
                                                                  queryFn: (q) => q
                                                                      .eqOrNull(
                                                                        'domCargo',
                                                                        'Motorista',
                                                                      )
                                                                      .order('nomeUsuario', ascending: true),
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitPulse(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<UsuarioRow>
                                                                      ddwMotoristaUsuarioRowList =
                                                                      snapshot
                                                                          .data!;

                                                                  return FlutterFlowDropDown<
                                                                      int>(
                                                                    controller: _model
                                                                            .ddwMotoristaValueController ??=
                                                                        FormFieldController<
                                                                            int>(
                                                                      _model.ddwMotoristaValue ??=
                                                                          0,
                                                                    ),
                                                                    options: List<int>.from(ddwMotoristaUsuarioRowList
                                                                        .map((e) =>
                                                                            e.idUsuario)
                                                                        .toList()),
                                                                    optionLabels: ddwMotoristaUsuarioRowList
                                                                        .map((e) =>
                                                                            e.nomeUsuario)
                                                                        .withoutNulls
                                                                        .toList(),
                                                                    onChanged: (val) =>
                                                                        safeSetState(() =>
                                                                            _model.ddwMotoristaValue =
                                                                                val),
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        50.0,
                                                                    searchHintTextStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    searchTextStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Motorista',
                                                                    searchHintText:
                                                                        'Pesquisar...',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    elevation:
                                                                        2.0,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    borderWidth:
                                                                        1.0,
                                                                    borderRadius:
                                                                        8.0,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            4.0,
                                                                            16.0,
                                                                            4.0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isSearchable:
                                                                        true,
                                                                    isMultiSelect:
                                                                        false,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        child: Container(
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                        ),
                                                      ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                    ))
                                                      Expanded(
                                                        child: Container(
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: double.infinity,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Text(
                                                            'Nome do Cooperado',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Text(
                                                            'Escola',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Text(
                                                            'Mês Referente',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Text(
                                                            'Alunos',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Text(
                                                            'Valor',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    child: FutureBuilder<
                                                        List<FinfechamentoRow>>(
                                                      future:
                                                          FinfechamentoTable()
                                                              .queryRows(
                                                        queryFn: (q) => q
                                                            .eqOrNull(
                                                              'mesbase',
                                                              _model.ddwMesBaseFechamentoValue !=
                                                                          null &&
                                                                      _model.ddwMesBaseFechamentoValue !=
                                                                          ''
                                                                  ? _model
                                                                      .ddwMesBaseFechamentoValue
                                                                  : '',
                                                            )
                                                            .order('mesbase',
                                                                ascending:
                                                                    true),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              child:
                                                                  SpinKitPulse(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                size: 50.0,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<FinfechamentoRow>
                                                            listViewFinfechamentoRowList =
                                                            snapshot.data!;

                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              listViewFinfechamentoRowList
                                                                  .length,
                                                          itemBuilder: (context,
                                                              listViewIndex) {
                                                            final listViewFinfechamentoRow =
                                                                listViewFinfechamentoRowList[
                                                                    listViewIndex];
                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 3,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        listViewFinfechamentoRow
                                                                            .nomeUsuario,
                                                                        '-',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        listViewFinfechamentoRow
                                                                            .nomeescola,
                                                                        '-',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        listViewFinfechamentoRow
                                                                            .mesreferente,
                                                                        '-',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        listViewFinfechamentoRow
                                                                            .qtdalunos
                                                                            ?.toString(),
                                                                        '0',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      listViewFinfechamentoRow.domTipoPessoa ==
                                                                              'Pessoa Física'
                                                                          ? valueOrDefault<
                                                                              String>(
                                                                              listViewFinfechamentoRow.valliquidoresumo,
                                                                              '-',
                                                                            )
                                                                          : valueOrDefault<
                                                                              String>(
                                                                              listViewFinfechamentoRow.valliquidoresumopj,
                                                                              '-',
                                                                            ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
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
                              ],
                            ),
                          ),
                        ],
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
  }
}
