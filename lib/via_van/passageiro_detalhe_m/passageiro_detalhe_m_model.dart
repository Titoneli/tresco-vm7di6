import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/vivan/models/vivan_models.dart';
import 'passageiro_detalhe_m_widget.dart' show PassageiroDetalheMWidget;

class PassageiroDetalheMModel
    extends FlutterFlowModel<PassageiroDetalheMWidget> {
  bool isLoading = true;
  VivanPassageiro? passageiro;
  List<VivanResponsavel> responsaveis = [];
  List<VivanContrato> contratos = [];
  bool isLoadingContratos = false;

  String get nome => passageiro?.nomePassageiro ?? '';
  String get cpf => passageiro?.cpfPassageiro ?? '';
  String get escola => passageiro?.nomeEscola ?? '';
  String get endereco => passageiro?.enderecoCompleto ?? '';
  String get foto => passageiro?.urlFoto ?? '';
  String get status => passageiro?.ativo == true ? 'ATIVO' : 'INATIVO';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchPassageiro(int passageiroId) async {
    isLoading = true;
    try {
      final rows = await SupaFlow.client
          .from('vivan_passageiros')
          .select()
          .eq('idPassageiro', passageiroId)
          .eq('idMotorista', FFAppState().idUsuario)
          .limit(1);

      if ((rows as List).isEmpty) {
        isLoading = false;
        return;
      }
      final r = Map<String, dynamic>.from(rows.first as Map);

      // Busca nome da escola separadamente (evita depender de FK no PostgREST)
      final escolaId = r['idEscola'] as int?;
      if (escolaId != null) {
        try {
          final esRows = await SupaFlow.client
              .from('vivan_escolas')
              .select('nomeEscola')
              .eq('idEscola', escolaId)
              .limit(1);
          if ((esRows as List).isNotEmpty) {
            r['nomeEscola'] = (esRows.first as Map)['nomeEscola']?.toString();
          }
        } catch (_) {}
      }
      passageiro = VivanPassageiro.fromJson(r);

      final respRows = await SupaFlow.client
          .from('vivan_responsaveis')
          .select()
          .eq('idPassageiro', passageiroId);
      responsaveis = (respRows as List)
          .map((row) => VivanResponsavel.fromJson(
              Map<String, dynamic>.from(row as Map)))
          .toList();
    } catch (e) {
      debugPrint('PassageiroDetalhe.fetchPassageiro: $e');
    }
    isLoading = false;
  }

  Future<void> fetchContratos(int motoristaId, int passageiroId) async {
    isLoadingContratos = true;
    try {
      final rows = await SupaFlow.client
          .from('vivan_contratos')
          .select()
          .eq('idPassageiro', passageiroId)
          .eq('idMotorista', motoristaId)
          .order('idContrato', ascending: false);
      contratos = (rows as List)
          .map((row) => VivanContrato.fromJson(
              Map<String, dynamic>.from(row as Map)))
          .toList();
    } catch (e) {
      debugPrint('PassageiroDetalhe.fetchContratos: $e');
    }
    isLoadingContratos = false;
  }

  Future<void> deleteResponsavel(int passageiroId, int responsavelId) async {
    try {
      await SupaFlow.client
          .from('vivan_responsaveis')
          .delete()
          .eq('idResponsavel', responsavelId)
          .eq('idPassageiro', passageiroId);
      responsaveis.removeWhere((r) => r.idResponsavel == responsavelId);
    } catch (e) {
      debugPrint('PassageiroDetalhe.deleteResponsavel: $e');
    }
  }
}
