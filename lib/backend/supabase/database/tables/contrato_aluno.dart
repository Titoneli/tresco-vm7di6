import '../database.dart';

class ContratoAlunoTable extends SupabaseTable<ContratoAlunoRow> {
  @override
  String get tableName => 'contratoAluno';

  @override
  ContratoAlunoRow createRow(Map<String, dynamic> data) =>
      ContratoAlunoRow(data);
}

class ContratoAlunoRow extends SupabaseDataRow {
  ContratoAlunoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ContratoAlunoTable();

  int get idContratoAluno => getField<int>('idContratoAluno')!;
  set idContratoAluno(int value) => setField<int>('idContratoAluno', value);

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  DateTime get dtContratoAluno => getField<DateTime>('dtContratoAluno')!;
  set dtContratoAluno(DateTime value) =>
      setField<DateTime>('dtContratoAluno', value);

  DateTime? get dtInicio => getField<DateTime>('dtInicio');
  set dtInicio(DateTime? value) => setField<DateTime>('dtInicio', value);

  DateTime? get dtFinal => getField<DateTime>('dtFinal');
  set dtFinal(DateTime? value) => setField<DateTime>('dtFinal', value);

  String? get dtPrimeiroVencimento => getField<String>('dtPrimeiroVencimento');
  set dtPrimeiroVencimento(String? value) =>
      setField<String>('dtPrimeiroVencimento', value);

  String? get domFormaPagto => getField<String>('domFormaPagto');
  set domFormaPagto(String? value) => setField<String>('domFormaPagto', value);

  String? get domIntervalo => getField<String>('domIntervalo');
  set domIntervalo(String? value) => setField<String>('domIntervalo', value);

  String? get domDiaVencimento => getField<String>('domDiaVencimento');
  set domDiaVencimento(String? value) =>
      setField<String>('domDiaVencimento', value);

  int? get numParcelas => getField<int>('numParcelas');
  set numParcelas(int? value) => setField<int>('numParcelas', value);

  String? get domContaBancaria => getField<String>('domContaBancaria');
  set domContaBancaria(String? value) =>
      setField<String>('domContaBancaria', value);

  String? get domPeriodo => getField<String>('domPeriodo');
  set domPeriodo(String? value) => setField<String>('domPeriodo', value);

  String? get domSala => getField<String>('domSala');
  set domSala(String? value) => setField<String>('domSala', value);

  String? get domSerie => getField<String>('domSerie');
  set domSerie(String? value) => setField<String>('domSerie', value);

  String? get domSituacao => getField<String>('domSituacao');
  set domSituacao(String? value) => setField<String>('domSituacao', value);

  String? get domFinanceiro => getField<String>('domFinanceiro');
  set domFinanceiro(String? value) => setField<String>('domFinanceiro', value);

  String? get domQuestionario => getField<String>('domQuestionario');
  set domQuestionario(String? value) =>
      setField<String>('domQuestionario', value);

  int? get idAluno => getField<int>('idAluno');
  set idAluno(int? value) => setField<int>('idAluno', value);

  dynamic get fotoAluno => getField<dynamic>('fotoAluno');
  set fotoAluno(dynamic value) => setField<dynamic>('fotoAluno', value);

  String? get fotoAlunob => getField<String>('fotoAlunob');
  set fotoAlunob(String? value) => setField<String>('fotoAlunob', value);

  String? get fotoAlunoBucket => getField<String>('fotoAlunoBucket');
  set fotoAlunoBucket(String? value) =>
      setField<String>('fotoAlunoBucket', value);
}
