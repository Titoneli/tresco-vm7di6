import '../database.dart';

class FilesTable extends SupabaseTable<FilesRow> {
  @override
  String get tableName => 'files';

  @override
  FilesRow createRow(Map<String, dynamic> data) => FilesRow(data);
}

class FilesRow extends SupabaseDataRow {
  FilesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FilesTable();

  String? get fileId => getField<String>('file_id');
  set fileId(String? value) => setField<String>('file_id', value);

  String? get fileName => getField<String>('file_name');
  set fileName(String? value) => setField<String>('file_name', value);

  String? get storageId => getField<String>('storage_id');
  set storageId(String? value) => setField<String>('storage_id', value);
}
