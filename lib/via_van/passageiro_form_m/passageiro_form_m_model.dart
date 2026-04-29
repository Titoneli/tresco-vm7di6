import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../_vivan_http.dart';
import 'passageiro_form_m_widget.dart' show PassageiroFormMWidget;

class PassageiroFormMModel extends FlutterFlowModel<PassageiroFormMWidget> {
  final pageCtrl = PageController();
  int step = 0;
  bool isSaving = false;
  String? erro;

  // ── Step 1 — Passageiro ──────────────────────────
  final nomeCtrl = TextEditingController();
  final sobrenomeCtrl = TextEditingController();
  DateTime? dataNascimento;
  bool? sexoMasculino;
  String? escolaNome;
  String? periodo;

  static const periodos = ['Integral', 'Manhã', 'Almoço', 'Tarde', 'Noite'];

  String get dataNascimentoFmt => dataNascimento != null
      ? DateFormat('dd/MM/yyyy').format(dataNascimento!)
      : '';

  // ── Step 2 — Endereço ────────────────────────────
  final cepCtrl = TextEditingController();
  final logradouroCtrl = TextEditingController();
  final numeroCtrl = TextEditingController();
  final complementoCtrl = TextEditingController();
  final bairroCtrl = TextEditingController();
  final cidadeCtrl = TextEditingController();
  final ufCtrl = TextEditingController();

  // ── Step 3 — Responsável ─────────────────────────
  final respNomeCtrl = TextEditingController();
  final respSobrenomeCtrl = TextEditingController();
  final respWhatsappCtrl = TextEditingController();
  final respEmailCtrl = TextEditingController();
  final respCpfCtrl = TextEditingController();
  String? respParentesco;

  static const parentescos = [
    'Pai', 'Mãe', 'Avô', 'Avó', 'Tio(a)',
    'Irmão(ã)', 'Padrasto', 'Madrasta', 'Responsável Legal', 'Outro',
  ];

  // ── Step 4 — Contrato ────────────────────────────
  final valorCtrl = TextEditingController();
  int? diaPagamento;
  DateTime? vigenciaInicio;
  DateTime? vigenciaFim;

  String get vigenciaInicioFmt => vigenciaInicio != null
      ? DateFormat('MM/yyyy').format(vigenciaInicio!)
      : '';
  String get vigenciaFimFmt =>
      vigenciaFim != null ? DateFormat('MM/yyyy').format(vigenciaFim!) : '';

  // ── IDs modo edição ──────────────────────────────
  int? passageiroId;
  int? _responsavelId;
  int? _contratoId;

  bool get isEdit => passageiroId != null;

  // ── Carregar para edição ─────────────────────────
  Future<void> carregar(int id) async {
    passageiroId = id;
    try {
      final json = await VivanHttp.get('/passageiros/$id');
      final p = json as Map<String, dynamic>;
      final partes = (p['nomePassageiro'] as String? ?? '').split(' ');
      nomeCtrl.text = partes.first;
      sobrenomeCtrl.text =
          partes.length > 1 ? partes.sublist(1).join(' ') : '';
      final dtn = p['dtNascimento'] as String?;
      if (dtn != null && dtn.isNotEmpty) {
        try { dataNascimento = DateTime.parse(dtn); } catch (_) {}
      }
      final sexo = p['sexo'] as String?;
      if (sexo == 'M') sexoMasculino = true;
      if (sexo == 'F') sexoMasculino = false;
      escolaNome = p['nomeEscola'] as String?;
      periodo = p['periodo'] as String?;
      cepCtrl.text = p['cep'] as String? ?? '';
      logradouroCtrl.text = p['logradouro'] as String? ?? '';
      numeroCtrl.text = p['numero'] as String? ?? '';
      complementoCtrl.text = p['complemento'] as String? ?? '';
      bairroCtrl.text = p['bairro'] as String? ?? '';
      cidadeCtrl.text = p['cidade'] as String? ?? '';
      ufCtrl.text = p['uf'] as String? ?? '';
    } catch (e) {
      debugPrint('PassageiroForm.carregar: $e');
    }
  }

  // ── Salvar ───────────────────────────────────────
  Future<bool> salvar() async {
    isSaving = true;
    erro = null;
    try {
      final nome =
          '${nomeCtrl.text.trim()} ${sobrenomeCtrl.text.trim()}'.trim();

      final endParts = <String>[
        if (logradouroCtrl.text.isNotEmpty) logradouroCtrl.text.trim(),
        if (numeroCtrl.text.isNotEmpty) numeroCtrl.text.trim(),
        if (complementoCtrl.text.isNotEmpty) complementoCtrl.text.trim(),
        if (bairroCtrl.text.isNotEmpty) bairroCtrl.text.trim(),
        if (cidadeCtrl.text.isNotEmpty) cidadeCtrl.text.trim(),
        if (ufCtrl.text.isNotEmpty) ufCtrl.text.trim(),
      ];

      final body = <String, dynamic>{
        'nomePassageiro': nome,
        'dtNascimento': (dataNascimento ?? DateTime(2000, 1, 1)).toIso8601String(),
        'endPassageiro': endParts.isNotEmpty ? endParts.join(', ') : 'Não informado',
        if (sexoMasculino != null) 'sexo': sexoMasculino! ? 'M' : 'F',
        if (escolaNome?.isNotEmpty == true) 'nomeEscola': escolaNome,
        if (periodo != null) 'periodo': periodo,
        if (cepCtrl.text.isNotEmpty) 'cepPassageiro': cepCtrl.text.trim(),
        if (numeroCtrl.text.isNotEmpty) 'numPassageiro': numeroCtrl.text.trim(),
        if (complementoCtrl.text.isNotEmpty) 'compPassageiro': complementoCtrl.text.trim(),
        if (bairroCtrl.text.isNotEmpty) 'bairroPassageiro': bairroCtrl.text.trim(),
        if (cidadeCtrl.text.isNotEmpty) 'cidadePassageiro': cidadeCtrl.text.trim(),
        if (ufCtrl.text.isNotEmpty) 'ufPassageiro': ufCtrl.text.trim(),
      };

      dynamic savedP;
      if (isEdit) {
        savedP = await VivanHttp.put('/passageiros/$passageiroId', body);
      } else {
        savedP = await VivanHttp.post('/passageiros', body);
        passageiroId =
            int.tryParse((savedP as Map)['idPassageiro']?.toString() ?? '');
      }

      // Responsável — todos os 5 campos são obrigatórios na API
      final respNome = '${respNomeCtrl.text.trim()} ${respSobrenomeCtrl.text.trim()}'.trim();
      final respCpf = respCpfCtrl.text.trim();
      final respWpp = respWhatsappCtrl.text.trim();
      final respEmail = respEmailCtrl.text.trim();
      if (passageiroId != null &&
          respNome.isNotEmpty &&
          respCpf.isNotEmpty &&
          respParentesco != null &&
          respWpp.isNotEmpty &&
          respEmail.isNotEmpty) {
        final rBody = <String, dynamic>{
          'nomeResponsavel': respNome,
          'cpfResponsavel': respCpf,
          'parentesco': respParentesco,
          'whatsAppResponsavel': respWpp,
          'emailResponsavel': respEmail,
        };
        try {
          if (_responsavelId != null) {
            await VivanHttp.put(
                '/passageiros/$passageiroId/responsaveis/$_responsavelId',
                rBody);
          } else {
            final r = await VivanHttp.post(
                '/passageiros/$passageiroId/responsaveis', rBody);
            if (r is Map) {
              _responsavelId =
                  int.tryParse(r['idResponsavel']?.toString() ?? '');
            }
          }
        } catch (e) {
          debugPrint('PassageiroForm.responsavel: $e');
        }
      }

      // Contrato — endpoint pode estar indisponível no servidor
      if (passageiroId != null && valorCtrl.text.trim().isNotEmpty) {
        final valor =
            double.tryParse(valorCtrl.text.replaceAll(',', '.')) ?? 0;
        final cBody = <String, dynamic>{
          'valorMensalidade': valor,
          if (diaPagamento != null) 'diaPagamento': diaPagamento,
          if (vigenciaInicio != null)
            'vigenciaInicio': DateFormat('yyyy-MM').format(vigenciaInicio!),
          if (vigenciaFim != null)
            'vigenciaFim': DateFormat('yyyy-MM').format(vigenciaFim!),
        };
        try {
          if (_contratoId != null) {
            await VivanHttp.put(
                '/passageiros/$passageiroId/contratos/$_contratoId', cBody);
          } else {
            final c = await VivanHttp.post(
                '/passageiros/$passageiroId/contratos', cBody);
            if (c is Map) {
              _contratoId = int.tryParse(c['idContrato']?.toString() ?? '');
            }
          }
        } catch (e) {
          debugPrint('PassageiroForm.contrato: $e');
        }
      }

      isSaving = false;
      return true;
    } catch (e) {
      debugPrint('PassageiroForm.salvar: $e');
      erro = e.toString();
      isSaving = false;
      return false;
    }
  }

  @override
  void initState(BuildContext context) {
    // pageCtrl inicializado inline no widget
  }

  @override
  void dispose() {
    pageCtrl.dispose();
    nomeCtrl.dispose();
    sobrenomeCtrl.dispose();
    cepCtrl.dispose();
    logradouroCtrl.dispose();
    numeroCtrl.dispose();
    complementoCtrl.dispose();
    bairroCtrl.dispose();
    cidadeCtrl.dispose();
    ufCtrl.dispose();
    respNomeCtrl.dispose();
    respSobrenomeCtrl.dispose();
    respWhatsappCtrl.dispose();
    respEmailCtrl.dispose();
    respCpfCtrl.dispose();
    valorCtrl.dispose();
  }
}
