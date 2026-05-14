import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/vivan/models/vivan_models.dart';
import '/via_van/financeiro_tab/financeiro_tab_widget.dart';
import '/via_van/mensalidades_tab/mensalidades_tab_widget.dart';
import '/via_van/passageiros_tab/passageiros_tab_widget.dart';
import '/via_van/ajuda_m/ajuda_m_widget.dart';
import '/via_van/aniversariantes_m/aniversariantes_m_widget.dart';
import '/via_van/contratos_lista_m/contratos_lista_m_widget.dart';
import '/via_van/notificacoes_m/notificacoes_m_widget.dart';
import '/via_van/escolas_m/escolas_m_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard_passageiros_m_model.dart';
export 'dashboard_passageiros_m_model.dart';

class DashboardPassageirosMWidget extends StatefulWidget {
  const DashboardPassageirosMWidget({super.key});

  static String routeName = 'dashboardPassageirosM';
  static String routePath = '/dashPassageirosM';

  @override
  State<DashboardPassageirosMWidget> createState() =>
      _DashboardPassageirosMWidgetState();
}

class _DashboardPassageirosMWidgetState
    extends State<DashboardPassageirosMWidget>
    with WidgetsBindingObserver {
  late DashboardPassageirosMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? _lastRefresh;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardPassageirosMModel());
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().idEmpresa == 0) {
        context.pushNamed(LoginWidget.routeName);
        return;
      }
      _lastRefresh = DateTime.now();
      await _model.fetchHomeData(FFAppState().idUsuario);
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _model.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final stale = _lastRefresh == null ||
          DateTime.now().difference(_lastRefresh!).inMinutes >= 2;
      if (stale) _refresh();
    }
  }

  Future<void> _refresh() async {
    if (!mounted || _model.isLoadingHome) return;
    _lastRefresh = DateTime.now();
    setState(() => _model.isLoadingHome = true);
    await _model.fetchHomeData(FFAppState().idUsuario);
    if (mounted) setState(() {});
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildTopBar(context),
              Expanded(
                child: PageView(
                  controller: _model.pageViewController ??=
                      PageController(initialPage: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildHomePage(context),
                    PassageirosTabWidget(),
                    MensalidadesTabWidget(),
                    FinanceiroTabWidget(),
                    _buildMaisPage(context),
                  ],
                ),
              ),
              _buildBottomNav(context),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top Bar ──────────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(blurRadius: 2.0, color: Color(0x1A000000), offset: Offset(0.0, 1.0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/vivan_logo_transparent.png',
              height: 40.0,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Text(
                'VIVAN',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                  font: GoogleFonts.interTight(fontWeight: FontWeight.w800),
                  color: Color(0xFF2D4739),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlutterFlowIconButton(
                  borderRadius: 20.0, buttonSize: 40.0,
                  icon: Icon(Icons.help_outline_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText, size: 24.0),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AjudaMWidget())),
                ),
                FlutterFlowIconButton(
                  borderRadius: 20.0, buttonSize: 40.0,
                  icon: Icon(Icons.notifications_none_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText, size: 24.0),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const NotificacoesMWidget())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Home Page ─────────────────────────────────────────────────────────────

  Widget _buildHomePage(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return RefreshIndicator(
      color: FlutterFlowTheme.of(context).primary,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Text(
                'Ola, ${FFAppState().nomeUsuario}!',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 0.0),
              child: Text(
                'Gerencie seus passageiros e financeiro',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: FlutterFlowTheme.of(context).secondaryText),
              ),
            ),
            SizedBox(height: 16.0),

            // Card Aviso dinâmico
            if (_model.avisoTexto != null) ...[
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFF90CAF9), width: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Aviso',
                            style: GoogleFonts.interTight(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1565C0))),
                        if (_model.avisoTitulo != null) ...[
                          SizedBox(height: 4.0),
                          Text(_model.avisoTitulo!,
                              style: GoogleFonts.interTight(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1565C0))),
                        ],
                        SizedBox(height: 4.0),
                        Text(_model.avisoTexto!,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: const Color(0xFF1565C0))),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
            ],

            // Resumo Geral
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [BoxShadow(blurRadius: 4.0, color: Color(0x0D000000), offset: Offset(0.0, 2.0))],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('RESUMO GERAL',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                color: FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.5)),
                      SizedBox(height: 16.0),
                      if (_model.isLoadingHome)
                        Center(child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primary, strokeWidth: 2)))
                      else if (_model.hasError)
                        _buildErrorWidget()
                      else
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: _buildResumoItem(context,
                                  icon: Icons.school_rounded,
                                  label: 'Escolas',
                                  value: '${_model.totalEscolas}',
                                  color: Color(0xFF4B7BEC)),
                            ),
                            Container(width: 1, height: 60, color: Colors.grey.shade100),
                            Expanded(
                              child: _buildResumoItem(context,
                                  icon: Icons.people_rounded,
                                  label: 'Passageiros',
                                  value: '${_model.totalPassageiros}',
                                  color: FlutterFlowTheme.of(context).primary),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),

            // Card Aniversariantes
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AniversariantesMWidget()),
                ),
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [BoxShadow(blurRadius: 4.0, color: Color(0x0D000000), offset: Offset(0.0, 2.0))],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    child: Row(
                      children: [
                        Text('🎉', style: TextStyle(fontSize: 26)),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            'Verifique os próximos aniversariantes do seu transporte escolar clicando aqui!',
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: FlutterFlowTheme.of(context).primaryText),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText, size: 14.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),

            // Mensalidades em Aberto
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [BoxShadow(blurRadius: 4.0, color: Color(0x0D000000), offset: Offset(0.0, 2.0))],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('MENSALIDADES EM ABERTO',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    letterSpacing: 0.5)),
                          GestureDetector(
                            onTap: () => setState(() {
                              _model.paginaAtiva = 2;
                              _model.pageViewController?.animateToPage(2,
                                  duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                            }),
                            child: Icon(Icons.arrow_forward_ios_rounded,
                                color: FlutterFlowTheme.of(context).secondaryText, size: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      if (_model.isLoadingHome)
                        Center(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primary, strokeWidth: 2)))
                      else if (_model.hasError)
                        _buildErrorWidget()
                      else if (_model.mensalidadesEmAberto.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_outline_rounded,
                                    color: FlutterFlowTheme.of(context).success, size: 48.0),
                                const SizedBox(height: 8.0),
                                Text('Nenhuma mensalidade em aberto',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).secondaryText)),
                              ],
                            ),
                          ),
                        )
                      else
                        _buildMensalidadesList(currency),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    } catch (_) {
      return iso;
    }
  }

  Widget _buildResumoItem(BuildContext context,
      {required IconData icon, required String label, required String value, required Color color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48.0, height: 48.0,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12.0)),
          child: Icon(icon, color: color, size: 24.0),
        ),
        SizedBox(height: 8.0),
        Text(value, style: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
              color: FlutterFlowTheme.of(context).primaryText)),
        SizedBox(height: 2.0),
        Text(label, style: FlutterFlowTheme.of(context).bodySmall.override(
              font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).secondaryText)),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                color: FlutterFlowTheme.of(context).secondaryText, size: 36.0),
            const SizedBox(height: 8.0),
            Text('Erro ao carregar dados',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: FlutterFlowTheme.of(context).secondaryText)),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: _refresh,
              child: Text('Tentar novamente',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: FlutterFlowTheme.of(context).primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMensalidadesList(NumberFormat currency) {
    final exibidas = _model.mensalidadesEmAberto.take(5).toList();
    final total = _model.mensalidadesEmAberto.length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exibidas.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (ctx, i) {
            final m = exibidas[i];
            final isAtrasado = m.isAtrasado;
            final statusColor = isAtrasado ? const Color(0xFFF56565) : const Color(0xFFED8936);
            final statusLabel = isAtrasado ? 'em atraso' : 'Pendente';
            return InkWell(
              onTap: () => _showMensalidadeModal(context, m),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(children: [
                  Container(
                    width: 40.0, height: 40.0,
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(isAtrasado ? Icons.warning_amber_rounded : Icons.receipt_long_rounded,
                        color: statusColor, size: 20.0),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.nomePassageiro ?? '—',
                          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                              color: FlutterFlowTheme.of(context).primaryText)),
                      if (m.dtVencimento != null)
                        Text(_formatDate(m.dtVencimento!),
                            style: GoogleFonts.inter(fontSize: 12,
                                color: FlutterFlowTheme.of(context).secondaryText)),
                    ],
                  )),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(currency.format(m.valOriginal ?? 0),
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700,
                            color: FlutterFlowTheme.of(context).primaryText)),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      if (isAtrasado) Icon(Icons.warning_amber_rounded, color: statusColor, size: 12),
                      if (isAtrasado) SizedBox(width: 2),
                      Text(statusLabel,
                          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500,
                              color: statusColor)),
                    ]),
                  ]),
                ]),
              ),
            );
          },
        ),
        if (total > 5)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: () => setState(() {
                _model.paginaAtiva = 2;
                _model.pageViewController?.animateToPage(2,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              }),
              child: Text('Ver todas ($total)',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: FlutterFlowTheme.of(context).primary)),
            ),
          ),
      ],
    );
  }

  // ── Modal Mensalidade ─────────────────────────────────────────────────────

  void _showMensalidadeModal(BuildContext context, VivanMensalidade m) {
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final isAtrasado = m.isAtrasado;
    final statusColor = isAtrasado ? const Color(0xFFF56565) : const Color(0xFFED8936);
    final statusLabel = isAtrasado ? 'em atraso' : 'Pendente';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 16),
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2)),
            ),
            // Avatar + nome
            CircleAvatar(
              radius: 32,
              backgroundColor: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1),
              child: Icon(Icons.person_rounded,
                  color: FlutterFlowTheme.of(context).primary, size: 32),
            ),
            SizedBox(height: 10),
            Text(m.nomePassageiro?.toUpperCase() ?? '—',
                style: GoogleFonts.interTight(
                    fontSize: 16, fontWeight: FontWeight.w700,
                    color: FlutterFlowTheme.of(context).primaryText)),
            if (m.dtVencimento != null)
              Text('Vencimento ${_formatDate(m.dtVencimento!)}',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: FlutterFlowTheme.of(context).secondaryText)),
            SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey.shade200),
            // Valor + status
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Valor',
                        style: GoogleFonts.inter(fontSize: 12,
                            color: FlutterFlowTheme.of(context).secondaryText)),
                    Text(currency.format(m.valOriginal ?? 0),
                        style: GoogleFonts.interTight(
                            fontSize: 18, fontWeight: FontWeight.w700,
                            color: FlutterFlowTheme.of(context).primaryText)),
                  ]),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    if (isAtrasado)
                      Icon(Icons.warning_amber_rounded, color: statusColor, size: 16),
                    if (isAtrasado) SizedBox(width: 4),
                    Text(statusLabel,
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600,
                            color: statusColor)),
                  ]),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            SizedBox(height: 20),
            // Botões Cobrar + Pagou
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _cobrarWhatsApp(ctx, m),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: FlutterFlowTheme.of(context).primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Cobrar',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: FlutterFlowTheme.of(context).primary)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showPagouDialog(ctx, m),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Pagou',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            // Botão Abonar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _showAbonarDialog(ctx, m),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Abonar',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: FlutterFlowTheme.of(context).secondaryText)),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _cobrarWhatsApp(BuildContext ctx, VivanMensalidade m) {
    final wpp = _model.wppPorPassageiro[m.idPassageiro];
    if (wpp == null || wpp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Responsável sem WhatsApp cadastrado')));
      return;
    }
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final valor = currency.format(m.valOriginal ?? 0);
    final nome = m.nomePassageiro ?? '';
    final venc = m.dtVencimento != null ? _formatDate(m.dtVencimento!) : '';
    final msg = Uri.encodeComponent(
        'Olá! Passando para lembrar sobre a mensalidade de $nome no valor de $valor '
        '${venc.isNotEmpty ? "(vencimento: $venc)" : ""}. Qualquer dúvida, estou à disposição!');
    final numero = wpp.replaceAll(RegExp(r'\D'), '');
    launchUrl(Uri.parse('https://wa.me/55$numero?text=$msg'),
        mode: LaunchMode.externalApplication);
    Navigator.pop(ctx);
  }

  void _showPagouDialog(BuildContext ctx, VivanMensalidade m) {
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    String formaSelecionada = 'PIX';
    final formas = ['PIX', 'Dinheiro', 'Cartão de Crédito', 'Cartão de Débito', 'Outro'];

    showDialog(
      context: ctx,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (dialogCtx, setStateDialog) => AlertDialog(
          title: Text('Registrar Pagamento',
              style: GoogleFonts.interTight(fontWeight: FontWeight.w700, fontSize: 16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Valor: ${currency.format(m.valOriginal ?? 0)}',
                  style: GoogleFonts.inter(fontSize: 14)),
              SizedBox(height: 12),
              Text('Forma de pagamento:',
                  style: GoogleFonts.inter(fontSize: 13,
                      color: Colors.grey.shade600)),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: formaSelecionada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  isDense: true,
                ),
                items: formas.map((f) =>
                    DropdownMenuItem(value: f, child: Text(f, style: GoogleFonts.inter(fontSize: 14)))).toList(),
                onChanged: (v) => setStateDialog(() => formaSelecionada = v ?? 'PIX'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogCtx);
                Navigator.pop(ctx);
                await _registrarPagamento(m, formaSelecionada);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              child: Text('Confirmar', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registrarPagamento(VivanMensalidade m, String forma) async {
    try {
      final hoje = DateTime.now();
      final dtPagamento = DateFormat('yyyy-MM-dd').format(hoje);
      final venc = m.dtVencimento != null ? DateTime.tryParse(m.dtVencimento!) : null;
      final status = (venc != null && hoje.isAfter(venc)) ? 'PAGO_ATRASO' : 'PAGO';
      await SupaFlow.client.from('vivan_mensalidades').update({
        'valPago': m.valOriginal,
        'formaPagamento': forma,
        'dtPagamento': dtPagamento,
        'status': status,
      }).eq('idMensalidade', m.idMensalidade!);
      await _refresh();
    } catch (e) {
      debugPrint('_registrarPagamento: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao registrar pagamento')));
      }
    }
  }

  void _showAbonarDialog(BuildContext ctx, VivanMensalidade m) {
    final motivoCtrl = TextEditingController();
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        title: Text('Abonar Mensalidade',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Informe o motivo do abono:',
                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600)),
            SizedBox(height: 8),
            TextField(
              controller: motivoCtrl,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Ex: falta justificada',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.all(12),
                isDense: true,
              ),
              style: GoogleFonts.inter(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogCtx);
              Navigator.pop(ctx);
              await _registrarAbono(m, motivoCtrl.text.trim());
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: Text('Confirmar', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<void> _registrarAbono(VivanMensalidade m, String motivo) async {
    try {
      await SupaFlow.client.from('vivan_mensalidades').update({
        'status': 'ABONADO',
        'motivoAbono': motivo.isNotEmpty ? motivo : null,
      }).eq('idMensalidade', m.idMensalidade!);
      await _refresh();
    } catch (e) {
      debugPrint('_registrarAbono: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao registrar abono')));
      }
    }
  }

  // ── Mais Page ─────────────────────────────────────────────────────────────

  Widget _buildMaisPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo ViVan centralizado
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 16.0),
            child: Center(
              child: Image.asset(
                'assets/images/vivan_logo_transparent.png',
                height: 44.0,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Text(
                  'VIVAN',
                  style: GoogleFonts.interTight(
                      fontSize: 22, fontWeight: FontWeight.w800,
                      color: Color(0xFF2D4739)),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          SizedBox(height: 8),
          // Menu items
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [BoxShadow(blurRadius: 4.0, color: Color(0x0D000000), offset: Offset(0.0, 2.0))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuItem(context,
                      icon: Icons.star_rounded,
                      label: 'Assinatura',
                      color: const Color(0xFFF6C90E),
                      onTap: () {}),
                  _buildMenuDivider(),
                  _buildMenuItem(context,
                      icon: Icons.edit_rounded,
                      label: 'Editar Perfil',
                      color: const Color(0xFF4B7BEC),
                      onTap: () {}),
                  _buildMenuDivider(),
                  _buildMenuItem(context,
                      icon: Icons.school_rounded,
                      label: 'Minhas Escolas',
                      color: const Color(0xFF4B7BEC),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const EscolasMWidget()))),
                  _buildMenuDivider(),
                  _buildMenuItem(context,
                      icon: Icons.description_rounded,
                      label: 'Contratos',
                      color: const Color(0xFF4B7BEC),
                      onTap: () => context.pushNamed(ContratosListaMWidget.routeName)),
                  _buildMenuDivider(),
                  _buildMenuItem(context,
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Mensagens',
                      color: const Color(0xFF4B7BEC),
                      onTap: () {}),
                  _buildMenuDivider(),
                  _buildMenuItem(context,
                      icon: Icons.logout_rounded,
                      label: 'Sair do Aplicativo',
                      color: Colors.red.shade400,
                      textColor: Colors.red.shade400,
                      onTap: _confirmarSair),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMenuDivider() =>
      Divider(height: 1, color: Colors.grey.shade100, indent: 16, endIndent: 16);

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    Color? textColor,
    String? badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 40.0, height: 40.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Text(label,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                        color: textColor ?? FlutterFlowTheme.of(context).primaryText)),
            ),
            if (badge != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4B7BEC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(badge,
                    style: GoogleFonts.inter(
                        fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
              )
            else
              Icon(Icons.arrow_forward_ios_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText, size: 16.0),
          ],
        ),
      ),
    );
  }

  void _confirmarSair() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Sair',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
        content: Text('Deseja encerrar a sessão?',
            style: GoogleFonts.inter(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancelar',
                style: TextStyle(color: FlutterFlowTheme.of(context).secondaryText)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              FFAppState().idEmpresa = 0;
              FFAppState().idUsuario = 0;
              FFAppState().nomeUsuario = '';
              context.goNamed(LoginWidget.routeName);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: Text('Sair', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ── Bottom Nav ────────────────────────────────────────────────────────────

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      width: double.infinity, height: 70.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [BoxShadow(blurRadius: 4.0, color: Color(0x1A000000), offset: Offset(0.0, -1.0))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, Icons.home_rounded, 'Inicio'),
          _buildNavItem(context, 1, Icons.people_rounded, 'Passageiros'),
          _buildNavItem(context, 2, Icons.receipt_long_rounded, 'Mensalidades'),
          _buildNavItem(context, 3, Icons.account_balance_wallet_rounded, 'Financeiro'),
          _buildNavItem(context, 4, Icons.more_horiz_rounded, 'Mais'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isActive = _model.paginaAtiva == index;
    final activeColor = FlutterFlowTheme.of(context).primary;
    final inactiveColor = FlutterFlowTheme.of(context).secondaryText;
    return InkWell(
      onTap: () {
        setState(() {
          _model.paginaAtiva = index;
          _model.pageViewController?.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
        if (index == 0) _refresh();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? activeColor : inactiveColor, size: 24.0),
          SizedBox(height: 4.0),
          Text(label, style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.inter(fontWeight: isActive ? FontWeight.w600 : FontWeight.normal),
                color: isActive ? activeColor : inactiveColor, fontSize: 11.0)),
        ],
      ),
    );
  }
}
