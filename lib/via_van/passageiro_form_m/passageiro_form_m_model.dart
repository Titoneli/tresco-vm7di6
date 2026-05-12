import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import 'passageiro_form_m_widget.dart' show PassageiroFormMWidget;

class PassageiroFormMModel extends FlutterFlowModel<PassageiroFormMWidget> {
  final pageCtrl = PageController();
  int step = 0;
  bool isSaving = false;
  String? erro;

  // ── Step 1 — Passageiro ──────────────────────────
  final nomeCtrl = TextEditingController();
  String? escolaNome;
  int? escolaId;
  String? periodo;
  List<String> escolas = [];
  final Map<String, int> _escolaIds = {};

  Future<void> loadEscolas() async {
    try {
      final rows = await SupaFlow.client
          .from('vivan_escolas')
          .select('idEscola, nomeEscola')
          .eq('idMotorista', FFAppState().idUsuario)
          .order('nomeEscola');
      _escolaIds.clear();
      escolas = (rows as List)
          .map((r) => (r as Map)['nomeEscola']?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
      for (final r in rows) {
        final nome = (r as Map)['nomeEscola']?.toString() ?? '';
        final id = (r)['idEscola'] as int?;
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

  Future<bool> criarNovaEscola(String nome) async {
    try {
      final row = await SupaFlow.client
          .from('vivan_escolas')
          .insert({'nomeEscola': nome, 'idMotorista': FFAppState().idUsuario})
          .select('idEscola')
          .single();
      final id = row['idEscola'] as int?;
      if (id != null) {
        _escolaIds[nome] = id;
        escolas = [...escolas, nome]..sort();
        escolaNome = nome;
        escolaId = id;
      }
      return id != null;
    } catch (e) {
      debugPrint('PassageiroForm.criarNovaEscola: $e');
      return false;
    }
  }

  static const periodos = ['Integral', 'Manhã', 'Tarde', 'Noite'];

  // ── Step 2 — Responsável (wizard + edit) ─────────
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

  bool get isEdit => passageiroId != null;

  // ── Carregar para edição ─────────────────────────
  Future<void> carregar(int id) async {
    passageiroId = id;
    try {
      // Passageiro com JOIN de escola
      final rows = await SupaFlow.client
          .from('vivan_passageiros')
          .select('*, vivan_escolas(nomeEscola)')
          .eq('idPassageiro', id)
          .eq('idMotorista', FFAppState().idUsuario)
          .limit(1);

      if ((rows as List).isEmpty) return;
      final r = Map<String, dynamic>.from(rows.first as Map);
      final escolaMap = r.remove('vivan_escolas') as Map?;

      final nomeCompleto = r['nomePassageiro']?.toString() ?? '';
      nomeCtrl.text = nomeCompleto;
      final partes = nomeCompleto.split(' ');
      primeiroNomeEditCtrl.text = partes.first;
      sobrenomeEditCtrl.text = partes.skip(1).join(' ');

      escolaNome = escolaMap?['nomeEscola']?.toString() ?? r['nomeEscola']?.toString();
      escolaId = r['idEscola'] as int?;
      periodo = r['domTurno']?.toString();

      final dtn = r['dtNascimento']?.toString();
      dtNascimento = dtn != null ? DateTime.tryParse(dtn) : null;

      // Responsável
      try {
        final respRows = await SupaFlow.client
            .from('vivan_responsaveis')
            .select()
            .eq('idPassageiro', id)
            .limit(1);
        if ((respRows as List).isNotEmpty) {
          final resp = Map<String, dynamic>.from(respRows.first as Map);
          _responsavelId = resp['idResponsavel'] as int?;
          final nomeResp = resp['nomeResponsavel']?.toString() ?? '';
          respNomeCtrl.text = nomeResp;
          final respPartes = nomeResp.split(' ');
          respNomeEditCtrl.text = respPartes.first;
          respSobrenomeEditCtrl.text = respPartes.skip(1).join(' ');
          final wpp = resp['whatsAppResponsavel']?.toString() ?? '';
          respWhatsappCtrl.text = wpp;
          final spaceIdx = wpp.indexOf(' ');
          respDddCtrl.text = spaceIdx > 0 ? wpp.substring(0, spaceIdx) : '';
          respTelCtrl.text = spaceIdx > 0 ? wpp.substring(spaceIdx + 1) : wpp;
          respCpfCtrl.text = resp['cpfResponsavel']?.toString() ?? '';
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
      if (isEdit) {
        await _salvarEdit();
      } else {
        await _salvarNovo();
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

  Future<void> _salvarEdit() async {
    final nomeEdit =
        '${primeiroNomeEditCtrl.text} ${sobrenomeEditCtrl.text}'.trim();
    final resolvedEscolaId = escolaId ?? _escolaIds[escolaNome ?? ''];

    await SupaFlow.client
        .from('vivan_passageiros')
        .update({
          'nomePassageiro':
              nomeEdit.isNotEmpty ? nomeEdit : nomeCtrl.text.trim(),
          if (dtNascimento != null)
            'dtNascimento': dtNascimento!.toIso8601String().substring(0, 10),
          if (resolvedEscolaId != null) 'idEscola': resolvedEscolaId,
          if (periodo != null) 'domTurno': periodo,
        })
        .eq('idPassageiro', passageiroId!)
        .eq('idMotorista', FFAppState().idUsuario);

    // Responsável
    final nomeR =
        '${respNomeEditCtrl.text} ${respSobrenomeEditCtrl.text}'.trim();
    final respNome = nomeR.isNotEmpty ? nomeR : respNomeCtrl.text.trim();
    final ddd = respDddCtrl.text.trim();
    final tel = respTelCtrl.text.trim();
    final respWpp = ddd.isNotEmpty && tel.isNotEmpty
        ? '$ddd $tel'
        : (ddd.isNotEmpty ? ddd : tel);
    final respCpf = respCpfCtrl.text.trim();

    if (respNome.isNotEmpty) {
      final rBody = <String, dynamic>{
        'nomeResponsavel': respNome,
        'idPassageiro': passageiroId,
        if (respWpp.isNotEmpty) 'whatsAppResponsavel': respWpp,
        if (respCpf.isNotEmpty) 'cpfResponsavel': respCpf,
      };
      if (_responsavelId != null) {
        await SupaFlow.client
            .from('vivan_responsaveis')
            .update(rBody)
            .eq('idResponsavel', _responsavelId!)
            .eq('idPassageiro', passageiroId!);
      } else {
        final r = await SupaFlow.client
            .from('vivan_responsaveis')
            .insert(rBody)
            .select('idResponsavel')
            .single();
        _responsavelId = r['idResponsavel'] as int?;
      }
    }
  }

  Future<void> _salvarNovo() async {
    final motoristaId = FFAppState().idUsuario;

    // Escola nova: INSERT direto
    int? resolvedEscolaId = escolaId;
    if (resolvedEscolaId == null && escolaNome?.isNotEmpty == true) {
      final row = await SupaFlow.client
          .from('vivan_escolas')
          .insert({'nomeEscola': escolaNome, 'idMotorista': motoristaId})
          .select('idEscola')
          .single();
      resolvedEscolaId = row['idEscola'] as int?;
      if (resolvedEscolaId != null) _escolaIds[escolaNome!] = resolvedEscolaId;
    }

    final respNome = respNomeCtrl.text.trim();
    final respWpp = respWhatsappCtrl.text.trim();
    final respCpf = respCpfCtrl.text.trim();
    final valorStr = valorCtrl.text.trim();
    final valor = valorStr.isNotEmpty
        ? (double.tryParse(valorStr.replaceAll(',', '.')) ?? 0)
        : 0.0;
    final agora = DateTime.now();
    final inicio = vigenciaInicio ?? agora;
    final fim = vigenciaFim ?? DateTime(agora.year, 12, 31);
    final dtInicio =
        DateFormat('yyyy-MM-dd').format(DateTime(inicio.year, inicio.month, 1));
    final dtTermino =
        DateFormat('yyyy-MM-dd').format(DateTime(fim.year, fim.month + 1, 0));

    // Chama RPC atômica que cria passageiro + responsável + contrato + mensalidades
    final result = await SupaFlow.client.rpc(
      'vivan_criar_passageiro_completo',
      params: {
        'p_motorista_id': motoristaId,
        'p_nome': nomeCtrl.text.trim(),
        'p_escola_id': resolvedEscolaId,
        'p_turno': periodo,
        'p_resp_nome': respNome.isNotEmpty ? respNome : null,
        'p_resp_cpf': respCpf.isNotEmpty ? respCpf : null,
        'p_resp_wpp': respWpp.isNotEmpty ? respWpp : null,
        'p_valor': valor > 0 ? valor : null,
        'p_dia_venc': diaPagamento ?? 5,
        'p_dt_inicio': dtInicio,
        'p_dt_termino': dtTermino,
      },
    );

    final res = result as Map;
    passageiroId = res['idPassageiro'] as int?;
    _responsavelId = res['idResponsavel'] as int?;
  }

  // ── Deletar ──────────────────────────────────────
  Future<bool> deletar() async {
    isSaving = true;
    erro = null;
    try {
      await SupaFlow.client.rpc('vivan_deletar_passageiro', params: {
        'p_passageiro_id': passageiroId,
        'p_motorista_id': FFAppState().idUsuario,
      });
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
