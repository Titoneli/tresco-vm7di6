import '../database.dart';

class TurmaTable extends SupabaseTable<TurmaRow> {
  @override
  String get tableName => 'turma';

  @override
  TurmaRow createRow(Map<String, dynamic> data) => TurmaRow(data);
}

class TurmaRow extends SupabaseDataRow {
  TurmaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TurmaTable();

  int get idTurma => getField<int>('idTurma')!;
  set idTurma(int value) => setField<int>('idTurma', value);

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get nomeTurma => getField<String>('nomeTurma');
  set nomeTurma(String? value) => setField<String>('nomeTurma', value);

  String? get domTurno => getField<String>('domTurno');
  set domTurno(String? value) => setField<String>('domTurno', value);

  String? get domSerie => getField<String>('domSerie');
  set domSerie(String? value) => setField<String>('domSerie', value);
}
