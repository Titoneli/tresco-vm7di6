import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import 'passageiros_lista_m_widget.dart' show PassageirosListaMWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

class PassageirosListaMModel extends FlutterFlowModel<PassageirosListaMWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;
  ApiCallResponse? passageirosResponse;
  List<dynamic> get passageiros =>
      VivanPassageirosListCall.passageiros(passageirosResponse?.jsonBody) ?? [];
  int get total =>
      VivanPassageirosListCall.total(passageirosResponse?.jsonBody) ?? 0;

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
    passageirosResponse = await VivanPassageirosListCall.call(
      motoristaId: motoristaId,
      busca: busca,
    );
    isLoading = false;
  }
}
