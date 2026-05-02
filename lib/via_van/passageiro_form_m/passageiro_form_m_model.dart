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
  final nomeCtrl = TextEditingController(); // nome completo (wizard + edit)
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

  static const periodos = ['Integral', 'Manhã', 'Tarde', 'Noite'];

  // ── Step 2 — Responsável (wizard + edit) ─────────
  final respNomeCtrl = TextEditingController();    // nome completo
  final respWhatsappCtrl = TextEditingController(); // WhatsApp / telefone
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

  // ── Campos extras — só no edit ───────────────────
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

      nomeCtrl.text = p['nomePassageiro']?.toString() ?? '';
      escolaNome = p['nomeEscola']?.toString();
      periodo = p['domTurno']?.toString() ?? p['periodo']?.toString();

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
          respNomeCtrl.text = r['nomeResponsavel']?.toString() ?? '';
          respWhatsappCtrl.text = r['whatsAppResponsavel']?.toString() ?? '';
          respCpfCtrl.text = r['cpfResponsavel']?.toString() ?? '';
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
          'nomePassageiro': nomeCtrl.text.trim(),
          if (dtNascimento != null)
            'dtNascimento': dtNascimento!.toIso8601String().substring(0, 10),
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

      // Responsável — salva com apenas nome (mínimo exigido pelo backend para criar contrato)
      final respNome = respNomeCtrl.text.trim();
      final respWpp = respWhatsappCtrl.text.trim();
      final respCpf = respCpfCtrl.text.trim();
      bool responsavelSalvo = _responsavelId != null;

      if (passageiroId != null && respNome.isNotEmpty) {
        final rBody = <String, dynamic>{
          'nomeResponsavel': respNome,
          if (respWpp.isNotEmpty) 'whatsAppResponsavel': respWpp,
          if (respCpf.isNotEmpty) 'cpfResponsavel': respCpf,
        };
        if (_responsavelId != null) {
          await VivanHttp.put(
              '/passageiros/$passageiroId/responsaveis/$_responsavelId',
              rBody);
          responsavelSalvo = true;
        } else {
          final r = await VivanHttp.post(
              '/passageiros/$passageiroId/responsaveis', rBody);
          if (r is Map) {
            _responsavelId =
                int.tryParse(r['idResponsavel']?.toString() ?? '');
            responsavelSalvo = true;
          }
        }
      }

      // Contrato — somente no wizard (criação), exige responsável salvo e valor preenchido.
      // O backend POST /passageiros/:id/contratos já cria contrato + mensalidades em uma única chamada.
      if (!isEdit &&
          passageiroId != null &&
          responsavelSalvo &&
          valorCtrl.text.trim().isNotEmpty) {
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
        final c = await VivanHttp.post(
            '/passageiros/$passageiroId/contratos', cBody);
        if (c is Map) {
          _contratoId = int.tryParse(
              (c['contrato'] as Map?)?['idContrato']?.toString() ?? '');
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
  }
}
