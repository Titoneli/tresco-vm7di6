import '../database.dart';

class AtfPassageiroTable extends SupabaseTable<AtfPassageiroRow> {
  @override
  String get tableName => 'atf_passageiro';

  @override
  AtfPassageiroRow createRow(Map<String, dynamic> data) =>
      AtfPassageiroRow(data);
}

class AtfPassageiroRow extends SupabaseDataRow {
  AtfPassageiroRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AtfPassageiroTable();

  int get idAtfPassageiro => getField<int>('id_atf_passageiro')!;
  set idAtfPassageiro(int value) => setField<int>('id_atf_passageiro', value);

  int get idAtf => getField<int>('id_atf')!;
  set idAtf(int value) => setField<int>('id_atf', value);

  String get nome => getField<String>('nome')!;
  set nome(String value) => setField<String>('nome', value);

  String get cpf => getField<String>('cpf')!;
  set cpf(String value) => setField<String>('cpf', value);

  String? get vinculo => getField<String>('vinculo');
  set vinculo(String? value) => setField<String>('vinculo', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
