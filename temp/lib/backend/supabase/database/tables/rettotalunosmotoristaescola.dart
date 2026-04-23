import '../database.dart';

class RettotalunosmotoristaescolaTable
    extends SupabaseTable<RettotalunosmotoristaescolaRow> {
  @override
  String get tableName => 'rettotalunosmotoristaescola';

  @override
  RettotalunosmotoristaescolaRow createRow(Map<String, dynamic> data) =>
      RettotalunosmotoristaescolaRow(data);
}

class RettotalunosmotoristaescolaRow extends SupabaseDataRow {
  RettotalunosmotoristaescolaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotalunosmotoristaescolaTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  int? get totcapacidade => getField<int>('totcapacidade');
  set totcapacidade(int? value) => setField<int>('totcapacidade', value);

  double? get totassentosocupados => getField<double>('totassentosocupados');
  set totassentosocupados(double? value) =>
      setField<double>('totassentosocupados', value);

  double? get totassentosdisponiveis =>
      getField<double>('totassentosdisponiveis');
  set totassentosdisponiveis(double? value) =>
      setField<double>('totassentosdisponiveis', value);

  double? get totassentosocupadosmanha =>
      getField<double>('totassentosocupadosmanha');
  set totassentosocupadosmanha(double? value) =>
      setField<double>('totassentosocupadosmanha', value);

  double? get totassentosdisponiveismanha =>
      getField<double>('totassentosdisponiveismanha');
  set totassentosdisponiveismanha(double? value) =>
      setField<double>('totassentosdisponiveismanha', value);

  double? get totassentosocupadostarde =>
      getField<double>('totassentosocupadostarde');
  set totassentosocupadostarde(double? value) =>
      setField<double>('totassentosocupadostarde', value);

  double? get totassentosdisponiveistarde =>
      getField<double>('totassentosdisponiveistarde');
  set totassentosdisponiveistarde(double? value) =>
      setField<double>('totassentosdisponiveistarde', value);

  double? get totassentosocupadosnoite =>
      getField<double>('totassentosocupadosnoite');
  set totassentosocupadosnoite(double? value) =>
      setField<double>('totassentosocupadosnoite', value);

  double? get totassentosdisponiveisnoite =>
      getField<double>('totassentosdisponiveisnoite');
  set totassentosdisponiveisnoite(double? value) =>
      setField<double>('totassentosdisponiveisnoite', value);

  double? get totvalmensal => getField<double>('totvalmensal');
  set totvalmensal(double? value) => setField<double>('totvalmensal', value);
}
