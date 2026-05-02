/// Modelos de dados do módulo ViVan.
/// Mapeiam 1:1 com as tabelas do banco (vivan_*).

// ── Helpers de parsing seguro ──────────────────────────────────────────────
// A API pode retornar números como String (ex: "123") — estes helpers
// aceitam qualquer tipo e convertem sem lançar exceção.

int? _i(dynamic v) => v == null ? null : int.tryParse(v.toString());
int _iOr(dynamic v, int d) => _i(v) ?? d;
double? _d(dynamic v) => v == null ? null : double.tryParse(v.toString());
double _dOr(dynamic v, double d) => _d(v) ?? d;
bool _b(dynamic v, {bool def = false}) {
  if (v == null) return def;
  if (v is bool) return v;
  final s = v.toString().toLowerCase();
  return s == 'true' || s == '1';
}
String? _s(dynamic v) => v?.toString();
String _sOr(dynamic v, String d) => _s(v) ?? d;

// ============================================
// PASSAGEIRO
// ============================================

class VivanPassageiro {
  final int? idPassageiro;
  final int? idMotorista;
  final String nomePassageiro;
  final String? cpfPassageiro;
  final String? rgPassageiro;
  final String? dtNascimento;
  final String? whatsAppPassageiro;
  final String? telPassageiro;
  final String? emailPassageiro;
  final String? cepPassageiro;
  final String endPassageiro;
  final String? numPassageiro;
  final String? compPassageiro;
  final String? bairroPassageiro;
  final String? cidadePassageiro;
  final String? ufPassageiro;
  final double? latPassageiro;
  final double? lngPassageiro;
  final String? urlFoto;
  final int? idEscola;
  final String? nomeEscola;
  final String? domTurno;
  final String? domSerie;
  final int? idTurma;
  final String? horarioEntrada;
  final String? horarioSaida;
  final String? periodoLetivo;
  final String? necessidadesEspeciais;
  final String? observacoes;
  final String? domSexo;
  final bool ativo;

  VivanPassageiro({
    this.idPassageiro,
    this.idMotorista,
    required this.nomePassageiro,
    this.cpfPassageiro,
    this.rgPassageiro,
    this.dtNascimento,
    this.whatsAppPassageiro,
    this.telPassageiro,
    this.emailPassageiro,
    this.cepPassageiro,
    required this.endPassageiro,
    this.numPassageiro,
    this.compPassageiro,
    this.bairroPassageiro,
    this.cidadePassageiro,
    this.ufPassageiro,
    this.latPassageiro,
    this.lngPassageiro,
    this.urlFoto,
    this.idEscola,
    this.nomeEscola,
    this.domTurno,
    this.domSerie,
    this.idTurma,
    this.horarioEntrada,
    this.horarioSaida,
    this.periodoLetivo,
    this.necessidadesEspeciais,
    this.observacoes,
    this.domSexo,
    this.ativo = true,
  });

  factory VivanPassageiro.fromJson(Map<String, dynamic> j) => VivanPassageiro(
        idPassageiro: _i(j['idPassageiro']),
        idMotorista: _i(j['idMotorista']),
        nomePassageiro: _sOr(j['nomePassageiro'], ''),
        cpfPassageiro: _s(j['cpfPassageiro']),
        rgPassageiro: _s(j['rgPassageiro']),
        dtNascimento: _s(j['dtNascimento']),
        whatsAppPassageiro: _s(j['whatsAppPassageiro']),
        telPassageiro: _s(j['telPassageiro']),
        emailPassageiro: _s(j['emailPassageiro']),
        cepPassageiro: _s(j['cepPassageiro']),
        endPassageiro: _sOr(j['endPassageiro'], ''),
        numPassageiro: _s(j['numPassageiro']),
        compPassageiro: _s(j['compPassageiro']),
        bairroPassageiro: _s(j['bairroPassageiro']),
        cidadePassageiro: _s(j['cidadePassageiro']),
        ufPassageiro: _s(j['ufPassageiro']),
        latPassageiro: _d(j['latPassageiro']),
        lngPassageiro: _d(j['lngPassageiro']),
        urlFoto: _s(j['urlFoto']),
        idEscola: _i(j['idEscola']),
        nomeEscola: _s(j['nomeEscola']),
        domTurno: _s(j['domTurno']),
        domSerie: _s(j['domSerie']),
        idTurma: _i(j['idTurma']),
        horarioEntrada: _s(j['horarioEntrada']),
        horarioSaida: _s(j['horarioSaida']),
        periodoLetivo: _s(j['periodoLetivo']),
        necessidadesEspeciais: _s(j['necessidadesEspeciais']),
        observacoes: _s(j['observacoes']),
        domSexo: _s(j['domSexo']),
        ativo: _b(j['ativo'], def: true),
      );

  Map<String, dynamic> toJson() => {
        if (idPassageiro != null) 'idPassageiro': idPassageiro,
        'idMotorista': idMotorista,
        'nomePassageiro': nomePassageiro,
        'cpfPassageiro': cpfPassageiro,
        'rgPassageiro': rgPassageiro,
        'dtNascimento': dtNascimento,
        'whatsAppPassageiro': whatsAppPassageiro,
        'telPassageiro': telPassageiro,
        'emailPassageiro': emailPassageiro,
        'cepPassageiro': cepPassageiro,
        'endPassageiro': endPassageiro,
        'numPassageiro': numPassageiro,
        'compPassageiro': compPassageiro,
        'bairroPassageiro': bairroPassageiro,
        'cidadePassageiro': cidadePassageiro,
        'ufPassageiro': ufPassageiro,
        'latPassageiro': latPassageiro,
        'lngPassageiro': lngPassageiro,
        'urlFoto': urlFoto,
        'idEscola': idEscola,
        'domTurno': domTurno,
        'domSerie': domSerie,
        'idTurma': idTurma,
        'horarioEntrada': horarioEntrada,
        'horarioSaida': horarioSaida,
        'periodoLetivo': periodoLetivo,
        'necessidadesEspeciais': necessidadesEspeciais,
        'observacoes': observacoes,
        'domSexo': domSexo,
        'ativo': ativo,
      };

  String get enderecoCompleto {
    final parts = <String>[];
    if (endPassageiro.isNotEmpty) parts.add(endPassageiro);
    if (numPassageiro?.isNotEmpty == true) parts.add(numPassageiro!);
    if (compPassageiro?.isNotEmpty == true) parts.add(compPassageiro!);
    if (bairroPassageiro?.isNotEmpty == true) parts.add(bairroPassageiro!);
    if (cidadePassageiro?.isNotEmpty == true) {
      parts.add('${cidadePassageiro!}${ufPassageiro != null ? '/$ufPassageiro' : ''}');
    }
    return parts.join(', ');
  }

  String get inicial => nomePassageiro.isNotEmpty ? nomePassageiro[0].toUpperCase() : 'P';
}


// ============================================
// ESCOLA
// ============================================

class VivanEscola {
  final int? idEscola;
  final int? idMotorista;
  final String nomeEscola;

  VivanEscola({this.idEscola, this.idMotorista, required this.nomeEscola});

  factory VivanEscola.fromJson(Map<String, dynamic> j) => VivanEscola(
        idEscola: _i(j['idEscola']),
        idMotorista: _i(j['idMotorista']),
        nomeEscola: _sOr(j['nomeEscola'], ''),
      );

  Map<String, dynamic> toJson() => {
        if (idEscola != null) 'idEscola': idEscola,
        'idMotorista': idMotorista,
        'nomeEscola': nomeEscola,
      };
}

// ============================================
// RESPONSÁVEL
// ============================================

class VivanResponsavel {
  final int? idResponsavel;
  final int? idPassageiro;
  final String nomeResponsavel;
  final String cpfResponsavel;
  final String? rgResponsavel;
  final String parentesco;
  final String? telResponsavel;
  final String whatsAppResponsavel;
  final String emailResponsavel;
  final String? endResponsavel;
  final String? cnhResponsavel;
  final String? profissao;
  final String? estadoCivil;
  final bool principal;
  final bool ativo;

  VivanResponsavel({
    this.idResponsavel,
    this.idPassageiro,
    required this.nomeResponsavel,
    required this.cpfResponsavel,
    this.rgResponsavel,
    required this.parentesco,
    this.telResponsavel,
    required this.whatsAppResponsavel,
    required this.emailResponsavel,
    this.endResponsavel,
    this.cnhResponsavel,
    this.profissao,
    this.estadoCivil,
    this.principal = true,
    this.ativo = true,
  });

  factory VivanResponsavel.fromJson(Map<String, dynamic> j) => VivanResponsavel(
        idResponsavel: _i(j['idResponsavel']),
        idPassageiro: _i(j['idPassageiro']),
        nomeResponsavel: _sOr(j['nomeResponsavel'], ''),
        cpfResponsavel: _sOr(j['cpfResponsavel'], ''),
        rgResponsavel: _s(j['rgResponsavel']),
        parentesco: _sOr(j['parentesco'], ''),
        telResponsavel: _s(j['telResponsavel']),
        whatsAppResponsavel: _sOr(j['whatsAppResponsavel'], ''),
        emailResponsavel: _sOr(j['emailResponsavel'], ''),
        endResponsavel: _s(j['endResponsavel']),
        cnhResponsavel: _s(j['cnhResponsavel']),
        profissao: _s(j['profissao']),
        estadoCivil: _s(j['estadoCivil']),
        principal: _b(j['principal'], def: true),
        ativo: _b(j['ativo'], def: true),
      );

  Map<String, dynamic> toJson() => {
        if (idResponsavel != null) 'idResponsavel': idResponsavel,
        'idPassageiro': idPassageiro,
        'nomeResponsavel': nomeResponsavel,
        'cpfResponsavel': cpfResponsavel,
        'rgResponsavel': rgResponsavel,
        'parentesco': parentesco,
        'telResponsavel': telResponsavel,
        'whatsAppResponsavel': whatsAppResponsavel,
        'emailResponsavel': emailResponsavel,
        'endResponsavel': endResponsavel,
        'cnhResponsavel': cnhResponsavel,
        'profissao': profissao,
        'estadoCivil': estadoCivil,
        'principal': principal,
      };
}

// ============================================
// CONTRATO
// ============================================

class VivanContrato {
  final int? idContrato;
  final String? numContrato;
  final int? idMotorista;
  final int? idPassageiro;
  final int? idResponsavel;
  final int? idEscola;
  final int? idVeiculo;
  final String? domTurno;
  final String? dtInicio;
  final String? dtTermino;
  final double? valMensal;
  final int? diaVencimento;
  final String? domFormaPagamento;
  final String? domCondicaoPagamento;
  final double? percentualDesconto;
  final double? percentualMulta;
  final double? percentualJurosDia;
  final Map<String, dynamic>? clausulasAdicionais;
  final String status;
  final String? motivoCancelamento;
  final String? motivoSuspensao;
  final String? observacoes;
  final String? nomePassageiro;
  final String? nomeResponsavel;
  final String? nomeEscola;

  VivanContrato({
    this.idContrato,
    this.numContrato,
    this.idMotorista,
    this.idPassageiro,
    this.idResponsavel,
    this.idEscola,
    this.idVeiculo,
    this.domTurno,
    this.dtInicio,
    this.dtTermino,
    this.valMensal,
    this.diaVencimento,
    this.domFormaPagamento,
    this.domCondicaoPagamento,
    this.percentualDesconto,
    this.percentualMulta,
    this.percentualJurosDia,
    this.clausulasAdicionais,
    this.status = 'RASCUNHO',
    this.motivoCancelamento,
    this.motivoSuspensao,
    this.observacoes,
    this.nomePassageiro,
    this.nomeResponsavel,
    this.nomeEscola,
  });

  factory VivanContrato.fromJson(Map<String, dynamic> j) => VivanContrato(
        idContrato: _i(j['idContrato']),
        numContrato: _s(j['numContrato']),
        idMotorista: _i(j['idMotorista']),
        idPassageiro: _i(j['idPassageiro']),
        idResponsavel: _i(j['idResponsavel']),
        idEscola: _i(j['idEscola']),
        idVeiculo: _i(j['idVeiculo']),
        domTurno: _s(j['domTurno']),
        dtInicio: _s(j['dtInicio']),
        dtTermino: _s(j['dtTermino']),
        valMensal: _d(j['valMensal']),
        diaVencimento: _i(j['diaVencimento']),
        domFormaPagamento: _s(j['domFormaPagamento']),
        domCondicaoPagamento: _s(j['domCondicaoPagamento']),
        percentualDesconto: _d(j['percentualDesconto']),
        percentualMulta: _d(j['percentualMulta']),
        percentualJurosDia: _d(j['percentualJurosDia']),
        clausulasAdicionais: j['clausulasAdicionais'] is Map
            ? Map<String, dynamic>.from(j['clausulasAdicionais'] as Map)
            : null,
        status: _sOr(j['status'], 'RASCUNHO'),
        motivoCancelamento: _s(j['motivoCancelamento']),
        motivoSuspensao: _s(j['motivoSuspensao']),
        observacoes: _s(j['observacoes']),
        nomePassageiro: _s(j['nomePassageiro']),
        nomeResponsavel: _s(j['nomeResponsavel']),
        nomeEscola: _s(j['nomeEscola']),
      );

  Map<String, dynamic> toJson() => {
        'idMotorista': idMotorista,
        'idPassageiro': idPassageiro,
        'idResponsavel': idResponsavel,
        'idEscola': idEscola,
        'idVeiculo': idVeiculo,
        'domTurno': domTurno,
        'dtInicio': dtInicio,
        'dtTermino': dtTermino,
        'valMensal': valMensal,
        'diaVencimento': diaVencimento,
        'domFormaPagamento': domFormaPagamento,
        'domCondicaoPagamento': domCondicaoPagamento,
        'percentualDesconto': percentualDesconto,
        'percentualMulta': percentualMulta,
        'percentualJurosDia': percentualJurosDia,
        'clausulasAdicionais': clausulasAdicionais,
        'observacoes': observacoes,
      };
}

// ============================================
// MENSALIDADE
// ============================================

class VivanMensalidade {
  final int? idMensalidade;
  final int? idContrato;
  final int? idPassageiro;
  final int? idResponsavel;
  final int? idMotorista;
  final String? mesReferencia;
  final String? dtVencimento;
  final double? valOriginal;
  final double? valDesconto;
  final double? valMulta;
  final double? valJuros;
  final double? valPago;
  final String? dtPagamento;
  final String? formaPagamento;
  final String status;
  final String? asaasPixQrCode;
  final String? asaasPixCopiaECola;
  final String? asaasInvoiceUrl;
  final String? asaasBankSlipUrl;
  final String? comprovanteUrl;
  final String? motivoAbono;
  final String? observacoes;
  final String? nomePassageiro;
  final String? nomeResponsavel;
  final String? numContrato;
  final String? turnoPassageiro;

  VivanMensalidade({
    this.idMensalidade,
    this.idContrato,
    this.idPassageiro,
    this.idResponsavel,
    this.idMotorista,
    this.mesReferencia,
    this.dtVencimento,
    this.valOriginal,
    this.valDesconto,
    this.valMulta,
    this.valJuros,
    this.valPago,
    this.dtPagamento,
    this.formaPagamento,
    this.status = 'AGUARDANDO',
    this.asaasPixQrCode,
    this.asaasPixCopiaECola,
    this.asaasInvoiceUrl,
    this.asaasBankSlipUrl,
    this.comprovanteUrl,
    this.motivoAbono,
    this.observacoes,
    this.nomePassageiro,
    this.nomeResponsavel,
    this.numContrato,
    this.turnoPassageiro,
  });

  factory VivanMensalidade.fromJson(Map<String, dynamic> j) => VivanMensalidade(
        idMensalidade: _i(j['idMensalidade']),
        idContrato: _i(j['idContrato']),
        idPassageiro: _i(j['idPassageiro']),
        idResponsavel: _i(j['idResponsavel']),
        idMotorista: _i(j['idMotorista']),
        mesReferencia: _s(j['mesReferencia']),
        dtVencimento: _s(j['dtVencimento']),
        valOriginal: _d(j['valOriginal']),
        valDesconto: _d(j['valDesconto']),
        valMulta: _d(j['valMulta']),
        valJuros: _d(j['valJuros']),
        valPago: _d(j['valPago']),
        dtPagamento: _s(j['dtPagamento']),
        formaPagamento: _s(j['formaPagamento']),
        status: _sOr(j['status'], 'AGUARDANDO'),
        asaasPixQrCode: _s(j['asaasPixQrCode']),
        asaasPixCopiaECola: _s(j['asaasPixCopiaECola']),
        asaasInvoiceUrl: _s(j['asaasInvoiceUrl']),
        asaasBankSlipUrl: _s(j['asaasBankSlipUrl']),
        comprovanteUrl: _s(j['comprovanteUrl']),
        motivoAbono: _s(j['motivoAbono']),
        observacoes: _s(j['observacoes']),
        nomePassageiro: _s(j['nomePassageiro']),
        nomeResponsavel: _s(j['nomeResponsavel']),
        numContrato: _s(j['numContrato']),
        turnoPassageiro: _s(j['turnoPassageiro']),
      );

  double get valorLiquido =>
      (valOriginal ?? 0) - (valDesconto ?? 0) + (valMulta ?? 0) + (valJuros ?? 0);

  bool get isPago => status == 'PAGO' || status == 'PAGO_ATRASO';
  bool get isAbonado => status == 'ABONADO';
  bool get isPendente => status == 'AGUARDANDO' || status == 'PENDENTE';
  bool get isAtrasado => status == 'ATRASADO';
}

// ============================================
// DESPESA
// ============================================

class VivanDespesa {
  final int? idDespesa;
  final int? idMotorista;
  final int? idVeiculo;
  final String categoria;
  final String descricao;
  final double valor;
  final String dtDespesa;
  final String? dtVencimento;
  final bool pago;
  final String? dtPagamento;
  final String? comprovanteUrl;
  final String? mesReferencia;
  final String? observacoes;
  final String tipoLancamento;
  final bool recorrente;
  final int? diaVencimento;
  final String? mesInicial;
  final String? mesFinal;

  VivanDespesa({
    this.idDespesa,
    this.idMotorista,
    this.idVeiculo,
    required this.categoria,
    required this.descricao,
    required this.valor,
    required this.dtDespesa,
    this.dtVencimento,
    this.pago = false,
    this.dtPagamento,
    this.comprovanteUrl,
    this.mesReferencia,
    this.observacoes,
    this.tipoLancamento = 'DESPESA',
    this.recorrente = false,
    this.diaVencimento,
    this.mesInicial,
    this.mesFinal,
  });

  factory VivanDespesa.fromJson(Map<String, dynamic> j) => VivanDespesa(
        idDespesa: _i(j['idDespesa']),
        idMotorista: _i(j['idMotorista']),
        idVeiculo: _i(j['idVeiculo']),
        categoria: _sOr(j['categoria'], ''),
        descricao: _sOr(j['descricao'], ''),
        valor: _dOr(j['valor'], 0),
        dtDespesa: _sOr(j['dtDespesa'], ''),
        dtVencimento: _s(j['dtVencimento']),
        pago: _b(j['pago']),
        dtPagamento: _s(j['dtPagamento']),
        comprovanteUrl: _s(j['comprovanteUrl']),
        mesReferencia: _s(j['mesReferencia']),
        observacoes: _s(j['observacoes']),
        tipoLancamento: _sOr(j['tipoLancamento'], 'DESPESA'),
        recorrente: _b(j['recorrente']),
        diaVencimento: _i(j['diaVencimento']),
        mesInicial: _s(j['mesInicial']),
        mesFinal: _s(j['mesFinal']),
      );

  Map<String, dynamic> toJson() => {
        'idMotorista': idMotorista,
        'idVeiculo': idVeiculo,
        'categoria': categoria,
        'descricao': descricao,
        'valor': valor,
        'dtDespesa': dtDespesa,
        'dtVencimento': dtVencimento,
        'pago': pago,
        'dtPagamento': dtPagamento,
        'comprovanteUrl': comprovanteUrl,
        'mesReferencia': mesReferencia,
        'observacoes': observacoes,
        'tipoLancamento': tipoLancamento,
        'recorrente': recorrente,
        'diaVencimento': diaVencimento,
        'mesInicial': mesInicial,
        'mesFinal': mesFinal,
      };
}

// ============================================
// PRESENÇA
// ============================================

class VivanPresenca {
  final int? idPresenca;
  final int? idContrato;
  final int? idPassageiro;
  final int? idMotorista;
  final String? dtPresenca;
  final String? domTurno;
  final String tipoPresenca;
  final String? justificativa;
  final double? latRegistro;
  final double? lngRegistro;
  final String? nomePassageiro;

  VivanPresenca({
    this.idPresenca,
    this.idContrato,
    this.idPassageiro,
    this.idMotorista,
    this.dtPresenca,
    this.domTurno,
    this.tipoPresenca = 'P',
    this.justificativa,
    this.latRegistro,
    this.lngRegistro,
    this.nomePassageiro,
  });

  factory VivanPresenca.fromJson(Map<String, dynamic> j) => VivanPresenca(
        idPresenca: _i(j['idPresenca']),
        idContrato: _i(j['idContrato']),
        idPassageiro: _i(j['idPassageiro']),
        idMotorista: _i(j['idMotorista']),
        dtPresenca: _s(j['dtPresenca']),
        domTurno: _s(j['domTurno']),
        tipoPresenca: _sOr(j['tipoPresenca'], 'P'),
        justificativa: _s(j['justificativa']),
        latRegistro: _d(j['latRegistro']),
        lngRegistro: _d(j['lngRegistro']),
        nomePassageiro: _s(j['nomePassageiro']),
      );

  Map<String, dynamic> toJson() => {
        'idContrato': idContrato,
        'idPassageiro': idPassageiro,
        'idMotorista': idMotorista,
        'dtPresenca': dtPresenca,
        'domTurno': domTurno,
        'tipoPresenca': tipoPresenca,
        'justificativa': justificativa,
        'latRegistro': latRegistro,
        'lngRegistro': lngRegistro,
      };

  bool get isPresente => tipoPresenca == 'P';
}

// ============================================
// CONTRATO HISTÓRICO
// ============================================

class VivanContratoHistorico {
  final int? idHistorico;
  final int? idContrato;
  final String? tipoAlteracao;
  final String? statusAnterior;
  final String? statusNovo;
  final String? usuario;
  final String? descricao;
  final String? dtAlteracao;

  VivanContratoHistorico({
    this.idHistorico,
    this.idContrato,
    this.tipoAlteracao,
    this.statusAnterior,
    this.statusNovo,
    this.usuario,
    this.descricao,
    this.dtAlteracao,
  });

  factory VivanContratoHistorico.fromJson(Map<String, dynamic> j) =>
      VivanContratoHistorico(
        idHistorico: _i(j['idHistorico']),
        idContrato: _i(j['idContrato']),
        tipoAlteracao: _s(j['tipoAlteracao']),
        statusAnterior: _s(j['statusAnterior']),
        statusNovo: _s(j['statusNovo']),
        usuario: _s(j['usuario']),
        descricao: _s(j['descricao']),
        dtAlteracao: _s(j['dtAlteracao']),
      );
}

// ============================================
// DASHBOARD RESUMO
// ============================================

class VivanDashboardResumo {
  final String mesReferencia;
  final int totalPassageiros;
  final int passageirosAtivos;
  final int totalContratos;
  final int contratosAtivos;
  final int mensalidadesPendentes;
  final int mensalidadesAtrasadas;
  final double totalAReceber;
  final double totalRecebido;
  final double totalAbonado;
  final double totalInadimplente;
  final double totalDespesas;

  VivanDashboardResumo({
    required this.mesReferencia,
    this.totalPassageiros = 0,
    this.passageirosAtivos = 0,
    this.totalContratos = 0,
    this.contratosAtivos = 0,
    this.mensalidadesPendentes = 0,
    this.mensalidadesAtrasadas = 0,
    this.totalAReceber = 0,
    this.totalRecebido = 0,
    this.totalAbonado = 0,
    this.totalInadimplente = 0,
    this.totalDespesas = 0,
  });

  factory VivanDashboardResumo.fromJson(Map<String, dynamic> j) =>
      VivanDashboardResumo(
        mesReferencia: _sOr(j['mesReferencia'], ''),
        totalPassageiros: _iOr(j['totalPassageiros'], 0),
        passageirosAtivos: _iOr(j['passageirosAtivos'], 0),
        totalContratos: _iOr(j['totalContratos'], 0),
        contratosAtivos: _iOr(j['contratosAtivos'], 0),
        mensalidadesPendentes: _iOr(j['mensalidadesPendentes'], 0),
        mensalidadesAtrasadas: _iOr(j['mensalidadesAtrasadas'], 0),
        totalAReceber: _dOr(j['totalAReceber'], 0),
        totalRecebido: _dOr(j['totalRecebido'], 0),
        totalAbonado: _dOr(j['totalAbonado'], 0),
        totalInadimplente: _dOr(j['totalInadimplente'], 0),
        totalDespesas: _dOr(j['totalDespesas'], 0),
      );

  double get saldoMes => totalRecebido - totalDespesas;
  double get percentualInadimplencia =>
      totalAReceber > 0 ? (totalInadimplente / totalAReceber) * 100 : 0;
}

// ============================================
// CAPACIDADE
// ============================================

class VivanCapacidade {
  final Map<String, dynamic>? veiculo;
  final Map<String, int> ocupacao;

  VivanCapacidade({this.veiculo, this.ocupacao = const {}});

  factory VivanCapacidade.fromJson(Map<String, dynamic> j) {
    final ocupMap = <String, int>{};
    final ocp = j['ocupacao'];
    if (ocp is Map) {
      ocp.forEach((k, v) => ocupMap[k.toString()] = _iOr(v, 0));
    }
    return VivanCapacidade(
      veiculo: j['veiculo'] is Map
          ? Map<String, dynamic>.from(j['veiculo'] as Map)
          : null,
      ocupacao: ocupMap,
    );
  }

  int get capacidadeVeiculo => _iOr(veiculo?['capacidade'], 0);
  String get placaVeiculo => veiculo?['placa']?.toString() ?? '';
}

// ============================================
// PAGINATED RESPONSE
// ============================================

class VivanPaginatedResponse<T> {
  final List<T> data;
  final int total;

  VivanPaginatedResponse({required this.data, required this.total});

  bool get isEmpty => data.isEmpty;
  int get count => data.length;
}
