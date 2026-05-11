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
  int? escolaId;
  String? periodo;
  List<String> escolas = [];
  final Map<String, int> _escolaIds = {};

  Future<void> loadEscolas() async {
    try {
      final res = await VivanHttp.get('/escolas?motorista=${FFAppState().idUsuario}');
      final lista = res is List ? res : (res is Map ? (res['data'] ?? []) : []);
      _escolaIds.clear();
      escolas = (lista as List)
          .map((e) => (e as Map)['nomeEscola']?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
      for (final e in lista) {
        final nome = (e as Map)['nomeEscola']?.toString() ?? '';
        final id = int.tryParse(e['idEscola']?.toString() ?? '');
        if (nome.isNotEmpty && id != null) _escolaIds[nome] = id;
      }
    } catch (e) {
      debugPrint('PassageiroForm.loadEscolas: $e');
    }
  }

  void setEscolaNome(String? nome) {
    escolaNome = nome;
    escolaId = nome != null ? _escolaIds[nome] : null;
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

  // Controllers divididos — somente modo edição
  final primeiroNomeEditCtrl = TextEditingController();
  final sobrenomeEditCtrl = TextEditingController();
  final respNomeEditCtrl = TextEditingController();
  final respSobrenomeEditCtrl = TextEditingController();
  final respDddCtrl = TextEditingController();
  final respTelCtrl = TextEditingController();

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

      final nomeCompleto = p['nomePassageiro']?.toString() ?? '';
      nomeCtrl.text = nomeCompleto;
      final partes = nomeCompleto.split(' ');
      primeiroNomeEditCtrl.text = partes.first;
      sobrenomeEditCtrl.text = partes.skip(1).join(' ');

      escolaNome = p['nomeEscola']?.toString();
      escolaId = int.tryParse(p['idEscola']?.toString() ?? '');
      periodo = p['domTurno']?.toString() ?? p['periodo']?.toString();

      final dtn = p['dtNascimento']?.toString();
      dtNascimento = dtn != null ? DateTime.tryParse(dtn) : null;

      // Responsável
      try {
        final resps = await VivanHttp.get('/passageiros/$id/responsaveis');
        final lista = (resps is Map ? resps['data'] : resps) as List? ?? [];
        if (lista.isNotEmpty) {
          final r = lista.first as Map<String, dynamic>;
          _responsavelId = int.tryParse(r['idResponsavel']?.toString() ?? '');
          final nomeResp = r['nomeResponsavel']?.toString() ?? '';
          respNomeCtrl.text = nomeResp;
          final respPartes = nomeResp.split(' ');
          respNomeEditCtrl.text = respPartes.first;
          respSobrenomeEditCtrl.text = respPartes.skip(1).join(' ');
          final wpp = r['whatsAppResponsavel']?.toString() ?? '';
          respWhatsappCtrl.text = wpp;
          final spaceIdx = wpp.indexOf(' ');
          respDddCtrl.text = spaceIdx > 0 ? wpp.substring(0, spaceIdx) : '';
          respTelCtrl.text = spaceIdx > 0 ? wpp.substring(spaceIdx + 1) : wpp;
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
        final nomeEdit =
            '${primeiroNomeEditCtrl.text} ${sobrenomeEditCtrl.text}'.trim();
        final resolvedEscolaId = escolaId ?? _escolaIds[escolaNome ?? ''];
        body = {
          'nomePassageiro': nomeEdit.isNotEmpty ? nomeEdit : nomeCtrl.text.trim(),
          if (dtNascimento != null)
            'dtNascimento': dtNascimento!.toIso8601String().substring(0, 10),
          if (resolvedEscolaId != null) 'idEscola': resolvedEscolaId,
          if (periodo != null) 'domTurno': periodo,
        };
      } else {
        // Criar escola separadamente para garantir idMotorista correto no banco.
        // Se usarmos nomeEscola no body, o servidor cria a escola com idMotorista
        // da conta de serviço (398) e ela some do picker do motorista depois.
        int? resolvedEscolaId = escolaId;
        if (resolvedEscolaId == null && escolaNome?.isNotEmpty == true) {
          try {
            final escolaRes = await VivanHttp.post('/escolas', {
              'nomeEscola': escolaNome,
              'idMotorista': FFAppState().idUsuario,
            });
            resolvedEscolaId = int.tryParse(
                (escolaRes as Map)['idEscola']?.toString() ?? '');
          } catch (_) {}
        }
        body = {
          'nomePassageiro': nomeCtrl.text.trim(),
          'idMotorista': FFAppState().idUsuario,
          if (resolvedEscolaId != null) 'idEscola': resolvedEscolaId
          else if (escolaNome?.isNotEmpty == true) 'nomeEscola': escolaNome,
          if (periodo != null) 'domTurno': periodo,
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

      // Responsável — no edit mode, usa campos divididos; no wizard, usa campo único
      final String respNome;
      final String respWpp;
      if (isEdit) {
        final nomeR =
            '${respNomeEditCtrl.text} ${respSobrenomeEditCtrl.text}'.trim();
        respNome = nomeR.isNotEmpty ? nomeR : respNomeCtrl.text.trim();
        final ddd = respDddCtrl.text.trim();
        final tel = respTelCtrl.text.trim();
        final wppJoin = ddd.isNotEmpty && tel.isNotEmpty
            ? '$ddd $tel'
            : (ddd.isNotEmpty ? ddd : tel);
        respWpp = wppJoin.isNotEmpty ? wppJoin : respWhatsappCtrl.text.trim();
      } else {
        respNome = respNomeCtrl.text.trim();
        respWpp = respWhatsappCtrl.text.trim();
      }
      final respCpf = respCpfCtrl.text.trim();
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
        } else {
          final r = await VivanHttp.post(
              '/passageiros/$passageiroId/responsaveis', rBody);
          if (r is Map) {
            _responsavelId =
                int.tryParse(r['idResponsavel']?.toString() ?? '');
          }
        }
      }

      // Contrato — somente no wizard (criação), quando valor preenchido.
      // POST /passageiros/:id/contratos cria contrato + ativa + mensalidades atomicamente.
      if (!isEdit &&
          passageiroId != null &&
          valorCtrl.text.trim().isNotEmpty) {
        final valor =
            double.tryParse(valorCtrl.text.replaceAll(',', '.')) ?? 0;
        final agora = DateTime.now();
        final inicio = vigenciaInicio ?? DateTime(agora.year, agora.month);
        final fim = vigenciaFim ?? DateTime(inicio.year + 1, inicio.month);
        final cBody = <String, dynamic>{
          'idMotorista': FFAppState().idUsuario,
          'idPassageiro': passageiroId,
          if (_responsavelId != null) 'idResponsavel': _responsavelId,
          'valMensal': valor,
          'diaVencimento': diaPagamento ?? 5,
          'dtInicio': DateFormat('yyyy-MM-dd').format(DateTime(inicio.year, inicio.month, 1)),
          'dtTermino': DateFormat('yyyy-MM-dd').format(DateTime(fim.year, fim.month + 1, 0)),
          'domFormaPagamento': 'OUTROS',
          'domCondicaoPagamento': 'Mensal',
          'percentualMulta': 2.0,
          'percentualJurosDia': 0.0333,
          'status': 'RASCUNHO',
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
    primeiroNomeEditCtrl.dispose();
    sobrenomeEditCtrl.dispose();
    respNomeCtrl.dispose();
    respNomeEditCtrl.dispose();
    respSobrenomeEditCtrl.dispose();
    respWhatsappCtrl.dispose();
    respDddCtrl.dispose();
    respTelCtrl.dispose();
    respCpfCtrl.dispose();
    valorCtrl.dispose();
  }
}
