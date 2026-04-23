import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'passageiro_detalhe_m_widget.dart' show PassageiroDetalheMWidget;
import 'package:flutter/material.dart';

class PassageiroDetalheMModel
    extends FlutterFlowModel<PassageiroDetalheMWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;
  VivanPassageiro? passageiro;
  List<VivanResponsavel> responsaveis = [];

  // Computed fields
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
      passageiro = await VivanLocator.service.getPassageiro(passageiroId);
      responsaveis = await VivanLocator.service.getResponsaveis(passageiroId);
    } catch (e) {
      debugPrint('Erro ao buscar passageiro: $e');
    }
    isLoading = false;
  }

  Future<void> deleteResponsavel(int passageiroId, int responsavelId) async {
    try {
      await VivanLocator.service.deleteResponsavel(passageiroId, responsavelId);
      responsaveis.removeWhere((r) => r.idResponsavel == responsavelId);
    } catch (e) {
      debugPrint('Erro ao excluir responsável: $e');
    }
  }
}
