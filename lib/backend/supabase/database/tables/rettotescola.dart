import '../database.dart';

class RettotescolaTable extends SupabaseTable<RettotescolaRow> {
  @override
  String get tableName => 'rettotescola';

  @override
  RettotescolaRow createRow(Map<String, dynamic> data) => RettotescolaRow(data);
}

class RettotescolaRow extends SupabaseDataRow {
  RettotescolaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotescolaTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get domSitAluno => getField<String>('domSitAluno');
  set domSitAluno(String? value) => setField<String>('domSitAluno', value);

  int? get count => getField<int>('count');
  set count(int? value) => setField<int>('count', value);
}
