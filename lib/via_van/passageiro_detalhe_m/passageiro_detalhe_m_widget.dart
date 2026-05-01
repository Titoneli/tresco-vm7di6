import '/vivan/vivan.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/via_van/passageiro_form_m/passageiro_form_m_widget.dart';
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
    String dtNasc = '';
    if (p?.dtNascimento != null && p!.dtNascimento!.isNotEmpty) {
      try {
        dtNasc =
            DateFormat('dd/MM/yyyy').format(DateTime.parse(p.dtNascimento!));
      } catch (_) {
        dtNasc = p.dtNascimento!;
      }
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFF4A5568),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
            ),
            child: _model.foto.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: Image.network(_model.foto,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person,
                            size: 36, color: Colors.white70)),
                  )
                : const Icon(Icons.person, size: 36, color: Colors.white70),
          ),
          const SizedBox(height: 12),
          Text(
            p?.nomePassageiro ?? '',
            textAlign: TextAlign.center,
            style: GoogleFonts.interTight(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          if (dtNasc.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(dtNasc,
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
          ],
          if ((p?.domTurno ?? '').isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(p!.domTurno!,
                style:
                    GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
          ],
          if ((p?.nomeEscola ?? '').isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              p!.nomeEscola!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.white54),
            ),
          ],
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

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(resp.nomeResponsavel,
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _primaryText)),
          if (resp.whatsAppResponsavel.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(resp.whatsAppResponsavel,
                style:
                    GoogleFonts.inter(fontSize: 13, color: _secondaryText)),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => launchUrl(Uri.parse('tel:$numero55')),
                  icon: const Icon(Icons.phone_outlined, size: 16),
                  label: const Text('Ligar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _primary,
                    side: BorderSide(color: _primary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => launchUrl(
                      Uri.parse('https://wa.me/$numero55'),
                      mode: LaunchMode.externalApplication),
                  icon: const Icon(Icons.chat_outlined, size: 16),
                  label: const Text('WhatsApp'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF25D366),
                    side: const BorderSide(color: Color(0xFF25D366)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Extrato Financeiro — em breve')));
  }

  void _openContratos() {
    if (_model.contratos.isNotEmpty) {
      context.pushNamed(
        'contratoDetalheM',
        queryParameters: {
          'contratoId': serializeParam(
              _model.contratos.first.idContrato, ParamType.int),
        }.withoutNulls,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum contrato encontrado')));
    }
  }

  void _openGestaoMensalidades() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Gestão de Mensalidades — em breve')));
  }

  void _openRenovarMensalidades() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Renovar Mensalidades — em breve')));
  }
}
