import '/atf/bts_a_t_f_adicionar_passageiro/bts_a_t_f_adicionar_passageiro_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/frame_work/bts_selecione/bts_selecione_widget.dart';
import 'dart:convert';
import 'dart:ui';
import 'bts_a_t_f_adicionar_m_widget.dart' show BtsATFAdicionarMWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class BtsATFAdicionarMModel extends FlutterFlowModel<BtsATFAdicionarMWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey3 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwTipoATF widget.
  String? ddwTipoATFValue;
  FormFieldController<String>? ddwTipoATFValueController;
  // State field(s) for ddwMotorista widget.
  String? ddwMotoristaValue;
  FormFieldController<String>? ddwMotoristaValueController;
  // State field(s) for placa widget.
  FocusNode? placaFocusNode;
  TextEditingController? placaTextController;
  String? Function(BuildContext, String?)? placaTextControllerValidator;
  String? _placaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Placa do Veículo é Obrigatória';
    }

    return null;
  }

  // State field(s) for documento widget.
  FocusNode? documentoFocusNode;
  TextEditingController? documentoTextController;
  String? Function(BuildContext, String?)? documentoTextControllerValidator;
  String? _documentoTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Documento é Obrigatório';
    }

    return null;
  }

  // State field(s) for serie widget.
  FocusNode? serieFocusNode;
  TextEditingController? serieTextController;
  String? Function(BuildContext, String?)? serieTextControllerValidator;
  String? _serieTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Série é Obrigatório';
    }

    return null;
  }

  // State field(s) for ddwOrigem widget.
  String? ddwOrigemValue;
  FormFieldController<String>? ddwOrigemValueController;
  // State field(s) for ddwDestino widget.
  String? ddwDestinoValue;
  FormFieldController<String>? ddwDestinoValueController;
  // State field(s) for itinerario widget.
  FocusNode? itinerarioFocusNode;
  TextEditingController? itinerarioTextController;
  String? Function(BuildContext, String?)? itinerarioTextControllerValidator;
  String? _itinerarioTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Itinerário é Obrigatório';
    }

    return null;
  }

  // State field(s) for dataIda widget.
  FocusNode? dataIdaFocusNode;
  TextEditingController? dataIdaTextController;
  late MaskTextInputFormatter dataIdaMask;
  String? Function(BuildContext, String?)? dataIdaTextControllerValidator;
  String? _dataIdaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Data ida é Obrigatório';
    }

    return null;
  }

  // State field(s) for horaIda widget.
  FocusNode? horaIdaFocusNode;
  TextEditingController? horaIdaTextController;
  late MaskTextInputFormatter horaIdaMask;
  String? Function(BuildContext, String?)? horaIdaTextControllerValidator;
  String? _horaIdaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Hora ida é Obrigatório';
    }

    return null;
  }

  // State field(s) for kmIda widget.
  FocusNode? kmIdaFocusNode;
  TextEditingController? kmIdaTextController;
  String? Function(BuildContext, String?)? kmIdaTextControllerValidator;
  String? _kmIdaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'KM ida é Obrigatório';
    }

    return null;
  }

  // State field(s) for dataVolta widget.
  FocusNode? dataVoltaFocusNode;
  TextEditingController? dataVoltaTextController;
  late MaskTextInputFormatter dataVoltaMask;
  String? Function(BuildContext, String?)? dataVoltaTextControllerValidator;
  String? _dataVoltaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Data volta é Obrigatório';
    }

    return null;
  }

  // State field(s) for horaVolta widget.
  FocusNode? horaVoltaFocusNode;
  TextEditingController? horaVoltaTextController;
  late MaskTextInputFormatter horaVoltaMask;
  String? Function(BuildContext, String?)? horaVoltaTextControllerValidator;
  String? _horaVoltaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Hora volta é Obrigatório';
    }

    return null;
  }

  // State field(s) for kmVolta widget.
  FocusNode? kmVoltaFocusNode;
  TextEditingController? kmVoltaTextController;
  String? Function(BuildContext, String?)? kmVoltaTextControllerValidator;
  String? _kmVoltaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'KM volta é Obrigatório';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  AtfRow? actResGravaATF;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AtfPassageiroRow>? acBuscaPassageiros;

  @override
  void initState(BuildContext context) {
    placaTextControllerValidator = _placaTextControllerValidator;
    documentoTextControllerValidator = _documentoTextControllerValidator;
    serieTextControllerValidator = _serieTextControllerValidator;
    itinerarioTextControllerValidator = _itinerarioTextControllerValidator;
    dataIdaTextControllerValidator = _dataIdaTextControllerValidator;
    horaIdaTextControllerValidator = _horaIdaTextControllerValidator;
    kmIdaTextControllerValidator = _kmIdaTextControllerValidator;
    dataVoltaTextControllerValidator = _dataVoltaTextControllerValidator;
    horaVoltaTextControllerValidator = _horaVoltaTextControllerValidator;
    kmVoltaTextControllerValidator = _kmVoltaTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    placaFocusNode?.dispose();
    placaTextController?.dispose();

    documentoFocusNode?.dispose();
    documentoTextController?.dispose();

    serieFocusNode?.dispose();
    serieTextController?.dispose();

    itinerarioFocusNode?.dispose();
    itinerarioTextController?.dispose();

    dataIdaFocusNode?.dispose();
    dataIdaTextController?.dispose();

    horaIdaFocusNode?.dispose();
    horaIdaTextController?.dispose();

    kmIdaFocusNode?.dispose();
    kmIdaTextController?.dispose();

    dataVoltaFocusNode?.dispose();
    dataVoltaTextController?.dispose();

    horaVoltaFocusNode?.dispose();
    horaVoltaTextController?.dispose();

    kmVoltaFocusNode?.dispose();
    kmVoltaTextController?.dispose();
  }
}
