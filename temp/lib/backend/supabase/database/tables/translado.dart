import '../database.dart';

class TransladoTable extends SupabaseTable<TransladoRow> {
  @override
  String get tableName => 'translado';

  @override
  TransladoRow createRow(Map<String, dynamic> data) => TransladoRow(data);
}

class TransladoRow extends SupabaseDataRow {
  TransladoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TransladoTable();

  int get idTranslado => getField<int>('idTranslado')!;
  set idTranslado(int value) => setField<int>('idTranslado', value);

  String? get nomeTranslado => getField<String>('nomeTranslado');
  set nomeTranslado(String? value) => setField<String>('nomeTranslado', value);

  String? get domTipoTranslado => getField<String>('domTipoTranslado');
  set domTipoTranslado(String? value) =>
      setField<String>('domTipoTranslado', value);

  String? get cepTranslado => getField<String>('cepTranslado');
  set cepTranslado(String? value) => setField<String>('cepTranslado', value);

  String? get endTranslado => getField<String>('endTranslado');
  set endTranslado(String? value) => setField<String>('endTranslado', value);

  String? get numTranslado => getField<String>('numTranslado');
  set numTranslado(String? value) => setField<String>('numTranslado', value);

  String? get compTranslado => getField<String>('compTranslado');
  set compTranslado(String? value) => setField<String>('compTranslado', value);

  String? get bairroTranslado => getField<String>('bairroTranslado');
  set bairroTranslado(String? value) =>
      setField<String>('bairroTranslado', value);

  String? get cidadeTranslado => getField<String>('cidadeTranslado');
  set cidadeTranslado(String? value) =>
      setField<String>('cidadeTranslado', value);

  String? get ufTranslado => getField<String>('ufTranslado');
  set ufTranslado(String? value) => setField<String>('ufTranslado', value);

  String? get infoTranslado => getField<String>('infoTranslado');
  set infoTranslado(String? value) => setField<String>('infoTranslado', value);

  String? get pointGeo => getField<String>('pointGeo');
  set pointGeo(String? value) => setField<String>('pointGeo', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  double? get long => getField<double>('long');
  set long(double? value) => setField<double>('long', value);

  int? get idItinerarioAluno => getField<int>('idItinerarioAluno');
  set idItinerarioAluno(int? value) =>
      setField<int>('idItinerarioAluno', value);
}
