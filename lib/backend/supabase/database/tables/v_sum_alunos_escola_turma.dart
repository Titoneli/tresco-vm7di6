import '../database.dart';

class VSumAlunosEscolaTurmaTable
    extends SupabaseTable<VSumAlunosEscolaTurmaRow> {
  @override
  String get tableName => 'v_sum_alunos_escola_turma';

  @override
  VSumAlunosEscolaTurmaRow createRow(Map<String, dynamic> data) =>
      VSumAlunosEscolaTurmaRow(data);
}

class VSumAlunosEscolaTurmaRow extends SupabaseDataRow {
  VSumAlunosEscolaTurmaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VSumAlunosEscolaTurmaTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get nomeEscola => getField<String>('nomeEscola');
  set nomeEscola(String? value) => setField<String>('nomeEscola', value);

  String? get domTurno => getField<String>('domTurno');
  set domTurno(String? value) => setField<String>('domTurno', value);

  String? get nomeTurma => getField<String>('nomeTurma');
  set nomeTurma(String? value) => setField<String>('nomeTurma', value);

  int? get qtdalunos => getField<int>('qtdalunos');
  set qtdalunos(int? value) => setField<int>('qtdalunos', value);
}
