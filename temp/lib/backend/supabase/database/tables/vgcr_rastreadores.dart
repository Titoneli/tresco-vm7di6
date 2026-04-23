import '../database.dart';

class VgcrRastreadoresTable extends SupabaseTable<VgcrRastreadoresRow> {
  @override
  String get tableName => 'vgcr_rastreadores';

  @override
  VgcrRastreadoresRow createRow(Map<String, dynamic> data) =>
      VgcrRastreadoresRow(data);
}

class VgcrRastreadoresRow extends SupabaseDataRow {
  VgcrRastreadoresRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VgcrRastreadoresTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get equipamento => getField<String>('equipamento');
  set equipamento(String? value) => setField<String>('equipamento', value);

  String? get chip => getField<String>('chip');
  set chip(String? value) => setField<String>('chip', value);

  String? get dddchip => getField<String>('dddchip');
  set dddchip(String? value) => setField<String>('dddchip', value);

  String? get telefone => getField<String>('telefone');
  set telefone(String? value) => setField<String>('telefone', value);

  String? get cliente => getField<String>('cliente');
  set cliente(String? value) => setField<String>('cliente', value);

  String? get interveniente => getField<String>('interveniente');
  set interveniente(String? value) => setField<String>('interveniente', value);

  String? get imeiEquipamento => getField<String>('imei_equipamento');
  set imeiEquipamento(String? value) =>
      setField<String>('imei_equipamento', value);

  String? get placa => getField<String>('placa');
  set placa(String? value) => setField<String>('placa', value);
}
