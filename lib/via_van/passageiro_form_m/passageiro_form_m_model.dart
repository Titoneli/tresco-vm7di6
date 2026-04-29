import '/flutter_flow/flutter_flow_util.dart';
import '/vivan/vivan.dart';
import 'passageiro_form_m_widget.dart' show PassageiroFormMWidget;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PassageiroFormMModel extends FlutterFlowModel<PassageiroFormMWidget> {
  // ── Page controller ──────────────────────────────
  late PageController pageController;
  int currentStep = 0;

  // ── Loading / saving state ───────────────────────
  bool isLoading = false;
  bool isSaving = false;
  String? errorMessage;

  // ── Form keys ────────────────────────────────────
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  // ══════════════════════════════════════════════════
  // STEP 1 — Passageiro + Informações Escolares
  // ══════════════════════════════════════════════════

  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  FocusNode? sobrenomeFocusNode;
  TextEditingController? sobrenomeTextController;

  DateTime? dataNascimento;
  String get dataNascimentoFormatted =>
      dataNascimento != null
          ? DateFormat('dd/MM/yyyy').format(dataNascimento!)
          : '';

  bool? sexoMasculino;

  List<VivanEscola> escolas = [];
  VivanEscola? escolaSelecionada;

  final List<String> periodos = ['Integral', 'Manhã', 'Almoço', 'Tarde', 'Noite'];
  String? periodoSelecionado;

  // ══════════════════════════════════════════════════
  // STEP 2 — Responsável
  // ══════════════════════════════════════════════════

  FocusNode? respNomeFocusNode;
  TextEditingController? respNomeTextController;
  FocusNode? respSobrenomeFocusNode;
  TextEditingController? respSobrenomeTextController;
  FocusNode? respDddFocusNode;
  TextEditingController? respDddTextController;
  FocusNode? respTelefoneFocusNode;
  TextEditingController? respTelefoneTextController;
  FocusNode? respCpfFocusNode;
  TextEditingController? respCpfTextController;

  // ══════════════════════════════════════════════════
  // STEP 3 — Mensalidade
  // ══════════════════════════════════════════════════

  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  int? diaPagamento;
  DateTime? vigenciaInicio;
  DateTime? vigenciaFinal;
  String get vigenciaInicioFormatted =>
      vigenciaInicio != null ? DateFormat('MM/yyyy').format(vigenciaInicio!) : '';
  String get vigenciaFinalFormatted =>
      vigenciaFinal != null ? DateFormat('MM/yyyy').format(vigenciaFinal!) : '';

  // ══════════════════════════════════════════════════
  // LIFECYCLE
  // ══════════════════════════════════════════════════

  @override
  void initState(BuildContext context) {
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();
    sobrenomeFocusNode?.dispose();
    sobrenomeTextController?.dispose();
    respNomeFocusNode?.dispose();
    respNomeTextController?.dispose();
    respSobrenomeFocusNode?.dispose();
    respSobrenomeTextController?.dispose();
    respDddFocusNode?.dispose();
    respDddTextController?.dispose();
    respTelefoneFocusNode?.dispose();
    respTelefoneTextController?.dispose();
    respCpfFocusNode?.dispose();
    respCpfTextController?.dispose();
    valorFocusNode?.dispose();
    valorTextController?.dispose();
  }

  // ══════════════════════════════════════════════════
  // NAVIGATION
  // ══════════════════════════════════════════════════

  void nextStep() {
    if (currentStep < 2) {
      currentStep++;
      pageController.animateToPage(currentStep,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      pageController.animateToPage(currentStep,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  // ══════════════════════════════════════════════════
  // DATA LOADING
  // ══════════════════════════════════════════════════

  Future<void> loadEscolas(int motoristaId) async {
    try {
      escolas = await VivanLocator.service.getEscolas(motoristaId);
    } catch (e) {
      debugPrint('Erro ao carregar escolas: $e');
    }
  }

  Future<void> loadPassageiro(int passageiroId) async {
    isLoading = true;
    try {
      final p = await VivanLocator.service.getPassageiro(passageiroId);
      final nameParts = p.nomePassageiro.split(' ');
      nomeTextController?.text = nameParts.first;
      sobrenomeTextController?.text =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
      if (p.dtNascimento != null && p.dtNascimento!.isNotEmpty) {
        try { dataNascimento = DateTime.parse(p.dtNascimento!); } catch (_) {}
      }
      if (p.idEscola != null) {
        escolaSelecionada = escolas.where((e) => e.idEscola == p.idEscola).firstOrNull;
      }
      periodoSelecionado = p.domTurno;

      try {
        final resps = await VivanLocator.service.getResponsaveis(passageiroId);
        if (resps.isNotEmpty) {
          final r = resps.first;
          final rNameParts = r.nomeResponsavel.split(' ');
          respNomeTextController?.text = rNameParts.first;
          respSobrenomeTextController?.text =
              rNameParts.length > 1 ? rNameParts.sublist(1).join(' ') : '';
          respCpfTextController?.text = r.cpfResponsavel;
          final tel = r.telResponsavel ?? r.whatsAppResponsavel;
          if (tel.isNotEmpty) {
            if (tel.length > 2) {
              respDddTextController?.text = tel.substring(0, 2);
              respTelefoneTextController?.text = tel.substring(2);
            } else {
              respTelefoneTextController?.text = tel;
            }
          }
        }
      } catch (_) {}

      try {
        final contratos = await VivanLocator.service.getContratos(
          motorista: p.idMotorista!, passageiro: passageiroId);
        if (contratos.data.isNotEmpty) {
          final c = contratos.data.first;
          if (c.valMensal != null) {
            valorTextController?.text =
                NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(c.valMensal);
          }
          diaPagamento = c.diaVencimento;
          if (c.dtInicio != null) { try { vigenciaInicio = DateTime.parse(c.dtInicio!); } catch (_) {} }
          if (c.dtTermino != null) { try { vigenciaFinal = DateTime.parse(c.dtTermino!); } catch (_) {} }
        }
      } catch (_) {}
    } catch (e) {
      debugPrint('Erro ao carregar passageiro: $e');
    }
    isLoading = false;
  }

  // ══════════════════════════════════════════════════
  // SAVE ALL
  // ══════════════════════════════════════════════════

  double _parseValor(String? text) {
    if (text == null || text.isEmpty) return 0;
    String clean = text.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.').trim();
    return double.tryParse(clean) ?? 0;
  }

  Future<bool> saveAll(int motoristaId, int? passageiroId) async {
    isSaving = true;
    errorMessage = null;
    try {
      final nomeCompleto =
          '${nomeTextController?.text ?? ''} ${sobrenomeTextController?.text ?? ''}'.trim();

      final p = VivanPassageiro(
        idMotorista: motoristaId,
        nomePassageiro: nomeCompleto,
        dtNascimento: dataNascimento?.toIso8601String(),
        idEscola: escolaSelecionada?.idEscola,
        nomeEscola: escolaSelecionada?.nomeEscola,
        domTurno: periodoSelecionado,
        endPassageiro: '',
      );

      VivanPassageiro savedP;
      if (passageiroId != null) {
        savedP = await VivanLocator.service.updatePassageiro(passageiroId, p);
      } else {
        savedP = await VivanLocator.service.createPassageiro(p);
      }
      final pId = savedP.idPassageiro!;

      final respNome =
          '${respNomeTextController?.text ?? ''} ${respSobrenomeTextController?.text ?? ''}'.trim();
      int? savedRespId;
      if (respNome.isNotEmpty) {
        final tel = '${respDddTextController?.text ?? ''}${respTelefoneTextController?.text ?? ''}';
        final r = VivanResponsavel(
          idPassageiro: pId,
          nomeResponsavel: respNome,
          cpfResponsavel: respCpfTextController?.text ?? '',
          parentesco: 'Responsável',
          telResponsavel: tel,
          whatsAppResponsavel: tel,
          emailResponsavel: '',
        );
        final savedR = await VivanLocator.service.createResponsavel(pId, r);
        savedRespId = savedR.idResponsavel;
      }

      final valor = _parseValor(valorTextController?.text);
      if (valor > 0) {
        final c = VivanContrato(
          idMotorista: motoristaId,
          idPassageiro: pId,
          idResponsavel: savedRespId,
          idEscola: escolaSelecionada?.idEscola,
          domTurno: periodoSelecionado,
          valMensal: valor,
          diaVencimento: diaPagamento,
          dtInicio: vigenciaInicio?.toIso8601String(),
          dtTermino: vigenciaFinal?.toIso8601String(),
          status: 'ATIVO',
        );
        await VivanLocator.service.createContrato(c);
      }

      isSaving = false;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isSaving = false;
      return false;
    }
  }
}
