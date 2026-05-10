import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../_vivan_http.dart';
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
      await _model.loadEscolas();
      if (widget.passageiroId != null) {
        await _model.carregar(widget.passageiroId!);
      }
      safeSetState(() {});
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

  static const _totalSteps = 3;

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (_model.isEdit) {
      return _buildEditScaffold();
    }
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

  // ────────────────────────────────────────────────
  // EDIT LAYOUT — página única (isEdit == true)
  // ────────────────────────────────────────────────
  Widget _buildEditScaffold() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            children: [
              _buildEditHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader('Passageiro', sub: '*Campos Opcionais'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _field(
                              ctrl: _model.primeiroNomeEditCtrl,
                              hint: 'Nome',
                              caps: TextCapitalization.words,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _field(
                              ctrl: _model.sobrenomeEditCtrl,
                              hint: 'Sobrenome',
                              caps: TextCapitalization.words,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _datePicker(
                        label: _model.dtNascimento != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(_model.dtNascimento!)
                            : 'Data de Nascimento',
                        hasValue: _model.dtNascimento != null,
                        onTap: _pickBirthDate,
                      ),
                      const SizedBox(height: 12),
                      _buildSexoToggle(),
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
                      const SizedBox(height: 24),
                      _sectionHeader('Responsável'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _field(
                              ctrl: _model.respNomeEditCtrl,
                              hint: 'Nome',
                              caps: TextCapitalization.words,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _field(
                              ctrl: _model.respSobrenomeEditCtrl,
                              hint: 'Sobrenome',
                              caps: TextCapitalization.words,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: _field(
                              ctrl: _model.respDddCtrl,
                              hint: 'DDD',
                              kb: TextInputType.phone,
                              maxLen: 3,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _field(
                              ctrl: _model.respTelCtrl,
                              hint: 'Número de telefone',
                              kb: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _field(
                        ctrl: _model.respCpfCtrl,
                        hint: 'CPF',
                        kb: TextInputType.number,
                        fmt: [FilteringTextInputFormatter.digitsOnly],
                        maxLen: 11,
                      ),
                      const SizedBox(height: 32),
                      OutlinedButton(
                        onPressed: _model.isSaving ? null : _onDeletePassageiro,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: FlutterFlowTheme.of(context).error),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: Text(
                          'Apagar Passageiro',
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).error,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              _buildEditBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditHeader() {
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
              child: Text('Editar Passageiro',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildEditBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: ElevatedButton(
        onPressed: _model.isSaving ? null : _onEditSave,
        style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            disabledBackgroundColor: Colors.grey.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 52),
            padding: const EdgeInsets.symmetric(vertical: 14)),
        child: _model.isSaving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : const Text('Salvar',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
      ),
    );
  }

  Future<void> _onEditSave() async {
    setState(() => _model.isSaving = true);
    final ok = await _model.salvar();
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Passageiro atualizado com sucesso!'),
        backgroundColor: _primary,
      ));
      Navigator.pop(context, true);
    } else if (mounted && _model.erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro: ${_model.erro}'),
        backgroundColor: Colors.red.shade400,
      ));
      setState(() => _model.isSaving = false);
    }
  }

  Future<void> _onDeletePassageiro() async {
    final nome = _model.nomeCtrl.text.trim();

    final confirm = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _ConfirmDeletePassageiroPage(nomePassageiro: nome),
      ),
    );

    if (confirm == true && mounted) {
      setState(() => _model.isSaving = true);
      final ok = await _model.deletar();
      if (ok && mounted) {
        Navigator.pop(context, 'deleted');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro ao apagar: ${_model.erro}'),
          backgroundColor: Colors.red.shade400,
        ));
        setState(() => _model.isSaving = false);
      }
    }
  }

  Widget _buildSexoToggle() {
    return Row(
      children: [
        Expanded(child: _sexoButton('Masculino', 'MASCULINO')),
        const SizedBox(width: 8),
        Expanded(child: _sexoButton('Feminino', 'FEMININO')),
      ],
    );
  }

  Widget _sexoButton(String label, String value) {
    final selected = _model.sexo == value;
    return GestureDetector(
      onTap: () => setState(() => _model.sexo = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? _primary : _secondBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? _primary : Colors.grey.shade200),
        ),
        child: Center(
          child: Text(label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal),
                    color: selected ? Colors.white : _secondaryText)),
        ),
      ),
    );
  }

  Future<void> _pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _model.dtNascimento ?? DateTime(2010),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _model.dtNascimento = picked);
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
              color: done || current ? _primary : Colors.grey.shade300,
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
      // Ao avançar do step 0 (passageiro) para o step 1 (responsável),
      // pré-preencher o nome do responsável com o nome do aluno
      if (_model.step == 0 && _model.respNomeCtrl.text.trim().isEmpty) {
        _model.respNomeCtrl.text = _model.nomeCtrl.text.trim();
      }
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
          _sectionHeader('Passageiro'),
          const SizedBox(height: 16),
          _field(
            ctrl: _model.nomeCtrl,
            hint: 'Nome completo',
            caps: TextCapitalization.words,
          ),
          const SizedBox(height: 24),
          _sectionHeader('Informações Escolares', sub: 'Opcional'),
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
  // STEP 2 — Responsável
  // ────────────────────────────────────────────────
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Responsável', sub: 'Opcional'),
          const SizedBox(height: 16),
          _field(
            ctrl: _model.respNomeCtrl,
            hint: 'Nome completo',
            caps: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          _field(
            ctrl: _model.respWhatsappCtrl,
            hint: 'WhatsApp',
            kb: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          _field(
            ctrl: _model.respCpfCtrl,
            hint: 'CPF',
            kb: TextInputType.number,
            fmt: [FilteringTextInputFormatter.digitsOnly],
            maxLen: 11,
          ),
          const SizedBox(height: 16),
          Text(
            'Preencha nome, WhatsApp e CPF para vincular um responsável.',
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  font: GoogleFonts.inter(), color: _secondaryText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────
  // STEP 3 — Contrato / Mensalidade
  // ────────────────────────────────────────────────
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Mensalidade', sub: 'Opcional'),
          const SizedBox(height: 16),
          _field(
            ctrl: _model.valorCtrl,
            hint: 'Valor',
            kb: const TextInputType.numberWithOptions(decimal: true),
            prefix: Text('R\$ ',
                style: TextStyle(
                    color: _primaryText, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 12),
          _pickerButton(
            label: _model.diaPagamento != null
                ? 'Dia ${_model.diaPagamento} de cada mês'
                : 'Dia de pagamento',
            hasValue: _model.diaPagamento != null,
            onTap: _showDiaPagamentoSheet,
          ),
          const SizedBox(height: 12),
          _datePicker(
            label: _model.vigenciaInicio != null
                ? 'Início: ${_model.vigenciaInicioFmt}'
                : 'Vigência início',
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
                : 'Vigência fim',
            hasValue: _model.vigenciaFim != null,
            onTap: () => _pickMonthYear(
              title: 'Vigência Fim',
              initial: _model.vigenciaFim,
              onPicked: (d) => setState(() => _model.vigenciaFim = d),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'As mensalidades serão geradas automaticamente ao salvar.',
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  font: GoogleFonts.inter(), color: _secondaryText),
            textAlign: TextAlign.center,
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
      opcoes: _model.escolas,
      selecionado: _model.escolaNome,
      onSelect: (v) => setState(() => _model.setEscolaNome(v)),
      emptyMsg: 'Use o botão + para adicionar uma escola',
    );
  }

  void _showNovaEscolaSheet() {
    final ctrl = TextEditingController();
    bool isSaving = false;
    String? erro;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.fromLTRB(
              24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nova Escola',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
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
              if (erro != null) ...[
                const SizedBox(height: 8),
                Text(erro!, style: GoogleFonts.inter(fontSize: 13, color: Colors.red)),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        final nome = ctrl.text.trim();
                        if (nome.isEmpty) return;
                        setSheet(() { isSaving = true; erro = null; });
                        try {
                          await VivanHttp.post('/escolas', {'nomeEscola': nome});
                          await _model.loadEscolas();
                          if (ctx.mounted) Navigator.pop(ctx);
                          setState(() => _model.setEscolaNome(nome));
                        } catch (e) {
                          setSheet(() {
                            isSaving = false;
                            erro = e.toString().replaceFirst('Exception: ', '');
                          });
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: isSaving
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Salvar',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
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
                        font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                        color: _primaryText)),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 44,
                  perspective: 0.004,
                  physics: const FixedExtentScrollPhysics(),
                  controller:
                      FixedExtentScrollController(initialItem: (temp ?? 1) - 1),
                  onSelectedItemChanged: (i) => setS(() => temp = i + 1),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 28, // máx 28 para evitar problemas com meses curtos (REGRAS)
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
    int selMonth = init.month - 1;
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
                      scrollController:
                          FixedExtentScrollController(initialItem: selMonth),
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

// ─────────────────────────────────────────────────────────────
// Tela fullscreen de confirmação de exclusão de passageiro
// ─────────────────────────────────────────────────────────────
class _ConfirmDeletePassageiroPage extends StatelessWidget {
  const _ConfirmDeletePassageiroPage({required this.nomePassageiro});

  final String nomePassageiro;

  static const _bullets = [
    'O passageiro não ficará mais visível na lista de passageiros.',
    'As mensalidades pendentes e em atraso serão canceladas automaticamente.',
    'Somente as mensalidades já pagas ou abonadas serão mantidas no histórico.',
    'Não será possível reativar este passageiro — será necessário cadastrá-lo novamente.',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final primary = theme.primary;
    final bg = theme.primaryBackground;
    final primaryText = theme.primaryText;
    final secondaryText = theme.secondaryText;
    final error = theme.error;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: bg,
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Text(
                      'Voltar',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                            color: primary),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Apagar Passageiro',
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                              font: GoogleFonts.interTight(
                                  fontWeight: FontWeight.w700),
                              color: primaryText),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  children: [
                    // Icon with red badge
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            size: 56,
                            color: primary.withValues(alpha: 0.5),
                          ),
                        ),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: error,
                          child: const Icon(Icons.remove,
                              color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      'Tem certeza que deseja apagar o(a) passageiro(a)',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.interTight(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: primaryText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '"$nomePassageiro"?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.interTight(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: error),
                    ),
                    const SizedBox(height: 28),
                    // Warning label
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Leia com atenção:',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: secondaryText),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Bullets
                    ..._bullets.map((text) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                  color: Colors.orange.shade600, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  text,
                                  style: GoogleFonts.inter(
                                      fontSize: 14, color: primaryText),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            // Footer — Apagar button
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                color: bg,
                border: Border(top: BorderSide(color: Colors.grey.shade100)),
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: error,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Apagar',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
