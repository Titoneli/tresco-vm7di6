import '../database.dart';

class ItinerarioAlunoTable extends SupabaseTable<ItinerarioAlunoRow> {
  @override
  String get tableName => 'itinerarioAluno';

  @override
  ItinerarioAlunoRow createRow(Map<String, dynamic> data) =>
      ItinerarioAlunoRow(data);
}

class ItinerarioAlunoRow extends SupabaseDataRow {
  ItinerarioAlunoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ItinerarioAlunoTable();

  int get idItinerarioAluno => getField<int>('idItinerarioAluno')!;
  set idItinerarioAluno(int value) => setField<int>('idItinerarioAluno', value);

  int? get idVeiculo => getField<int>('idVeiculo');
  set idVeiculo(int? value) => setField<int>('idVeiculo', value);

  PostgresTime? get idaSobe => getField<PostgresTime>('idaSobe');
  set idaSobe(PostgresTime? value) => setField<PostgresTime>('idaSobe', value);

  PostgresTime? get idaDesce => getField<PostgresTime>('idaDesce');
  set idaDesce(PostgresTime? value) =>
      setField<PostgresTime>('idaDesce', value);

  PostgresTime? get voltaSobe => getField<PostgresTime>('voltaSobe');
  set voltaSobe(PostgresTime? value) =>
      setField<PostgresTime>('voltaSobe', value);

  PostgresTime? get voltaDesc => getField<PostgresTime>('voltaDesc');
  set voltaDesc(PostgresTime? value) =>
      setField<PostgresTime>('voltaDesc', value);

  double? get idaDistancia => getField<double>('idaDistancia');
  set idaDistancia(double? value) => setField<double>('idaDistancia', value);

  double? get voltaDistancia => getField<double>('voltaDistancia');
  set voltaDistancia(double? value) =>
      setField<double>('voltaDistancia', value);

  int? get seqItinerarioVeiculo => getField<int>('seqItinerarioVeiculo');
  set seqItinerarioVeiculo(int? value) =>
      setField<int>('seqItinerarioVeiculo', value);

  double? get anteDistPonto => getField<double>('anteDistPonto');
  set anteDistPonto(double? value) => setField<double>('anteDistPonto', value);

  double? get proxDistPonto => getField<double>('proxDistPonto');
  set proxDistPonto(double? value) => setField<double>('proxDistPonto', value);

  String? get domTipoItinerario => getField<String>('domTipoItinerario');
  set domTipoItinerario(String? value) =>
      setField<String>('domTipoItinerario', value);

  String? get domSitItinerario => getField<String>('domSitItinerario');
  set domSitItinerario(String? value) =>
      setField<String>('domSitItinerario', value);
}
