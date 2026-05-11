import 'dart:ui' as ui;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import '/via_van/clausulas_contrato_m/clausula_storage.dart';

class GerarContratoMWidget extends StatefulWidget {
  const GerarContratoMWidget({
    super.key,
    required this.passageiroId,
    required this.nomePassageiro,
  });

  final int passageiroId;
  final String nomePassageiro;

  @override
  State<GerarContratoMWidget> createState() => _GerarContratoMWidgetState();
}

class _GerarContratoMWidgetState extends State<GerarContratoMWidget> {
  int _step = 0;
  bool _isLoading = true;
  bool _isSaving = false;
  int? _contratoId;

  // Step 1 — Motorista
  final _nomeMotoristaCtrl = TextEditingController();
  final _cpfMotoristaCtrl = TextEditingController();
  final _telMotoristaCtrl = TextEditingController();

  // Step 2 — Passageiro
  final _nomePassCtrl = TextEditingController();
  final _ufCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final _enderecoCtrl = TextEditingController();
  final _numeroCtrl = TextEditingController();
  final _complementoCtrl = TextEditingController();
  String? _escolaNome;
  String? _serieAno;
  String? _periodo;
  String? _tipoViagem;

  // Step 3 — Responsável
  final _nomeRespCtrl = TextEditingController();
  final _cpfRespCtrl = TextEditingController();
  final _telRespCtrl = TextEditingController();
  String? _parentesco;

  // Step 4 — Financeiro
  DateTime? _vigenciaInicio;
  DateTime? _vigenciaFim;
  final _valorCtrl = TextEditingController();
  final _diaVencCtrl = TextEditingController();
  final _valorTotalCtrl = TextEditingController();
  final _jurosMultaCtrl = TextEditingController();
  final _jurosMesCtrl = TextEditingController();

  // Step 5 — Assinatura
  final List<Offset?> _points = [];
  final _scrollController = ScrollController();
  bool _isDrawing = false;

  VivanResponsavel? _responsavel;

  static const _series = [
    '1º Ano', '2º Ano', '3º Ano', '4º Ano', '5º Ano',
    '6º Ano', '7º Ano', '8º Ano', '9º Ano',
    '1ª Série EM', '2ª Série EM', '3ª Série EM',
  ];

  static const _periodos = ['Integral', 'Manhã', 'Tarde', 'Noite'];

  static const _tiposViagem = ['Apenas Ida', 'Apenas Volta', 'Ida e Volta'];

  static const _parentescos = [
    'Pai', 'Mãe', 'Avô', 'Avó', 'Tio', 'Tia', 'Responsável Legal', 'Outro',
  ];

  static const _ufs = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO',
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI',
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO',
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final appState = FFAppState();
      _nomeMotoristaCtrl.text = appState.nomeUsuario;
      await _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      final p = await VivanLocator.service.getPassageiro(widget.passageiroId);
      final resps =
          await VivanLocator.service.getResponsaveis(widget.passageiroId);
      if (mounted) {
        setState(() {
          _responsavel = resps.isNotEmpty ? resps.first : null;
          _prefillPassageiro(p);
          if (_responsavel != null) _prefillResponsavel(_responsavel!);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _prefillPassageiro(VivanPassageiro p) {
    _nomePassCtrl.text = p.nomePassageiro;
    _ufCtrl.text = p.ufPassageiro ?? '';
    _cidadeCtrl.text = p.cidadePassageiro ?? '';
    _enderecoCtrl.text = p.endPassageiro;
    _numeroCtrl.text = p.numPassageiro ?? '';
    _complementoCtrl.text = p.compPassageiro ?? '';
    _escolaNome = p.nomeEscola;
    _periodo = p.domTurno;
  }

  void _prefillResponsavel(VivanResponsavel r) {
    _nomeRespCtrl.text = r.nomeResponsavel;
    _cpfRespCtrl.text = r.cpfResponsavel;
    _telRespCtrl.text = r.whatsAppResponsavel;
    _parentesco = r.parentesco.isNotEmpty ? r.parentesco : null;
  }

  @override
  void dispose() {
    _nomeMotoristaCtrl.dispose();
    _cpfMotoristaCtrl.dispose();
    _telMotoristaCtrl.dispose();
    _nomePassCtrl.dispose();
    _ufCtrl.dispose();
    _cidadeCtrl.dispose();
    _enderecoCtrl.dispose();
    _numeroCtrl.dispose();
    _complementoCtrl.dispose();
    _nomeRespCtrl.dispose();
    _cpfRespCtrl.dispose();
    _telRespCtrl.dispose();
    _valorCtrl.dispose();
    _diaVencCtrl.dispose();
    _valorTotalCtrl.dispose();
    _jurosMultaCtrl.dispose();
    _jurosMesCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _secondBg => FlutterFlowTheme.of(context).secondaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(color: _primary))
              : Column(
                  children: [
                    _buildHeader(),
                    _buildStepIndicator(),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: _isDrawing ? const NeverScrollableScrollPhysics() : null,
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
                        child: _buildCurrentStep(),
                      ),
                    ),
                    _buildBottomBar(),
                  ],
                ),
        ),
      ),
    );
  }

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
            onTap: () {
              if (_step > 0) {
                setState(() => _step--);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text('Voltar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      color: _primary)),
          ),
          Expanded(
            child: Center(
              child: Text('Gerar Contrato',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final labels = ['Motorista', 'Passageiro', 'Responsável', 'Financeiro', 'Assinatura'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(5, (i) {
          final active = i == _step;
          final done = i < _step;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: done || active
                              ? _primary
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(labels[i],
                          style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: active
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                              color: active ? _primary : _secondaryText)),
                    ],
                  ),
                ),
                if (i < 4) const SizedBox(width: 4),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildStep5();
      default:
        return const SizedBox.shrink();
    }
  }

  // ── Step 1: Motorista ─────────────────────────────
  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Suas informações'),
        const SizedBox(height: 16),
        _field(ctrl: _nomeMotoristaCtrl, hint: 'Nome completo'),
        const SizedBox(height: 12),
        _field(
            ctrl: _cpfMotoristaCtrl,
            hint: 'CPF',
            kb: TextInputType.number,
            fmt: [FilteringTextInputFormatter.digitsOnly]),
        const SizedBox(height: 12),
        _field(
            ctrl: _telMotoristaCtrl,
            hint: 'Telefone / WhatsApp',
            kb: TextInputType.phone),
      ],
    );
  }

  // ── Step 2: Passageiro ────────────────────────────
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Informações do Passageiro'),
        const SizedBox(height: 16),
        _field(ctrl: _nomePassCtrl, hint: 'Nome completo'),
        const SizedBox(height: 12),
        _pickerBtn(
          label: _ufCtrl.text.isNotEmpty ? _ufCtrl.text : 'Estado (UF)',
          hasValue: _ufCtrl.text.isNotEmpty,
          onTap: () => _showListPicker(
            title: 'Estado',
            options: _ufs,
            selected: _ufCtrl.text.isNotEmpty ? _ufCtrl.text : null,
            onSelect: (v) => setState(() => _ufCtrl.text = v),
          ),
        ),
        const SizedBox(height: 12),
        _field(ctrl: _cidadeCtrl, hint: 'Cidade'),
        const SizedBox(height: 12),
        _field(ctrl: _enderecoCtrl, hint: 'Endereço'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _field(ctrl: _numeroCtrl, hint: 'Número', kb: TextInputType.number)),
            const SizedBox(width: 8),
            Expanded(child: _field(ctrl: _complementoCtrl, hint: 'Complemento')),
          ],
        ),
        const SizedBox(height: 12),
        _pickerBtn(
          label: _escolaNome ?? 'Escola',
          hasValue: _escolaNome != null,
          onTap: () => _showTextInputPicker(
            title: 'Escola',
            initial: _escolaNome,
            onConfirm: (v) => setState(() => _escolaNome = v),
          ),
        ),
        const SizedBox(height: 12),
        _pickerBtn(
          label: _serieAno ?? 'Série / Ano',
          hasValue: _serieAno != null,
          onTap: () => _showListPicker(
            title: 'Série / Ano',
            options: _series,
            selected: _serieAno,
            onSelect: (v) => setState(() => _serieAno = v),
          ),
        ),
        const SizedBox(height: 12),
        _pickerBtn(
          label: _periodo ?? 'Período',
          hasValue: _periodo != null,
          onTap: () => _showListPicker(
            title: 'Período',
            options: _periodos,
            selected: _periodo,
            onSelect: (v) => setState(() => _periodo = v),
          ),
        ),
        const SizedBox(height: 12),
        _pickerBtn(
          label: _tipoViagem ?? 'Tipo de Viagem',
          hasValue: _tipoViagem != null,
          onTap: () => _showListPicker(
            title: 'Tipo de Viagem',
            options: _tiposViagem,
            selected: _tipoViagem,
            onSelect: (v) => setState(() => _tipoViagem = v),
          ),
        ),
      ],
    );
  }

  // ── Step 3: Responsável ───────────────────────────
  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Informações do Responsável'),
        const SizedBox(height: 16),
        _field(ctrl: _nomeRespCtrl, hint: 'Nome completo'),
        const SizedBox(height: 12),
        _field(
            ctrl: _cpfRespCtrl,
            hint: 'CPF',
            kb: TextInputType.number,
            fmt: [FilteringTextInputFormatter.digitsOnly]),
        const SizedBox(height: 12),
        _field(
            ctrl: _telRespCtrl, hint: 'WhatsApp', kb: TextInputType.phone),
        const SizedBox(height: 12),
        _pickerBtn(
          label: _parentesco ?? 'Parentesco',
          hasValue: _parentesco != null,
          onTap: () => _showListPicker(
            title: 'Parentesco',
            options: _parentescos,
            selected: _parentesco,
            onSelect: (v) => setState(() => _parentesco = v),
          ),
        ),
      ],
    );
  }

  // ── Step 4: Financeiro ────────────────────────────
  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Informações Financeiras'),
        const SizedBox(height: 16),
        _datePickerBtn(
          'Mês primeira parcela',
          _vigenciaInicio,
          (d) => setState(() => _vigenciaInicio = d),
        ),
        const SizedBox(height: 12),
        _datePickerBtn(
          'Mês última parcela',
          _vigenciaFim,
          (d) => setState(() => _vigenciaFim = d),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
                child: _field(
                    ctrl: _valorCtrl,
                    hint: 'R\$ valor mensal',
                    kb: const TextInputType.numberWithOptions(decimal: true))),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: _field(
                  ctrl: _diaVencCtrl,
                  hint: 'Dia venc.',
                  kb: TextInputType.number,
                  fmt: [FilteringTextInputFormatter.digitsOnly]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _field(
            ctrl: _valorTotalCtrl,
            hint: 'Valor total do contrato',
            kb: const TextInputType.numberWithOptions(decimal: true)),
        const SizedBox(height: 12),
        _field(ctrl: _jurosMultaCtrl, hint: 'Juros por quebra (%)'),
        const SizedBox(height: 4),
        Text(
          'O juros de multa por rescisão de contrato incide sobre o valor total restante do contrato.',
          style: GoogleFonts.inter(fontSize: 12, color: _secondaryText),
        ),
        const SizedBox(height: 12),
        _field(ctrl: _jurosMesCtrl, hint: 'Juros ao mês (%)'),
        const SizedBox(height: 4),
        Text(
          'O juros por atraso no pagamento de mensalidade incide sobre o valor da parcela em atraso.',
          style: GoogleFonts.inter(fontSize: 12, color: _secondaryText),
        ),
      ],
    );
  }

  // ── Step 5: Assinatura ────────────────────────────
  Widget _buildStep5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Assinatura'),
        const SizedBox(height: 12),
        Text(
          'Desenhe abaixo a assinatura que será usada no contrato.',
          style: GoogleFonts.inter(fontSize: 14, color: _secondaryText),
        ),
        const SizedBox(height: 16),
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _secondBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown:   (_) => setState(() => _isDrawing = true),
              onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
              onPanEnd:    (_) => setState(() { _points.add(null); _isDrawing = false; }),
              onPanCancel: ()  => setState(() => _isDrawing = false),
              child: CustomPaint(
                painter: _SignaturePainter(_points, _primary),
                child: Container(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => setState(() => _points.clear()),
            style: OutlinedButton.styleFrom(
              foregroundColor: _primaryText,
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Limpar Assinatura',
                style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Ao gerar o contrato, você poderá compartilhar o link com o responsável para assinatura digital.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 12, color: _secondaryText),
        ),
      ],
    );
  }

  // ── Bottom bar ────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          if (_step > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _step--),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _primaryText,
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  minimumSize: const Size(double.infinity, 52),
                ),
                child: Text('Voltar',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _onPrimaryAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                minimumSize: const Size(double.infinity, 52),
              ),
              child: _isSaving
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : Text(_step < 4 ? 'Avançar' : 'Gerar contrato',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  void _onPrimaryAction() {
    if (_step < 4) {
      setState(() => _step++);
    } else {
      _gerarContrato();
    }
  }

  Future<void> _gerarContrato() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    try {
      // Captura e salva a assinatura do motorista (reutilizada em todos os contratos)
      if (_points.isNotEmpty) {
        await _salvarAssinatura();
      }

      // Só cria o contrato se ainda não foi criado (evita duplicata em retry)
      if (_contratoId == null) {
        final valor =
            double.tryParse(_valorCtrl.text.replaceAll(',', '.')) ?? 0;
        final diaVenc = int.tryParse(_diaVencCtrl.text) ?? 5;
        final agora = DateTime.now();
        final inicio = _vigenciaInicio ?? agora;
        final fim    = _vigenciaFim    ?? DateTime(agora.year, 12, 31);
        final c = VivanContrato(
          idMotorista: FFAppState().idUsuario,
          idPassageiro: widget.passageiroId,
          idResponsavel: _responsavel?.idResponsavel,
          valMensal: valor,
          diaVencimento: diaVenc,
          dtInicio: DateFormat('yyyy-MM-dd').format(inicio),
          dtTermino: DateFormat('yyyy-MM-dd').format(fim),
          percentualMulta: double.tryParse(
                  _jurosMultaCtrl.text.replaceAll(',', '.').replaceAll('%', '')) ??
              2.0,
          percentualJurosDia: double.tryParse(
                  _jurosMesCtrl.text.replaceAll(',', '.').replaceAll('%', '')) ??
              0.0333,
          domFormaPagamento: 'OUTROS',
          domCondicaoPagamento: 'Mensal',
          status: 'RASCUNHO',
        );
        final criado = await VivanLocator.service.createContrato(c);
        _contratoId = criado.idContrato;
      }
      await VivanLocator.service.ativarContrato(_contratoId!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Contrato gerado e ativado com sucesso!'),
              backgroundColor: Color(0xFF2F8D2F)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro ao criar contrato: $e'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _salvarAssinatura() async {
    try {
      // Bounding box dos pontos para recortar a área utilizada
      double minX = double.infinity, minY = double.infinity;
      double maxX = double.negativeInfinity, maxY = double.negativeInfinity;
      for (final p in _points) {
        if (p == null) continue;
        if (p.dx < minX) minX = p.dx;
        if (p.dy < minY) minY = p.dy;
        if (p.dx > maxX) maxX = p.dx;
        if (p.dy > maxY) maxY = p.dy;
      }
      // Fallback para tamanho fixo se só um ponto
      if (minX == maxX) { minX -= 1; maxX += 1; }
      if (minY == maxY) { minY -= 1; maxY += 1; }

      const padding = 8.0;
      final width = (maxX - minX + padding * 2).ceilToDouble();
      final height = (maxY - minY + padding * 2).ceilToDouble();

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
          recorder,
          Rect.fromLTWH(0, 0, width, height));

      // Fundo branco
      canvas.drawRect(
          Rect.fromLTWH(0, 0, width, height),
          Paint()..color = Colors.white);

      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final offsetX = -minX + padding;
      final offsetY = -minY + padding;

      for (int i = 0; i < _points.length - 1; i++) {
        if (_points[i] != null && _points[i + 1] != null) {
          canvas.drawLine(
            _points[i]!.translate(offsetX, offsetY),
            _points[i + 1]!.translate(offsetX, offsetY),
            paint,
          );
        }
      }

      final img = await recorder
          .endRecording()
          .toImage(width.toInt(), height.toInt());
      final data = await img.toByteData(format: ui.ImageByteFormat.png);
      if (data != null) {
        await SignatureStorage.save(data.buffer.asUint8List());
      }
    } catch (e) {
      debugPrint('_salvarAssinatura: $e');
    }
  }

  // ── Common helpers ────────────────────────────────
  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.interTight(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _primaryText),
    );
  }

  Widget _field({
    required TextEditingController ctrl,
    required String hint,
    TextInputType? kb,
    List<TextInputFormatter>? fmt,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: kb,
      inputFormatters: fmt,
      style: FlutterFlowTheme.of(context)
          .bodyMedium
          .override(font: GoogleFonts.inter(), color: _primaryText),
      decoration: InputDecoration(
        hintText: hint,
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
    );
  }

  Widget _pickerBtn({
    required String label,
    required bool hasValue,
    required VoidCallback onTap,
  }) {
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
            width: hasValue ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(),
                color: hasValue ? _primaryText : _secondaryText),
        ),
      ),
    );
  }

  Widget _datePickerBtn(
    String label,
    DateTime? value,
    void Function(DateTime) onPicked,
  ) {
    final display = value != null
        ? DateFormat('MMMM yyyy', 'pt_BR').format(value)
        : label;
    return GestureDetector(
      onTap: () => _pickMonthYear(
        title: label,
        initial: value,
        onPicked: onPicked,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _secondBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value != null ? _primary : Colors.grey.shade200,
            width: value != null ? 1.5 : 1,
          ),
        ),
        child: Text(
          display,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(),
                color: value != null ? _primary : _secondaryText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // ── Month/Year picker ─────────────────────────────
  Future<void> _pickMonthYear({
    required String title,
    required DateTime? initial,
    required void Function(DateTime) onPicked,
  }) async {
    const firstYear = 2020;
    const lastYear = 2040;
    const months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      onSelectedItemChanged: (i) =>
                          setS(() => selMonth = i),
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

  // ── List picker bottom sheet ──────────────────────
  void _showListPicker({
    required String title,
    required List<String> options,
    required String? selected,
    required void Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _bg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        maxChildSize: 0.85,
        builder: (_, scrollCtrl) => Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Text('Cancelar',
                        style:
                            TextStyle(color: _primary, fontSize: 16)),
                  ),
                  Text(title,
                      style: TextStyle(
                          color: _primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 60),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                itemCount: options.length,
                itemBuilder: (_, i) {
                  final opt = options[i];
                  final isSelected = opt == selected;
                  return ListTile(
                    title: Text(opt,
                        style: GoogleFonts.inter(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color:
                                isSelected ? _primary : _primaryText)),
                    trailing: isSelected
                        ? Icon(Icons.check, color: _primary)
                        : null,
                    onTap: () {
                      onSelect(opt);
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Text input picker ─────────────────────────────
  void _showTextInputPicker({
    required String title,
    required String? initial,
    required void Function(String) onConfirm,
  }) {
    final ctrl = TextEditingController(text: initial ?? '');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: GoogleFonts.interTight(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _primaryText)),
            const SizedBox(height: 16),
            TextFormField(
              controller: ctrl,
              autofocus: true,
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(font: GoogleFonts.inter(), color: _primaryText),
              decoration: InputDecoration(
                hintText: title,
                hintStyle: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(
                        font: GoogleFonts.inter(), color: _secondaryText),
                filled: true,
                fillColor: _secondBg,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: _primary, width: 1.5)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final v = ctrl.text.trim();
                if (v.isNotEmpty) {
                  onConfirm(v);
                  Navigator.pop(ctx);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Confirmar',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Signature painter ─────────────────────────────────────────────────────────
class _SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;

  _SignaturePainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SignaturePainter oldDelegate) => true;
}
