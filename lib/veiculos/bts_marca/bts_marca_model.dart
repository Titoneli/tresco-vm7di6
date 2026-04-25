import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'bts_marca_widget.dart' show BtsMarcaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BtsMarcaModel extends FlutterFlowModel<BtsMarcaWidget> {
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
