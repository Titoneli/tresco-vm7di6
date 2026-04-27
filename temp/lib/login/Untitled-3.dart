import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'atf_lista_model.dart';
export 'atf_lista_model.dart';

class AtfListaWidget extends StatefulWidget {
  const AtfListaWidget({super.key});

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
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'validado':
        return Colors.green;
      case 'enviado_sgtf':
        return Colors.blue;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status) {
      case 'validado':
        return 'Validado';
      case 'enviado_sgtf':
        return 'Enviado SGTF';
      case 'cancelado':
        return 'Cancelado';
      case 'rascunho':
        return 'Rascunho';
      default:
        return status ?? 'Rascunho';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'ATFs',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderRadius: 20.0,
              buttonSize: 40.0,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24.0,
              ),
              onPressed: () async {
                // Criar nova ATF
                await AtfTable().insert({
                  'status': 'rascunho',
                  'tipo_atf': 'Manual',
                });
                
                // Buscar a ATF criada
                final atfCriada = await AtfTable().querySingleRow(
                  queryFn: (q) => q.order('created_at', ascending: false),
                );

                if (atfCriada != null) {
                  context.pushNamed(
                    'atf_form',
                    queryParameters: {
                      'atf_id': serializeParam(
                        atfCriada.id,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                  );
                }
              },
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: FutureBuilder<List<AtfRow>>(
            future: AtfTable().queryRows(
              queryFn: (q) => q.order('data_ida', ascending: false).limit(50),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                );
              }
              
              List<AtfRow> listViewAtfRowList = snapshot.data!;
              
              if (listViewAtfRowList.isEmpty) {
                return Center(
                  child: Text(
                    'Nenhuma ATF cadastrada',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: listViewAtfRowList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                itemBuilder: (context, listViewIndex) {
                  final atf = listViewAtfRowList[listViewIndex];
                  
                  return InkWell(
                    onTap: () async {
                      context.pushNamed(
                        'atf_form',
                        queryParameters: {
                          'atf_id': serializeParam(
                            atf.id,
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${atf.origem ?? ''} → ${atf.destino ?? ''}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  atf.dataIda != null
                                      ? dateTimeFormat('d/M/y', atf.dataIda)
                                      : 'Data não definida',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(atf.status),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              _getStatusLabel(atf.status),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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
    );
  }
}