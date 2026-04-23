import '../database.dart';

class KeepAliveTable extends SupabaseTable<KeepAliveRow> {
  @override
  String get tableName => 'keep_alive';

  @override
  KeepAliveRow createRow(Map<String, dynamic> data) => KeepAliveRow(data);
}

class KeepAliveRow extends SupabaseDataRow {
  KeepAliveRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KeepAliveTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get num => getField<int>('num');
  set num(int? value) => setField<int>('num', value);
}
