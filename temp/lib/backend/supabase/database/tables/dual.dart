import '../database.dart';

class DualTable extends SupabaseTable<DualRow> {
  @override
  String get tableName => 'dual';

  @override
  DualRow createRow(Map<String, dynamic> data) => DualRow(data);
}

class DualRow extends SupabaseDataRow {
  DualRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DualTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);
}
