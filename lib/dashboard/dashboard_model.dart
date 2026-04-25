import '/alunos/bts_aluno_busca/bts_aluno_busca_widget.dart';
import '/alunos/bts_aluno_busca_escola/bts_aluno_busca_escola_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/colaboradores/bts_colab_editar/bts_colab_editar_widget.dart';
import '/colaboradores/bts_colab_lista/bts_colab_lista_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/veiculos/bts_veiculo_editar/bts_veiculo_editar_widget.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (refreshViews)] action in dashboard widget.
  ApiCallResponse? apiResRefresh;
  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for filterEscola widget.
  FocusNode? filterEscolaFocusNode1;
  TextEditingController? filterEscolaTextController1;
  String? Function(BuildContext, String?)? filterEscolaTextController1Validator;
  // State field(s) for filterMotorista widget.
  FocusNode? filterMotoristaFocusNode;
  TextEditingController? filterMotoristaTextController;
  String? Function(BuildContext, String?)?
      filterMotoristaTextControllerValidator;
  // State field(s) for filterEscola widget.
  FocusNode? filterEscolaFocusNode2;
  TextEditingController? filterEscolaTextController2;
  String? Function(BuildContext, String?)? filterEscolaTextController2Validator;
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
    filterEscolaFocusNode1?.dispose();
    filterEscolaTextController1?.dispose();

    filterMotoristaFocusNode?.dispose();
    filterMotoristaTextController?.dispose();

    filterEscolaFocusNode2?.dispose();
    filterEscolaTextController2?.dispose();

    menuSideBarExpandidoModel2.dispose();
  }
}
