import '../database.dart';

class AtfTable extends SupabaseTable<AtfRow> {
  @override
  String get tableName => 'atf';

  @override
  AtfRow createRow(Map<String, dynamic> data) => AtfRow(data);
}

class AtfRow extends SupabaseDataRow {
  AtfRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AtfTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get origem => getField<String>('origem');
  set origem(String? value) => setField<String>('origem', value);

  String? get destino => getField<String>('destino');
  set destino(String? value) => setField<String>('destino', value);

  DateTime? get dataIda => getField<DateTime>('data_ida');
  set dataIda(DateTime? value) => setField<DateTime>('data_ida', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
