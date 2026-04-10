import '/alunos/bts_aluno_endereco/bts_aluno_endereco_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/escolas/bts_turmas/bts_turmas_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/frame_work/bts_aguarde/bts_aguarde_widget.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'bts_aluno_editar_widget.dart' show BtsAlunoEditarWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsAlunoEditarModel extends FlutterFlowModel<BtsAlunoEditarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwSitAluno widget.
  String? ddwSitAlunoValue;
  FormFieldController<String>? ddwSitAlunoValueController;
  // State field(s) for ddwExclusaoAluno widget.
  String? ddwExclusaoAlunoValue;
  FormFieldController<String>? ddwExclusaoAlunoValueController;
  // State field(s) for ddwTipoAluno widget.
  String? ddwTipoAlunoValue;
  FormFieldController<String>? ddwTipoAlunoValueController;
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode1;
  TextEditingController? nomeTextController1;
  String? Function(BuildContext, String?)? nomeTextController1Validator;
  String? _nomeTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Nome é obrigatório';
    }

    return null;
  }

  // State field(s) for cpfCnpj widget.
  FocusNode? cpfCnpjFocusNode;
  TextEditingController? cpfCnpjTextController;
  String? Function(BuildContext, String?)? cpfCnpjTextControllerValidator;
  // State field(s) for telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  String? _telefoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'WhatsApp / Telefone Celular é obrigatório';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for lat widget.
  FocusNode? latFocusNode;
  TextEditingController? latTextController;
  String? Function(BuildContext, String?)? latTextControllerValidator;
  // State field(s) for long widget.
  FocusNode? longFocusNode;
  TextEditingController? longTextController;
  String? Function(BuildContext, String?)? longTextControllerValidator;
  // State field(s) for ddwVeiculo widget.
  int? ddwVeiculoValue;
  FormFieldController<int>? ddwVeiculoValueController;
  // State field(s) for cep widget.
  FocusNode? cepFocusNode;
  TextEditingController? cepTextController;
  String? Function(BuildContext, String?)? cepTextControllerValidator;
  // State field(s) for logradouro widget.
  FocusNode? logradouroFocusNode;
  TextEditingController? logradouroTextController;
  String? Function(BuildContext, String?)? logradouroTextControllerValidator;
  // State field(s) for numero widget.
  FocusNode? numeroFocusNode;
  TextEditingController? numeroTextController;
  String? Function(BuildContext, String?)? numeroTextControllerValidator;
  // State field(s) for comp widget.
  FocusNode? compFocusNode;
  TextEditingController? compTextController;
  String? Function(BuildContext, String?)? compTextControllerValidator;
  // State field(s) for bairro widget.
  FocusNode? bairroFocusNode;
  TextEditingController? bairroTextController;
  String? Function(BuildContext, String?)? bairroTextControllerValidator;
  // State field(s) for cidade widget.
  FocusNode? cidadeFocusNode;
  TextEditingController? cidadeTextController;
  String? Function(BuildContext, String?)? cidadeTextControllerValidator;
  // State field(s) for uf widget.
  FocusNode? ufFocusNode;
  TextEditingController? ufTextController;
  String? Function(BuildContext, String?)? ufTextControllerValidator;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // State field(s) for nomeResp widget.
  FocusNode? nomeRespFocusNode;
  TextEditingController? nomeRespTextController;
  String? Function(BuildContext, String?)? nomeRespTextControllerValidator;
  // State field(s) for rgResp widget.
  FocusNode? rgRespFocusNode;
  TextEditingController? rgRespTextController;
  String? Function(BuildContext, String?)? rgRespTextControllerValidator;
  // State field(s) for telResp widget.
  FocusNode? telRespFocusNode;
  TextEditingController? telRespTextController;
  String? Function(BuildContext, String?)? telRespTextControllerValidator;
  // State field(s) for swcAutorizacaoEntregue widget.
  bool? swcAutorizacaoEntregueValue;
  // Stores action output result for [Backend Call - API (WHGERAAUTORIZACAORESP)] action in Button widget.
  ApiCallResponse? apiResGeraAutorizacao;
  bool isDataUploading_updataSupabase = false;
  FFUploadedFile uploadedLocalFile_updataSupabase =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_updataSupabase = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AlunoRow>? apiResSalvaFoto;
  // State field(s) for ddwEscola widget.
  int? ddwEscolaValue;
  FormFieldController<int>? ddwEscolaValueController;
  // State field(s) for ddwSerie widget.
  String? ddwSerieValue;
  FormFieldController<String>? ddwSerieValueController;
  // State field(s) for ddwTurno widget.
  String? ddwTurnoValue;
  FormFieldController<String>? ddwTurnoValueController;
  // State field(s) for ddwTurma widget.
  int? ddwTurmaValue;
  FormFieldController<int>? ddwTurmaValueController;
  // State field(s) for ddwMotorista widget.
  int? ddwMotoristaValue;
  FormFieldController<int>? ddwMotoristaValueController;
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode2;
  TextEditingController? nomeTextController2;
  String? Function(BuildContext, String?)? nomeTextController2Validator;
  // State field(s) for chkConfirmaMotorista widget.
  bool? chkConfirmaMotoristaValue;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AlunoRow>? apiResEditaUsuario;

  @override
  void initState(BuildContext context) {
    nomeTextController1Validator = _nomeTextController1Validator;
    telefoneTextControllerValidator = _telefoneTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    nomeFocusNode1?.dispose();
    nomeTextController1?.dispose();

    cpfCnpjFocusNode?.dispose();
    cpfCnpjTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    latFocusNode?.dispose();
    latTextController?.dispose();

    longFocusNode?.dispose();
    longTextController?.dispose();

    cepFocusNode?.dispose();
    cepTextController?.dispose();

    logradouroFocusNode?.dispose();
    logradouroTextController?.dispose();

    numeroFocusNode?.dispose();
    numeroTextController?.dispose();

    compFocusNode?.dispose();
    compTextController?.dispose();

    bairroFocusNode?.dispose();
    bairroTextController?.dispose();

    cidadeFocusNode?.dispose();
    cidadeTextController?.dispose();

    ufFocusNode?.dispose();
    ufTextController?.dispose();

    nomeRespFocusNode?.dispose();
    nomeRespTextController?.dispose();

    rgRespFocusNode?.dispose();
    rgRespTextController?.dispose();

    telRespFocusNode?.dispose();
    telRespTextController?.dispose();

    nomeFocusNode2?.dispose();
    nomeTextController2?.dispose();
  }
}
