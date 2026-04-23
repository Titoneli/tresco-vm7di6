import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_veiculo_adicionar_widget.dart' show BtsVeiculoAdicionarWidget;
import 'package:flutter/material.dart';

class BtsVeiculoAdicionarModel
    extends FlutterFlowModel<BtsVeiculoAdicionarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
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
  String? Function(BuildContext, String?)? capacidadeTextControllerValidator;
  String? _capacidadeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  // State field(s) for ddwCargo widget.
  int? ddwCargoValue;
  FormFieldController<int>? ddwCargoValueController;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  VeiculoRow? apiResAdicionaVeiculo;

  @override
  void initState(BuildContext context) {
    placaTextControllerValidator = _placaTextControllerValidator;
    capacidadeTextControllerValidator = _capacidadeTextControllerValidator;
  }

  @override
  void dispose() {
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
  }
}
