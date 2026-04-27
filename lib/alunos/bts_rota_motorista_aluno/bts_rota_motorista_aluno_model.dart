import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bts_rota_motorista_aluno_widget.dart' show BtsRotaMotoristaAlunoWidget;
import 'package:flutter/material.dart';

class BtsRotaMotoristaAlunoModel
    extends FlutterFlowModel<BtsRotaMotoristaAlunoWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Backend Call - API (WHGERAURLGOOGLEMAPS)] action in Button widget.
  ApiCallResponse? apiResGeraGoogleMapsURL;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
