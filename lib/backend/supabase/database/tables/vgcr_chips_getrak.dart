import '../database.dart';

class VgcrChipsGetrakTable extends SupabaseTable<VgcrChipsGetrakRow> {
  @override
  String get tableName => 'vgcr_chips_getrak';

  @override
  VgcrChipsGetrakRow createRow(Map<String, dynamic> data) =>
      VgcrChipsGetrakRow(data);
}

class VgcrChipsGetrakRow extends SupabaseDataRow {
  VgcrChipsGetrakRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VgcrChipsGetrakTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  String? get chip => getField<String>('chip');
  set chip(String? value) => setField<String>('chip', value);

  String? get telefone => getField<String>('telefone');
  set telefone(String? value) => setField<String>('telefone', value);

  String? get operadora => getField<String>('operadora');
  set operadora(String? value) => setField<String>('operadora', value);

  String? get ativacao => getField<String>('ativacao');
  set ativacao(String? value) => setField<String>('ativacao', value);

  String? get cancelamento => getField<String>('cancelamento');
  set cancelamento(String? value) => setField<String>('cancelamento', value);

  String? get servico => getField<String>('servico');
  set servico(String? value) => setField<String>('servico', value);

  String? get produto => getField<String>('produto');
  set produto(String? value) => setField<String>('produto', value);

  String? get valorchip => getField<String>('valorchip');
  set valorchip(String? value) => setField<String>('valorchip', value);
}
