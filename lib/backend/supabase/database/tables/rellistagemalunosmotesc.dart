import '../database.dart';

class RellistagemalunosmotescTable
    extends SupabaseTable<RellistagemalunosmotescRow> {
  @override
  String get tableName => 'rellistagemalunosmotesc';

  @override
  RellistagemalunosmotescRow createRow(Map<String, dynamic> data) =>
      RellistagemalunosmotescRow(data);
}

class RellistagemalunosmotescRow extends SupabaseDataRow {
  RellistagemalunosmotescRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RellistagemalunosmotescTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  int? get idMotorista => getField<int>('idMotorista');
  set idMotorista(int? value) => setField<int>('idMotorista', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get cpfUsuario => getField<String>('cpfUsuario');
  set cpfUsuario(String? value) => setField<String>('cpfUsuario', value);

  double? get valAluno => getField<double>('valAluno');
  set valAluno(double? value) => setField<double>('valAluno', value);

  String? get domTipoPessoa => getField<String>('domTipoPessoa');
  set domTipoPessoa(String? value) => setField<String>('domTipoPessoa', value);

  String? get codINSS => getField<String>('codINSS');
  set codINSS(String? value) => setField<String>('codINSS', value);

  double? get qtddependentesir => getField<double>('qtddependentesir');
  set qtddependentesir(double? value) =>
      setField<double>('qtddependentesir', value);

  String? get pix => getField<String>('pix');
  set pix(String? value) => setField<String>('pix', value);

  String? get valDescontoCooperativa =>
      getField<String>('valDescontoCooperativa');
  set valDescontoCooperativa(String? value) =>
      setField<String>('valDescontoCooperativa', value);

  String? get matriculaCooperativa => getField<String>('matriculaCooperativa');
  set matriculaCooperativa(String? value) =>
      setField<String>('matriculaCooperativa', value);

  String? get nomeescola => getField<String>('nomeescola');
  set nomeescola(String? value) => setField<String>('nomeescola', value);

  String? get nomeAluno => getField<String>('nomeAluno');
  set nomeAluno(String? value) => setField<String>('nomeAluno', value);

  String? get domturno => getField<String>('domturno');
  set domturno(String? value) => setField<String>('domturno', value);

  String? get nometurma => getField<String>('nometurma');
  set nometurma(String? value) => setField<String>('nometurma', value);
}
