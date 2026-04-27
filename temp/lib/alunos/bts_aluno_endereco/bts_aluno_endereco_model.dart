import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bts_aluno_endereco_widget.dart' show BtsAlunoEnderecoWidget;
import 'package:flutter/material.dart';

class BtsAlunoEnderecoModel extends FlutterFlowModel<BtsAlunoEnderecoWidget> {
  ///  Local state fields for this component.

  int? idAlunoMotorista;

  String? durationText;

  String? distanceText;

  bool showContainerRoute = false;

  bool avoidTolls = false;

  String? staticDurationText;

  ///  State fields for stateful widgets in this component.

  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  // State field(s) for PlacePickerOrigin widget.
  FFPlace placePickerOriginValue = FFPlace();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Backend Call - API (WHGERAURLGOOGLEMAPS)] action in Button widget.
  ApiCallResponse? apiResGeraUrlGoogleMaps;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();
  }
}
