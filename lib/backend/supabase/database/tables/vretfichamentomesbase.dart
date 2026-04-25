import '../database.dart';

class VretfichamentomesbaseTable
    extends SupabaseTable<VretfichamentomesbaseRow> {
  @override
  String get tableName => 'vretfichamentomesbase';

  @override
  VretfichamentomesbaseRow createRow(Map<String, dynamic> data) =>
      VretfichamentomesbaseRow(data);
}

class VretfichamentomesbaseRow extends SupabaseDataRow {
  VretfichamentomesbaseRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VretfichamentomesbaseTable();

  String? get mesbase => getField<String>('mesbase');
  set mesbase(String? value) => setField<String>('mesbase', value);
}
