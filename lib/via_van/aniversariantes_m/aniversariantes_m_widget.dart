import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AniversariantesMWidget extends StatefulWidget {
  const AniversariantesMWidget({super.key});

  @override
  State<AniversariantesMWidget> createState() => _AniversariantesMWidgetState();
}

class _AniversariantesMWidgetState extends State<AniversariantesMWidget> {
  bool _loading = true;
  // Lista de grupos: {mes: int, label: String, itens: List<_Aniversariante>}
  List<_MesGroup> _grupos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final motoristaId = FFAppState().idUsuario;

      final passRows = await SupaFlow.client
          .from('vivan_passageiros')
          .select('idPassageiro, nomePassageiro, dtNascimento')
          .eq('idMotorista', motoristaId)
          .not('dtNascimento', 'is', null);

      final passIds = (passRows as List)
          .map((r) => r['idPassageiro'] as int?)
          .whereType<int>()
          .toList();

      Map<int, String?> wppMap = {};
      if (passIds.isNotEmpty) {
        final respRows = await SupaFlow.client
            .from('vivan_responsaveis')
            .select('idPassageiro, whatsAppResponsavel')
            .inFilter('idPassageiro', passIds);
        for (final r in respRows as List) {
          final id = r['idPassageiro'] as int?;
          if (id != null) wppMap[id] = r['whatsAppResponsavel']?.toString();
        }
      }

      final hoje = DateTime.now();
      final List<_Aniversariante> todos = [];

      for (final r in passRows) {
        final id = r['idPassageiro'] as int?;
        final nome = r['nomePassageiro']?.toString() ?? '';
        final dtStr = r['dtNascimento']?.toString();
        if (dtStr == null || id == null) continue;
        try {
          final dt = DateTime.parse(dtStr);
          todos.add(_Aniversariante(
            id: id,
            nome: nome,
            dtNascimento: dt,
            wpp: wppMap[id],
            idade: _proximaIdade(dt, hoje),
          ));
        } catch (_) {}
      }

      // Agrupar por mês de nascimento, ordenar por próximo mês relativo a hoje
      final Map<int, List<_Aniversariante>> porMes = {};
      for (final a in todos) {
        porMes.putIfAbsent(a.dtNascimento.month, () => []).add(a);
      }

      // Ordenar dentro de cada mês pelo dia
      for (final list in porMes.values) {
        list.sort((a, b) => a.dtNascimento.day.compareTo(b.dtNascimento.day));
      }

      // Ordenar meses: começando pelo mês atual
      final mesesOrdenados = porMes.keys.toList()
        ..sort((a, b) {
          final da = (a - hoje.month + 12) % 12;
          final db = (b - hoje.month + 12) % 12;
          return da.compareTo(db);
        });

      _grupos = mesesOrdenados
          .map((mes) => _MesGroup(mes: mes, itens: porMes[mes]!))
          .toList();
    } catch (e) {
      debugPrint('AniversariantesMWidget._load: $e');
    }
    if (mounted) setState(() => _loading = false);
  }

  int _proximaIdade(DateTime dtNasc, DateTime hoje) {
    int idade = hoje.year - dtNasc.year;
    final proxAniv = DateTime(hoje.year, dtNasc.month, dtNasc.day);
    if (proxAniv.isBefore(hoje)) idade++;
    return idade;
  }

  void _enviarWhatsApp(String nome, String? wpp) {
    if (wpp == null || wpp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Responsável sem WhatsApp cadastrado')));
      return;
    }
    final numero = wpp.replaceAll(RegExp(r'\D'), '');
    final msg = Uri.encodeComponent(
        'Olá! Passando para lembrar que hoje é aniversário de $nome! 🎉 '
        'Mostre seu carinho e pode cantar parabéns na van!');
    launchUrl(Uri.parse('https://wa.me/55$numero?text=$msg'),
        mode: LaunchMode.externalApplication);
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
          child: Text('Fechar',
              style: GoogleFonts.inter(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w500)),
        ),
        leadingWidth: 80,
        title: Text('Aniversariantes',
            style: GoogleFonts.interTight(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: FlutterFlowTheme.of(context).primaryText)),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator(
              color: FlutterFlowTheme.of(context).primary))
          : _grupos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cake_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText, size: 48),
                      SizedBox(height: 12),
                      Text('Nenhum aniversariante cadastrado',
                          style: GoogleFonts.inter(
                              color: FlutterFlowTheme.of(context).secondaryText)),
                      SizedBox(height: 4),
                      Text('Cadastre a data de nascimento dos passageiros.',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: FlutterFlowTheme.of(context).secondaryText)),
                    ],
                  ),
                )
              : ListView(
                  children: [
                    // Header banner
                    Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text('🎉', style: TextStyle(fontSize: 32)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Surpreenda no aniversário!',
                                    style: GoogleFonts.interTight(
                                        fontSize: 14, fontWeight: FontWeight.w700,
                                        color: const Color(0xFF1565C0))),
                                SizedBox(height: 4),
                                Text(
                                    'Mostre seu carinho enviando uma mensagem ao responsável e pergunte se pode cantar parabéns na van.',
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: const Color(0xFF1565C0))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Grupos por mês
                    for (final grupo in _grupos) ...[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                        child: Text(grupo.labelMes.toUpperCase(),
                            style: GoogleFonts.interTight(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.5)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(
                              blurRadius: 4, color: Color(0x0D000000),
                              offset: Offset(0, 2))],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: grupo.itens.asMap().entries.map((e) {
                            final i = e.key;
                            final a = e.value;
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (i > 0) Divider(height: 1, color: Colors.grey.shade100,
                                    indent: 16, endIndent: 16),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundColor: FlutterFlowTheme.of(context)
                                            .primary
                                            .withValues(alpha: 0.1),
                                        child: Icon(Icons.person_rounded,
                                            color: FlutterFlowTheme.of(context).primary,
                                            size: 22),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(a.nome.toUpperCase(),
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: FlutterFlowTheme.of(context).primaryText)),
                                            Text(
                                                '${a.dtNascimento.day.toString().padLeft(2, '0')}/${a.dtNascimento.month.toString().padLeft(2, '0')}',
                                                style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: FlutterFlowTheme.of(context).secondaryText)),
                                            Text('Vai completar ${a.idade} ${a.idade == 1 ? 'ano' : 'anos'}',
                                                style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: FlutterFlowTheme.of(context).secondaryText)),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => _enviarWhatsApp(a.nome, a.wpp),
                                        child: Text('Enviar',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                color: FlutterFlowTheme.of(context).primary)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                    SizedBox(height: 24),
                  ],
                ),
    );
  }
}

class _Aniversariante {
  final int id;
  final String nome;
  final DateTime dtNascimento;
  final String? wpp;
  final int idade;

  _Aniversariante({
    required this.id,
    required this.nome,
    required this.dtNascimento,
    required this.wpp,
    required this.idade,
  });
}

class _MesGroup {
  final int mes;
  final List<_Aniversariante> itens;

  _MesGroup({required this.mes, required this.itens});

  String get labelMes {
    const nomes = [
      '', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];
    return nomes[mes];
  }
}
