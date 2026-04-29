import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'passageiro_form_m_model.dart';
export 'passageiro_form_m_model.dart';

const Color _kPrimaryBlue = Color(0xFF5DA5DA);
const Color _kDarkText = Color(0xFF333333);
const Color _kGrayText = Color(0xFF999999);
const Color _kBorderBlue = Color(0xFF5DA5DA);
const Color _kWhite = Colors.white;

class PassageiroFormMWidget extends StatefulWidget {
  const PassageiroFormMWidget({super.key, this.passageiroId});
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
    _model.sobrenomeTextController ??= TextEditingController();
    _model.sobrenomeFocusNode ??= FocusNode();
    _model.respNomeTextController ??= TextEditingController();
    _model.respNomeFocusNode ??= FocusNode();
    _model.respSobrenomeTextController ??= TextEditingController();
    _model.respSobrenomeFocusNode ??= FocusNode();
    _model.respDddTextController ??= TextEditingController();
    _model.respDddFocusNode ??= FocusNode();
    _model.respTelefoneTextController ??= TextEditingController();
    _model.respTelefoneFocusNode ??= FocusNode();
    _model.respCpfTextController ??= TextEditingController();
    _model.respCpfFocusNode ??= FocusNode();
    _model.valorTextController ??= TextEditingController();
    _model.valorFocusNode ??= FocusNode();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.loadEscolas(FFAppState().idUsuario);
      if (isEditing) await _model.loadPassageiro(widget.passageiroId!);
      safeSetState(() {});
    });
  }

  @override
  void dispose() { _model.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: _kWhite,
        body: SafeArea(
          child: _model.isLoading
              ? const Center(child: SpinKitPulse(color: _kPrimaryBlue, size: 50.0))
              : Column(children: [
                  _buildHeader(),
                  Divider(height: 1, color: _kPrimaryBlue.withOpacity(0.3)),
                  Expanded(
                    child: PageView(
                      controller: _model.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [_buildStep1Passageiro(), _buildStep2Responsavel(), _buildStep3Mensalidade()],
                    ),
                  ),
                ]),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: () {
            if (_model.currentStep > 0) { _model.previousStep(); safeSetState(() {}); }
            else { context.safePop(); }
          },
          child: Text(_model.currentStep > 0 ? 'Voltar' : 'Fechar',
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: _kPrimaryBlue)),
        ),
        Text('Cadastrar', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: _kDarkText)),
        const SizedBox(width: 60),
      ]),
    );
  }

  // ── STEP 1 ─────────────────────────────────────────
  Widget _buildStep1Passageiro() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _model.formKeyStep1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Passageiro', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: _kDarkText)),
            Text('*Campos Opcionais', style: GoogleFonts.inter(fontSize: 13, color: _kGrayText)),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _buildTextField(controller: _model.nomeTextController!, focusNode: _model.nomeFocusNode!, hint: 'Nome',
                validator: (val) { if (val == null || val.isEmpty) return 'Obrigatório'; return null; })),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(controller: _model.sobrenomeTextController!, focusNode: _model.sobrenomeFocusNode!, hint: 'Sobrenome*')),
          ]),
          const SizedBox(height: 12),
          _buildPickerButton(
            label: _model.dataNascimentoFormatted.isNotEmpty ? _model.dataNascimentoFormatted : 'Data de Nascimento*',
            isPlaceholder: _model.dataNascimento == null, onTap: () => _showDatePicker()),
          const SizedBox(height: 12),
          _buildSexoToggle(),
          const SizedBox(height: 24),
          Text('Informações Escolares', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: _kDarkText)),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _buildPickerButton(
                label: _model.escolaSelecionada?.nomeEscola ?? 'Escola',
                isPlaceholder: _model.escolaSelecionada == null, onTap: () => _showEscolaPicker())),
            const SizedBox(width: 12),
            GestureDetector(onTap: () => _showCadastrarEscola(),
              child: Container(width: 48, height: 48,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _kBorderBlue, width: 1.5)),
                child: const Icon(Icons.add, color: _kBorderBlue, size: 24))),
          ]),
          const SizedBox(height: 12),
          _buildPickerButton(label: _model.periodoSelecionado ?? 'Período',
              isPlaceholder: _model.periodoSelecionado == null, onTap: () => _showPeriodoPicker()),
          const SizedBox(height: 24),
          _buildPrimaryButton('Próximo', onTap: () {
            if (_model.formKeyStep1.currentState?.validate() != true) return;
            _model.nextStep(); safeSetState(() {});
          }),
        ]),
      ),
    );
  }

  // ── STEP 2 ─────────────────────────────────────────
  Widget _buildStep2Responsavel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _model.formKeyStep2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Responsável', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: _kDarkText)),
            Text('*Campos Opcionais', style: GoogleFonts.inter(fontSize: 13, color: _kGrayText)),
          ]),
          const SizedBox(height: 16),
          _buildOutlinedButton('Importar da Agenda', onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Funcionalidade em desenvolvimento')));
          }),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _buildTextField(controller: _model.respNomeTextController!, focusNode: _model.respNomeFocusNode!, hint: 'Nome')),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(controller: _model.respSobrenomeTextController!, focusNode: _model.respSobrenomeFocusNode!, hint: 'Sobrenome')),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            SizedBox(width: 80, child: _buildTextField(controller: _model.respDddTextController!, focusNode: _model.respDddFocusNode!, hint: 'DDD', keyboardType: TextInputType.number, maxLength: 2)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(controller: _model.respTelefoneTextController!, focusNode: _model.respTelefoneFocusNode!, hint: 'Telefone', keyboardType: TextInputType.phone)),
          ]),
          const SizedBox(height: 8),
          Text('Caso queira que o CPF do responsável apareça no recibo de pagamento preencha o campo abaixo:',
              style: GoogleFonts.inter(fontSize: 13, color: _kGrayText)),
          const SizedBox(height: 8),
          _buildTextField(controller: _model.respCpfTextController!, focusNode: _model.respCpfFocusNode!, hint: 'CPF',
              keyboardType: TextInputType.number,
              inputFormatters: [MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')})]),
          const SizedBox(height: 24),
          _buildPrimaryButton('Adicionar Responsável', onTap: () { _model.nextStep(); safeSetState(() {}); }),
        ]),
      ),
    );
  }

  // ── STEP 3 ─────────────────────────────────────────
  Widget _buildStep3Mensalidade() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _model.formKeyStep3,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Mensalidade', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: _kDarkText)),
          const SizedBox(height: 8),
          Text('Informe a mensalidade do passageiro para gerenciar em seu controle financeiro:',
              style: GoogleFonts.inter(fontSize: 14, color: _kDarkText)),
          const SizedBox(height: 4),
          Text('Obs.: Os dados não são expostos para outros usuários.', style: GoogleFonts.inter(fontSize: 13, color: _kGrayText)),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _buildTextField(controller: _model.valorTextController!, focusNode: _model.valorFocusNode!, hint: '0,00',
                keyboardType: const TextInputType.numberWithOptions(decimal: true))),
            const SizedBox(width: 12),
            Expanded(child: _buildPickerButton(
                label: _model.diaPagamento != null ? '${_model.diaPagamento}' : 'Dia Pagto.',
                isPlaceholder: _model.diaPagamento == null, outlined: true, onTap: () => _showDiaPagamentoPicker())),
          ]),
          const SizedBox(height: 24),
          Text('Prazo de Vigência', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: _kDarkText)),
          const SizedBox(height: 8),
          Text('Informe o prazo de vigência inicial e final:', style: GoogleFonts.inter(fontSize: 14, color: _kDarkText)),
          const SizedBox(height: 4),
          Text('Obs.: As mensalidades só serão apresentadas no período selecionado', style: GoogleFonts.inter(fontSize: 13, color: _kGrayText)),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _buildPickerButton(
                label: _model.vigenciaInicioFormatted.isNotEmpty ? _model.vigenciaInicioFormatted : 'Início',
                isPlaceholder: _model.vigenciaInicio == null, outlined: true, onTap: () => _showMonthYearPicker(isInicio: true))),
            const SizedBox(width: 12),
            Expanded(child: _buildPickerButton(
                label: _model.vigenciaFinalFormatted.isNotEmpty ? _model.vigenciaFinalFormatted : 'Final',
                isPlaceholder: _model.vigenciaFinal == null, outlined: true, onTap: () => _showMonthYearPicker(isInicio: false))),
          ]),
          const SizedBox(height: 24),
          _buildPrimaryButton(_model.isSaving ? 'Salvando...' : 'Finalizar Cadastro do Passageiro',
            onTap: _model.isSaving ? null : () async {
              final success = await _model.saveAll(FFAppState().idUsuario, widget.passageiroId);
              safeSetState(() {});
              if (success && context.mounted) { context.safePop(); }
              else if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_model.errorMessage ?? 'Erro ao salvar')));
              }
            }),
        ]),
      ),
    );
  }

  // ── REUSABLE WIDGETS ───────────────────────────────
  Widget _buildTextField({required TextEditingController controller, required FocusNode focusNode, required String hint,
      TextInputType keyboardType = TextInputType.text, int? maxLength, String? Function(String?)? validator,
      List<MaskTextInputFormatter>? inputFormatters}) {
    return TextFormField(
      controller: controller, focusNode: focusNode, keyboardType: keyboardType, maxLength: maxLength,
      validator: validator, inputFormatters: inputFormatters, textAlign: TextAlign.left,
      style: GoogleFonts.inter(fontSize: 15, color: _kDarkText),
      decoration: InputDecoration(
        hintText: hint, hintStyle: GoogleFonts.inter(fontSize: 15, color: _kGrayText), counterText: '',
        filled: true, fillColor: _kWhite, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: _kBorderBlue, width: 1.5)),
      ),
    );
  }

  Widget _buildPickerButton({required String label, bool isPlaceholder = false, bool outlined = false, VoidCallback? onTap}) {
    return GestureDetector(onTap: onTap, child: Container(height: 48,
      decoration: BoxDecoration(color: _kWhite, borderRadius: BorderRadius.circular(24),
          border: Border.all(color: outlined ? _kBorderBlue : Colors.grey.shade300, width: outlined ? 1.5 : 1)),
      alignment: Alignment.center,
      child: Text(label, style: GoogleFonts.inter(fontSize: 15,
          color: isPlaceholder ? _kPrimaryBlue : _kDarkText, fontWeight: isPlaceholder ? FontWeight.w400 : FontWeight.w500))));
  }

  Widget _buildPrimaryButton(String label, {VoidCallback? onTap}) {
    return GestureDetector(onTap: onTap, child: Container(width: double.infinity, height: 48,
      decoration: BoxDecoration(color: onTap == null ? _kPrimaryBlue.withOpacity(0.5) : _kPrimaryBlue, borderRadius: BorderRadius.circular(24)),
      alignment: Alignment.center,
      child: Text(label, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: _kWhite))));
  }

  Widget _buildOutlinedButton(String label, {VoidCallback? onTap}) {
    return GestureDetector(onTap: onTap, child: Container(width: double.infinity, height: 48,
      decoration: BoxDecoration(color: _kWhite, borderRadius: BorderRadius.circular(24), border: Border.all(color: _kBorderBlue, width: 1.5)),
      alignment: Alignment.center,
      child: Text(label, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: _kPrimaryBlue))));
  }

  Widget _buildSexoToggle() {
    return Container(height: 48,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), border: Border.all(color: _kBorderBlue, width: 1.5)),
      child: Row(children: [
        Expanded(child: GestureDetector(onTap: () { _model.sexoMasculino = true; safeSetState(() {}); },
          child: Container(
            decoration: BoxDecoration(color: _model.sexoMasculino == true ? _kPrimaryBlue : _kWhite,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(22))),
            alignment: Alignment.center,
            child: Text('Masculino', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500,
                color: _model.sexoMasculino == true ? _kWhite : _kPrimaryBlue))))),
        Expanded(child: GestureDetector(onTap: () { _model.sexoMasculino = false; safeSetState(() {}); },
          child: Container(
            decoration: BoxDecoration(color: _model.sexoMasculino == false ? _kPrimaryBlue : _kWhite,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(22))),
            alignment: Alignment.center,
            child: Text('Feminino', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500,
                color: _model.sexoMasculino == false ? _kWhite : _kPrimaryBlue))))),
      ]));
  }

  // ── PICKERS ────────────────────────────────────────
  void _showDatePicker() {
    DateTime temp = _model.dataNascimento ?? DateTime(2010, 1, 1);
    showCupertinoModalPopup(context: context, builder: (_) => Container(height: 300, color: _kWhite,
      child: Column(children: [
        _buildPickerHeader(onSelect: () { _model.dataNascimento = temp; safeSetState(() {}); Navigator.pop(context); }),
        Expanded(child: CupertinoDatePicker(mode: CupertinoDatePickerMode.date, initialDateTime: temp,
            maximumDate: DateTime.now(), minimumDate: DateTime(1950), onDateTimeChanged: (dt) => temp = dt)),
      ])));
  }

  void _showEscolaPicker() {
    if (_model.escolas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nenhuma escola cadastrada. Use o botão + para adicionar.')));
      return;
    }
    int selectedIndex = _model.escolaSelecionada != null
        ? _model.escolas.indexWhere((e) => e.idEscola == _model.escolaSelecionada!.idEscola) : 0;
    if (selectedIndex < 0) selectedIndex = 0;
    showCupertinoModalPopup(context: context, builder: (_) => Container(height: 300, color: _kWhite,
      child: Column(children: [
        _buildPickerHeader(onSelect: () { _model.escolaSelecionada = _model.escolas[selectedIndex]; safeSetState(() {}); Navigator.pop(context); }),
        Expanded(child: CupertinoPicker(scrollController: FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40, onSelectedItemChanged: (i) => selectedIndex = i,
            children: _model.escolas.map((e) => Center(child: Text(e.nomeEscola, style: GoogleFonts.inter(fontSize: 16)))).toList())),
      ])));
  }

  void _showPeriodoPicker() {
    int selectedIndex = _model.periodoSelecionado != null ? _model.periodos.indexOf(_model.periodoSelecionado!) : 0;
    if (selectedIndex < 0) selectedIndex = 0;
    showCupertinoModalPopup(context: context, builder: (_) => Container(height: 300, color: _kWhite,
      child: Column(children: [
        _buildPickerHeader(onSelect: () { _model.periodoSelecionado = _model.periodos[selectedIndex]; safeSetState(() {}); Navigator.pop(context); }),
        Expanded(child: CupertinoPicker(scrollController: FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40, onSelectedItemChanged: (i) => selectedIndex = i,
            children: _model.periodos.map((p) => Center(child: Text(p, style: GoogleFonts.inter(fontSize: 16)))).toList())),
      ])));
  }

  void _showDiaPagamentoPicker() {
    int selectedIndex = (_model.diaPagamento ?? 1) - 1;
    showCupertinoModalPopup(context: context, builder: (_) => Container(height: 300, color: _kWhite,
      child: Column(children: [
        _buildPickerHeader(onSelect: () { _model.diaPagamento = selectedIndex + 1; safeSetState(() {}); Navigator.pop(context); }),
        Expanded(child: CupertinoPicker(scrollController: FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40, onSelectedItemChanged: (i) => selectedIndex = i,
            children: List.generate(31, (i) => Center(child: Text('${i + 1}', style: GoogleFonts.inter(fontSize: 18)))))),
      ])));
  }

  void _showMonthYearPicker({required bool isInicio}) {
    final now = DateTime.now();
    DateTime temp = isInicio ? (_model.vigenciaInicio ?? now) : (_model.vigenciaFinal ?? DateTime(now.year + 1, now.month));
    showCupertinoModalPopup(context: context, builder: (_) => Container(height: 300, color: _kWhite,
      child: Column(children: [
        _buildPickerHeader(onSelect: () {
          if (isInicio) { _model.vigenciaInicio = temp; } else { _model.vigenciaFinal = temp; }
          safeSetState(() {}); Navigator.pop(context);
        }),
        Expanded(child: CupertinoDatePicker(mode: CupertinoDatePickerMode.monthYear, initialDateTime: temp,
            minimumDate: DateTime(2020), maximumDate: DateTime(2035), onDateTimeChanged: (dt) => temp = dt)),
      ])));
  }

  Widget _buildPickerHeader({required VoidCallback onSelect}) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 16), height: 44,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(onTap: () => Navigator.pop(context),
            child: Text('Cancelar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500))),
        GestureDetector(onTap: onSelect,
            child: Text('Selecionar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: _kPrimaryBlue))),
      ]));
  }

  // ── CADASTRAR ESCOLA BOTTOM SHEET ──────────────────
  void _showCadastrarEscola() {
    final controller = TextEditingController();
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: _kWhite,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(onTap: () => Navigator.pop(ctx),
                child: Text('Fechar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: _kPrimaryBlue))),
            Text('Cadastrar Escola', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: _kPrimaryBlue)),
            const SizedBox(width: 60),
          ]),
          Divider(height: 24, color: _kPrimaryBlue.withOpacity(0.3)),
          Align(alignment: Alignment.centerLeft,
              child: Text('Escola', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: _kGrayText))),
          const SizedBox(height: 8),
          TextFormField(controller: controller, autofocus: true, style: GoogleFonts.inter(fontSize: 15, color: _kDarkText),
            decoration: InputDecoration(hintText: 'Nome', hintStyle: GoogleFonts.inter(fontSize: 15, color: _kGrayText),
              filled: true, fillColor: _kWhite, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: _kBorderBlue, width: 1.5)))),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              final nome = controller.text.trim();
              if (nome.isEmpty) return;
              try {
                final escola = await VivanLocator.service.createEscola(VivanEscola(idMotorista: FFAppState().idUsuario, nomeEscola: nome));
                _model.escolas.add(escola);
                _model.escolaSelecionada = escola;
                if (ctx.mounted) Navigator.pop(ctx);
                safeSetState(() {});
              } catch (e) {
                if (ctx.mounted) ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Erro: $e')));
              }
            },
            child: Container(width: double.infinity, height: 48,
              decoration: BoxDecoration(color: _kPrimaryBlue, borderRadius: BorderRadius.circular(24)),
              alignment: Alignment.center,
              child: Text('Salvar', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: _kWhite)))),
        ]),
      ));
  }
}
