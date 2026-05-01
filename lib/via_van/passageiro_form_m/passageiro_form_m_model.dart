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
  final nomeCtrl = TextEditingController(); // nome completo (wizard)
  String? escolaNome;
  String? periodo;
  List<String> escolas = [];

  Future<void> loadEscolas() async {
    try {
      final res = await VivanHttp.get('/escolas');
      final lista = res is List ? res : (res is Map ? (res['data'] ?? []) : []);
      escolas = (lista as List)
          .map((e) => (e as Map)['nomeEscola']?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    } catch (e) {
      debugPrint('PassageiroForm.loadEscolas: $e');
    }
  }

  static const periodos = ['Integral', 'Manhã', 'Almoço', 'Tarde', 'Noite'];

  // ── Step 2 — Responsável (wizard) ────────────────
  final respNomeCtrl = TextEditingController();
  final respWhatsappCtrl = TextEditingController();
  final respCpfCtrl = TextEditingController();

  // ── Step 3 — Contrato (wizard) ───────────────────
  final valorCtrl = TextEditingController();
  int? diaPagamento;
  DateTime? vigenciaInicio;
  DateTime? vigenciaFim;

  String get vigenciaInicioFmt => vigenciaInicio != null
      ? DateFormat('MM/yyyy').format(vigenciaInicio!)
      : '';
  String get vigenciaFimFmt =>
      vigenciaFim != null ? DateFormat('MM/yyyy').format(vigenciaFim!) : '';

  // ── Controllers modo edição ──────────────────────
  final primeiroNomeEditCtrl = TextEditingController();
  final sobrenomeEditCtrl = TextEditingController();
  final respNomeEditCtrl = TextEditingController();
  final respSobrenomeEditCtrl = TextEditingController();
  final respDddCtrl = TextEditingController();
  final respTelCtrl = TextEditingController();

  // ── Campos extras modo edição ────────────────────
  DateTime? dtNascimento;
  String? sexo;

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

      // Wizard (nome completo)
      nomeCtrl.text = p['nomePassageiro']?.toString() ?? '';
      escolaNome = p['nomeEscola']?.toString();
      periodo = p['domTurno']?.toString() ?? p['periodo']?.toString();

      // Edit mode (nome dividido)
      final partes = (p['nomePassageiro'] ?? '').toString().split(' ');
      primeiroNomeEditCtrl.text = partes.isNotEmpty ? partes.first : '';
      sobrenomeEditCtrl.text =
          partes.length > 1 ? partes.skip(1).join(' ') : '';

      // Data de nascimento e sexo
      final dtn = p['dtNascimento']?.toString();
      dtNascimento = dtn != null ? DateTime.tryParse(dtn) : null;
      sexo = p['domSexo']?.toString();

      // Responsável
      try {
        final resps = await VivanHttp.get('/passageiros/$id/responsaveis');
        final lista = (resps is Map ? resps['data'] : resps) as List? ?? [];
        if (lista.isNotEmpty) {
          final r = lista.first as Map<String, dynamic>;
          _responsavelId = int.tryParse(r['idResponsavel']?.toString() ?? '');

          // Wizard
          respNomeCtrl.text = r['nomeResponsavel']?.toString() ?? '';
          respWhatsappCtrl.text = r['whatsAppResponsavel']?.toString() ?? '';
          respCpfCtrl.text = r['cpfResponsavel']?.toString() ?? '';

          // Edit mode (nome dividido)
          final respPartes = (r['nomeResponsavel'] ?? '').toString().split(' ');
          respNomeEditCtrl.text =
              respPartes.isNotEmpty ? respPartes.first : '';
          respSobrenomeEditCtrl.text =
              respPartes.length > 1 ? respPartes.skip(1).join(' ') : '';

          // Telefone dividido em DDD + número
          final wpp = r['whatsAppResponsavel']?.toString() ?? '';
          final spaceIdx = wpp.indexOf(' ');
          respDddCtrl.text = spaceIdx > 0 ? wpp.substring(0, spaceIdx) : '';
          respTelCtrl.text =
              spaceIdx > 0 ? wpp.substring(spaceIdx + 1) : wpp;
        }
      } catch (_) {}
    } catch (e) {
      debugPrint('PassageiroForm.carregar: $e');
    }
  }

  // ── Salvar ───────────────────────────────────────
  Future<bool> salvar() async {
    isSaving = true;
    erro = null;
    try {
      final Map<String, dynamic> body;
      if (isEdit) {
        body = {
          'nomePassageiro':
              '${primeiroNomeEditCtrl.text.trim()} ${sobrenomeEditCtrl.text.trim()}'
                  .trim(),
          if (dtNascimento != null)
            'dtNascimento':
                dtNascimento!.toIso8601String().substring(0, 10),
          if (sexo != null) 'domSexo': sexo,
          if (escolaNome?.isNotEmpty == true) 'nomeEscola': escolaNome,
          if (periodo != null) 'domTurno': periodo,
        };
      } else {
        body = {
          'nomePassageiro': nomeCtrl.text.trim(),
          if (escolaNome?.isNotEmpty == true) 'nomeEscola': escolaNome,
          if (periodo != null) 'periodo': periodo,
        };
      }

      dynamic savedP;
      if (isEdit) {
        savedP = await VivanHttp.put('/passageiros/$passageiroId', body);
      } else {
        savedP = await VivanHttp.post('/passageiros', body);
        passageiroId =
            int.tryParse((savedP as Map)['idPassageiro']?.toString() ?? '');
      }

      // Responsável
      final String respNome;
      final String respWpp;
      final String respCpf;
      if (isEdit) {
        respNome =
            '${respNomeEditCtrl.text.trim()} ${respSobrenomeEditCtrl.text.trim()}'
                .trim();
        respWpp =
            '${respDddCtrl.text.trim()} ${respTelCtrl.text.trim()}'.trim();
        respCpf = respCpfCtrl.text.trim();
      } else {
        respNome = respNomeCtrl.text.trim();
        respWpp = respWhatsappCtrl.text.trim();
        respCpf = respCpfCtrl.text.trim();
      }

      final shouldSaveResp = isEdit
          ? (passageiroId != null && respNome.isNotEmpty)
          : (passageiroId != null &&
              respNome.isNotEmpty &&
              respWpp.isNotEmpty &&
              respCpf.isNotEmpty);

      if (shouldSaveResp) {
        final rBody = <String, dynamic>{
          'nomeResponsavel': respNome,
          if (respWpp.isNotEmpty) 'whatsAppResponsavel': respWpp,
          if (respCpf.isNotEmpty) 'cpfResponsavel': respCpf,
        };
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
      }

      // Contrato — somente no wizard (criação)
      if (!isEdit && passageiroId != null && valorCtrl.text.trim().isNotEmpty) {
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
        if (_contratoId != null) {
          await VivanHttp.put(
              '/passageiros/$passageiroId/contratos/$_contratoId', cBody);
        } else {
          final c = await VivanHttp.post(
              '/passageiros/$passageiroId/contratos', cBody);
          if (c is Map) {
            _contratoId = int.tryParse(
                (c['contrato'] as Map?)?['idContrato']?.toString() ?? '');
          }
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

  // ── Deletar ──────────────────────────────────────
  Future<bool> deletar() async {
    isSaving = true;
    erro = null;
    try {
      await VivanHttp.delete('/passageiros/$passageiroId');
      isSaving = false;
      return true;
    } catch (e) {
      debugPrint('PassageiroForm.deletar: $e');
      erro = e.toString();
      isSaving = false;
      return false;
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    pageCtrl.dispose();
    nomeCtrl.dispose();
    respNomeCtrl.dispose();
    respWhatsappCtrl.dispose();
    respCpfCtrl.dispose();
    valorCtrl.dispose();
    primeiroNomeEditCtrl.dispose();
    sobrenomeEditCtrl.dispose();
    respNomeEditCtrl.dispose();
    respSobrenomeEditCtrl.dispose();
    respDddCtrl.dispose();
    respTelCtrl.dispose();
  }
}
