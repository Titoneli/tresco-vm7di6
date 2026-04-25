import '../database.dart';

class VeiculoTable extends SupabaseTable<VeiculoRow> {
  @override
  String get tableName => 'veiculo';

  @override
  VeiculoRow createRow(Map<String, dynamic> data) => VeiculoRow(data);
}

class VeiculoRow extends SupabaseDataRow {
  VeiculoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VeiculoTable();

  int get idVeiculo => getField<int>('idVeiculo')!;
  set idVeiculo(int value) => setField<int>('idVeiculo', value);

  DateTime? get dtVediculo => getField<DateTime>('dtVediculo');
  set dtVediculo(DateTime? value) => setField<DateTime>('dtVediculo', value);

  String? get placa => getField<String>('placa');
  set placa(String? value) => setField<String>('placa', value);

  String? get renavam => getField<String>('renavam');
  set renavam(String? value) => setField<String>('renavam', value);

  String? get chassis => getField<String>('chassis');
  set chassis(String? value) => setField<String>('chassis', value);

  String? get anoModelo => getField<String>('anoModelo');
  set anoModelo(String? value) => setField<String>('anoModelo', value);

  String? get corVeiculo => getField<String>('corVeiculo');
  set corVeiculo(String? value) => setField<String>('corVeiculo', value);

  String? get domCapacidade => getField<String>('domCapacidade');
  set domCapacidade(String? value) => setField<String>('domCapacidade', value);

  String? get domMarca => getField<String>('domMarca');
  set domMarca(String? value) => setField<String>('domMarca', value);

  String? get domModelo => getField<String>('domModelo');
  set domModelo(String? value) => setField<String>('domModelo', value);

  String? get idMotorista => getField<String>('idMotorista');
  set idMotorista(String? value) => setField<String>('idMotorista', value);

  String? get idCooperado => getField<String>('idCooperado');
  set idCooperado(String? value) => setField<String>('idCooperado', value);

  String? get domTipoVeiculo => getField<String>('domTipoVeiculo');
  set domTipoVeiculo(String? value) =>
      setField<String>('domTipoVeiculo', value);

  String? get domCategoriaVeiculo => getField<String>('domCategoriaVeiculo');
  set domCategoriaVeiculo(String? value) =>
      setField<String>('domCategoriaVeiculo', value);

  String? get idEmpresa => getField<String>('idEmpresa');
  set idEmpresa(String? value) => setField<String>('idEmpresa', value);

  String? get domSitVeiculo => getField<String>('domSitVeiculo');
  set domSitVeiculo(String? value) => setField<String>('domSitVeiculo', value);

  String? get codEmpresa => getField<String>('codEmpresa');
  set codEmpresa(String? value) => setField<String>('codEmpresa', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  double? get long => getField<double>('long');
  set long(double? value) => setField<double>('long', value);

  int? get anoLimiteVeiculo => getField<int>('anoLimiteVeiculo');
  set anoLimiteVeiculo(int? value) => setField<int>('anoLimiteVeiculo', value);
}
