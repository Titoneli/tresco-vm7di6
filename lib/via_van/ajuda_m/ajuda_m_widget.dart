import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AjudaMWidget extends StatelessWidget {
  const AjudaMWidget({super.key});

  static const _faqs = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Column(
        children: [
          // ── Header navy ──────────────────────────────────────────────────
          Container(
            color: const Color(0xFF0D1B2A),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 36)),
                      child: Text('Fechar',
                          style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
                    const SizedBox(height: 12),
                    Text('ViVan',
                        style: GoogleFonts.interTight(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5)),
                  ],
                ),
              ),
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
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _faqs.length,
              itemBuilder: (context, i) => _FaqTile(
                pergunta: _faqs[i].$1,
                resposta: _faqs[i].$2,
                showDivider: i > 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  const _FaqTile({
    required this.pergunta,
    required this.resposta,
    required this.showDivider,
  });

  final String pergunta;
  final String resposta;
  final bool showDivider;

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
        if (widget.showDivider)
          Divider(height: 1, color: Colors.grey.shade200),
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                  color: Colors.white,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.fromLTRB(52, 0, 20, 16),
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
