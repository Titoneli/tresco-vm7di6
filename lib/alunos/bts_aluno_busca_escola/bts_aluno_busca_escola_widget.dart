import '/alunos/bts_aluno_adicionar/bts_aluno_adicionar_widget.dart';
import '/alunos/bts_aluno_editar/bts_aluno_editar_widget.dart';
import '/alunos/bts_aluno_motorista/bts_aluno_motorista_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bts_aluno_busca_escola_model.dart';
export 'bts_aluno_busca_escola_model.dart';

class BtsAlunoBuscaEscolaWidget extends StatefulWidget {
  const BtsAlunoBuscaEscolaWidget({
    super.key,
    this.idAluno,
    this.idEscolaDash,
    this.domSitAluno,
    required this.nomeEscola,
  });

  final int? idAluno;
  final int? idEscolaDash;
  final String? domSitAluno;
  final String? nomeEscola;

  @override
  State<BtsAlunoBuscaEscolaWidget> createState() =>
      _BtsAlunoBuscaEscolaWidgetState();
}

class _BtsAlunoBuscaEscolaWidgetState extends State<BtsAlunoBuscaEscolaWidget> {
  late BtsAlunoBuscaEscolaModel _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BtsAlunoBuscaEscolaModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.filterAlunoTextController ??= TextEditingController();
    _model.filterAlunoFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: SafeArea(
        child: Container(
          width: 900.0,
          height: 650.0,
          constraints: BoxConstraints(
            maxHeight: 650.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 1.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  2.0,
                ),
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                3.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Alunos da Escola ${widget!.nomeEscola}',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close_outlined,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 6.0, 8.0, 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 300.0,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 0.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100.0),
                                                            ),
                                                            child: Container(
                                                              width: 350.0,
                                                              height: 45.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        4.0,
                                                                        16.0,
                                                                        4.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            FlutterFlowIconButton(
                                                                              borderRadius: 20.0,
                                                                              borderWidth: 1.0,
                                                                              buttonSize: 40.0,
                                                                              icon: Icon(
                                                                                FFIcons.ksearch,
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                              onPressed: () {
                                                                                print('IconButton pressed ...');
                                                                              },
                                                                            ),
                                                                            Expanded(
                                                                              child: TextFormField(
                                                                                controller: _model.filterAlunoTextController,
                                                                                focusNode: _model.filterAlunoFocusNode,
                                                                                onChanged: (_) => EasyDebounce.debounce(
                                                                                  '_model.filterAlunoTextController',
                                                                                  Duration(milliseconds: 2000),
                                                                                  () => safeSetState(() {}),
                                                                                ),
                                                                                autofocus: true,
                                                                                obscureText: false,
                                                                                decoration: InputDecoration(
                                                                                  alignLabelWithHint: false,
                                                                                  hintText: 'Nome, Sobrenome, etc...',
                                                                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Colors.black,
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: Color(0x00000000),
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Colors.black,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                validator: _model.filterAlunoTextControllerValidator.asValidator(context),
                                                                              ),
                                                                            ),
                                                                            FlutterFlowIconButton(
                                                                              borderColor: Colors.transparent,
                                                                              borderRadius: 20.0,
                                                                              borderWidth: 1.0,
                                                                              buttonSize: 30.0,
                                                                              fillColor: FlutterFlowTheme.of(context).accent2,
                                                                              icon: Icon(
                                                                                FFIcons.kxMark,
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                size: 14.0,
                                                                              ),
                                                                              onPressed: () async {
                                                                                safeSetState(() {
                                                                                  _model.filterAlunoTextController?.clear();
                                                                                });
                                                                              },
                                                                            ),
                                                                          ].divide(SizedBox(width: 8.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          4.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          runAlignment: WrapAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: [
                            FlutterFlowChoiceChips(
                              options: [
                                ChipData('Ativo'),
                                ChipData('Aguardando'),
                                ChipData('Inativo')
                              ],
                              onChanged: (val) => safeSetState(() => _model
                                  .choiceSituacaoValue = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: Color(0xFFEFECF0),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondary,
                                iconSize: 18.0,
                                elevation: 0.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF656266),
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                iconColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                iconSize: 18.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              chipSpacing: 3.0,
                              rowSpacing: 12.0,
                              multiselect: false,
                              initialized: _model.choiceSituacaoValue != null,
                              alignment: WrapAlignment.start,
                              controller:
                                  _model.choiceSituacaoValueController ??=
                                      FormFieldController<List<String>>(
                                ['Ativo'],
                              ),
                              wrapped: false,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: FlutterFlowChoiceChips(
                                options: [
                                  ChipData('Confirmado'),
                                  ChipData('Recusado')
                                ],
                                onChanged: (val) => safeSetState(() =>
                                    _model.choiceRespMotoristaValue =
                                        val?.firstOrNull),
                                selectedChipStyle: ChipStyle(
                                  backgroundColor: Color(0xFFEFECF0),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                  iconColor:
                                      FlutterFlowTheme.of(context).secondary,
                                  iconSize: 18.0,
                                  elevation: 0.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF656266),
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  iconSize: 18.0,
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                chipSpacing: 3.0,
                                rowSpacing: 12.0,
                                multiselect: false,
                                initialized:
                                    _model.choiceRespMotoristaValue != null,
                                alignment: WrapAlignment.start,
                                controller: _model
                                        .choiceRespMotoristaValueController ??=
                                    FormFieldController<List<String>>(
                                  ['Confirmado'],
                                ),
                                wrapped: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    1.0, 0.0, 1.0, 0.0),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3.0, 0.0, 0.0, 0.0),
                                        child: AutoSizeText(
                                          'Aluno',
                                          minFontSize: 10.0,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      1.0, 0.0, 1.0, 0.0),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          3.0, 0.0, 0.0, 0.0),
                                      child: AutoSizeText(
                                        'Motorista',
                                        minFontSize: 10.0,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      1.0, 0.0, 1.0, 0.0),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          3.0, 0.0, 0.0, 0.0),
                                      child: AutoSizeText(
                                        'Escola',
                                        minFontSize: 10.0,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      1.0, 0.0, 1.0, 0.0),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          3.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Turma',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      1.0, 0.0, 1.0, 0.0),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          3.0, 0.0, 0.0, 0.0),
                                      child: AutoSizeText(
                                        'Turno',
                                        minFontSize: 10.0,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    1.0, 0.0, 1.0, 0.0),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3.0, 0.0, 0.0, 0.0),
                                    child: AutoSizeText(
                                      'Ação',
                                      minFontSize: 10.0,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<ApiCallResponse>(
                          future: SearchAlunoBuscaEscolaCall.call(
                            searchString: _model.filterAlunoTextController.text,
                            searchEscola: widget!.idEscolaDash,
                            checkAluno:
                                _model.choiceRespMotoristaValue == 'Confirmado',
                            searchDomSitAluno: _model.choiceSituacaoValue,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitPulse(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewSearchAlunoBuscaEscolaResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final alunosLista =
                                    listViewSearchAlunoBuscaEscolaResponse
                                        .jsonBody
                                        .toList();

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: alunosLista.length,
                                  itemBuilder: (context, alunosListaIndex) {
                                    final alunosListaItem =
                                        alunosLista[alunosListaIndex];
                                    return Container(
                                      width: double.infinity,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        color: alunosListaIndex.floor().isEven
                                            ? Color(0xFFFAFAFA)
                                            : FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(1.0, 0.0, 1.0, 0.0),
                                              child: Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  color: alunosListaIndex
                                                          .floor()
                                                          .isEven
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (valueOrDefault<bool>(
                                                      getJsonField(
                                                        alunosListaItem,
                                                        r'''$.domsitalunoativo''',
                                                      )
                                                          ? true
                                                          : false,
                                                      false,
                                                    ))
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons
                                                              .airline_seat_recline_normal_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    if (valueOrDefault<bool>(
                                                      getJsonField(
                                                        alunosListaItem,
                                                        r'''$.domsitalunoaguardando''',
                                                      )
                                                          ? true
                                                          : false,
                                                      false,
                                                    ))
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons
                                                              .airline_seat_recline_normal_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .warning,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    if (valueOrDefault<bool>(
                                                      getJsonField(
                                                        alunosListaItem,
                                                        r'''$.domsitalunoinativo''',
                                                      )
                                                          ? true
                                                          : false,
                                                      false,
                                                    ))
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons
                                                              .airline_seat_recline_normal_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  3.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        getJsonField(
                                                          alunosListaItem,
                                                          r'''$.nomeAluno''',
                                                        ).toString().toUpperCase(),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                          ))
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 0.0, 1.0, 0.0),
                                                child: Container(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    color: alunosListaIndex
                                                            .floor()
                                                            .isEven
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Theme(
                                                        data: ThemeData(
                                                          checkboxTheme:
                                                              CheckboxThemeData(
                                                            shape:
                                                                CircleBorder(),
                                                          ),
                                                          unselectedWidgetColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                        ),
                                                        child: Checkbox(
                                                          value: _model
                                                                      .checkboxValueMap[
                                                                  alunosListaItem] ??=
                                                              getJsonField(
                                                            alunosListaItem,
                                                            r'''$.domCheckAluno''',
                                                          ),
                                                          onChanged:
                                                              (newValue) async {
                                                            safeSetState(() =>
                                                                _model.checkboxValueMap[
                                                                        alunosListaItem] =
                                                                    newValue!);
                                                            if (newValue!) {
                                                              _model.actTrue =
                                                                  await AlunoTable()
                                                                      .update(
                                                                data: {
                                                                  'domCheckAluno':
                                                                      true,
                                                                },
                                                                matchingRows:
                                                                    (rows) => rows
                                                                        .eqOrNull(
                                                                  'idAluno',
                                                                  getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.idAluno''',
                                                                  ),
                                                                ),
                                                                returnRows:
                                                                    true,
                                                              );

                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              _model.actFalse =
                                                                  await AlunoTable()
                                                                      .update(
                                                                data: {
                                                                  'domCheckAluno':
                                                                      false,
                                                                },
                                                                matchingRows:
                                                                    (rows) => rows
                                                                        .eqOrNull(
                                                                  'idAluno',
                                                                  getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.idAluno''',
                                                                  ),
                                                                ),
                                                                returnRows:
                                                                    true,
                                                              );

                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          },
                                                          side: (FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate !=
                                                                  null)
                                                              ? BorderSide(
                                                                  width: 2,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate!,
                                                                )
                                                              : null,
                                                          activeColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          checkColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .info,
                                                        ),
                                                      ),
                                                      if (responsiveVisibility(
                                                        context: context,
                                                        phone: false,
                                                        tablet: false,
                                                        tabletLandscape: false,
                                                        desktop: false,
                                                      ))
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      3.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Icon(
                                                            FFIcons
                                                                .kcheckFatFill,
                                                            color: getJsonField(
                                                              alunosListaItem,
                                                              r'''$.domCheckAluno''',
                                                            )
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    3.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            getJsonField(
                                                              alunosListaItem,
                                                              r'''$.nomemotorista''',
                                                            )?.toString(),
                                                            '-',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                          ))
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 0.0, 1.0, 0.0),
                                                child: Container(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    color: alunosListaIndex
                                                            .floor()
                                                            .isEven
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(3.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        getJsonField(
                                                          alunosListaItem,
                                                          r'''$.nomeescola''',
                                                        )?.toString(),
                                                        '-',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                            tabletLandscape: false,
                                            desktop: false,
                                          ))
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 0.0, 1.0, 0.0),
                                                child: Container(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    color: alunosListaIndex
                                                            .floor()
                                                            .isEven
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(3.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        getJsonField(
                                                          alunosListaItem,
                                                          r'''$.nometurma''',
                                                        )?.toString(),
                                                        '-',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            fontSize: 10.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                          ))
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 0.0, 1.0, 0.0),
                                                child: Container(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    color: alunosListaIndex
                                                            .floor()
                                                            .isEven
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(3.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        getJsonField(
                                                          alunosListaItem,
                                                          r'''$.domTurno''',
                                                        )?.toString(),
                                                        '-',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(1.0, 0.0, 1.0, 0.0),
                                              child: Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  color: alunosListaIndex
                                                          .floor()
                                                          .isEven
                                                      ? Color(0xFFFAFAFA)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    BtsAlunoEditarWidget(
                                                                  idAluno:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.idAluno''',
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                        child: Icon(
                                                          FFIcons.kedit,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  0.0,
                                                                  8.0,
                                                                  0.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    BtsAlunoMotoristaWidget(
                                                                  idAlunoMotorista:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.idAluno''',
                                                                  ),
                                                                  nomeAluno:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.nomeAluno''',
                                                                  ).toString(),
                                                                  idMotorista:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.idUsuario''',
                                                                  ),
                                                                  idEscola:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.idEscola''',
                                                                  ),
                                                                  domTurno:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.domTurno''',
                                                                  ).toString(),
                                                                  domSerie:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.domSerie''',
                                                                  ).toString(),
                                                                  idTurma:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.idTurma''',
                                                                  ),
                                                                  domTipoAluno:
                                                                      getJsonField(
                                                                    alunosListaItem,
                                                                    r'''$.domTipoAluno''',
                                                                  ).toString(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));

                                                          FFAppState()
                                                                  .indexAluno =
                                                              getJsonField(
                                                            alunosListaItem,
                                                            r'''$.idAluno''',
                                                          );
                                                          FFAppState()
                                                              .update(() {});
                                                        },
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .shuttleVan,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (!(isWeb
                    ? MediaQuery.viewInsetsOf(context).bottom > 0
                    : _isKeyboardVisible))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: BtsAlunoAdicionarWidget(),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          text: 'Novo',
                          icon: Icon(
                            FFIcons.kplus,
                            size: 26.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).accent1,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            _model.resEscolaAlunos2 =
                                await ListagemescolaalunosTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'nomeEscola',
                                    widget!.nomeEscola,
                                  )
                                  .order('nomeAluno', ascending: true),
                            );
                            await actions.downloadToAnyPlatfromCSVCopy(
                              widget!.nomeEscola,
                              _model.choiceSituacaoValue!,
                            );

                            safeSetState(() {});
                          },
                          text: 'Exportar Excel',
                          icon: Icon(
                            FFIcons.kmicrosoftExcelLogo,
                            size: 26.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).accent1,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
