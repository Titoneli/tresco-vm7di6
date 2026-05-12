import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/models/vivan_models.dart';
import '/backend/supabase/supabase.dart';
import 'presenca_m_widget.dart' show PresencaMWidget;
import 'package:flutter/material.dart';

class PresencaMModel extends FlutterFlowModel<PresencaMWidget> {
  bool isLoading = true;
  bool isSending = false;
  List<VivanPresenca> presencas = [];

  int get totalPresentes => presencas.where((p) => p.isPresente).length;
  int get totalFaltas => presencas.where((p) => !p.isPresente).length;

  // Mapa: passageiroId -> tipo (P ou F)
  Map<int, String> presencaMap = {};

  // Geolocalização
  double? latitude;
  double? longitude;

  // Filtro para histórico
  FocusNode? dataInicioFocusNode;
  TextEditingController? dataInicioTextController;
  FocusNode? dataFimFocusNode;
  TextEditingController? dataFimTextController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    dataInicioFocusNode?.dispose();
    dataInicioTextController?.dispose();
    dataFimFocusNode?.dispose();
    dataFimTextController?.dispose();
  }

  Future<void> fetchPresencasHoje(int motoristaId) async {
    isLoading = true;
    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      final rows = await SupaFlow.client
          .from('vivan_presencas')
          .select()
          .eq('idMotorista', motoristaId)
          .eq('dtPresenca', hoje);
      presencas = (rows as List)
          .map((r) => VivanPresenca.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
      presencaMap.clear();
      for (final p in presencas) {
        if (p.idPassageiro != null) {
          presencaMap[p.idPassageiro!] = p.tipoPresenca;
        }
      }
    } catch (e) {
      debugPrint('PresencaM.fetchPresencasHoje: $e');
      presencas = [];
    }
    isLoading = false;
  }

  Future<void> fetchHistorico(int motoristaId, String dataInicio, String dataFim) async {
    isLoading = true;
    try {
      final rows = await SupaFlow.client
          .from('vivan_presencas')
          .select()
          .eq('idMotorista', motoristaId)
          .gte('dtPresenca', dataInicio)
          .lte('dtPresenca', dataFim)
          .order('dtPresenca', ascending: false);
      presencas = (rows as List)
          .map((r) => VivanPresenca.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      debugPrint('PresencaM.fetchHistorico: $e');
      presencas = [];
    }
    isLoading = false;
  }

  Future<bool> enviarPresencasLote(int motoristaId) async {
    isSending = true;
    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      final registros = presencaMap.entries.map((e) => {
        'idPassageiro': e.key,
        'idMotorista': motoristaId,
        'dtPresenca': hoje,
        'tipoPresenca': e.value,
        if (latitude != null) 'latRegistro': latitude,
        if (longitude != null) 'lngRegistro': longitude,
      }).toList();
      await SupaFlow.client.from('vivan_presencas').upsert(
        registros,
        onConflict: 'idMotorista,idPassageiro,dtPresenca',
      );
      isSending = false;
      return true;
    } catch (e) {
      debugPrint('PresencaM.enviarPresencasLote: $e');
      isSending = false;
      return false;
    }
  }

  void togglePresenca(int passageiroId) {
    final current = presencaMap[passageiroId];
    presencaMap[passageiroId] = (current == null || current == 'F') ? 'P' : 'F';
  }
}
