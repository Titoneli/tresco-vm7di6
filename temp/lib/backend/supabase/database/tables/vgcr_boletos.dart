import '../database.dart';

class VgcrBoletosTable extends SupabaseTable<VgcrBoletosRow> {
  @override
  String get tableName => 'vgcr_boletos';

  @override
  VgcrBoletosRow createRow(Map<String, dynamic> data) => VgcrBoletosRow(data);
}

class VgcrBoletosRow extends SupabaseDataRow {
  VgcrBoletosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VgcrBoletosTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get nome => getField<String>('nome');
  set nome(String? value) => setField<String>('nome', value);

  String? get placa => getField<String>('placa');
  set placa(String? value) => setField<String>('placa', value);

  String? get valor => getField<String>('valor');
  set valor(String? value) => setField<String>('valor', value);

  String? get vencimento => getField<String>('vencimento');
  set vencimento(String? value) => setField<String>('vencimento', value);

  String? get situacao => getField<String>('situacao');
  set situacao(String? value) => setField<String>('situacao', value);

  String? get sitveiculo => getField<String>('sitveiculo');
  set sitveiculo(String? value) => setField<String>('sitveiculo', value);
}
