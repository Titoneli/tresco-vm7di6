import '../database.dart';

class RettotmotoristaTable extends SupabaseTable<RettotmotoristaRow> {
  @override
  String get tableName => 'rettotmotorista';

  @override
  RettotmotoristaRow createRow(Map<String, dynamic> data) =>
      RettotmotoristaRow(data);
}

class RettotmotoristaRow extends SupabaseDataRow {
  RettotmotoristaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotmotoristaTable();

  int? get idMotorista => getField<int>('idMotorista');
  set idMotorista(int? value) => setField<int>('idMotorista', value);

  String? get domSitAluno => getField<String>('domSitAluno');
  set domSitAluno(String? value) => setField<String>('domSitAluno', value);

  int? get count => getField<int>('count');
  set count(int? value) => setField<int>('count', value);
}
