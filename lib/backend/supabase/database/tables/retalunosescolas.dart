import '../database.dart';

class RetalunosescolasTable extends SupabaseTable<RetalunosescolasRow> {
  @override
  String get tableName => 'retalunosescolas';

  @override
  RetalunosescolasRow createRow(Map<String, dynamic> data) =>
      RetalunosescolasRow(data);
}

class RetalunosescolasRow extends SupabaseDataRow {
  RetalunosescolasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RetalunosescolasTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  DateTime? get dtEscola => getField<DateTime>('dtEscola');
  set dtEscola(DateTime? value) => setField<DateTime>('dtEscola', value);

  String? get nomeEscola => getField<String>('nomeEscola');
  set nomeEscola(String? value) => setField<String>('nomeEscola', value);

  String? get domTipoEscola => getField<String>('domTipoEscola');
  set domTipoEscola(String? value) => setField<String>('domTipoEscola', value);

  String? get whatsAppEscola => getField<String>('whatsAppEscola');
  set whatsAppEscola(String? value) =>
      setField<String>('whatsAppEscola', value);

  String? get telEscola => getField<String>('telEscola');
  set telEscola(String? value) => setField<String>('telEscola', value);

  String? get emailEscola => getField<String>('emailEscola');
  set emailEscola(String? value) => setField<String>('emailEscola', value);

  String? get cepEscola => getField<String>('cepEscola');
  set cepEscola(String? value) => setField<String>('cepEscola', value);

  String? get endEscola => getField<String>('endEscola');
  set endEscola(String? value) => setField<String>('endEscola', value);

  String? get numEscola => getField<String>('numEscola');
  set numEscola(String? value) => setField<String>('numEscola', value);

  String? get compEscola => getField<String>('compEscola');
  set compEscola(String? value) => setField<String>('compEscola', value);

  String? get bairroEscola => getField<String>('bairroEscola');
  set bairroEscola(String? value) => setField<String>('bairroEscola', value);

  String? get cidadeEscola => getField<String>('cidadeEscola');
  set cidadeEscola(String? value) => setField<String>('cidadeEscola', value);

  String? get ufEscola => getField<String>('ufEscola');
  set ufEscola(String? value) => setField<String>('ufEscola', value);

  String? get infoEscola => getField<String>('infoEscola');
  set infoEscola(String? value) => setField<String>('infoEscola', value);

  String? get pointGeo => getField<String>('pointGeo');
  set pointGeo(String? value) => setField<String>('pointGeo', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  double? get long => getField<double>('long');
  set long(double? value) => setField<double>('long', value);

  int? get idEmpresa => getField<int>('idEmpresa');
  set idEmpresa(int? value) => setField<int>('idEmpresa', value);

  String? get domSituacao => getField<String>('domSituacao');
  set domSituacao(String? value) => setField<String>('domSituacao', value);

  String? get codEmpresa => getField<String>('codEmpresa');
  set codEmpresa(String? value) => setField<String>('codEmpresa', value);

  String? get siglaEscola => getField<String>('siglaEscola');
  set siglaEscola(String? value) => setField<String>('siglaEscola', value);

  bool? get ativo => getField<bool>('ativo');
  set ativo(bool? value) => setField<bool>('ativo', value);

  double? get valContrato => getField<double>('valContrato');
  set valContrato(double? value) => setField<double>('valContrato', value);

  int? get alunosescola => getField<int>('alunosescola');
  set alunosescola(int? value) => setField<int>('alunosescola', value);

  int? get alunosmotorista => getField<int>('alunosmotorista');
  set alunosmotorista(int? value) => setField<int>('alunosmotorista', value);

  int? get alunossemmotorista => getField<int>('alunossemmotorista');
  set alunossemmotorista(int? value) =>
      setField<int>('alunossemmotorista', value);

  String? get valalunosmotorista => getField<String>('valalunosmotorista');
  set valalunosmotorista(String? value) =>
      setField<String>('valalunosmotorista', value);

  String? get valalunosapagar => getField<String>('valalunosapagar');
  set valalunosapagar(String? value) =>
      setField<String>('valalunosapagar', value);
}
