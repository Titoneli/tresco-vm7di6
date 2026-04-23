import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/index.dart';
import 'dashboard_rel_widget.dart' show DashboardRelWidget;
import 'package:flutter/material.dart';

class DashboardRelModel extends FlutterFlowModel<DashboardRelWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for ddwMesBase widget.
  String? ddwMesBaseValue;
  FormFieldController<String>? ddwMesBaseValueController;
  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // State field(s) for ddwMotorista widget.
  int? ddwMotoristaValue;
  FormFieldController<int>? ddwMotoristaValueController;
  // Stores action output result for [Backend Call - API (retContabilPorMotorista)] action in IconButton widget.
  ApiCallResponse? apiResGeraRelContabilPorMotorista;
  // Stores action output result for [Backend Call - API (retFechamentoGeral)] action in IconButton widget.
  ApiCallResponse? apiResGeraRelFechamentoGeral;
  // Stores action output result for [Backend Call - API (retFechamentoGeral)] action in IconButton widget.
  ApiCallResponse? apiResGeraRelFechamentoEscola;
  // Stores action output result for [Backend Call - API (retFechamentoGeral)] action in IconButton widget.
  ApiCallResponse? apiResGeraRelFechamentoMotorista;
  // Stores action output result for [Backend Call - API (retFaturamentoSinteticoMot)] action in IconButton widget.
  ApiCallResponse? apiResGeraFatSinteticoMotMesBas;
  // Stores action output result for [Backend Call - API (retFaturamentoSinteticoMot)] action in IconButton widget.
  ApiCallResponse? apiResGeraFatSinteticoMotSemMesBase;
  // Stores action output result for [Backend Call - API (WHGERADEMPFPJ)] action in IconButton widget.
  ApiCallResponse? apiResGeraDemonstrativo;
  // Stores action output result for [Backend Call - API (WHGERADEMPFPJ)] action in IconButton widget.
  ApiCallResponse? apiResGeraAnaliticoSemMesBase;
  // Stores action output result for [Backend Call - API (retListagemAlunosMotEsc)] action in IconButton widget.
  ApiCallResponse? apiResGeraListaAlunosEsc;
  // Stores action output result for [Backend Call - API (retListagemAlunosMotEsc)] action in IconButton widget.
  ApiCallResponse? apiResGeraListaAlunosMot;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel2;

  @override
  void initState(BuildContext context) {
    menuSideBarExpandidoModel1 =
        createModel(context, () => MenuSideBarExpandidoModel());
    menuSideBarExpandidoModel2 =
        createModel(context, () => MenuSideBarExpandidoModel());
  }

  @override
  void dispose() {
    menuSideBarExpandidoModel1.dispose();
    menuSideBarExpandidoModel2.dispose();
  }
}
