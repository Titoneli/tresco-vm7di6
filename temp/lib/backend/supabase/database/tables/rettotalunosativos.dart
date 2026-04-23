import '../database.dart';

class RettotalunosativosTable extends SupabaseTable<RettotalunosativosRow> {
  @override
  String get tableName => 'rettotalunosativos';

  @override
  RettotalunosativosRow createRow(Map<String, dynamic> data) =>
      RettotalunosativosRow(data);
}

class RettotalunosativosRow extends SupabaseDataRow {
  RettotalunosativosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotalunosativosTable();

  int? get count => getField<int>('count');
  set count(int? value) => setField<int>('count', value);
}
