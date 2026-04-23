import '../database.dart';

class AtfPassageiroTable extends SupabaseTable<AtfPassageiroRow> {
  @override
  String get tableName => 'atf_passageiro';

  @override
  AtfPassageiroRow createRow(Map<String, dynamic> data) => AtfPassageiroRow(data);
}

class AtfPassageiroRow extends SupabaseDataRow {
  AtfPassageiroRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AtfPassageiroTable();

  String get id => getField<String>('id')!;
  String get atfId => getField<String>('atf_id')!;
  String? get nome => getField<String>('nome');
  String? get cpf => getField<String>('cpf');
  String? get vinculo => getField<String>('vinculo');
  DateTime get createdAt => getField<DateTime>('created_at')!;
}