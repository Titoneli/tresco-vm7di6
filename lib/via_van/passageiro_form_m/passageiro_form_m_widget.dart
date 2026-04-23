import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'passageiro_form_m_model.dart';
export 'passageiro_form_m_model.dart';

class PassageiroFormMWidget extends StatefulWidget {
  const PassageiroFormMWidget({
    super.key,
    this.passageiroId,
  });

  final int? passageiroId;

  static String routeName = 'passageiroFormM';
  static String routePath = '/passageiroForm';

  @override
  State<PassageiroFormMWidget> createState() => _PassageiroFormMWidgetState();
}

class _PassageiroFormMWidgetState extends State<PassageiroFormMWidget> {
  late PassageiroFormMModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isEditing => widget.passageiroId != null;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PassageiroFormMModel());

    _model.nomeTextController ??= TextEditingController();
    _model.nomeFocusNode ??= FocusNode();
    _model.cpfTextController ??= TextEditingController();
    _model.cpfFocusNode ??= FocusNode();
    _model.escolaTextController ??= TextEditingController();
    _model.escolaFocusNode ??= FocusNode();
    _model.enderecoTextController ??= TextEditingController();
    _model.enderecoFocusNode ??= FocusNode();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (isEditing) {
        await _model.loadPassageiro(widget.passageiroId!);
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          leading: FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 40.0,
            icon: Icon(Icons.arrow_back,
                color: FlutterFlowTheme.of(context).info, size: 24.0),
            onPressed: () async => context.safePop(),
          ),
          title: Text(
            isEditing ? 'Editar Passageiro' : 'Novo Passageiro',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                  color: FlutterFlowTheme.of(context).info,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: _model.isLoading
              ? Center(
                  child: SpinKitPulse(
                      color: FlutterFlowTheme.of(context).primary,
                      size: 50.0))
              : Form(
                  key: _model.formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _buildFormField(context, 'Nome *',
                              _model.nomeTextController!, _model.nomeFocusNode!,
                              validator: (context, val) {
                            if (val == null || val.isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          }),
                          SizedBox(height: 16.0),
                          _buildFormField(context, 'CPF',
                              _model.cpfTextController!, _model.cpfFocusNode!),
                          SizedBox(height: 16.0),
                          _buildFormField(
                              context,
                              'Escola',
                              _model.escolaTextController!,
                              _model.escolaFocusNode!),
                          SizedBox(height: 16.0),
                          _buildFormField(
                              context,
                              'Endereço',
                              _model.enderecoTextController!,
                              _model.enderecoFocusNode!,
                              maxLines: 3),
                          SizedBox(height: 32.0),
                          FFButtonWidget(
                            onPressed: _model.isSaving
                                ? null
                                : () async {
                                    if (_model.formKey.currentState
                                            ?.validate() !=
                                        true) return;
                                    final response =
                                        await _model.savePassageiro(
                                      FFAppState().idUsuario,
                                      widget.passageiroId,
                                    );
                                    safeSetState(() {});
                                    if (response.succeeded) {
                                      context.safePop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Erro ao salvar passageiro')),
                                      );
                                    }
                                  },
                            text: _model.isSaving ? 'Salvando...' : 'Salvar',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48.0,
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildFormField(BuildContext context, String label,
      TextEditingController controller, FocusNode focusNode,
      {int maxLines = 1,
      String? Function(BuildContext, String?)? validator}) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      validator: validator != null ? (val) => validator(context, val) : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            font: GoogleFonts.inter(
                fontWeight:
                    FlutterFlowTheme.of(context).bodyMedium.fontWeight),
            letterSpacing: 0.0,
          ),
    );
  }
}
