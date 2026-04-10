import '/alunos/bts_aluno_busca/bts_aluno_busca_widget.dart';
import '/alunos/bts_aluno_busca_escola/bts_aluno_busca_escola_widget.dart';
import '/alunos/bts_aluno_busca_motorista_escola/bts_aluno_busca_motorista_escola_widget.dart';
import '/alunos/bts_aluno_editar/bts_aluno_editar_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/colaboradores/bts_colab_lista/bts_colab_lista_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/bts_aguarde/bts_aguarde_widget.dart';
import '/frame_work/bts_selecione/bts_selecione_widget.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/frame_work/menu_side_bar_reduzido/menu_side_bar_reduzido_widget.dart';
import '/frame_work/menu_side_bar_tablet/menu_side_bar_tablet_widget.dart';
import '/frame_work/row_aluno_vazio/row_aluno_vazio_widget.dart';
import '/frame_work/row_escola_vazio/row_escola_vazio_widget.dart';
import '/frame_work/row_motorista_vazio/row_motorista_vazio_widget.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'dashboard_admin_widget.dart' show DashboardAdminWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardAdminModel extends FlutterFlowModel<DashboardAdminWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarTablet component.
  late MenuSideBarTabletModel menuSideBarTabletModel;
  // Model for menuSideBarReduzido component.
  late MenuSideBarReduzidoModel menuSideBarReduzidoModel;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for rdgFiltro widget.
  FormFieldController<String>? rdgFiltroValueController;
  // State field(s) for filter widget.
  FocusNode? filterFocusNode;
  TextEditingController? filterTextController;
  String? Function(BuildContext, String?)? filterTextControllerValidator;
  // Stores action output result for [Backend Call - API (retListagemAlunosMotEsc)] action in Icon widget.
  ApiCallResponse? apiResGeraListaAlunosEsc;
  // Stores action output result for [Backend Call - API (WHGERADEMPFPJ)] action in btnDemonstrativo widget.
  ApiCallResponse? apiResGeraDemonstrativo;
  // Stores action output result for [Backend Call - API (retFaturamentoSinteticoMot)] action in btnSintetico widget.
  ApiCallResponse? apiResGeraFatSinteticoMot;
  // Stores action output result for [Backend Call - API (retListagemAlunosMotEsc)] action in btnListaAlunos widget.
  ApiCallResponse? apiResGeraListaAlunos;
  // State field(s) for ddwMesBase widget.
  String? ddwMesBaseValue;
  FormFieldController<String>? ddwMesBaseValueController;
  Completer<List<FinfechconfirmadoRow>>? requestCompleter;
  // State field(s) for ddwEscolaPgto widget.
  int? ddwEscolaPgtoValue;
  FormFieldController<int>? ddwEscolaPgtoValueController;
  // State field(s) for ddwMotoristaPgto widget.
  int? ddwMotoristaPgtoValue;
  FormFieldController<int>? ddwMotoristaPgtoValueController;
  // Stores action output result for [Backend Call - Delete Row(s)] action in btnExcluirConfirmacao widget.
  List<FinfechconfirmadoRow>? apiResExcluirConfirmacao;
  // Stores action output result for [Backend Call - API (WHGRAVARFECHAMENTO)] action in Button widget.
  ApiCallResponse? apiResWHINSERTFINFECHAMENTO;
  // State field(s) for ddwMesBaseFechamento widget.
  String? ddwMesBaseFechamentoValue;
  FormFieldController<String>? ddwMesBaseFechamentoValueController;
  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // State field(s) for ddwMotorista widget.
  int? ddwMotoristaValue;
  FormFieldController<int>? ddwMotoristaValueController;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel2;

  @override
  void initState(BuildContext context) {
    menuSideBarTabletModel =
        createModel(context, () => MenuSideBarTabletModel());
    menuSideBarReduzidoModel =
        createModel(context, () => MenuSideBarReduzidoModel());
    menuSideBarExpandidoModel1 =
        createModel(context, () => MenuSideBarExpandidoModel());
    menuSideBarExpandidoModel2 =
        createModel(context, () => MenuSideBarExpandidoModel());
  }

  @override
  void dispose() {
    menuSideBarTabletModel.dispose();
    menuSideBarReduzidoModel.dispose();
    menuSideBarExpandidoModel1.dispose();
    tabBarController?.dispose();
    filterFocusNode?.dispose();
    filterTextController?.dispose();

    menuSideBarExpandidoModel2.dispose();
  }

  /// Additional helper methods.
  String? get rdgFiltroValue => rdgFiltroValueController?.value;
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
