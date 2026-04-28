import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/frame_work/cmp_header/cmp_header_widget.dart';
import '/via_van/bts_via_van_assinante_adicionar/bts_via_van_assinante_adicionar_widget.dart';
import '/via_van/bts_via_van_motorista_adicionar/bts_via_van_motorista_adicionar_widget.dart';
import '/via_van/bts_via_van_motorista_editar_m/bts_via_van_motorista_editar_m_widget.dart';
import 'dart:convert';
import 'dart:ui';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'login';
  static String routePath = '/login';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.emailAddressLoginTextController ??=
        TextEditingController(text: FFAppState().usuario);

    _model.passwordLoginTextController ??=
        TextEditingController(text: FFAppState().senha);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: SafeArea(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                constraints: BoxConstraints(
                  maxWidth: 1280.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: SafeArea(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    constraints: BoxConstraints(
                      maxWidth: 1280.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await _model.pageViewController?.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: wrapWithModel(
                                model: _model.cmpHeaderModel,
                                updateCallback: () => safeSetState(() {}),
                                child: CmpHeaderWidget(),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 8.0, 12.0, 0.0),
                                    child: SafeArea(
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        height: 655.0,
                                        decoration: BoxDecoration(),
                                        child: Container(
                                          width: double.infinity,
                                          height: 500.0,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 40.0),
                                            child: PageView(
                                              controller:
                                                  _model.pageViewController ??=
                                                      PageController(
                                                          initialPage: 0),
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Container(
                                                  width: 434.0,
                                                  height: 555.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(35.0),
                                                      bottomRight:
                                                          Radius.circular(35.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 16.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (responsiveVisibility(
                                                          context: context,
                                                          phone: false,
                                                          tablet: false,
                                                          tabletLandscape:
                                                              false,
                                                        ))
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        150.0,
                                                                        8.0,
                                                                        100.0,
                                                                        16.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Bem vindo de volta',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.poppins(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Color(0xFF2F8D2F),
                                                                            fontSize:
                                                                                22.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                      tabletLandscape:
                                                                          false,
                                                                    ))
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            4.0),
                                                                        child:
                                                                            Text(
                                                                          'Acesse sua conta',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                font: GoogleFonts.poppins(
                                                                                  fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        Form(
                                                          key: _model.formKey,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .disabled,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          20.0,
                                                                          24.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        300.0,
                                                                    child: Autocomplete<
                                                                        String>(
                                                                      initialValue:
                                                                          TextEditingValue(
                                                                              text: FFAppState().usuario),
                                                                      optionsBuilder:
                                                                          (textEditingValue) {
                                                                        if (textEditingValue.text ==
                                                                            '') {
                                                                          return const Iterable<
                                                                              String>.empty();
                                                                        }
                                                                        return <String>[]
                                                                            .where((option) {
                                                                          final lowercaseOption =
                                                                              option.toLowerCase();
                                                                          return lowercaseOption.contains(textEditingValue
                                                                              .text
                                                                              .toLowerCase());
                                                                        });
                                                                      },
                                                                      optionsViewBuilder: (context,
                                                                          onSelected,
                                                                          options) {
                                                                        return AutocompleteOptionsList(
                                                                          textFieldKey:
                                                                              _model.emailAddressLoginKey,
                                                                          textController:
                                                                              _model.emailAddressLoginTextController!,
                                                                          options:
                                                                              options.toList(),
                                                                          onSelected:
                                                                              onSelected,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                          textHighlightStyle:
                                                                              TextStyle(),
                                                                          elevation:
                                                                              4.0,
                                                                          optionBackgroundColor:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          optionHighlightColor:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          maxHeight:
                                                                              200.0,
                                                                        );
                                                                      },
                                                                      onSelected:
                                                                          (String
                                                                              selection) {
                                                                        safeSetState(() =>
                                                                            _model.emailAddressLoginSelectedOption =
                                                                                selection);
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                      },
                                                                      fieldViewBuilder:
                                                                          (
                                                                        context,
                                                                        textEditingController,
                                                                        focusNode,
                                                                        onEditingComplete,
                                                                      ) {
                                                                        _model.emailAddressLoginFocusNode =
                                                                            focusNode;

                                                                        _model.emailAddressLoginTextController =
                                                                            textEditingController;
                                                                        return TextFormField(
                                                                          key: _model
                                                                              .emailAddressLoginKey,
                                                                          controller:
                                                                              textEditingController,
                                                                          focusNode:
                                                                              focusNode,
                                                                          onEditingComplete:
                                                                              onEditingComplete,
                                                                          autofocus:
                                                                              true,
                                                                          autofillHints: [
                                                                            AutofillHints.username
                                                                          ],
                                                                          obscureText:
                                                                              false,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            labelText:
                                                                                'Usuário',
                                                                            labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.lexendDeca(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                            alignLabelWithHint:
                                                                                true,
                                                                            hintText:
                                                                                'Informe seu usuário',
                                                                            hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.lexendDeca(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            errorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            focusedErrorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                20.0,
                                                                                24.0,
                                                                                20.0,
                                                                                24.0),
                                                                            hoverColor:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                font: GoogleFonts.interTight(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                          maxLines:
                                                                              null,
                                                                          keyboardType:
                                                                              TextInputType.name,
                                                                          validator: _model
                                                                              .emailAddressLoginTextControllerValidator
                                                                              .asValidator(context),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          12.0,
                                                                          24.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        300.0,
                                                                    child: Autocomplete<
                                                                        String>(
                                                                      initialValue:
                                                                          TextEditingValue(
                                                                              text: FFAppState().senha),
                                                                      optionsBuilder:
                                                                          (textEditingValue) {
                                                                        if (textEditingValue.text ==
                                                                            '') {
                                                                          return const Iterable<
                                                                              String>.empty();
                                                                        }
                                                                        return <String>[]
                                                                            .where((option) {
                                                                          final lowercaseOption =
                                                                              option.toLowerCase();
                                                                          return lowercaseOption.contains(textEditingValue
                                                                              .text
                                                                              .toLowerCase());
                                                                        });
                                                                      },
                                                                      optionsViewBuilder: (context,
                                                                          onSelected,
                                                                          options) {
                                                                        return AutocompleteOptionsList(
                                                                          textFieldKey:
                                                                              _model.passwordLoginKey,
                                                                          textController:
                                                                              _model.passwordLoginTextController!,
                                                                          options:
                                                                              options.toList(),
                                                                          onSelected:
                                                                              onSelected,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                          textHighlightStyle:
                                                                              TextStyle(),
                                                                          elevation:
                                                                              4.0,
                                                                          optionBackgroundColor:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          optionHighlightColor:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          maxHeight:
                                                                              200.0,
                                                                        );
                                                                      },
                                                                      onSelected:
                                                                          (String
                                                                              selection) {
                                                                        safeSetState(() =>
                                                                            _model.passwordLoginSelectedOption =
                                                                                selection);
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                      },
                                                                      fieldViewBuilder:
                                                                          (
                                                                        context,
                                                                        textEditingController,
                                                                        focusNode,
                                                                        onEditingComplete,
                                                                      ) {
                                                                        _model.passwordLoginFocusNode =
                                                                            focusNode;

                                                                        _model.passwordLoginTextController =
                                                                            textEditingController;
                                                                        return TextFormField(
                                                                          key: _model
                                                                              .passwordLoginKey,
                                                                          controller:
                                                                              textEditingController,
                                                                          focusNode:
                                                                              focusNode,
                                                                          onEditingComplete:
                                                                              onEditingComplete,
                                                                          onFieldSubmitted:
                                                                              (_) async {
                                                                            _model.apiResValidaUsuarioEnter =
                                                                                await WhvalidausuarioCall.call(
                                                                              usuario: _model.emailAddressLoginTextController.text,
                                                                              senha: _model.passwordLoginTextController.text,
                                                                              empresa: FFAppState().nomeEmpresa,
                                                                            );

                                                                            if ((_model.apiResValidaUsuarioEnter?.succeeded ??
                                                                                true)) {
                                                                              FFAppState().nomeUsuario = WhvalidausuarioCall.nomeUsuario(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              )!;
                                                                              FFAppState().cargoUsuario = WhvalidausuarioCall.domCargo(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              )!;
                                                                              FFAppState().nomeEmpresa = WhvalidausuarioCall.nomeEmpresa(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              )!;
                                                                              FFAppState().usuario = WhvalidausuarioCall.usuario(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              )!;
                                                                              FFAppState().idEmpresa = WhvalidausuarioCall.idEmpresa(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              )!;
                                                                              FFAppState().idUsuario = WhvalidausuarioCall.idUsuario(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              )!;
                                                                              FFAppState().menuExpandido = isWeb == true;
                                                                              FFAppState().idEscolaUsuario = WhvalidausuarioCall.idEscola(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              )!;
                                                                              FFAppState().senha = _model.passwordLoginTextController.text;
                                                                              safeSetState(() {});
                                                                              if (WhvalidausuarioCall.domCargo(
                                                                                    (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                  ) ==
                                                                                  'Escola') {
                                                                                if ((MediaQuery.sizeOf(context).width < 1040.0) && (MediaQuery.sizeOf(context).height < 1366.0)) {
                                                                                  context.pushNamed(DashboardEscolaMWidget.routeName);
                                                                                } else {
                                                                                  context.pushNamed(DashboardEscolaWidget.routeName);
                                                                                }
                                                                              } else {
                                                                                if (WhvalidausuarioCall.domCargo(
                                                                                      (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                    ) ==
                                                                                    'Motorista') {
                                                                                  if ((MediaQuery.sizeOf(context).width < 1040.0) && (MediaQuery.sizeOf(context).height < 1366.0)) {
                                                                                    context.pushNamed(DashboardAssociadoMWidget.routeName);
                                                                                  } else {
                                                                                    context.pushNamed(DashboardAssociadoWidget.routeName);
                                                                                  }
                                                                                } else {
                                                                                  if (WhvalidausuarioCall.domCargo(
                                                                                        (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                      ) ==
                                                                                      'MotoristaViaVan') {
                                                                                    if ((MediaQuery.sizeOf(context).width < 1040.0) && (MediaQuery.sizeOf(context).height < 1366.0)) {
                                                                                      if (FFAppState().nomeUsuario != '') {
                                                                                        context.pushNamed(DashboardPassageirosMWidget.routeName);
                                                                                      } else {
                                                                                        await showModalBottomSheet(
                                                                                          isScrollControlled: true,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          enableDrag: false,
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return GestureDetector(
                                                                                              onTap: () {
                                                                                                FocusScope.of(context).unfocus();
                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                              },
                                                                                              child: Padding(
                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                child: BtsViaVanMotoristaEditarMWidget(
                                                                                                  idUsuario: WhvalidausuarioCall.idUsuario(
                                                                                                    (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ).then((value) => safeSetState(() {}));
                                                                                      }
                                                                                    } else {
                                                                                      context.pushNamed(DashboardPassageirosMWidget.routeName);
                                                                                    }
                                                                                  } else {
                                                                                    context.pushNamed(DashboardWidget.routeName);
                                                                                  }
                                                                                }
                                                                              }
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    'Usuário e/ou senha inválido',
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                            }

                                                                            safeSetState(() {});
                                                                          },
                                                                          autofillHints: [
                                                                            AutofillHints.password
                                                                          ],
                                                                          textInputAction:
                                                                              TextInputAction.send,
                                                                          obscureText:
                                                                              !_model.passwordLoginVisibility,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            labelText:
                                                                                'Senha',
                                                                            labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.lexendDeca(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                            alignLabelWithHint:
                                                                                true,
                                                                            hintText:
                                                                                'Informe sua senha',
                                                                            hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.lexendDeca(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            errorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            focusedErrorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                20.0,
                                                                                24.0,
                                                                                20.0,
                                                                                24.0),
                                                                            hoverColor:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            suffixIcon:
                                                                                InkWell(
                                                                              onTap: () async {
                                                                                safeSetState(() => _model.passwordLoginVisibility = !_model.passwordLoginVisibility);
                                                                              },
                                                                              focusNode: FocusNode(skipTraversal: true),
                                                                              child: Icon(
                                                                                _model.passwordLoginVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                                                                color: Color(0xFF95A1AC),
                                                                                size: 25.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                font: GoogleFonts.interTight(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                          keyboardType:
                                                                              TextInputType.visiblePassword,
                                                                          validator: _model
                                                                              .passwordLoginTextControllerValidator
                                                                              .asValidator(context),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      await _model
                                                                          .pageViewController
                                                                          ?.animateToPage(
                                                                        2,
                                                                        duration:
                                                                            Duration(milliseconds: 500),
                                                                        curve: Curves
                                                                            .ease,
                                                                      );
                                                                    },
                                                                    text:
                                                                        'Esqueceu a senha?',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          44.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          32.0,
                                                                          0.0,
                                                                          32.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              40.0),
                                                                      hoverColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryBackground,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          16.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      _model.apiResValidaUsuario =
                                                                          await WhvalidausuarioCall
                                                                              .call(
                                                                        usuario: _model
                                                                            .emailAddressLoginTextController
                                                                            .text,
                                                                        senha: _model
                                                                            .passwordLoginTextController
                                                                            .text,
                                                                        empresa:
                                                                            FFAppState().nomeEmpresa,
                                                                      );

                                                                      if ((_model
                                                                              .apiResValidaUsuario
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        FFAppState().nomeUsuario =
                                                                            WhvalidausuarioCall.nomeUsuario(
                                                                          (_model.apiResValidaUsuario?.jsonBody ??
                                                                              ''),
                                                                        )!;
                                                                        FFAppState().cargoUsuario =
                                                                            WhvalidausuarioCall.domCargo(
                                                                          (_model.apiResValidaUsuario?.jsonBody ??
                                                                              ''),
                                                                        )!;
                                                                        FFAppState().nomeEmpresa =
                                                                            WhvalidausuarioCall.nomeEmpresa(
                                                                          (_model.apiResValidaUsuario?.jsonBody ??
                                                                              ''),
                                                                        )!;
                                                                        FFAppState().usuario =
                                                                            WhvalidausuarioCall.usuario(
                                                                          (_model.apiResValidaUsuario?.jsonBody ??
                                                                              ''),
                                                                        )!;
                                                                        FFAppState().idEmpresa =
                                                                            WhvalidausuarioCall.idEmpresa(
                                                                          (_model.apiResValidaUsuario?.jsonBody ??
                                                                              ''),
                                                                        )!;
                                                                        FFAppState().idUsuario =
                                                                            WhvalidausuarioCall.idUsuario(
                                                                          (_model.apiResValidaUsuario?.jsonBody ??
                                                                              ''),
                                                                        )!;
                                                                        FFAppState().menuExpandido =
                                                                            isWeb ==
                                                                                true;
                                                                        FFAppState().idEscolaUsuario =
                                                                            WhvalidausuarioCall.idEscola(
                                                                          (_model.apiResValidaUsuario?.jsonBody ??
                                                                              ''),
                                                                        )!;
                                                                        FFAppState().senha = _model
                                                                            .passwordLoginTextController
                                                                            .text;
                                                                        safeSetState(
                                                                            () {});
                                                                        if (WhvalidausuarioCall.domCargo(
                                                                              (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                            ) ==
                                                                            'Escola') {
                                                                          if ((MediaQuery.sizeOf(context).width < 1040.0) &&
                                                                              (MediaQuery.sizeOf(context).height < 1366.0)) {
                                                                            context.pushNamed(DashboardEscolaMWidget.routeName);
                                                                          } else {
                                                                            context.pushNamed(DashboardEscolaWidget.routeName);
                                                                          }
                                                                        } else {
                                                                          if (WhvalidausuarioCall.domCargo(
                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                              ) ==
                                                                              'Motorista') {
                                                                            if ((MediaQuery.sizeOf(context).width < 1040.0) &&
                                                                                (MediaQuery.sizeOf(context).height < 1366.0)) {
                                                                              context.pushNamed(DashboardAssociadoMWidget.routeName);
                                                                            } else {
                                                                              context.pushNamed(DashboardAssociadoWidget.routeName);
                                                                            }
                                                                          } else {
                                                                            if (WhvalidausuarioCall.domCargo(
                                                                                  (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                ) ==
                                                                                'MotoristaViaVan') {
                                                                              if ((MediaQuery.sizeOf(context).width < 1040.0) && (MediaQuery.sizeOf(context).height < 1366.0)) {
                                                                                if (FFAppState().nomeUsuario != '') {
                                                                                  context.pushNamed(DashboardPassageirosMWidget.routeName);
                                                                                } else {
                                                                                  await showModalBottomSheet(
                                                                                    isScrollControlled: true,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    enableDrag: false,
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return GestureDetector(
                                                                                        onTap: () {
                                                                                          FocusScope.of(context).unfocus();
                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                          child: BtsViaVanMotoristaEditarMWidget(
                                                                                            idUsuario: WhvalidausuarioCall.idUsuario(
                                                                                              (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ).then((value) => safeSetState(() {}));
                                                                                }
                                                                              } else {
                                                                                context.pushNamed(DashboardPassageirosMWidget.routeName);
                                                                              }
                                                                            } else {
                                                                              if (WhvalidausuarioCall.domCargo(
                                                                                    (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                  ) ==
                                                                                  'Assinante') {
                                                                                if ((MediaQuery.sizeOf(context).width < 1040.0) && (MediaQuery.sizeOf(context).height < 1366.0)) {
                                                                                  if (FFAppState().nomeUsuario != '') {
                                                                                    context.pushNamed(DashboardRespViaVanMWidget.routeName);
                                                                                  } else {
                                                                                    await showModalBottomSheet(
                                                                                      isScrollControlled: true,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      enableDrag: false,
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return GestureDetector(
                                                                                          onTap: () {
                                                                                            FocusScope.of(context).unfocus();
                                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                                          },
                                                                                          child: Padding(
                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                            child: BtsViaVanMotoristaEditarMWidget(
                                                                                              idUsuario: WhvalidausuarioCall.idUsuario(
                                                                                                (_model.apiResValidaUsuario?.jsonBody ?? ''),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ).then((value) => safeSetState(() {}));
                                                                                  }
                                                                                } else {
                                                                                  context.pushNamed(DashboardRespViaVanMWidget.routeName);
                                                                                }
                                                                              } else {
                                                                                context.pushNamed(DashboardWidget.routeName);
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      } else {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Usuário e/ou senha inválido',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        );
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    text:
                                                                        'Entrar',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width:
                                                                          230.0,
                                                                      height:
                                                                          50.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.lexendDeca(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                      elevation:
                                                                          3.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            16.0,
                                                                            0.0,
                                                                            16.0),
                                                                    child:
                                                                        FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        await _model
                                                                            .pageViewController
                                                                            ?.nextPage(
                                                                          duration:
                                                                              Duration(milliseconds: 300),
                                                                          curve:
                                                                              Curves.ease,
                                                                        );
                                                                      },
                                                                      text:
                                                                          'Saber como entrar?',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            230.0,
                                                                        height:
                                                                            50.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            32.0,
                                                                            0.0,
                                                                            32.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        elevation:
                                                                            3.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(24.0),
                                                                        hoverColor:
                                                                            FlutterFlowTheme.of(context).primaryBackground,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 24.0, 8.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          3.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            180.0,
                                                                        height:
                                                                            30.0,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          3.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                8.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'Crie uma conta Tresco \ne acesse a plataforma completa',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.poppins(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          24.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      MouseRegion(
                                                                    opaque:
                                                                        false,
                                                                    cursor: MouseCursor
                                                                            .defer ??
                                                                        MouseCursor
                                                                            .defer,
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        showModalBottomSheet(
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          isDismissible:
                                                                              false,
                                                                          enableDrag:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(context).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: Padding(
                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                child: BtsViaVanMotoristaAdicionarWidget(),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then((value) =>
                                                                            safeSetState(() {}));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            260.0,
                                                                        height:
                                                                            70.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(36.0),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            await showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              backgroundColor: Colors.transparent,
                                                                              isDismissible: false,
                                                                              enableDrag: false,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(context).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                    child: BtsViaVanMotoristaAdicionarWidget(),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).then((value) =>
                                                                                safeSetState(() {}));
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                FFIcons.ksteeringWheel,
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                size: 30.0,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'SOU MOTORISTA',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.poppins(
                                                                                          fontWeight: FontWeight.w300,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w300,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onEnter:
                                                                        ((event) async {
                                                                      safeSetState(() =>
                                                                          _model.mrgCadMotoristaHovered =
                                                                              true);
                                                                    }),
                                                                    onExit:
                                                                        ((event) async {
                                                                      safeSetState(() =>
                                                                          _model.mrgCadMotoristaHovered =
                                                                              false);
                                                                    }),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          24.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      MouseRegion(
                                                                    opaque:
                                                                        false,
                                                                    cursor: MouseCursor
                                                                            .defer ??
                                                                        MouseCursor
                                                                            .defer,
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        await _model
                                                                            .pageViewController
                                                                            ?.nextPage(
                                                                          duration:
                                                                              Duration(milliseconds: 300),
                                                                          curve:
                                                                              Curves.ease,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            260.0,
                                                                        height:
                                                                            70.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
                                                                          borderRadius:
                                                                              BorderRadius.circular(36.0),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            await showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              backgroundColor: Colors.transparent,
                                                                              isDismissible: false,
                                                                              enableDrag: false,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(context).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                    child: BtsViaVanAssinanteAdicionarWidget(),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).then((value) =>
                                                                                safeSetState(() {}));
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                FFIcons.kschool,
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                size: 30.0,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'SOU RESPONSÁVEL OU ALUNO',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.poppins(
                                                                                          fontWeight: FontWeight.w300,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w300,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onEnter:
                                                                        ((event) async {
                                                                      safeSetState(() =>
                                                                          _model.mrgCadAlunoRespHovered =
                                                                              true);
                                                                    }),
                                                                    onExit:
                                                                        ((event) async {
                                                                      safeSetState(() =>
                                                                          _model.mrgCadAlunoRespHovered =
                                                                              false);
                                                                    }),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      24.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await _model
                                                                  .pageViewController
                                                                  ?.animateToPage(
                                                                0,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        500),
                                                                curve:
                                                                    Curves.ease,
                                                              );
                                                            },
                                                            text:
                                                                'Acessar o Tresco',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 230.0,
                                                              height: 50.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 3.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      24.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await launchURL(
                                                                  'https://wkf.ms/43TjHB8');
                                                            },
                                                            text:
                                                                'Incluir Aluno',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 230.0,
                                                              height: 50.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 3.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      24.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await launchURL(
                                                                  'https://wkf.ms/3Dvlodv');
                                                            },
                                                            text:
                                                                'Protocolo de Solicitação',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 230.0,
                                                              height: 50.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 3.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [],
                                                ),
                                              ],
                                            ),
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
                                ))
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 85.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        constraints: BoxConstraints(
                                          maxWidth: 800.0,
                                          maxHeight: 550.0,
                                        ),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                              'assets/images/1457718455276_1.png',
                                            ).image,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              FlutterFlowTheme.of(context)
                                                  .secondary
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(0.0, -1.0),
                                            end: AlignmentDirectional(0, 1.0),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(32.0),
                                            bottomRight: Radius.circular(32.0),
                                          ),
                                        ),
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(82.0),
                                                child: Image.asset(
                                                  'assets/images/splash_tresco_(2).png',
                                                  width: 400.0,
                                                  height: 400.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
