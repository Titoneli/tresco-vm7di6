import '/vivan/vivan.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/via_van/passageiro_form_m/passageiro_form_m_widget.dart';
import '/via_van/extrato_passageiro_m/extrato_passageiro_m_widget.dart';
import '/via_van/gestao_mensalidades_m/gestao_mensalidades_m_widget.dart';
import '/via_van/renovar_mensalidades_m/renovar_mensalidades_m_widget.dart';
import '/via_van/contratos_lista_m/contratos_lista_m_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: _model.isLoading
              ? Center(
                  child: SpinKitPulse(color: _primary, size: 50.0),
                )
              : Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDarkCard(),
                            const SizedBox(height: 24),
                            _buildResponsaveisSection(),
                            const SizedBox(height: 24),
                            _buildActionButtons(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Fechar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      color: _primary)),
          ),
          Expanded(
            child: Center(
              child: Text('Passageiro',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          GestureDetector(
            onTap: _openEditForm,
            child: Text('Editar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: _primary)),
          ),
        ],
      ),
    );
  }

  // ── Dark info card ────────────────────────────────
  Widget _buildDarkCard() {
    final p = _model.passageiro;
    String dtNasc = '—';
    if (p?.dtNascimento != null && p!.dtNascimento!.isNotEmpty) {
      try {
        dtNasc =
            DateFormat('dd/MM/yyyy').format(DateTime.parse(p.dtNascimento!));
      } catch (_) {
        dtNasc = p.dtNascimento!;
      }
    }
    final turno = (p?.domTurno ?? '').isNotEmpty ? p!.domTurno! : '—';
    final escola = (p?.nomeEscola ?? '').isNotEmpty ? p!.nomeEscola! : '—';

    Widget infoRow(String label, String value, {bool last = false}) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: Colors.white70)),
                Flexible(
                  child: Text(value,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          if (!last)
            Divider(
                height: 1,
                color: Colors.white.withValues(alpha: 0.10)),
        ],
      );
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFF4A5568),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              p?.nomePassageiro ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.20)),
          infoRow('Data Nascimento', dtNasc),
          infoRow('Período', turno),
          infoRow('Escola', escola, last: true),
        ],
      ),
    );
  }

  // ── Responsáveis ──────────────────────────────────
  Widget _buildResponsaveisSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('RESPONSÁVEIS ADICIONADOS',
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: _secondaryText)),
          const SizedBox(height: 12),
          if (_model.responsaveis.isEmpty)
            Text('Nenhum responsável cadastrado',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: _secondaryText)),
          ..._model.responsaveis.map((resp) => _buildResponsavelCard(resp)),
        ],
      ),
    );
  }

  Widget _buildResponsavelCard(VivanResponsavel resp) {
    final tel =
        resp.whatsAppResponsavel.replaceAll(' ', '').replaceAll('-', '');
    final numero55 = tel.startsWith('+') ? tel : '+55$tel';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(resp.nomeResponsavel,
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _primaryText)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(resp.whatsAppResponsavel,
                        style: GoogleFonts.inter(
                            fontSize: 13, color: _secondaryText)),
                  ),
                  GestureDetector(
                    onTap: () => launchUrl(Uri.parse('tel:$numero55')),
                    child: Text('Ligar',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _primary)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => launchUrl(
                    Uri.parse('https://wa.me/$numero55'),
                    mode: LaunchMode.externalApplication),
                child: Text('Conversar no WhatsApp',
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _primary)),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey.shade100),
      ],
    );
  }

  // ── 4 action buttons ──────────────────────────────
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _actionButton(
            label: 'Extrato Financeiro',
            icon: Icons.receipt_long_outlined,
            onTap: _openExtrato,
          ),
          const SizedBox(height: 10),
          _actionButton(
            label: 'Contratos',
            icon: Icons.description_outlined,
            onTap: _openContratos,
          ),
          const SizedBox(height: 10),
          _actionButton(
            label: 'Editar Mensalidades',
            icon: Icons.edit_calendar_outlined,
            onTap: _openGestaoMensalidades,
          ),
          const SizedBox(height: 10),
          _actionButton(
            label: 'Renovar Mensalidades',
            icon: Icons.autorenew_rounded,
            onTap: _openRenovarMensalidades,
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      {required String label,
      required IconData icon,
      required VoidCallback onTap}) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20, color: _primary),
      label: Text(label,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, color: _primaryText)),
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        side: BorderSide(color: Colors.grey.shade300),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        minimumSize: const Size(double.infinity, 52),
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  // ── Navigation ────────────────────────────────────
  Future<void> _openEditForm() async {
    final result = await Navigator.push<dynamic>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PassageiroFormMWidget(passageiroId: widget.passageiroId),
      ),
    );
    if (result != null && mounted) {
      if (result == 'deleted') {
        Navigator.pop(context);
      } else {
        await _model.fetchPassageiro(widget.passageiroId!);
        safeSetState(() {});
      }
    }
  }

  void _openExtrato() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExtratoPassageiroMWidget(
          passageiroId: widget.passageiroId!,
          nomePassageiro: _model.nome,
          urlFoto: _model.foto.isNotEmpty ? _model.foto : null,
        ),
      ),
    );
  }

  void _openContratos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContratosListaMWidget(
          passageiroId: widget.passageiroId!,
          nomePassageiro: _model.nome,
        ),
      ),
    );
  }

  void _openGestaoMensalidades() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GestaoMensalidadesMWidget(
          passageiroId: widget.passageiroId!,
          nomePassageiro: _model.nome,
        ),
      ),
    );
  }

  void _openRenovarMensalidades() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RenovarMensalidadesMWidget(
          passageiroId: widget.passageiroId!,
          nomePassageiro: _model.nome,
        ),
      ),
    );
  }
}
