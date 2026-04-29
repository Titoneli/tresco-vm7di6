import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'contrato_detalhe_m_widget.dart' show ContratoDetalheMWidget;
import 'package:flutter/material.dart';

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
      final result = await VivanLocator.service.getPassageiros(
        motorista: motoristaId,
        limit: 100,
      );
      passageiros = result.data;
    } catch (e) {
      debugPrint('Erro ao buscar passageiros: $e');
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
      final results = await Future.wait([
        VivanLocator.service.getContrato(contratoId),
        VivanLocator.service.getContratoHistorico(contratoId),
      ]);
      contrato = results[0] as VivanContrato;
      historico = results[1] as List<VivanContratoHistorico>;
    } catch (e) {
      debugPrint('Erro ao buscar contrato: $e');
    }
    isLoading = false;
  }

  Future<bool> ativar(int contratoId) async {
    isActionLoading = true;
    try {
      contrato = await VivanLocator.service.ativarContrato(contratoId);
      isActionLoading = false;
      return true;
    } catch (e) {
      isActionLoading = false;
      return false;
    }
  }

  Future<bool> suspender(int contratoId, {String motivo = ''}) async {
    isActionLoading = true;
    try {
      contrato = await VivanLocator.service.suspenderContrato(contratoId, motivo);
      isActionLoading = false;
      return true;
    } catch (e) {
      isActionLoading = false;
      return false;
    }
  }

  Future<bool> cancelar(int contratoId, String motivo) async {
    isActionLoading = true;
    try {
      contrato = await VivanLocator.service.cancelarContrato(contratoId, motivo);
      isActionLoading = false;
      return true;
    } catch (e) {
      isActionLoading = false;
      return false;
    }
  }

  Future<bool> enviarAssinatura(int contratoId) async {
    isActionLoading = true;
    try {
      contrato = await VivanLocator.service.enviarParaAssinatura(contratoId);
      isActionLoading = false;
      return true;
    } catch (e) {
      isActionLoading = false;
      return false;
    }
  }
}
