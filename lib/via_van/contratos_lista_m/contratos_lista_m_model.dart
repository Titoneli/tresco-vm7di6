import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/vivan/models/vivan_models.dart';
import 'contratos_lista_m_widget.dart' show ContratosListaMWidget;

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
      var query = SupaFlow.client
          .from('vivan_contratos')
          .select('*, vivan_passageiros(nomePassageiro)')
          .eq('idMotorista', motoristaId);

      if (passageiro != null) query = query.eq('idPassageiro', passageiro);
      if (status != null) query = query.eq('status', status);

      final rows = await query.order('idContrato', ascending: false);

      contratos = (rows as List).map((row) {
        final r = Map<String, dynamic>.from(row as Map);
        final passMap = r.remove('vivan_passageiros') as Map?;
        if (passMap != null) r['nomePassageiro'] = passMap['nomePassageiro'];
        return VivanContrato.fromJson(r);
      }).toList();

      total = contratos.length;
    } catch (e) {
      debugPrint('ContratosLista.fetchContratos: $e');
      contratos = [];
      total = 0;
    }
    isLoading = false;
  }

  VivanContrato? get contratoAtivo {
    try {
      return contratos.firstWhere((c) => c.status.toUpperCase() == 'ATIVO');
    } catch (_) {
      return contratos.isNotEmpty ? contratos.first : null;
    }
  }
}
