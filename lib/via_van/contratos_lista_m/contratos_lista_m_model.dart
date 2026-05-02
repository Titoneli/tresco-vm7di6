import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'contratos_lista_m_widget.dart' show ContratosListaMWidget;
import 'package:flutter/material.dart';

class ContratosListaMModel extends FlutterFlowModel<ContratosListaMWidget> {
  bool isLoading = true;
  String? filtroStatus;
  List<VivanContrato> contratos = [];
  int total = 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchContratos(int motoristaId,
      {String? status, int? passageiro}) async {
    isLoading = true;
    filtroStatus = status;
    try {
      final result = await VivanLocator.service.getContratos(
        motorista: motoristaId,
        status: status,
        passageiro: passageiro,
      );
      contratos = result.data;
      total = result.total;
    } catch (e) {
      debugPrint('Erro ao buscar contratos: $e');
      contratos = [];
      total = 0;
    }
    isLoading = false;
  }

  VivanContrato? get contratoAtivo {
    try {
      return contratos.firstWhere(
          (c) => c.status.toUpperCase() == 'ATIVO');
    } catch (_) {
      return contratos.isNotEmpty ? contratos.first : null;
    }
  }
}
