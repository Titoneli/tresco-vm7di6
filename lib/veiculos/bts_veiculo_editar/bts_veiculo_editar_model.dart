import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_veiculo_editar_widget.dart' show BtsVeiculoEditarWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BtsVeiculoEditarModel extends FlutterFlowModel<BtsVeiculoEditarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ddwCargo widget.
  int? ddwCargoValue;
  FormFieldController<int>? ddwCargoValueController;
  // State field(s) for Placa widget.
  FocusNode? placaFocusNode;
  TextEditingController? placaTextController;
  String? Function(BuildContext, String?)? placaTextControllerValidator;
  String? _placaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for ddwCatVeiculo widget.
  String? ddwCatVeiculoValue;
  FormFieldController<String>? ddwCatVeiculoValueController;
  // State field(s) for ddwTipoVeiculo widget.
  String? ddwTipoVeiculoValue;
  FormFieldController<String>? ddwTipoVeiculoValueController;
  // State field(s) for ddwMarca widget.
  String? ddwMarcaValue;
  FormFieldController<String>? ddwMarcaValueController;
  // State field(s) for ddwModeo widget.
  String? ddwModeoValue;
  FormFieldController<String>? ddwModeoValueController;
  // State field(s) for Chassis widget.
  FocusNode? chassisFocusNode;
  TextEditingController? chassisTextController;
  String? Function(BuildContext, String?)? chassisTextControllerValidator;
  // State field(s) for Renavam widget.
  FocusNode? renavamFocusNode;
  TextEditingController? renavamTextController;
  String? Function(BuildContext, String?)? renavamTextControllerValidator;
  // State field(s) for cor widget.
  FocusNode? corFocusNode;
  TextEditingController? corTextController;
  String? Function(BuildContext, String?)? corTextControllerValidator;
  // State field(s) for anoModelo widget.
  FocusNode? anoModeloFocusNode;
  TextEditingController? anoModeloTextController;
  String? Function(BuildContext, String?)? anoModeloTextControllerValidator;
  // State field(s) for capacidade widget.
  FocusNode? capacidadeFocusNode;
  TextEditingController? capacidadeTextController;
  late MaskTextInputFormatter capacidadeMask;
  String? Function(BuildContext, String?)? capacidadeTextControllerValidator;
  String? _capacidadeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for lat widget.
  FocusNode? latFocusNode;
  TextEditingController? latTextController;
  String? Function(BuildContext, String?)? latTextControllerValidator;
  // State field(s) for long widget.
  FocusNode? longFocusNode;
  TextEditingController? longTextController;
  String? Function(BuildContext, String?)? longTextControllerValidator;
  // Stores action output result for [Backend Call - API (GeoCodeReverse)] action in Tab widget.
  ApiCallResponse? apiResBuscaEndVeiculo;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<VeiculoRow>? apiResEditaVeiculo;

  @override
  void initState(BuildContext context) {
    placaTextControllerValidator = _placaTextControllerValidator;
    capacidadeTextControllerValidator = _capacidadeTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    placaFocusNode?.dispose();
    placaTextController?.dispose();

    chassisFocusNode?.dispose();
    chassisTextController?.dispose();

    renavamFocusNode?.dispose();
    renavamTextController?.dispose();

    corFocusNode?.dispose();
    corTextController?.dispose();

    anoModeloFocusNode?.dispose();
    anoModeloTextController?.dispose();

    capacidadeFocusNode?.dispose();
    capacidadeTextController?.dispose();

    latFocusNode?.dispose();
    latTextController?.dispose();

    longFocusNode?.dispose();
    longTextController?.dispose();
  }
}
