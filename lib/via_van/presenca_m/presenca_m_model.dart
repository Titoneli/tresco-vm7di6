import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
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
      final result = await VivanLocator.service.getPresencas(
        motorista: motoristaId,
        dtPresenca: hoje,
      );
      presencas = result.data;
      // Initialize presencaMap from existing records
      for (final p in presencas) {
        if (p.idPassageiro != null) {
          presencaMap[p.idPassageiro!] = p.tipoPresenca;
        }
      }
    } catch (e) {
      debugPrint('Erro ao buscar presenças: $e');
      presencas = [];
    }
    isLoading = false;
  }

  Future<void> fetchHistorico(int motoristaId, String dataInicio, String dataFim) async {
    isLoading = true;
    try {
      final result = await VivanLocator.service.getPresencas(
        motorista: motoristaId,
        dtPresenca: dataInicio, // TODO: API should support date range
      );
      presencas = result.data;
    } catch (e) {
      debugPrint('Erro ao buscar histórico: $e');
      presencas = [];
    }
    isLoading = false;
  }

  Future<bool> enviarPresencasLote(int motoristaId) async {
    isSending = true;
    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      final registros = presencaMap.entries.map((e) => VivanPresenca(
        idPassageiro: e.key,
        idMotorista: motoristaId,
        dtPresenca: hoje,
        tipoPresenca: e.value,
        latRegistro: latitude,
        lngRegistro: longitude,
      )).toList();
      await VivanLocator.service.enviarPresencasLote(registros);
      isSending = false;
      return true;
    } catch (e) {
      debugPrint('Erro ao enviar presenças: $e');
      isSending = false;
      return false;
    }
  }

  void togglePresenca(int passageiroId) {
    final current = presencaMap[passageiroId];
    presencaMap[passageiroId] = (current == null || current == 'F') ? 'P' : 'F';
  }
}
