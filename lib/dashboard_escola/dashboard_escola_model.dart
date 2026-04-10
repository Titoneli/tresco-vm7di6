import '/alunos/bts_aluno_busca_escola/bts_aluno_busca_escola_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/colaboradores/bts_colab_editar/bts_colab_editar_widget.dart';
import '/escolas/bts_escola_editar/bts_escola_editar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/frame_work/menu_side_bar_expandido/menu_side_bar_expandido_widget.dart';
import '/veiculos/bts_veiculo_editar/bts_veiculo_editar_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'dashboard_escola_widget.dart' show DashboardEscolaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardEscolaModel extends FlutterFlowModel<DashboardEscolaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for menuSideBarExpandido component.
  late MenuSideBarExpandidoModel menuSideBarExpandidoModel1;
  // State field(s) for filterMotorista widget.
  FocusNode? filterMotoristaFocusNode;
  TextEditingController? filterMotoristaTextController;
  String? Function(BuildContext, String?)?
      filterMotoristaTextControllerValidator;
  // State field(s) for filterEscola widget.
  FocusNode? filterEscolaFocusNode;
  TextEditingController? filterEscolaTextController;
  String? Function(BuildContext, String?)? filterEscolaTextControllerValidator;
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
    filterMotoristaFocusNode?.dispose();
    filterMotoristaTextController?.dispose();

    filterEscolaFocusNode?.dispose();
    filterEscolaTextController?.dispose();

    menuSideBarExpandidoModel2.dispose();
  }
}
