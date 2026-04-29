import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'passageiro_form_m_model.dart';
export 'passageiro_form_m_model.dart';

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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PassageiroFormMModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.passageiroId != null) {
        await _model.carregar(widget.passageiroId!);
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;
  Color get _secondBg => FlutterFlowTheme.of(context).secondaryBackground;

  static const _totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgress(),
              Expanded(
                child: PageView(
                  controller: _model.pageCtrl,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildStep1(),
                    _buildStep2(),
                    _buildStep3(),
                    _buildStep4(),
                  ],
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Fechar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      color: _primary)),
          ),
          Expanded(
            child: Center(
              child: Text(
                _model.isEdit ? 'Editar Passageiro' : 'Cadastrar',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                      color: _primaryText),
              ),
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }

  // ── Progress dots ────────────────────────────────
  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_totalSteps, (i) {
          final done = i < _model.step;
          final current = i == _model.step;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: current ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: done || current
                  ? _primary
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  // ── Bottom bar ───────────────────────────────────
  Widget _buildBottomBar() {
    final isLast = _model.step == _totalSteps - 1;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          if (_model.step > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _model.pageCtrl.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                  setState(() => _model.step--);
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: _primary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: Text('Voltar',
                    style: TextStyle(
                        color: _primary, fontWeight: FontWeight.w600)),
              ),
            ),
          if (_model.step > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _model.isSaving ? null : _onNextOrSave,
              style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: _model.isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : Text(
                      isLast ? 'Salvar' : 'Próximo',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onNextOrSave() async {
    if (_model.step < _totalSteps - 1) {
      _model.pageCtrl.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _model.step++);
    } else {
      setState(() => _model.isSaving = true);
      final ok = await _model.salvar();
      if (ok && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_model.isEdit
              ? 'Passageiro atualizado com sucesso!'
              : 'Passageiro cadastrado com sucesso!'),
          backgroundColor: _primary,
        ));
        Navigator.pop(context);
      } else if (mounted && _model.erro != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro: ${_model.erro}'),
          backgroundColor: Colors.red.shade400,
        ));
      }
      setState(() => _model.isSaving = false);
    }
  }

  // ────────────────────────────────────────────────
  // STEP 1 — Passageiro
  // ────────────────────────────────────────────────
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Passageiro', sub: '*Campos Opcionais'),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _field(ctrl: _model.nomeCtrl, hint: 'Nome')),
            const SizedBox(width: 12),
            Expanded(
                child: _field(ctrl: _model.sobrenomeCtrl, hint: 'Sobrenome*')),
          ]),
          const SizedBox(height: 12),
          _datePicker(
            label: _model.dataNascimento != null
                ? _model.dataNascimentoFmt
                : 'Data de Nascimento*',
            hasValue: _model.dataNascimento != null,
            onTap: () => _pickDate(
              initial: _model.dataNascimento,
              first: DateTime(1900),
              last: DateTime.now(),
              onPicked: (d) => setState(() => _model.dataNascimento = d),
            ),
          ),
          const SizedBox(height: 12),
          _sexoToggle(),
          const SizedBox(height: 24),
          _sectionHeader('Informações Escolares'),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: _pickerButton(
                label: _model.escolaNome ?? 'Escola',
                hasValue: _model.escolaNome != null,
                onTap: _showEscolaSheet,
              ),
            ),
            const SizedBox(width: 8),
            _addButton(onTap: _showNovaEscolaSheet),
          ]),
          const SizedBox(height: 12),
          _pickerButton(
            label: _model.periodo ?? 'Período',
            hasValue: _model.periodo != null,
            onTap: _showPeriodoSheet,
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────
  // STEP 2 — Endereço
  // ────────────────────────────────────────────────
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Endereço', sub: '*Campos Opcionais'),
          const SizedBox(height: 16),
          _field(
            ctrl: _model.cepCtrl,
            hint: 'CEP',
            kb: TextInputType.number,
            fmt: [FilteringTextInputFormatter.digitsOnly],
            maxLen: 8,
          ),
          const SizedBox(height: 12),
          _field(ctrl: _model.logradouroCtrl, hint: 'Logradouro'),
          const SizedBox(height: 12),
          Row(children: [
            SizedBox(
                width: 100,
                child: _field(
                    ctrl: _model.numeroCtrl,
                    hint: 'Nº',
                    kb: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(
                child: _field(ctrl: _model.complementoCtrl, hint: 'Complemento*')),
          ]),
          const SizedBox(height: 12),
          _field(ctrl: _model.bairroCtrl, hint: 'Bairro'),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _field(ctrl: _model.cidadeCtrl, hint: 'Cidade')),
            const SizedBox(width: 12),
            SizedBox(
                width: 70,
                child: _field(
                    ctrl: _model.ufCtrl,
                    hint: 'UF',
                    maxLen: 2,
                    caps: TextCapitalization.characters)),
          ]),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────
  // STEP 3 — Responsável
  // ────────────────────────────────────────────────
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Responsável', sub: '*Campos Opcionais'),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _field(ctrl: _model.respNomeCtrl, hint: 'Nome')),
            const SizedBox(width: 12),
            Expanded(
                child: _field(
                    ctrl: _model.respSobrenomeCtrl, hint: 'Sobrenome*')),
          ]),
          const SizedBox(height: 12),
          _field(
            ctrl: _model.respTelefoneCtrl,
            hint: 'WhatsApp / Telefone',
            kb: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          _field(
            ctrl: _model.respCpfCtrl,
            hint: 'CPF*',
            kb: TextInputType.number,
            fmt: [FilteringTextInputFormatter.digitsOnly],
            maxLen: 11,
          ),
          const SizedBox(height: 12),
          _pickerButton(
            label: _model.respParentesco ?? 'Parentesco*',
            hasValue: _model.respParentesco != null,
            onTap: _showParentescoSheet,
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────
  // STEP 4 — Contrato / Mensalidade
  // ────────────────────────────────────────────────
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Mensalidade', sub: '*Campos Opcionais'),
          const SizedBox(height: 16),
          _field(
            ctrl: _model.valorCtrl,
            hint: 'Valor (R\$)',
            kb: const TextInputType.numberWithOptions(decimal: true),
            prefix: Text('R\$ ',
                style: TextStyle(
                    color: _primaryText, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 12),
          _pickerButton(
            label: _model.diaPagamento != null
                ? 'Dia ${_model.diaPagamento} de cada mês'
                : 'Dia de pagamento*',
            hasValue: _model.diaPagamento != null,
            onTap: _showDiaPagamentoSheet,
          ),
          const SizedBox(height: 12),
          _datePicker(
            label: _model.vigenciaInicio != null
                ? 'Início: ${_model.vigenciaInicioFmt}'
                : 'Vigência início*',
            hasValue: _model.vigenciaInicio != null,
            onTap: () => _pickMonthYear(
              title: 'Vigência Início',
              initial: _model.vigenciaInicio,
              onPicked: (d) => setState(() => _model.vigenciaInicio = d),
            ),
          ),
          const SizedBox(height: 12),
          _datePicker(
            label: _model.vigenciaFim != null
                ? 'Fim: ${_model.vigenciaFimFmt}'
                : 'Vigência fim*',
            hasValue: _model.vigenciaFim != null,
            onTap: () => _pickMonthYear(
              title: 'Vigência Fim',
              initial: _model.vigenciaFim,
              onPicked: (d) => setState(() => _model.vigenciaFim = d),
            ),
          ),
        ],
      ),
    );
  }

  // ── Shared UI components ─────────────────────────
  Widget _sectionHeader(String title, {String? sub}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                  color: _primaryText)),
        if (sub != null)
          Text(sub,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(), color: _secondaryText)),
      ],
    );
  }

  Widget _field({
    required TextEditingController ctrl,
    required String hint,
    TextInputType? kb,
    List<TextInputFormatter>? fmt,
    int? maxLen,
    TextCapitalization caps = TextCapitalization.words,
    Widget? prefix,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: kb,
      inputFormatters: fmt,
      maxLength: maxLen,
      textCapitalization: caps,
      style: FlutterFlowTheme.of(context)
          .bodyMedium
          .override(font: GoogleFonts.inter(), color: _primaryText),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: FlutterFlowTheme.of(context)
            .bodyMedium
            .override(font: GoogleFonts.inter(), color: _secondaryText),
        prefix: prefix,
        counterText: '',
        filled: true,
        fillColor: _secondBg,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _primary, width: 1.5)),
      ),
    );
  }

  Widget _pickerButton(
      {required String label,
      required bool hasValue,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _secondBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(),
                color: hasValue ? _primaryText : _secondaryText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _datePicker(
      {required String label,
      required bool hasValue,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _secondBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: hasValue ? _primary : Colors.grey.shade200,
              width: hasValue ? 1.5 : 1),
        ),
        child: Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(),
                color: hasValue ? _primary : _secondaryText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _sexoToggle() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: _primary),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _sexoOption('Masculino', true),
          _sexoOption('Feminino', false),
        ],
      ),
    );
  }

  Widget _sexoOption(String label, bool isMasc) {
    final active = _model.sexoMasculino == isMasc;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _model.sexoMasculino = isMasc),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? _primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font:
                      GoogleFonts.inter(fontWeight: FontWeight.w600),
                  color: active ? Colors.white : _primaryText),
          ),
        ),
      ),
    );
  }

  Widget _addButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _primary, width: 1.5),
        ),
        child: Icon(Icons.add_rounded, color: _primary, size: 22),
      ),
    );
  }

  // ── Bottom sheets ────────────────────────────────
  void _showEscolaSheet() {
    _showListSheet(
      titulo: 'Escola',
      opcoes: const [], // lista vazia — endpoint indisponível
      selecionado: _model.escolaNome,
      onSelect: (v) => setState(() => _model.escolaNome = v),
      emptyMsg: 'Use o botão + para adicionar uma escola',
    );
  }

  void _showNovaEscolaSheet() {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nova Escola',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font:
                          GoogleFonts.interTight(fontWeight: FontWeight.w700),
                      color: _primaryText)),
            const SizedBox(height: 16),
            TextFormField(
              controller: ctrl,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(font: GoogleFonts.inter(), color: _primaryText),
              decoration: InputDecoration(
                hintText: 'Nome da escola',
                hintStyle: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(font: GoogleFonts.inter(), color: _secondaryText),
                filled: true,
                fillColor: _secondBg,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primary, width: 1.5)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final nome = ctrl.text.trim();
                if (nome.isEmpty) return;
                setState(() => _model.escolaNome = nome);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('Salvar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _showPeriodoSheet() {
    _showListSheet(
      titulo: 'Período',
      opcoes: PassageiroFormMModel.periodos,
      selecionado: _model.periodo,
      onSelect: (v) => setState(() => _model.periodo = v),
    );
  }

  void _showParentescoSheet() {
    _showListSheet(
      titulo: 'Parentesco',
      opcoes: PassageiroFormMModel.parentescos,
      selecionado: _model.respParentesco,
      onSelect: (v) => setState(() => _model.respParentesco = v),
    );
  }

  void _showDiaPagamentoSheet() {
    int? temp = _model.diaPagamento;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setS) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Dia de Pagamento',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 44,
                  perspective: 0.004,
                  physics: const FixedExtentScrollPhysics(),
                  controller: FixedExtentScrollController(
                      initialItem: (temp ?? 1) - 1),
                  onSelectedItemChanged: (i) => setS(() => temp = i + 1),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 31,
                    builder: (_, i) => Center(
                      child: Text(
                        'Dia ${i + 1}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: temp == i + 1
                              ? FontWeight.w700
                              : FontWeight.normal,
                          color: temp == i + 1 ? _primary : _secondaryText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() => _model.diaPagamento = temp ?? 1);
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text('Confirmar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showListSheet({
    required String titulo,
    required List<String> opcoes,
    required String? selecionado,
    required void Function(String) onSelect,
    String? emptyMsg,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(titulo,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                      color: _primaryText)),
            const SizedBox(height: 12),
            if (opcoes.isEmpty && emptyMsg != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(emptyMsg,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(), color: _secondaryText),
                    textAlign: TextAlign.center),
              ),
            ...opcoes.map((o) => InkWell(
                  onTap: () {
                    onSelect(o);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(o,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                        fontWeight: selecionado == o
                                            ? FontWeight.w700
                                            : FontWeight.normal),
                                    color: selecionado == o
                                        ? _primaryText
                                        : _secondaryText,
                                  )),
                        ),
                        if (selecionado == o)
                          Icon(Icons.check_rounded, color: _primary, size: 20),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // ── Date pickers ─────────────────────────────────
  Future<void> _pickDate({
    required DateTime? initial,
    required DateTime first,
    required DateTime last,
    required void Function(DateTime) onPicked,
  }) async {
    DateTime temp = initial ?? DateTime(2010, 1, 1);
    if (temp.isAfter(last)) temp = last;
    if (temp.isBefore(first)) temp = first;

    await showModalBottomSheet(
      context: context,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: Text('Cancelar',
                      style: TextStyle(
                          color: _primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                Text('Data de Nascimento',
                    style: TextStyle(
                        color: _primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () {
                    onPicked(temp);
                    Navigator.pop(ctx);
                  },
                  child: Text('Selecionar',
                      style: TextStyle(
                          color: _primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          SizedBox(
            height: 220,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: temp,
              minimumDate: first,
              maximumDate: last,
              onDateTimeChanged: (d) => temp = d,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _pickMonthYear({
    required String title,
    required DateTime? initial,
    required void Function(DateTime) onPicked,
  }) async {
    const firstYear = 2020;
    const lastYear = 2040;
    const months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];

    final now = DateTime.now();
    final init = initial ?? now;
    int selMonth = init.month - 1; // 0-based index
    int selYear = init.year.clamp(firstYear, lastYear);

    await showModalBottomSheet(
      context: context,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (_, setS) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Text('Cancelar',
                        style: TextStyle(
                            color: _primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                  Text(title,
                      style: TextStyle(
                          color: _primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () {
                      onPicked(DateTime(selYear, selMonth + 1));
                      Navigator.pop(ctx);
                    },
                    child: Text('Selecionar',
                        style: TextStyle(
                            color: _primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            SizedBox(
              height: 220,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: selMonth),
                      itemExtent: 44,
                      onSelectedItemChanged: (i) => setS(() => selMonth = i),
                      children: months
                          .map((m) => Center(
                              child: Text(m,
                                  style: TextStyle(
                                      color: _primaryText, fontSize: 18))))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: selYear - firstYear),
                      itemExtent: 44,
                      onSelectedItemChanged: (i) =>
                          setS(() => selYear = firstYear + i),
                      children: List.generate(
                        lastYear - firstYear + 1,
                        (i) => Center(
                            child: Text('${firstYear + i}',
                                style: TextStyle(
                                    color: _primaryText, fontSize: 18))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
