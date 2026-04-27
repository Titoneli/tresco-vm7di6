import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bts_alerta_model.dart';
export 'bts_alerta_model.dart';

class BtsAlertaWidget extends StatefulWidget {
  const BtsAlertaWidget({super.key});

  @override
  State<BtsAlertaWidget> createState() => _BtsAlertaWidgetState();
}

class _BtsAlertaWidgetState extends State<BtsAlertaWidget> {
  late BtsAlertaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BtsAlertaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: SafeArea(
        child: Container(
          width: 320.0,
          height: 295.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32.0),
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 18.0, 0.0, 0.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/#1f2034.png',
                    fit: BoxFit.contain,
                    alignment: Alignment(0.0, 0.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Só um instante...',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        color: Color(0xFF100F0F),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
                child: Text(
                  'Por favor, aguarde enquanto \nexecutamos sua solicitação',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Color(0xFF19191A),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Divider(
                thickness: 2.0,
                color: Color(0xFFEAE9ED),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Text(
                  'Processando...',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
