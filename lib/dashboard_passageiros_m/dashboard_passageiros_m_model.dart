import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/models/vivan_models.dart';
import 'package:flutter/material.dart';
import 'dashboard_passageiros_m_widget.dart'
    show DashboardPassageirosMWidget;

class DashboardPassageirosMModel
    extends FlutterFlowModel<DashboardPassageirosMWidget> {
  final unfocusNode = FocusNode();
  int paginaAtiva = 0;
  PageController? pageViewController;

  // Home tab data
  int totalEscolas = 0;
  int totalPassageiros = 0;
  List<VivanMensalidade> mensalidadesEmAberto = [];
  bool isLoadingHome = true;
  bool hasError = false;

  // Aviso dinâmico
  String? avisoTitulo;
  String? avisoTexto;

  // WhatsApp dos responsáveis (idPassageiro → whatsApp)
  Map<int, String?> wppPorPassageiro = {};

  Future<void> fetchHomeData(int motoristaId) async {
    if (motoristaId == 0) motoristaId = FFAppState().idUsuario;
    if (motoristaId == 0) { isLoadingHome = false; return; }
    isLoadingHome = true;
    hasError = false;

    // ── Bloco 1: queries críticas (hasError = true se falharem) ──────────────
    List mensRows = [];
    try {
      final mesAtual = DateFormat('MM/yyyy').format(DateTime.now());
      final results = await Future.wait([
        SupaFlow.client
            .from('vivan_passageiros')
            .select('idPassageiro')
            .eq('idMotorista', motoristaId),
        SupaFlow.client
            .from('vivan_escolas')
            .select('idEscola')
            .eq('idMotorista', motoristaId),
        SupaFlow.client
            .from('vivan_mensalidades')
            .select()
            .eq('idMotorista', motoristaId)
            .inFilter('status', ['PENDENTE', 'ATRASADO'])
            .eq('mesReferencia', mesAtual)
            .order('dtVencimento', ascending: true)
            .limit(50),
      ]);

      totalPassageiros = (results[0] as List).length;
      totalEscolas     = (results[1] as List).length;

      mensRows = results[2] as List;
      mensalidadesEmAberto = mensRows
          .map((r) => VivanMensalidade.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      debugPrint('DashboardPassageiros.fetchHomeData/core: $e');
      hasError = true;
      isLoadingHome = false;
      return;
    }

    // ── Bloco 2: aviso dinâmico (falha silenciosa) ───────────────────────────
    try {
      final avisos = await SupaFlow.client
          .from('vivan_comunicado')
          .select()
          .eq('idMotorista', motoristaId)
          .order('createdAt', ascending: false)
          .limit(1) as List;
      if (avisos.isNotEmpty) {
        final a = avisos.first as Map;
        avisoTitulo = a['titulo']?.toString() ?? a['assunto']?.toString();
        avisoTexto  = a['texto']?.toString() ?? a['mensagem']?.toString() ?? a['msgComunicado']?.toString();
      } else {
        avisoTitulo = null;
        avisoTexto  = null;
      }
    } catch (e) {
      debugPrint('DashboardPassageiros.fetchHomeData/aviso: $e');
      avisoTitulo = null;
      avisoTexto  = null;
    }

    // ── Bloco 3: enriquecer nomes + WhatsApp (falha silenciosa) ─────────────
    try {
      final passIds = mensRows
          .map((r) => (r as Map)['idPassageiro'] as int?)
          .whereType<int>()
          .toSet()
          .toList();

      if (passIds.isNotEmpty) {
        final passRows = await SupaFlow.client
            .from('vivan_passageiros')
            .select('idPassageiro, nomePassageiro')
            .inFilter('idPassageiro', passIds) as List;
        final Map<int, String> nomes = {};
        for (final r in passRows) {
          final id = (r as Map)['idPassageiro'] as int?;
          final nome = r['nomePassageiro']?.toString();
          if (id != null && nome != null) nomes[id] = nome;
        }

        final respRows = await SupaFlow.client
            .from('vivan_responsaveis')
            .select('idPassageiro, whatsAppResponsavel')
            .inFilter('idPassageiro', passIds) as List;
        wppPorPassageiro = {};
        for (final r in respRows) {
          final id = (r as Map)['idPassageiro'] as int?;
          if (id != null) wppPorPassageiro[id] = r['whatsAppResponsavel']?.toString();
        }

        mensalidadesEmAberto = mensRows.map((r) {
          final row = Map<String, dynamic>.from(r as Map);
          final pid = row['idPassageiro'] as int?;
          if (pid != null && nomes.containsKey(pid)) {
            row['nomePassageiro'] = nomes[pid];
          }
          return VivanMensalidade.fromJson(row);
        }).toList();
      }
    } catch (e) {
      debugPrint('DashboardPassageiros.fetchHomeData/enrich: $e');
    }

    isLoadingHome = false;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    pageViewController?.dispose();
  }
}
