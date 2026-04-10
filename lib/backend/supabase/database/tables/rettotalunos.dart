import '../database.dart';

class RettotalunosTable extends SupabaseTable<RettotalunosRow> {
  @override
  String get tableName => 'rettotalunos';

  @override
  RettotalunosRow createRow(Map<String, dynamic> data) => RettotalunosRow(data);
}

class RettotalunosRow extends SupabaseDataRow {
  RettotalunosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotalunosTable();

  String? get domSitAluno => getField<String>('domSitAluno');
  set domSitAluno(String? value) => setField<String>('domSitAluno', value);

  int? get count => getField<int>('count');
  set count(int? value) => setField<int>('count', value);
}
