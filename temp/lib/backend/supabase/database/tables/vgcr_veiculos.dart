import '../database.dart';

class VgcrVeiculosTable extends SupabaseTable<VgcrVeiculosRow> {
  @override
  String get tableName => 'vgcr_veiculos';

  @override
  VgcrVeiculosRow createRow(Map<String, dynamic> data) => VgcrVeiculosRow(data);
}

class VgcrVeiculosRow extends SupabaseDataRow {
  VgcrVeiculosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VgcrVeiculosTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get nome => getField<String>('nome');
  set nome(String? value) => setField<String>('nome', value);

  String? get cpfcnpj => getField<String>('cpfcnpj');
  set cpfcnpj(String? value) => setField<String>('cpfcnpj', value);

  String? get tipoveiculo => getField<String>('tipoveiculo');
  set tipoveiculo(String? value) => setField<String>('tipoveiculo', value);

  String? get placa => getField<String>('placa');
  set placa(String? value) => setField<String>('placa', value);

  String? get equipamento => getField<String>('equipamento');
  set equipamento(String? value) => setField<String>('equipamento', value);

  String? get situacao => getField<String>('situacao');
  set situacao(String? value) => setField<String>('situacao', value);

  String? get sitcliente => getField<String>('sitcliente');
  set sitcliente(String? value) => setField<String>('sitcliente', value);

  String? get interveniente => getField<String>('interveniente');
  set interveniente(String? value) => setField<String>('interveniente', value);

  String? get chip => getField<String>('chip');
  set chip(String? value) => setField<String>('chip', value);

  String? get iccid => getField<String>('iccid');
  set iccid(String? value) => setField<String>('iccid', value);

  String? get imeiEquipamento => getField<String>('imei_equipamento');
  set imeiEquipamento(String? value) =>
      setField<String>('imei_equipamento', value);
}
