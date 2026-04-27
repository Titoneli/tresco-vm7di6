import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_commons/api_requests/api_paging_params.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'atf_lista_model.dart';
export 'atf_lista_model.dart';

class AtfListaWidget extends StatefulWidget {
  const AtfListaWidget({super.key});

  static const String routePath = '/atfs';
  static const String routeName = 'AtfLista';

  @override
  State<AtfListaWidget> createState() => _AtfListaWidgetState();
}

class _AtfListaWidgetState extends State<AtfListaWidget> {
  late AtfListaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AtfListaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          automaticallyImplyLeading: true,
          title: Text(
            'ATFs',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  // Create new ATF document
                  await AtfTable().insert({
                    'status': 'rascunho',
                    'created_at': supaSerialize<DateTime>(
                      getCurrentTimestamp,
                    ),
                  }).then((newAtf) async {
                    if (newAtf != null) {
                      context.pushNamed(
                        'AtfForm',
                        queryParameters: {
                          'atfId': serializeParam(
                            newAtf.id,
                            ParamType.int,
                          ),
                        }.withoutNulls,
                      );
                    }
                  });
                },
                text: 'Nova ATF',
                icon: Icon(
                  Icons.add,
                  size: 18.0,
                ),
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: PagedListView<int, AtfRow>.separated(
              pagingController: _model.setListViewController(
                (nextPageMarker) async {
                  final queryResults = await AtfTable()
                      .queryRows(
                        queryFn: (q) => q.order('data_ida', ascending: false),
                      )
                      .then((rows) => rows);
                  return queryResults;
                },
              ),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              reverse: false,
              scrollDirection: Axis.vertical,
              separatorBuilder: (_, __) => SizedBox(height: 12.0),
              builderDelegate: PagedChildBuilderDelegate<AtfRow>(
                // Customize what your widget looks like when it's loading the first page.
                firstPageProgressIndicatorBuilder: (_) => Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitPulse(
                      color: FlutterFlowTheme.of(context).primary,
                      size: 50.0,
                    ),
                  ),
                ),
                // Customize what your widget looks like when it's loading another page.
                newPageProgressIndicatorBuilder: (_) => Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitPulse(
                      color: FlutterFlowTheme.of(context).primary,
                      size: 50.0,
                    ),
                  ),
                ),
                noItemsFoundIndicatorBuilder: (_) => Center(
                  child: Text(
                    'Nenhuma ATF encontrada',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontStyle,
                        ),
                  ),
                ),
                itemBuilder: (context, _, atfListIndex) {
                  final atfListAtfRow =
                      _model.listViewPagingController!.itemList![atfListIndex];
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        'AtfForm',
                        queryParameters: {
                          'atfId': serializeParam(
                            atfListAtfRow.id,
                            ParamType.int,
                          ),
                        }.withoutNulls,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              1.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 16.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${atfListAtfRow.origem ?? ''} → ${atfListAtfRow.destino ?? ''}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                  ),
                                  if (atfListAtfRow.dataIda != null)
                                    Text(
                                      dateTimeFormat(
                                        "dd/MM/yyyy",
                                        atfListAtfRow.dataIda,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            letterSpacing: 0.0,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: () {
                                  if (atfListAtfRow.status == 'rascunho') {
                                    return FlutterFlowTheme.of(context)
                                        .secondaryText;
                                  } else if (atfListAtfRow.status ==
                                      'validado') {
                                    return Color(0xFF4CAF50);
                                  } else if (atfListAtfRow.status ==
                                      'enviado_sgtf') {
                                    return FlutterFlowTheme.of(context).primary;
                                  } else if (atfListAtfRow.status ==
                                      'cancelado') {
                                    return FlutterFlowTheme.of(context).error;
                                  } else {
                                    return FlutterFlowTheme.of(context)
                                        .secondaryText;
                                  }
                                }(),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 6.0, 12.0, 6.0),
                                child: Text(
                                  () {
                                    if (atfListAtfRow.status == 'rascunho') {
                                      return 'Rascunho';
                                    } else if (atfListAtfRow.status ==
                                        'validado') {
                                      return 'Validado';
                                    } else if (atfListAtfRow.status ==
                                        'enviado_sgtf') {
                                      return 'Enviado';
                                    } else if (atfListAtfRow.status ==
                                        'cancelado') {
                                      return 'Cancelado';
                                    } else {
                                      return atfListAtfRow.status ?? '';
                                    }
                                  }(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodySmall
                                              .fontStyle,
                                        ),
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
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
        ),
      ),
    );
  }
}
