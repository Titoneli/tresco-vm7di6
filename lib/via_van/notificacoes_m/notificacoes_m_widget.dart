import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificacoesMWidget extends StatefulWidget {
  const NotificacoesMWidget({super.key});

  @override
  State<NotificacoesMWidget> createState() => _NotificacoesMWidgetState();
}

class _NotificacoesMWidgetState extends State<NotificacoesMWidget> {
  bool _loading = true;
  List<_Notificacao> _notifs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final motoristaId = FFAppState().idUsuario;
      final rows = await SupaFlow.client
          .from('vivan_notificacoes')
          .select()
          .eq('idMotorista', motoristaId)
          .order('dtCriacao', ascending: false)
          .limit(50) as List;

      _notifs = rows.map((r) {
        final m = r as Map;
        return _Notificacao(
          id: (m['idNotificacao'] as int?) ?? 0,
          titulo: m['titulo']?.toString() ?? '',
          corpo: m['corpo']?.toString(),
          lido: (m['lido'] as bool?) ?? false,
          dtCriacao: m['dtCriacao']?.toString() ?? '',
        );
      }).toList();

      // Marcar todos como lidos em background
      _marcarTodosLidos(motoristaId);
    } catch (e) {
      debugPrint('NotificacoesMWidget._load: $e');
      _notifs = [];
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _marcarTodosLidos(int motoristaId) async {
    try {
      await SupaFlow.client
          .from('vivan_notificacoes')
          .update({'lido': true, 'dtLeitura': DateTime.now().toIso8601String()})
          .eq('idMotorista', motoristaId)
          .eq('lido', false);
      if (mounted) {
        setState(() {
          for (final n in _notifs) {
            n.lido = true;
          }
        });
      }
    } catch (_) {}
  }

  String _fmtData(String s) {
    try {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(s));
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Voltar',
              style: GoogleFonts.inter(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w500)),
        ),
        leadingWidth: 80,
        title: Text('Notificações',
            style: GoogleFonts.interTight(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: FlutterFlowTheme.of(context).primaryText)),
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primary))
          : _notifs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.notifications_none_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 48),
                      SizedBox(height: 12),
                      Text('Nenhuma notificação',
                          style: GoogleFonts.inter(
                              color:
                                  FlutterFlowTheme.of(context).secondaryText)),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: _notifs.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: Colors.grey.shade100),
                  itemBuilder: (context, i) {
                    final n = _notifs[i];
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(n.titulo,
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText)),
                                  if (n.corpo != null &&
                                      n.corpo!.isNotEmpty) ...[
                                    SizedBox(height: 4),
                                    Text(n.corpo!,
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                  SizedBox(height: 6),
                                  if (n.dtCriacao.isNotEmpty)
                                    Text('Recebida em ${_fmtData(n.dtCriacao)}',
                                        style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText)),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!n.lido)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                  ),
                                SizedBox(height: 6),
                                Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class _Notificacao {
  final int id;
  final String titulo;
  final String? corpo;
  bool lido;
  final String dtCriacao;

  _Notificacao({
    required this.id,
    required this.titulo,
    required this.corpo,
    required this.lido,
    required this.dtCriacao,
  });
}
