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
import 'passageiro_detalhe_m_model.dart';
export 'passageiro_detalhe_m_model.dart';

class PassageiroDetalheMWidget extends StatefulWidget {
  const PassageiroDetalheMWidget({
    super.key,
    required this.passageiroId,
  });

  final int? passageiroId;

  static String routeName = 'passageiroDetalheM';
  static String routePath = '/passageiroDetalhe';

  @override
  State<PassageiroDetalheMWidget> createState() =>
      _PassageiroDetalheMWidgetState();
}

class _PassageiroDetalheMWidgetState extends State<PassageiroDetalheMWidget> {
  late PassageiroDetalheMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PassageiroDetalheMModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.passageiroId != null) {
        await _model.fetchPassageiro(widget.passageiroId!);
        safeSetState(() {});
        await _model.fetchContratos(
            FFAppState().idUsuario, widget.passageiroId!);
        safeSetState(() {});
      }
    });
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
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          leading: FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 40.0,
            icon: Icon(Icons.arrow_back,
                color: FlutterFlowTheme.of(context).info, size: 24.0),
            onPressed: () async => context.safePop(),
          ),
          title: Text(
            'Passageiro',
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
                icon: Icon(Icons.edit,
                    color: FlutterFlowTheme.of(context).info, size: 24.0),
                onPressed: () async {
                  context.pushNamed(
                    'passageiroFormM',
                    queryParameters: {
                      'passageiroId': serializeParam(
                          widget.passageiroId, ParamType.int),
                    }.withoutNulls,
                  );
                },
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: _model.isLoading
              ? Center(
                  child: SpinKitPulse(
                    color: FlutterFlowTheme.of(context).primary,
                    size: 50.0,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Header com avatar e status
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: _model.foto.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Image.network(
                                          _model.foto,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(Icons.person,
                                                      size: 40.0,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primary),
                                        ),
                                      )
                                    : Icon(Icons.person,
                                        size: 40.0,
                                        color: FlutterFlowTheme.of(context)
                                            .primary),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                _model.nome,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.interTight(
                                          fontWeight: FontWeight.w600),
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: _model.status == 'ATIVO'
                                      ? Color(0xFF39D2C0).withOpacity(0.2)
                                      : FlutterFlowTheme.of(context)
                                          .alternate
                                          .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  _model.status,
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600),
                                        color: _model.status == 'ATIVO'
                                            ? Color(0xFF39D2C0)
                                            : FlutterFlowTheme.of(context)
                                                .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Info cards
                      _buildInfoCard(
                          context, 'CPF', _model.cpf, Icons.badge_outlined),
                      _buildInfoCard(context, 'Escola', _model.escola,
                          Icons.school_outlined),
                      _buildInfoCard(context, 'Endereço', _model.endereco,
                          Icons.location_on_outlined),
                      SizedBox(height: 16.0),
                      // Responsáveis
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Responsáveis',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600),
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 40.0,
                              icon: Icon(Icons.add,
                                  color:
                                      FlutterFlowTheme.of(context).primary,
                                  size: 24.0),
                              onPressed: () async {
                                await _showResponsavelForm(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      if (_model.responsaveis.isEmpty)
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Nenhum responsável cadastrado',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        )
                      else
                        ...List.generate(_model.responsaveis.length, (index) {
                          final resp = _model.responsaveis[index];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_outline,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0),
                                    SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            resp.nomeResponsavel,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            '${resp.parentesco} • ${resp.whatsAppResponsavel}',
                                            style: FlutterFlowTheme.of(context)
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
                                    PopupMenuButton<String>(
                                      onSelected: (value) async {
                                        if (value == 'editar') {
                                          await _showResponsavelForm(context,
                                              responsavel: resp);
                                        } else if (value == 'excluir') {
                                          await _model.deleteResponsavel(
                                              widget.passageiroId!, resp.idResponsavel!);
                                          await _model.fetchPassageiro(
                                              widget.passageiroId!);
                                          safeSetState(() {});
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                            value: 'editar',
                                            child: Text('Editar')),
                                        PopupMenuItem(
                                            value: 'excluir',
                                            child: Text('Excluir')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      SizedBox(height: 24.0),
                      // Contratos
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contratos',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600),
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 40.0,
                              icon: Icon(Icons.add,
                                  color:
                                      FlutterFlowTheme.of(context).primary,
                                  size: 24.0),
                              onPressed: () async {
                                await _showNovoContratoBottomSheet(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      if (_model.isLoadingContratos)
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        )
                      else if (_model.contratos.isEmpty)
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Nenhum contrato cadastrado',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        )
                      else
                        ...List.generate(_model.contratos.length, (index) {
                          final contrato = _model.contratos[index];
                          final statusColor = _contratoStatusColor(
                              contrato.status);
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () async {
                                await context.pushNamed(
                                  'contratoDetalheM',
                                  queryParameters: {
                                    'contratoId': serializeParam(
                                        contrato.idContrato, ParamType.int),
                                  }.withoutNulls,
                                );
                                if (mounted) {
                                  await _model.fetchContratos(
                                      FFAppState().idUsuario,
                                      widget.passageiroId!);
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border(
                                    left: BorderSide(
                                        color: statusColor, width: 4.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6.0,
                                                      vertical: 2.0),
                                                  decoration: BoxDecoration(
                                                    color: statusColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                  ),
                                                  child: Text(
                                                    contrato.status ?? '',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          font: GoogleFonts.inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          color: statusColor,
                                                          fontSize: 11.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              'R\$ ${contrato.valMensal?.toStringAsFixed(2) ?? '0,00'}/mês',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                            if (contrato.dtInicio != null)
                                              Text(
                                                '${contrato.dtInicio} - ${contrato.dtTermino ?? 'Indeterminado'}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.chevron_right,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 20.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      SizedBox(height: 24.0),
                      // Botão excluir passageiro
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 24.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Excluir Passageiro'),
                                content: Text(
                                    'Tem certeza que deseja excluir este passageiro?'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: Text('Cancelar')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      child: Text('Excluir')),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await VivanLocator.service.deletePassageiro(widget.passageiroId!);
                              context.safePop();
                            }
                          },
                          text: 'Excluir Passageiro',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 48.0,
                            color: FlutterFlowTheme.of(context).error,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Color _contratoStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'ATIVO': return Color(0xFF39D2C0);
      case 'RASCUNHO': return Color(0xFF9E9E9E);
      case 'SUSPENSO': return Color(0xFFF9CF58);
      case 'CANCELADO': return Color(0xFFFF5963);
      default: return Color(0xFF9E9E9E);
    }
  }

  Future<void> _showNovoContratoBottomSheet(BuildContext context) async {
    final valorController = TextEditingController();
    final inicioController = TextEditingController();
    final fimController = TextEditingController();
    bool isSaving = false;

    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.0, height: 4.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Novo Contrato',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                      letterSpacing: 0.0,
                    )),
                SizedBox(height: 4.0),
                Text('Passageiro: ${_model.nome}',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                    )),
                SizedBox(height: 16.0),
                _buildTextField(ctx, valorController, 'Valor Mensal (R\$)',
                    keyboardType: TextInputType.numberWithOptions(decimal: true)),
                SizedBox(height: 12.0),
                _buildTextField(ctx, inicioController, 'Data Início (AAAA-MM-DD)'),
                SizedBox(height: 12.0),
                _buildTextField(ctx, fimController, 'Data Fim (AAAA-MM-DD) — opcional'),
                SizedBox(height: 24.0),
                FFButtonWidget(
                  onPressed: isSaving ? null : () async {
                    setModalState(() => isSaving = true);
                    try {
                      final valor = double.tryParse(
                          valorController.text.replaceAll(',', '.')) ?? 0;
                      await VivanLocator.service.createContrato(VivanContrato(
                        idMotorista: FFAppState().idUsuario,
                        idPassageiro: widget.passageiroId,
                        valMensal: valor,
                        dtInicio: inicioController.text.trim().isEmpty
                            ? null : inicioController.text.trim(),
                        dtTermino: fimController.text.trim().isEmpty
                            ? null : fimController.text.trim(),
                        status: 'RASCUNHO',
                      ));
                      if (ctx.mounted) Navigator.pop(ctx);
                      await _model.fetchContratos(
                          FFAppState().idUsuario, widget.passageiroId!);
                      safeSetState(() {});
                    } catch (e) {
                      setModalState(() => isSaving = false);
                      if (ctx.mounted) {
                        ScaffoldMessenger.of(ctx).showSnackBar(
                          SnackBar(content: Text('Erro ao criar contrato')));
                      }
                    }
                  },
                  text: isSaving ? 'Salvando...' : 'Criar Contrato',
                  options: FFButtonOptions(
                    width: double.infinity, height: 48.0,
                    color: isSaving
                        ? FlutterFlowTheme.of(context).primary.withOpacity(0.5)
                        : FlutterFlowTheme.of(context).primary,
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
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String label, String value, IconData icon) {
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
              Icon(icon,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(fontWeight: FontWeight.normal),
                          color:
                              FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    value.isNotEmpty ? value : '-',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showResponsavelForm(BuildContext context,
      {dynamic responsavel}) async {
    final nomeController = TextEditingController(
        text: responsavel != null
            ? responsavel.nomeResponsavel
            : '');
    final cpfController = TextEditingController(
        text: '');
    final telefoneController = TextEditingController(
        text: responsavel != null
            ? responsavel.whatsAppResponsavel
            : '');
    final parentescoController = TextEditingController(
        text: responsavel != null
            ? responsavel.parentesco
            : '');

    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      context: context,
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  responsavel != null
                      ? 'Editar Responsável'
                      : 'Novo Responsável',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font:
                            GoogleFonts.interTight(fontWeight: FontWeight.w600),
                        letterSpacing: 0.0,
                      ),
                ),
                SizedBox(height: 16.0),
                _buildTextField(bottomSheetContext, nomeController, 'Nome'),
                SizedBox(height: 12.0),
                _buildTextField(bottomSheetContext, cpfController, 'CPF'),
                SizedBox(height: 12.0),
                _buildTextField(
                    bottomSheetContext, telefoneController, 'Telefone'),
                SizedBox(height: 12.0),
                _buildTextField(
                    bottomSheetContext, parentescoController, 'Parentesco'),
                SizedBox(height: 24.0),
                FFButtonWidget(
                  onPressed: () async {
                    final r = VivanResponsavel(
                      idResponsavel: responsavel?.idResponsavel,
                      idPassageiro: widget.passageiroId,
                      nomeResponsavel: nomeController.text,
                      cpfResponsavel: cpfController.text,
                      parentesco: parentescoController.text,
                      whatsAppResponsavel: telefoneController.text,
                      emailResponsavel: '',
                    );
                    if (responsavel != null) {
                      await VivanLocator.service.updateResponsavel(
                        widget.passageiroId!, responsavel!.idResponsavel!, r,
                      );
                    } else {
                      await VivanLocator.service.createResponsavel(
                        widget.passageiroId!, r,
                      );
                    }
                    Navigator.of(bottomSheetContext).pop();
                    await _model.fetchPassageiro(widget.passageiroId!);
                    safeSetState(() {});
                  },
                  text: 'Salvar',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 48.0,
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle:
                        FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600),
                              color: Colors.white,
                              letterSpacing: 0.0,
                            ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      BuildContext context, TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: FlutterFlowTheme.of(context).primaryBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            font: GoogleFonts.inter(
                fontWeight:
                    FlutterFlowTheme.of(context).bodyMedium.fontWeight),
            letterSpacing: 0.0,
          ),
    );
  }
}
