/// Modelos de dados do módulo ViVan.
/// Mapeiam 1:1 com as tabelas do banco (vivan_*).
///
/// Quando virar app separado, estes modelos são reutilizados integralmente.

import 'dart:convert';

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
  final String? nomeEscola; // join
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

  factory VivanPassageiro.fromJson(Map<String, dynamic> json) {
    return VivanPassageiro(
      idPassageiro: json['idPassageiro'] as int?,
      idMotorista: json['idMotorista'] as int?,
      nomePassageiro: json['nomePassageiro'] as String? ?? '',
      cpfPassageiro: json['cpfPassageiro'] as String?,
      rgPassageiro: json['rgPassageiro'] as String?,
      dtNascimento: json['dtNascimento'] as String?,
      whatsAppPassageiro: json['whatsAppPassageiro'] as String?,
      telPassageiro: json['telPassageiro'] as String?,
      emailPassageiro: json['emailPassageiro'] as String?,
      cepPassageiro: json['cepPassageiro'] as String?,
      endPassageiro: json['endPassageiro'] as String? ?? '',
      numPassageiro: json['numPassageiro'] as String?,
      compPassageiro: json['compPassageiro'] as String?,
      bairroPassageiro: json['bairroPassageiro'] as String?,
      cidadePassageiro: json['cidadePassageiro'] as String?,
      ufPassageiro: json['ufPassageiro'] as String?,
      latPassageiro: (json['latPassageiro'] as num?)?.toDouble(),
      lngPassageiro: (json['lngPassageiro'] as num?)?.toDouble(),
      urlFoto: json['urlFoto'] as String?,
      idEscola: json['idEscola'] as int?,
      nomeEscola: json['nomeEscola'] as String?,
      domTurno: json['domTurno'] as String?,
      domSerie: json['domSerie'] as String?,
      idTurma: json['idTurma'] as int?,
      horarioEntrada: json['horarioEntrada'] as String?,
      horarioSaida: json['horarioSaida'] as String?,
      periodoLetivo: json['periodoLetivo'] as String?,
      necessidadesEspeciais: json['necessidadesEspeciais'] as String?,
      observacoes: json['observacoes'] as String?,
      domSexo: json['domSexo'] as String?,
      ativo: json['ativo'] as bool? ?? true,
    );
  }

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

  /// Endereço formatado
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

  /// Inicial do nome para avatar
  String get inicial => nomePassageiro.isNotEmpty ? nomePassageiro[0].toUpperCase() : 'P';
}


// ============================================
// ESCOLA
// ============================================

class VivanEscola {
  final int? idEscola;
  final int? idMotorista;
  final String nomeEscola;

  VivanEscola({
    this.idEscola,
    this.idMotorista,
    required this.nomeEscola,
  });

  factory VivanEscola.fromJson(Map<String, dynamic> json) {
    return VivanEscola(
      idEscola: json['idEscola'] as int?,
      idMotorista: json['idMotorista'] as int?,
      nomeEscola: json['nomeEscola'] as String? ?? '',
    );
  }

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

  factory VivanResponsavel.fromJson(Map<String, dynamic> json) {
    return VivanResponsavel(
      idResponsavel: json['idResponsavel'] as int?,
      idPassageiro: json['idPassageiro'] as int?,
      nomeResponsavel: json['nomeResponsavel'] as String? ?? '',
      cpfResponsavel: json['cpfResponsavel'] as String? ?? '',
      rgResponsavel: json['rgResponsavel'] as String?,
      parentesco: json['parentesco'] as String? ?? '',
      telResponsavel: json['telResponsavel'] as String?,
      whatsAppResponsavel: json['whatsAppResponsavel'] as String? ?? '',
      emailResponsavel: json['emailResponsavel'] as String? ?? '',
      endResponsavel: json['endResponsavel'] as String?,
      cnhResponsavel: json['cnhResponsavel'] as String?,
      profissao: json['profissao'] as String?,
      estadoCivil: json['estadoCivil'] as String?,
      principal: json['principal'] as bool? ?? true,
      ativo: json['ativo'] as bool? ?? true,
    );
  }

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
  // Joins
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

  factory VivanContrato.fromJson(Map<String, dynamic> json) {
    return VivanContrato(
      idContrato: json['idContrato'] as int?,
      numContrato: json['numContrato'] as String?,
      idMotorista: json['idMotorista'] as int?,
      idPassageiro: json['idPassageiro'] as int?,
      idResponsavel: json['idResponsavel'] as int?,
      idEscola: json['idEscola'] as int?,
      idVeiculo: json['idVeiculo'] as int?,
      domTurno: json['domTurno'] as String?,
      dtInicio: json['dtInicio'] as String?,
      dtTermino: json['dtTermino'] as String?,
      valMensal: (json['valMensal'] as num?)?.toDouble(),
      diaVencimento: json['diaVencimento'] as int?,
      domFormaPagamento: json['domFormaPagamento'] as String?,
      domCondicaoPagamento: json['domCondicaoPagamento'] as String?,
      percentualDesconto: (json['percentualDesconto'] as num?)?.toDouble(),
      percentualMulta: (json['percentualMulta'] as num?)?.toDouble(),
      percentualJurosDia: (json['percentualJurosDia'] as num?)?.toDouble(),
      clausulasAdicionais: json['clausulasAdicionais'] as Map<String, dynamic>?,
      status: json['status'] as String? ?? 'RASCUNHO',
      motivoCancelamento: json['motivoCancelamento'] as String?,
      motivoSuspensao: json['motivoSuspensao'] as String?,
      observacoes: json['observacoes'] as String?,
      nomePassageiro: json['nomePassageiro'] as String?,
      nomeResponsavel: json['nomeResponsavel'] as String?,
      nomeEscola: json['nomeEscola'] as String?,
    );
  }

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
  // Joins
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

  factory VivanMensalidade.fromJson(Map<String, dynamic> json) {
    return VivanMensalidade(
      idMensalidade: json['idMensalidade'] as int?,
      idContrato: json['idContrato'] as int?,
      idPassageiro: json['idPassageiro'] as int?,
      idResponsavel: json['idResponsavel'] as int?,
      idMotorista: json['idMotorista'] as int?,
      mesReferencia: json['mesReferencia'] as String?,
      dtVencimento: json['dtVencimento'] as String?,
      valOriginal: (json['valOriginal'] as num?)?.toDouble(),
      valDesconto: (json['valDesconto'] as num?)?.toDouble(),
      valMulta: (json['valMulta'] as num?)?.toDouble(),
      valJuros: (json['valJuros'] as num?)?.toDouble(),
      valPago: (json['valPago'] as num?)?.toDouble(),
      dtPagamento: json['dtPagamento'] as String?,
      formaPagamento: json['formaPagamento'] as String?,
      status: json['status'] as String? ?? 'AGUARDANDO',
      asaasPixQrCode: json['asaasPixQrCode'] as String?,
      asaasPixCopiaECola: json['asaasPixCopiaECola'] as String?,
      asaasInvoiceUrl: json['asaasInvoiceUrl'] as String?,
      asaasBankSlipUrl: json['asaasBankSlipUrl'] as String?,
      comprovanteUrl: json['comprovanteUrl'] as String?,
      motivoAbono: json['motivoAbono'] as String?,
      observacoes: json['observacoes'] as String?,
      nomePassageiro: json['nomePassageiro'] as String?,
      nomeResponsavel: json['nomeResponsavel'] as String?,
      numContrato: json['numContrato'] as String?,
      turnoPassageiro: json['turnoPassageiro'] as String?,
    );
  }

  /// Valor líquido a pagar
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

  factory VivanDespesa.fromJson(Map<String, dynamic> json) {
    return VivanDespesa(
      idDespesa: json['idDespesa'] as int?,
      idMotorista: json['idMotorista'] as int?,
      idVeiculo: json['idVeiculo'] as int?,
      categoria: json['categoria'] as String? ?? '',
      descricao: json['descricao'] as String? ?? '',
      valor: (json['valor'] as num?)?.toDouble() ?? 0,
      dtDespesa: json['dtDespesa'] as String? ?? '',
      dtVencimento: json['dtVencimento'] as String?,
      pago: json['pago'] as bool? ?? false,
      dtPagamento: json['dtPagamento'] as String?,
      comprovanteUrl: json['comprovanteUrl'] as String?,
      mesReferencia: json['mesReferencia'] as String?,
      observacoes: json['observacoes'] as String?,
      tipoLancamento: json['tipoLancamento'] as String? ?? 'DESPESA',
      recorrente: json['recorrente'] as bool? ?? false,
      diaVencimento: json['diaVencimento'] as int?,
      mesInicial: json['mesInicial'] as String?,
      mesFinal: json['mesFinal'] as String?,
    );
  }

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
  final String tipoPresenca; // P = Presente, F = Falta
  final String? justificativa;
  final double? latRegistro;
  final double? lngRegistro;
  // Join
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

  factory VivanPresenca.fromJson(Map<String, dynamic> json) {
    return VivanPresenca(
      idPresenca: json['idPresenca'] as int?,
      idContrato: json['idContrato'] as int?,
      idPassageiro: json['idPassageiro'] as int?,
      idMotorista: json['idMotorista'] as int?,
      dtPresenca: json['dtPresenca'] as String?,
      domTurno: json['domTurno'] as String?,
      tipoPresenca: json['tipoPresenca'] as String? ?? 'P',
      justificativa: json['justificativa'] as String?,
      latRegistro: (json['latRegistro'] as num?)?.toDouble(),
      lngRegistro: (json['lngRegistro'] as num?)?.toDouble(),
      nomePassageiro: json['nomePassageiro'] as String?,
    );
  }

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

  factory VivanContratoHistorico.fromJson(Map<String, dynamic> json) {
    return VivanContratoHistorico(
      idHistorico: json['idHistorico'] as int?,
      idContrato: json['idContrato'] as int?,
      tipoAlteracao: json['tipoAlteracao'] as String?,
      statusAnterior: json['statusAnterior'] as String?,
      statusNovo: json['statusNovo'] as String?,
      usuario: json['usuario'] as String?,
      descricao: json['descricao'] as String?,
      dtAlteracao: json['dtAlteracao'] as String?,
    );
  }
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

  factory VivanDashboardResumo.fromJson(Map<String, dynamic> json) {
    return VivanDashboardResumo(
      mesReferencia: json['mesReferencia'] as String? ?? '',
      totalPassageiros: json['totalPassageiros'] as int? ?? 0,
      passageirosAtivos: json['passageirosAtivos'] as int? ?? 0,
      totalContratos: json['totalContratos'] as int? ?? 0,
      contratosAtivos: json['contratosAtivos'] as int? ?? 0,
      mensalidadesPendentes: json['mensalidadesPendentes'] as int? ?? 0,
      mensalidadesAtrasadas: json['mensalidadesAtrasadas'] as int? ?? 0,
      totalAReceber: (json['totalAReceber'] as num?)?.toDouble() ?? 0,
      totalRecebido: (json['totalRecebido'] as num?)?.toDouble() ?? 0,
      totalAbonado: (json['totalAbonado'] as num?)?.toDouble() ?? 0,
      totalInadimplente: (json['totalInadimplente'] as num?)?.toDouble() ?? 0,
      totalDespesas: (json['totalDespesas'] as num?)?.toDouble() ?? 0,
    );
  }

  /// Saldo do mês = recebido - despesas
  double get saldoMes => totalRecebido - totalDespesas;

  /// Percentual de inadimplência
  double get percentualInadimplencia =>
      totalAReceber > 0 ? (totalInadimplente / totalAReceber) * 100 : 0;
}

// ============================================
// CAPACIDADE
// ============================================

class VivanCapacidade {
  final Map<String, dynamic>? veiculo;
  final Map<String, int> ocupacao; // turno -> quantidade

  VivanCapacidade({
    this.veiculo,
    this.ocupacao = const {},
  });

  factory VivanCapacidade.fromJson(Map<String, dynamic> json) {
    final ocupMap = <String, int>{};
    final ocp = json['ocupacao'];
    if (ocp is Map) {
      ocp.forEach((k, v) {
        ocupMap[k.toString()] = (v as num?)?.toInt() ?? 0;
      });
    }
    return VivanCapacidade(
      veiculo: json['veiculo'] as Map<String, dynamic>?,
      ocupacao: ocupMap,
    );
  }

  int get capacidadeVeiculo =>
      (veiculo?['capacidade'] as num?)?.toInt() ?? 0;

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
