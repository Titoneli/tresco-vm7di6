import '../database.dart';

class EmpresaTable extends SupabaseTable<EmpresaRow> {
  @override
  String get tableName => 'empresa';

  @override
  EmpresaRow createRow(Map<String, dynamic> data) => EmpresaRow(data);
}

class EmpresaRow extends SupabaseDataRow {
  EmpresaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EmpresaTable();

  int get idEmpresa => getField<int>('idEmpresa')!;
  set idEmpresa(int value) => setField<int>('idEmpresa', value);

  DateTime get dtCadEmpresa => getField<DateTime>('dtCadEmpresa')!;
  set dtCadEmpresa(DateTime value) => setField<DateTime>('dtCadEmpresa', value);

  String? get nomeEmpresa => getField<String>('nomeEmpresa');
  set nomeEmpresa(String? value) => setField<String>('nomeEmpresa', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  double? get long => getField<double>('long');
  set long(double? value) => setField<double>('long', value);

  List<double> get latlong => getListField<double>('latlong');
  set latlong(List<double>? value) => setListField<double>('latlong', value);
}
