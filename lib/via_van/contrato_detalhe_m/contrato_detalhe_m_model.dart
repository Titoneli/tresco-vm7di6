import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/vivan/models/vivan_models.dart';
import 'contrato_detalhe_m_widget.dart' show ContratoDetalheMWidget;

class ContratoDetalheMModel extends FlutterFlowModel<ContratoDetalheMWidget> {
  bool isLoading = true;
  bool isActionLoading = false;
  VivanContrato? contrato;
  List<VivanContratoHistorico> historico = [];

  // Computed
  int? get id => contrato?.idContrato;
  String get status => contrato?.status ?? '';
  double get valorMensal => contrato?.valMensal ?? 0.0;
  String get passageiroNome => contrato?.nomePassageiro ?? '';
  String get dataInicio => contrato?.dtInicio ?? '';
  String get dataFim => contrato?.dtTermino ?? '';
  String get condicoes => contrato?.observacoes ?? '';

  // Form fields for creation
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  FocusNode? condicoesFocusNode;
  TextEditingController? condicoesTextController;
  FocusNode? dataInicioFocusNode;
  TextEditingController? dataInicioTextController;
  FocusNode? dataFimFocusNode;
  TextEditingController? dataFimTextController;
  List<VivanPassageiro> passageiros = [];
  VivanPassageiro? passageiroSelecionado;
  bool isLoadingPassageiros = false;

  int? get selectedPassageiroId => passageiroSelecionado?.idPassageiro;

  @override
  void initState(BuildContext context) {}

  Future<void> fetchPassageiros(int motoristaId) async {
    isLoadingPassageiros = true;
    try {
      final rows = await SupaFlow.client
          .from('vivan_passageiros')
          .select('idPassageiro, nomePassageiro, idMotorista, domTurno')
          .eq('idMotorista', motoristaId)
          .order('nomePassageiro')
          .limit(200);
      passageiros = (rows as List)
          .map((r) => VivanPassageiro.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      debugPrint('ContratoDetalhe.fetchPassageiros: $e');
    }
    isLoadingPassageiros = false;
  }

  @override
  void dispose() {
    valorFocusNode?.dispose();
    valorTextController?.dispose();
    condicoesFocusNode?.dispose();
    condicoesTextController?.dispose();
    dataInicioFocusNode?.dispose();
    dataInicioTextController?.dispose();
    dataFimFocusNode?.dispose();
    dataFimTextController?.dispose();
  }

  Future<void> fetchContrato(int contratoId) async {
    isLoading = true;
    try {
      final rows = await SupaFlow.client
          .from('vivan_contratos')
          .select('*, vivan_passageiros(nomePassageiro)')
          .eq('idContrato', contratoId)
          .eq('idMotorista', FFAppState().idUsuario)
          .limit(1);

      if ((rows as List).isNotEmpty) {
        final r = Map<String, dynamic>.from(rows.first as Map);
        final passMap = r.remove('vivan_passageiros') as Map?;
        if (passMap != null) r['nomePassageiro'] = passMap['nomePassageiro'];
        contrato = VivanContrato.fromJson(r);
      }

      // Histórico — retorna lista vazia se tabela não existir
      try {
        final hist = await SupaFlow.client
            .from('vivan_contratos_historico')
            .select()
            .eq('idContrato', contratoId)
            .order('createdAt', ascending: false);
        historico = (hist as List)
            .map((r) => VivanContratoHistorico.fromJson(
                Map<String, dynamic>.from(r as Map)))
            .toList();
      } catch (_) {
        historico = [];
      }
    } catch (e) {
      debugPrint('ContratoDetalhe.fetchContrato: $e');
    }
    isLoading = false;
  }

  Future<bool> ativar(int contratoId) async {
    isActionLoading = true;
    try {
      final result = await SupaFlow.client.rpc('vivan_ativar_contrato', params: {
        'p_contrato_id': contratoId,
        'p_motorista_id': FFAppState().idUsuario,
      });
      final newStatus = (result as Map?)?['status']?.toString() ?? 'ATIVO';
      if (contrato != null) {
        contrato = VivanContrato.fromJson({
          ...contrato!.toJson(),
          'idContrato': contrato!.idContrato,
          'status': newStatus,
        });
      }
      isActionLoading = false;
      return true;
    } catch (e) {
      debugPrint('ContratoDetalhe.ativar: $e');
      isActionLoading = false;
      return false;
    }
  }

  Future<bool> suspender(int contratoId, {String motivo = ''}) async {
    isActionLoading = true;
    try {
      await SupaFlow.client.rpc('vivan_suspender_contrato', params: {
        'p_contrato_id': contratoId,
        'p_motorista_id': FFAppState().idUsuario,
        'p_motivo': motivo,
      });
      if (contrato != null) {
        contrato = VivanContrato.fromJson({
          ...contrato!.toJson(),
          'idContrato': contrato!.idContrato,
          'status': 'SUSPENSO',
          'motivoSuspensao': motivo,
        });
      }
      isActionLoading = false;
      return true;
    } catch (e) {
      debugPrint('ContratoDetalhe.suspender: $e');
      isActionLoading = false;
      return false;
    }
  }

  Future<bool> cancelar(int contratoId, String motivo) async {
    isActionLoading = true;
    try {
      await SupaFlow.client.rpc('vivan_cancelar_contrato', params: {
        'p_contrato_id': contratoId,
        'p_motorista_id': FFAppState().idUsuario,
        'p_motivo': motivo,
      });
      if (contrato != null) {
        contrato = VivanContrato.fromJson({
          ...contrato!.toJson(),
          'idContrato': contrato!.idContrato,
          'status': 'CANCELADO',
          'motivoCancelamento': motivo,
        });
      }
      isActionLoading = false;
      return true;
    } catch (e) {
      debugPrint('ContratoDetalhe.cancelar: $e');
      isActionLoading = false;
      return false;
    }
  }

  Future<bool> deletar(int contratoId) async {
    isActionLoading = true;
    try {
      await SupaFlow.client.rpc('vivan_deletar_contrato', params: {
        'p_contrato_id': contratoId,
        'p_motorista_id': FFAppState().idUsuario,
      });
      isActionLoading = false;
      return true;
    } catch (e) {
      debugPrint('ContratoDetalhe.deletar: $e');
      isActionLoading = false;
      return false;
    }
  }

  // Mantido para compatibilidade com o widget — não faz chamada à API (Asaas abandonado)
  Future<bool> enviarAssinatura(int contratoId) async => false;
}
