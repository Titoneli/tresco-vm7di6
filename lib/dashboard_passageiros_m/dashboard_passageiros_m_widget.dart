import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/via_van/financeiro_tab/financeiro_tab_widget.dart';
import '/via_van/mensalidades_tab/mensalidades_tab_widget.dart';
import '/via_van/passageiros_tab/passageiros_tab_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
      await _refresh();
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
      _refresh();
    }
  }

  Future<void> _refresh() async {
    if (!mounted) return;
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
                  onPressed: () {},
                ),
                FlutterFlowIconButton(
                  borderRadius: 20.0, buttonSize: 40.0,
                  icon: Icon(Icons.notifications_none_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText, size: 24.0),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
                      Text('Resumo Geral',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                                color: FlutterFlowTheme.of(context).primaryText)),
                      SizedBox(height: 16.0),
                      _model.isLoadingHome
                          ? Center(child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: CircularProgressIndicator(
                                  color: FlutterFlowTheme.of(context).primary, strokeWidth: 2)))
                          : Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildResumoItem(context,
                                    icon: Icons.people_rounded,
                                    label: 'Passageiros',
                                    value: '${_model.totalPassageiros}',
                                    color: FlutterFlowTheme.of(context).primary),
                                _buildResumoItem(context,
                                    icon: Icons.school_rounded,
                                    label: 'Escolas',
                                    value: '${_model.totalEscolas}',
                                    color: Color(0xFF4B7BEC)),
                                _buildResumoItem(context,
                                    icon: Icons.attach_money_rounded,
                                    label: 'A Receber',
                                    value: currency.format(_model.totalAReceber),
                                    color: FlutterFlowTheme.of(context).success),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
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
                          Text('Mensalidades em Aberto',
                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                                    color: FlutterFlowTheme.of(context).primaryText)),
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
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primary, strokeWidth: 2)))
                      else if (_model.mensalidadesEmAberto.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_outline_rounded,
                                    color: FlutterFlowTheme.of(context).success, size: 48.0),
                                SizedBox(height: 8.0),
                                Text('Nenhuma mensalidade em aberto',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).secondaryText)),
                              ],
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _model.mensalidadesEmAberto.length,
                          separatorBuilder: (_, __) => Divider(height: 1),
                          itemBuilder: (ctx, i) {
                            final m = _model.mensalidadesEmAberto[i];
                            final isAtrasado = m.isAtrasado;
                            final statusColor = isAtrasado ? Color(0xFFF56565) : Color(0xFFED8936);
                            final statusLabel = isAtrasado ? 'Atrasado' : 'Pendente';
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(children: [
                                Container(
                                  width: 40.0, height: 40.0,
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(Icons.receipt_long_rounded, color: statusColor, size: 20.0),
                                ),
                                SizedBox(width: 12.0),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(m.nomePassageiro ?? '—',
                                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,
                                            color: FlutterFlowTheme.of(context).primaryText)),
                                    if (m.dtVencimento != null)
                                      Text('Vence: ${_formatDate(m.dtVencimento!)}',
                                          style: GoogleFonts.inter(fontSize: 12,
                                              color: FlutterFlowTheme.of(context).secondaryText)),
                                  ],
                                )),
                                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                  Text(currency.format(m.valOriginal ?? 0),
                                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700,
                                          color: statusColor)),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(statusLabel,
                                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
                                            color: statusColor)),
                                  ),
                                ]),
                              ]),
                            );
                          },
                        ),
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

  Widget _buildMaisPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 8.0),
            child: Text(
              'Menu',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                    color: FlutterFlowTheme.of(context).primaryText),
            ),
          ),
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
                  InkWell(
                    onTap: () => context.pushNamed(PassageirosListaMWidget.routeName),
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(Icons.people_rounded,
                                color: FlutterFlowTheme.of(context).primary, size: 22.0),
                          ),
                          SizedBox(width: 14.0),
                          Expanded(
                            child: Text(
                              'Gestão de Passageiros',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                    color: FlutterFlowTheme.of(context).primaryText),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText, size: 16.0),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade100, indent: 16, endIndent: 16),
                  InkWell(
                    onTap: _confirmarSair,
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(Icons.logout_rounded,
                                color: Colors.red.shade400, size: 22.0),
                          ),
                          SizedBox(width: 14.0),
                          Expanded(
                            child: Text(
                              'Sair',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                    color: Colors.red.shade400),
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
          const SizedBox(height: 32),
          Center(
            child: FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (ctx, snap) {
                final info = snap.data;
                final label = info != null
                    ? 'ViVan v${info.version}+${info.buildNumber}'
                    : 'ViVan';
                return Text(
                  label,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: FlutterFlowTheme.of(context).secondaryText),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
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
                style: TextStyle(
                    color: FlutterFlowTheme.of(context).secondaryText)),
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
