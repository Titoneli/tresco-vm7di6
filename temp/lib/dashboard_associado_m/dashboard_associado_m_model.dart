import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/index.dart';
import 'dashboard_associado_m_widget.dart' show DashboardAssociadoMWidget;
import 'package:flutter/material.dart';

class DashboardAssociadoMModel
    extends FlutterFlowModel<DashboardAssociadoMWidget> {
  ///  Local state fields for this page.

  int? paginaAtiva;

  String? selectedEscolaLabel;

  bool btnConfirmaAtivo = true;

  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwEscolaConfirma widget.
  int? ddwEscolaConfirmaValue;
  FormFieldController<int>? ddwEscolaConfirmaValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<FinfechconfirmadoRow>? apiResBuscaConfirmacao;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<EscolaRow>? apiResNomeEscola;
  // Stores action output result for [Backend Call - Insert Row] action in Container widget.
  FinfechconfirmadoRow? apiResInsertConfirmaFechamento;
  // State field(s) for ddwEscolaPgto widget.
  int? ddwEscolaPgtoValue;
  FormFieldController<int>? ddwEscolaPgtoValueController;
  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // State field(s) for filterAluno widget.
  FocusNode? filterAlunoFocusNode;
  TextEditingController? filterAlunoTextController;
  String? Function(BuildContext, String?)? filterAlunoTextControllerValidator;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // State field(s) for Checkbox widget.
  Map<AppAlunosConferenciaRow, bool> checkboxValueMap = {};
  List<AppAlunosConferenciaRow> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Backend Call - Update Row(s)] action in Checkbox widget.
  List<AlunoRow>? actTrue;
  // Stores action output result for [Backend Call - Update Row(s)] action in Checkbox widget.
  List<AlunoRow>? actFalse;

  @override
  void initState(BuildContext context) {
    menuSideBarExpandidoModel =
        createModel(context, () => MenuSideBarExpandidoModel());
  }

  @override
  void dispose() {
    menuSideBarExpandidoModel.dispose();
    tabBarController?.dispose();
    filterAlunoFocusNode?.dispose();
    filterAlunoTextController?.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
