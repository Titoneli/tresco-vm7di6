import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bts_categoria_veiculo_widget.dart' show BtsCategoriaVeiculoWidget;
import 'package:flutter/material.dart';

class BtsCategoriaVeiculoModel
    extends FlutterFlowModel<BtsCategoriaVeiculoWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nomeLead widget.
  FocusNode? nomeLeadFocusNode;
  TextEditingController? nomeLeadTextController;
  String? Function(BuildContext, String?)? nomeLeadTextControllerValidator;
  String? _nomeLeadTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for ddwOrigemIndicador widget.
  String? ddwOrigemIndicadorValue;
  FormFieldController<String>? ddwOrigemIndicadorValueController;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  CorDominioRow? apiResAdicionaCargo;

  @override
  void initState(BuildContext context) {
    nomeLeadTextControllerValidator = _nomeLeadTextControllerValidator;
  }

  @override
  void dispose() {
    nomeLeadFocusNode?.dispose();
    nomeLeadTextController?.dispose();
  }
}
