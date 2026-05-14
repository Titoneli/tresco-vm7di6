import '/backend/supabase/supabase.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Fallback usado quando vivan_faq não está acessível
const _kFaqFallback = [
  (
    'Como funciona o ViVan?',
    'O ViVan é um app para motoristas de van escolar gerenciarem passageiros, mensalidades e financeiro de forma simples, tudo pelo celular.'
  ),
  (
    'Quais são as principais funções do ViVan?',
    'Cadastro de passageiros e escolas, controle de mensalidades, gestão financeira (receitas e despesas), geração de contratos e comunicação com responsáveis via WhatsApp.'
  ),
  (
    'Eu preciso pagar para ter o ViVan?',
    'O ViVan oferece um período de experimentação gratuito. Após esse período, é necessária uma assinatura para continuar utilizando todos os recursos.'
  ),
  (
    'Como faço para experimentar o ViVan?',
    'Baixe o app, crie sua conta de motorista e comece a usar gratuitamente no período de trial. Nenhum cartão é exigido para começar.'
  ),
  (
    'Após o período de experimentação vou precisar pagar?',
    'Sim, após o trial você precisará de uma assinatura ativa para continuar gerenciando passageiros e mensalidades pelo ViVan.'
  ),
];

class AjudaMWidget extends StatefulWidget {
  const AjudaMWidget({super.key});

  @override
  State<AjudaMWidget> createState() => _AjudaMWidgetState();
}

class _AjudaMWidgetState extends State<AjudaMWidget> {
  bool _loading = true;
  List<({String pergunta, String resposta})> _faqs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    try {
      final rows = await SupaFlow.client
          .from('vivan_faq')
          .select('pergunta, resposta, ordem')
          .eq('ativo', true)
          .order('ordem', ascending: true) as List;

      if (rows.isNotEmpty) {
        _faqs = rows.map((r) {
          final m = r as Map;
          return (
            pergunta: m['pergunta']?.toString() ?? '',
            resposta: m['resposta']?.toString() ?? '',
          );
        }).toList();
      } else {
        _useFallback();
      }
    } catch (_) {
      _useFallback();
    }
    if (mounted) setState(() => _loading = false);
  }

  void _useFallback() {
    _faqs = _kFaqFallback
        .map((t) => (pergunta: t.$1, resposta: t.$2))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Column(
        children: [
          // ── "Fechar" + header navy (SafeArea fora do navy) ───────────────
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // "Fechar" em fundo branco, acima do navy
                Container(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          minimumSize: const Size(0, 36)),
                      child: Text('Fechar',
                          style: GoogleFonts.inter(
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
                  ),
                ),
                // Header navy
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  child: Center(
                    child: Image.asset(
                      'assets/images/vivan_logo_transparent.png',
                      height: 52,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Text('ViVan',
                          style: GoogleFonts.interTight(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2D4739))),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Título ───────────────────────────────────────────────────────
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text(
              'Sobre o ViVan',
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: FlutterFlowTheme.of(context).primaryText),
            ),
          ),

          // ── Lista FAQ ────────────────────────────────────────────────────
          Expanded(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(
                        color: FlutterFlowTheme.of(context).primary,
                        strokeWidth: 2))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: _faqs.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        clipBehavior: Clip.antiAlias,
                        child: _FaqTile(
                          pergunta: _faqs[i].pergunta,
                          resposta: _faqs[i].resposta,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  const _FaqTile({required this.pergunta, required this.resposta});

  final String pergunta;
  final String resposta;

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  _expanded ? Icons.remove_rounded : Icons.add_rounded,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.pergunta,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: FlutterFlowTheme.of(context).primaryText),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _expanded
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(48, 0, 16, 16),
                  child: Text(
                    widget.resposta,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        height: 1.5),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
