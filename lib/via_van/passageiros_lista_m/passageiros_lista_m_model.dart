import '/flutter_flow/flutter_flow_util.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/vivan/vivan.dart';
import 'passageiros_lista_m_widget.dart' show PassageirosListaMWidget;
import 'package:flutter/material.dart';

class PassageirosListaMModel extends FlutterFlowModel<PassageirosListaMWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;
  List<VivanPassageiro> passageiros = [];
  int total = 0;

  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel;
  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    menuSideBarExpandidoModel =
        createModel(context, () => MenuSideBarExpandidoModel());
  }

  @override
  void dispose() {
    menuSideBarExpandidoModel.dispose();
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();
  }

  /// Fetch passageiros from API
  Future<void> fetchPassageiros(int motoristaId, {String? busca}) async {
    isLoading = true;
    try {
      final result = await VivanLocator.service.getPassageiros(
        motorista: motoristaId,
        busca: busca,
      );
      passageiros = result.data;
      total = result.total;
    } catch (e) {
      debugPrint('Erro ao buscar passageiros: $e');
      passageiros = [];
      total = 0;
    }
    isLoading = false;
  }
}
