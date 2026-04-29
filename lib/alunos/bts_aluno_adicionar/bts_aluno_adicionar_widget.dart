import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'bts_aluno_adicionar_model.dart';
export 'bts_aluno_adicionar_model.dart';

class BtsAlunoAdicionarWidget extends StatefulWidget {
  const BtsAlunoAdicionarWidget({super.key});
  @override
  State<BtsAlunoAdicionarWidget> createState() => _BtsAlunoAdicionarWidgetState();
}

class _BtsAlunoAdicionarWidgetState extends State<BtsAlunoAdicionarWidget> {
  late BtsAlunoAdicionarModel _model;
  final _cpfMask = MaskTextInputFormatter(mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});

  @override
  void setState(VoidCallback callback) { super.setState(callback); _model.onUpdate(); }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BtsAlunoAdicionarModel());
    _model.pageController = PageController(initialPage: 0);
    _model.nomeTextController ??= TextEditingController();
    _model.nomeFocusNode ??= FocusNode();
    _model.sobrenomeTextController ??= TextEditingController();
    _model.sobrenomeFocusNode ??= FocusNode();
    _model.respNomeTextController ??= TextEditingController();
    _model.respNomeFocusNode ??= FocusNode();
    _model.respSobrenomeTextController ??= TextEditingController();
    _model.respSobrenomeFocusNode ??= FocusNode();
    _model.respDDDTextController ??= TextEditingController();
    _model.respDDDFocusNode ??= FocusNode();
    _model.respTelefoneTextController ??= TextEditingController();
    _model.respTelefoneFocusNode ??= FocusNode();
    _model.respCPFTextController ??= TextEditingController();
    _model.respCPFFocusNode ??= FocusNode();
    _model.valorMensalidadeTextController ??= TextEditingController();
    _model.valorMensalidadeFocusNode ??= FocusNode();
    _loadEscolas();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _loadEscolas() async {
    final escolas = await EscolaTable().queryRows(
      queryFn: (q) => q.eqOrNull('idEmpresa', FFAppState().idEmpresa).order('nomeEscola', ascending: true),
    );
    if (mounted) { safeSetState(() { _model.escolasList = escolas; }); }
  }

  @override
  void dispose() { _model.maybeDispose(); super.dispose(); }

  Widget _buildTextField({
    required TextEditingController controller, required FocusNode focusNode, required String hintText,
    TextInputType keyboardType = TextInputType.text, List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator, TextCapitalization textCapitalization = TextCapitalization.words, int? maxLength,
  }) {
    return TextFormField(
      controller: controller, focusNode: focusNode, autofocus: false, textCapitalization: textCapitalization,
      keyboardType: keyboardType, maxLength: maxLength, obscureText: false,
      decoration: InputDecoration(
        hintText: hintText, counterText: '',
        hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
          font: GoogleFonts.inter(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight),
          color: FlutterFlowTheme.of(context).secondaryText, fontSize: 14.0, letterSpacing: 0.0,
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 1.0), borderRadius: BorderRadius.circular(24.0)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.5), borderRadius: BorderRadius.circular(24.0)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0), borderRadius: BorderRadius.circular(24.0)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.5), borderRadius: BorderRadius.circular(24.0)),
        filled: true, fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        contentPadding: EdgeInsetsDirectional.fromSTEB(20.0, 14.0, 20.0, 14.0),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
        font: GoogleFonts.inter(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight),
        color: FlutterFlowTheme.of(context).primaryText, fontSize: 14.0, letterSpacing: 0.0,
      ),
      inputFormatters: inputFormatters,
      validator: validator != null ? (val) => validator(val) : null,
    );
  }

  Widget _buildOutlineButton({required String text, required VoidCallback onTap, Color? textColor}) {
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(24.0),
      child: Container(
        width: double.infinity, height: 50.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.0), border: Border.all(color: FlutterFlowTheme.of(context).primary, width: 1.5)),
        alignment: Alignment.center,
        child: Text(text, style: FlutterFlowTheme.of(context).bodyMedium.override(
          font: GoogleFonts.inter(fontWeight: FontWeight.w500), color: textColor ?? FlutterFlowTheme.of(context).primary, fontSize: 14.0, letterSpacing: 0.0,
        )),
      ),
    );
  }

  Widget _buildPrimaryButton({required String text, required VoidCallback onPressed}) {
    return FFButtonWidget(
      onPressed: onPressed, text: text,
      options: FFButtonOptions(
        width: double.infinity, height: 50.0,
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
          font: GoogleFonts.interTight(fontWeight: FontWeight.w600), color: Colors.white, fontSize: 16.0, letterSpacing: 0.0,
        ),
        elevation: 0.0, borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }

  void _showCupertinoPicker({required List<String> items, required String? currentValue, required ValueChanged<String> onSelected}) {
    int initialIndex = 0;
    if (currentValue != null) { final idx = items.indexOf(currentValue); if (idx >= 0) initialIndex = idx; }
    int selectedIndex = initialIndex;
    showModalBottomSheet(context: context, backgroundColor: Colors.white, builder: (ctx) {
      return Container(height: 300, child: Column(children: [
        Container(padding: EdgeInsets.symmetric(horizontal: 16.0), height: 44, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CupertinoButton(padding: EdgeInsets.zero, child: Text('Cancelar', style: TextStyle(color: FlutterFlowTheme.of(context).primaryText, fontSize: 16)), onPressed: () => Navigator.pop(ctx)),
          CupertinoButton(padding: EdgeInsets.zero, child: Text('Selecionar', style: TextStyle(color: FlutterFlowTheme.of(context).primary, fontSize: 16, fontWeight: FontWeight.w600)), onPressed: () { onSelected(items[selectedIndex]); Navigator.pop(ctx); }),
        ])),
        Divider(height: 1),
        Expanded(child: CupertinoPicker(
          scrollController: FixedExtentScrollController(initialItem: initialIndex), itemExtent: 40,
          onSelectedItemChanged: (index) { selectedIndex = index; },
          children: items.map((item) => Center(child: Text(item, style: TextStyle(fontSize: 20)))).toList(),
        )),
      ]));
    });
  }

  void _showDatePicker({required DateTime? currentDate, required ValueChanged<DateTime> onSelected, CupertinoDatePickerMode mode = CupertinoDatePickerMode.date}) {
    DateTime tempDate = currentDate ?? DateTime.now();
    showModalBottomSheet(context: context, backgroundColor: Colors.white, builder: (ctx) {
      return Container(height: 300, child: Column(children: [
        Container(padding: EdgeInsets.symmetric(horizontal: 16.0), height: 44, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CupertinoButton(padding: EdgeInsets.zero, child: Text('Cancelar', style: TextStyle(color: FlutterFlowTheme.of(context).primaryText, fontSize: 16)), onPressed: () => Navigator.pop(ctx)),
          CupertinoButton(padding: EdgeInsets.zero, child: Text('Selecionar', style: TextStyle(color: FlutterFlowTheme.of(context).primary, fontSize: 16, fontWeight: FontWeight.w600)), onPressed: () { onSelected(tempDate); Navigator.pop(ctx); }),
        ])),
        Divider(height: 1),
        Expanded(child: CupertinoDatePicker(
          mode: mode, initialDateTime: currentDate ?? DateTime.now(),
          maximumDate: DateTime.now().add(Duration(days: 365 * 5)), minimumDate: DateTime(1990), use24hFormat: true,
          onDateTimeChanged: (date) { tempDate = date; },
        )),
      ]));
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          _buildHeader(),
          Divider(height: 1, thickness: 1, color: FlutterFlowTheme.of(context).alternate),
          Expanded(child: PageView(
            controller: _model.pageController, physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) { safeSetState(() => _model.currentPage = index); },
            children: [_buildStep1Passageiro(), _buildStep2Responsavel(), _buildStep3Mensalidade()],
          )),
        ]),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {
            if (_model.currentPage > 0) { _model.pageController?.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut); }
            else { Navigator.pop(context); }
          },
          child: Text(_model.currentPage > 0 ? 'Voltar' : 'Fechar',
            style: FlutterFlowTheme.of(context).bodyLarge.override(font: GoogleFonts.inter(fontWeight: FontWeight.w500), color: FlutterFlowTheme.of(context).primary, fontSize: 16.0, letterSpacing: 0.0)),
        ),
        Text('Cadastrar', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.w600), color: FlutterFlowTheme.of(context).primaryText, fontSize: 18.0, letterSpacing: 0.0)),
        SizedBox(width: 50),
      ]),
    );
  }

  Widget _buildStep1Passageiro() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Form(key: _model.formKey, autovalidateMode: AutovalidateMode.disabled,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Passageiro', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.bold), fontSize: 18.0, letterSpacing: 0.0, color: FlutterFlowTheme.of(context).primaryText)),
            Text('*Campos Opcionais', style: FlutterFlowTheme.of(context).bodySmall.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).secondaryText, fontSize: 12.0, letterSpacing: 0.0)),
          ]),
          SizedBox(height: 20.0),
          Row(children: [
            Expanded(child: _buildTextField(controller: _model.nomeTextController!, focusNode: _model.nomeFocusNode!, hintText: 'Nome',
              validator: (val) { if (val == null || val.isEmpty) return 'Obrigatório'; return null; })),
            SizedBox(width: 12.0),
            Expanded(child: _buildTextField(controller: _model.sobrenomeTextController!, focusNode: _model.sobrenomeFocusNode!, hintText: 'Sobrenome*')),
          ]),
          SizedBox(height: 12.0),
          _buildOutlineButton(
            text: _model.dtNascimento != null ? DateFormat('dd/MM/yyyy').format(_model.dtNascimento!) : 'Data de Nascimento*',
            onTap: () { _showDatePicker(currentDate: _model.dtNascimento, onSelected: (date) { safeSetState(() => _model.dtNascimento = date); }); },
          ),
          SizedBox(height: 12.0),
          Container(
            width: double.infinity, height: 50.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.0), border: Border.all(color: FlutterFlowTheme.of(context).primary, width: 1.5)),
            child: ClipRRect(borderRadius: BorderRadius.circular(23.0), child: Row(children: [
              Expanded(child: GestureDetector(
                onTap: () => safeSetState(() => _model.sexo = 'Masculino'),
                child: Container(alignment: Alignment.center,
                  color: _model.sexo == 'Masculino' ? FlutterFlowTheme.of(context).primary : Colors.transparent,
                  child: Text('Masculino', style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.inter(fontWeight: FontWeight.w500), color: _model.sexo == 'Masculino' ? Colors.white : FlutterFlowTheme.of(context).primary, fontSize: 14.0, letterSpacing: 0.0))),
              )),
              Expanded(child: GestureDetector(
                onTap: () => safeSetState(() => _model.sexo = 'Feminino'),
                child: Container(alignment: Alignment.center,
                  color: _model.sexo == 'Feminino' ? FlutterFlowTheme.of(context).primary : Colors.transparent,
                  child: Text('Feminino', style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.inter(fontWeight: FontWeight.w500), color: _model.sexo == 'Feminino' ? Colors.white : FlutterFlowTheme.of(context).primary, fontSize: 14.0, letterSpacing: 0.0))),
              )),
            ])),
          ),
          SizedBox(height: 24.0),
          Text('Informações Escolares', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.bold), fontSize: 16.0, letterSpacing: 0.0, color: FlutterFlowTheme.of(context).primaryText)),
          SizedBox(height: 16.0),
          Row(children: [
            Expanded(child: _buildOutlineButton(
              text: _model.selectedEscolaNome ?? 'Escola',
              textColor: _model.selectedEscolaNome != null ? FlutterFlowTheme.of(context).primaryText : null,
              onTap: () {
                if (_model.escolasList.isEmpty) return;
                _showCupertinoPicker(
                  items: _model.escolasList.map((e) => e.nomeEscola ?? '').toList(),
                  currentValue: _model.selectedEscolaNome,
                  onSelected: (val) {
                    final escola = _model.escolasList.firstWhere((e) => e.nomeEscola == val);
                    safeSetState(() { _model.selectedEscolaId = escola.idEscola; _model.selectedEscolaNome = escola.nomeEscola; });
                  },
                );
              },
            )),
            SizedBox(width: 12.0),
            GestureDetector(
              onTap: () async {
                final result = await showModalBottomSheet<EscolaRow>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (ctx) {
                  return Padding(padding: MediaQuery.viewInsetsOf(ctx), child: _CadastrarEscolaSheet());
                });
                if (result != null) {
                  await _loadEscolas();
                  safeSetState(() { _model.selectedEscolaId = result.idEscola; _model.selectedEscolaNome = result.nomeEscola; });
                }
              },
              child: Container(width: 50, height: 50,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: FlutterFlowTheme.of(context).primary, width: 1.5)),
                child: Icon(Icons.add, color: FlutterFlowTheme.of(context).primary, size: 24)),
            ),
          ]),
          SizedBox(height: 12.0),
          _buildOutlineButton(
            text: _model.selectedPeriodo ?? 'Período',
            textColor: _model.selectedPeriodo != null ? FlutterFlowTheme.of(context).primaryText : null,
            onTap: () { _showCupertinoPicker(items: _model.periodoOptions, currentValue: _model.selectedPeriodo, onSelected: (val) { safeSetState(() => _model.selectedPeriodo = val); }); },
          ),
          SizedBox(height: 24.0),
          _buildPrimaryButton(text: 'Próximo', onPressed: () {
            if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) return;
            _model.pageController?.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          }),
        ]),
      ),
    );
  }

  Widget _buildStep2Responsavel() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Responsável', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.bold), fontSize: 18.0, letterSpacing: 0.0, color: FlutterFlowTheme.of(context).primaryText)),
          Text('*Campos Opcionais', style: FlutterFlowTheme.of(context).bodySmall.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).secondaryText, fontSize: 12.0, letterSpacing: 0.0)),
        ]),
        SizedBox(height: 16.0),
        _buildOutlineButton(text: 'Importar da Agenda', onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Em breve'), duration: Duration(seconds: 2)));
        }),
        SizedBox(height: 16.0),
        Row(children: [
          Expanded(child: _buildTextField(controller: _model.respNomeTextController!, focusNode: _model.respNomeFocusNode!, hintText: 'Nome')),
          SizedBox(width: 12.0),
          Expanded(child: _buildTextField(controller: _model.respSobrenomeTextController!, focusNode: _model.respSobrenomeFocusNode!, hintText: 'Sobrenome')),
        ]),
        SizedBox(height: 12.0),
        Row(children: [
          SizedBox(width: 80, child: _buildTextField(controller: _model.respDDDTextController!, focusNode: _model.respDDDFocusNode!, hintText: 'DDD', keyboardType: TextInputType.number, maxLength: 2, inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
          SizedBox(width: 12.0),
          Expanded(child: _buildTextField(controller: _model.respTelefoneTextController!, focusNode: _model.respTelefoneFocusNode!, hintText: 'Telefone', keyboardType: TextInputType.phone, maxLength: 9, inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
        ]),
        SizedBox(height: 16.0),
        Text('Caso queira que o CPF do responsável apareça no recibo de pagamento preencha o campo abaixo:', style: FlutterFlowTheme.of(context).bodySmall.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).secondaryText, fontSize: 13.0, letterSpacing: 0.0)),
        SizedBox(height: 12.0),
        _buildTextField(controller: _model.respCPFTextController!, focusNode: _model.respCPFFocusNode!, hintText: '000.000.000-00', keyboardType: TextInputType.number, inputFormatters: [_cpfMask]),
        SizedBox(height: 24.0),
        _buildPrimaryButton(text: 'Adicionar Responsável', onPressed: () {
          _model.pageController?.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        }),
      ]),
    );
  }

  Widget _buildStep3Mensalidade() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Mensalidade', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.bold), fontSize: 18.0, letterSpacing: 0.0, color: FlutterFlowTheme.of(context).primaryText)),
        SizedBox(height: 8.0),
        Text('Informe a mensalidade do passageiro para gerenciar em seu controle financeiro:', style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).primaryText, fontSize: 14.0, letterSpacing: 0.0)),
        SizedBox(height: 4.0),
        Text('Obs.: Os dados não são expostos para outros usuários.', style: FlutterFlowTheme.of(context).bodySmall.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).secondaryText, fontSize: 12.0, letterSpacing: 0.0)),
        SizedBox(height: 16.0),
        Row(children: [
          Expanded(child: _buildTextField(controller: _model.valorMensalidadeTextController!, focusNode: _model.valorMensalidadeFocusNode!, hintText: '0,00', keyboardType: TextInputType.numberWithOptions(decimal: true), inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))])),
          SizedBox(width: 12.0),
          Expanded(child: _buildOutlineButton(
            text: _model.diaPagamento != null ? 'Dia ${_model.diaPagamento}' : 'Dia Pagto.',
            onTap: () { _showCupertinoPicker(items: List.generate(31, (i) => '${i + 1}'), currentValue: _model.diaPagamento, onSelected: (val) { safeSetState(() => _model.diaPagamento = val); }); },
          )),
        ]),
        SizedBox(height: 24.0),
        Text('Prazo de Vigência', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.bold), fontSize: 16.0, letterSpacing: 0.0, color: FlutterFlowTheme.of(context).primaryText)),
        SizedBox(height: 8.0),
        Text('Informe o prazo de vigência inicial e final:', style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).primaryText, fontSize: 14.0, letterSpacing: 0.0)),
        SizedBox(height: 4.0),
        Text('Obs.: As mensalidades só serão apresentadas no período selecionado', style: FlutterFlowTheme.of(context).bodySmall.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).secondaryText, fontSize: 12.0, letterSpacing: 0.0)),
        SizedBox(height: 16.0),
        Row(children: [
          Expanded(child: _buildOutlineButton(
            text: _model.dtInicioVigencia != null ? DateFormat('dd/MM/yyyy').format(_model.dtInicioVigencia!) : 'Início',
            onTap: () { _showDatePicker(currentDate: _model.dtInicioVigencia, onSelected: (date) { safeSetState(() => _model.dtInicioVigencia = date); }); },
          )),
          SizedBox(width: 12.0),
          Expanded(child: _buildOutlineButton(
            text: _model.dtFinalVigencia != null ? DateFormat('dd/MM/yyyy').format(_model.dtFinalVigencia!) : 'Final',
            onTap: () { _showDatePicker(currentDate: _model.dtFinalVigencia, onSelected: (date) { safeSetState(() => _model.dtFinalVigencia = date); }); },
          )),
        ]),
        SizedBox(height: 32.0),
        _buildPrimaryButton(text: 'Finalizar Cadastro do Passageiro', onPressed: () async { await _finalizarCadastro(); }),
      ]),
    );
  }

  Future<void> _finalizarCadastro() async {
    _model.apiResBuscaAluno = await AlunoTable().queryRows(
      queryFn: (q) => q.eqOrNull('nomeAluno', _model.nomeCompleto),
    );
    if (_model.apiResBuscaAluno != null && _model.apiResBuscaAluno!.isNotEmpty) {
      await showDialog(context: context, builder: (alertCtx) {
        return AlertDialog(title: Text('Cadastrar Passageiro'), content: Text('Passageiro já cadastrado.'),
          actions: [TextButton(onPressed: () => Navigator.pop(alertCtx), child: Text('Ok'))]);
      });
      return;
    }
    try {
      _model.apiResAdicionaAluno = await AlunoTable().insert({
        'idEmpresa': FFAppState().idEmpresa, 'ativo': false,
        'nomeAluno': _model.nomeCompleto, 'domTipoAluno': 'Particular',
        'domSitAluno': 'Aguardando', 'idMotorista': FFAppState().idUsuario,
        'idEscola': _model.selectedEscolaId, 'domTurno': _model.selectedPeriodo, 'domCheckAluno': true,
        if (_model.dtNascimento != null) 'dtNascimento': _model.dtNascimento!.toIso8601String(),
        if (_model.sexo != null) 'sexo': _model.sexo,
        if (_model.nomeCompletoResponsavel.isNotEmpty) 'nomeResponsavel': _model.nomeCompletoResponsavel,
        if (_model.telefoneCompletoResponsavel.isNotEmpty) 'telResponsavel': _model.telefoneCompletoResponsavel,
        if (_model.respCPFTextController!.text.trim().isNotEmpty) 'cpfResponsavel': _model.respCPFTextController!.text.trim(),
        if (_model.valorMensalidadeDouble != null) 'vlrMensalidade': _model.valorMensalidadeDouble,
      });
      if (_model.apiResAdicionaAluno?.idAluno != null) {
        if (_model.dtInicioVigencia != null || _model.dtFinalVigencia != null || _model.diaPagamento != null) {
          await ContratoAlunoTable().insert({
            'idAluno': _model.apiResAdicionaAluno!.idAluno, 'idEscola': _model.selectedEscolaId,
            if (_model.dtInicioVigencia != null) 'dtInicio': _model.dtInicioVigencia!.toIso8601String(),
            if (_model.dtFinalVigencia != null) 'dtFinal': _model.dtFinalVigencia!.toIso8601String(),
            if (_model.diaPagamento != null) 'domDiaVencimento': _model.diaPagamento,
          });
        }
        if (mounted) Navigator.pop(context);
      } else { _showError('Falha ao cadastrar passageiro'); }
    } catch (e) { _showError('Erro ao cadastrar: $e'); }
  }

  void _showError(String message) {
    showDialog(context: context, builder: (alertCtx) {
      return AlertDialog(title: Text('Cadastrar Passageiro'), content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(alertCtx), child: Text('Ok'))]);
    });
  }
}

class _CadastrarEscolaSheet extends StatefulWidget {
  @override
  State<_CadastrarEscolaSheet> createState() => _CadastrarEscolaSheetState();
}

class _CadastrarEscolaSheetState extends State<_CadastrarEscolaSheet> {
  final _nomeController = TextEditingController();
  final _nomeFocusNode = FocusNode();
  bool _saving = false;

  @override
  void dispose() { _nomeController.dispose(); _nomeFocusNode.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: FlutterFlowTheme.of(context).primaryBackground, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      padding: EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(onTap: () => Navigator.pop(context), child: Text('Fechar',
            style: FlutterFlowTheme.of(context).bodyLarge.override(font: GoogleFonts.inter(fontWeight: FontWeight.w500), color: FlutterFlowTheme.of(context).primary, fontSize: 16.0, letterSpacing: 0.0))),
          Text('Cadastrar Escola', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.w600), color: FlutterFlowTheme.of(context).primary, fontSize: 18.0, letterSpacing: 0.0)),
          SizedBox(width: 50),
        ]),
        Divider(height: 24),
        Text('Escola', style: FlutterFlowTheme.of(context).titleSmall.override(font: GoogleFonts.interTight(fontWeight: FontWeight.w600), color: FlutterFlowTheme.of(context).primaryText, fontSize: 14.0, letterSpacing: 0.0)),
        SizedBox(height: 12),
        TextFormField(
          controller: _nomeController, focusNode: _nomeFocusNode, autofocus: true,
          decoration: InputDecoration(
            hintText: 'Nome',
            hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).secondaryText, fontSize: 14.0, letterSpacing: 0.0),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 1.0), borderRadius: BorderRadius.circular(12.0)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
            filled: true, fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 14.0, 16.0, 14.0),
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).primaryText, fontSize: 14.0, letterSpacing: 0.0),
          textCapitalization: TextCapitalization.words,
        ),
        SizedBox(height: 16),
        SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
          onPressed: _saving ? null : () async {
            final nome = _nomeController.text.trim();
            if (nome.isEmpty) return;
            setState(() => _saving = true);
            try {
              final escola = await EscolaTable().insert({'nomeEscola': nome, 'idEmpresa': FFAppState().idEmpresa});
              if (mounted) Navigator.pop(context, escola);
            } catch (e) {
              if (mounted) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar escola'))); setState(() => _saving = false); }
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), elevation: 0),
          child: _saving
              ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text('Salvar', style: FlutterFlowTheme.of(context).titleSmall.override(font: GoogleFonts.interTight(fontWeight: FontWeight.w600), color: Colors.white, fontSize: 16.0, letterSpacing: 0.0)),
        )),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 0 ? 8 : 24),
      ]),
    );
  }
}
