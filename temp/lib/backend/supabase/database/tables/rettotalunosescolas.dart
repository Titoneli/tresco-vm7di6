import '../database.dart';

class RettotalunosescolasTable extends SupabaseTable<RettotalunosescolasRow> {
  @override
  String get tableName => 'rettotalunosescolas';

  @override
  RettotalunosescolasRow createRow(Map<String, dynamic> data) =>
      RettotalunosescolasRow(data);
}

class RettotalunosescolasRow extends SupabaseDataRow {
  RettotalunosescolasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotalunosescolasTable();

  double? get totalunosescola => getField<double>('totalunosescola');
  set totalunosescola(double? value) =>
      setField<double>('totalunosescola', value);

  double? get totalunosmotorista => getField<double>('totalunosmotorista');
  set totalunosmotorista(double? value) =>
      setField<double>('totalunosmotorista', value);

  double? get totalunossemmotorista =>
      getField<double>('totalunossemmotorista');
  set totalunossemmotorista(double? value) =>
      setField<double>('totalunossemmotorista', value);
}
