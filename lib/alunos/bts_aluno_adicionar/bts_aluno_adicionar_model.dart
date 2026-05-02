import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bts_aluno_adicionar_widget.dart' show BtsAlunoAdicionarWidget;
import 'package:flutter/material.dart';

class BtsAlunoAdicionarModel extends FlutterFlowModel<BtsAlunoAdicionarWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();

  // PageView controller
  PageController? pageController;
  int currentPage = 0;

  // ===== Step 1 - Passageiro =====
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  String? _nomeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Informe o Nome do Passageiro';
    }
    return null;
  }

  FocusNode? sobrenomeFocusNode;
  TextEditingController? sobrenomeTextController;

  DateTime? dtNascimento;
  String? sexo; // 'Masculino' or 'Feminino'

  // Escola
  int? selectedEscolaId;
  String? selectedEscolaNome;
  List<EscolaRow> escolasList = [];

  // Período (Turno)
  String? selectedPeriodo;
  final List<String> periodoOptions = [
    'Integral',
    'Manhã',
    'Almoço',
    'Tarde',
    'Noite',
  ];

  // ===== Step 2 - Responsável =====
  FocusNode? respNomeFocusNode;
  TextEditingController? respNomeTextController;

  FocusNode? respSobrenomeFocusNode;
  TextEditingController? respSobrenomeTextController;

  FocusNode? respDDDFocusNode;
  TextEditingController? respDDDTextController;

  FocusNode? respTelefoneFocusNode;
  TextEditingController? respTelefoneTextController;

  FocusNode? respCPFFocusNode;
  TextEditingController? respCPFTextController;

  // ===== Step 3 - Mensalidade =====
  FocusNode? valorMensalidadeFocusNode;
  TextEditingController? valorMensalidadeTextController;

  String? diaPagamento;
  DateTime? dtInicioVigencia;
  DateTime? dtFinalVigencia;

  // API results
  List<AlunoRow>? apiResBuscaAluno;
  AlunoRow? apiResAdicionaAluno;
  ContratoAlunoRow? apiResAdicionaContrato;

  @override
  void initState(BuildContext context) {
    nomeTextControllerValidator = _nomeTextControllerValidator;
  }

  @override
  void dispose() {
    pageController?.dispose();

    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    sobrenomeFocusNode?.dispose();
    sobrenomeTextController?.dispose();

    respNomeFocusNode?.dispose();
    respNomeTextController?.dispose();

    respSobrenomeFocusNode?.dispose();
    respSobrenomeTextController?.dispose();

    respDDDFocusNode?.dispose();
    respDDDTextController?.dispose();

    respTelefoneFocusNode?.dispose();
    respTelefoneTextController?.dispose();

    respCPFFocusNode?.dispose();
    respCPFTextController?.dispose();

    valorMensalidadeFocusNode?.dispose();
    valorMensalidadeTextController?.dispose();
  }

  /// Concatena Nome + Sobrenome para salvar em nomeAluno
  String get nomeCompleto {
    final nome = nomeTextController?.text.trim() ?? '';
    final sobrenome = sobrenomeTextController?.text.trim() ?? '';
    if (sobrenome.isEmpty) return nome;
    return '$nome $sobrenome';
  }

  /// Concatena responsável nome + sobrenome
  String get nomeCompletoResponsavel {
    final nome = respNomeTextController?.text.trim() ?? '';
    final sobrenome = respSobrenomeTextController?.text.trim() ?? '';
    if (sobrenome.isEmpty) return nome;
    return '$nome $sobrenome';
  }

  /// Telefone completo com DDD
  String get telefoneCompletoResponsavel {
    final ddd = respDDDTextController?.text.trim() ?? '';
    final tel = respTelefoneTextController?.text.trim() ?? '';
    if (ddd.isEmpty) return tel;
    return '($ddd) $tel';
  }

  /// Converte valor mensalidade string (ex: "350,00") para double
  double? get valorMensalidadeDouble {
    final text = valorMensalidadeTextController?.text.trim() ?? '';
    if (text.isEmpty) return null;
    final normalized = text.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(normalized);
  }
}
