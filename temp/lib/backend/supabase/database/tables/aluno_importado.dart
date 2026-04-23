import '../database.dart';

class AlunoImportadoTable extends SupabaseTable<AlunoImportadoRow> {
  @override
  String get tableName => 'aluno_importado';

  @override
  AlunoImportadoRow createRow(Map<String, dynamic> data) =>
      AlunoImportadoRow(data);
}

class AlunoImportadoRow extends SupabaseDataRow {
  AlunoImportadoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AlunoImportadoTable();

  int get idAluno => getField<int>('idAluno')!;
  set idAluno(int value) => setField<int>('idAluno', value);

  DateTime get dtAluno => getField<DateTime>('dtAluno')!;
  set dtAluno(DateTime value) => setField<DateTime>('dtAluno', value);

  String? get nomeAluno => getField<String>('nomeAluno');
  set nomeAluno(String? value) => setField<String>('nomeAluno', value);

  String? get domTipoAluno => getField<String>('domTipoAluno');
  set domTipoAluno(String? value) => setField<String>('domTipoAluno', value);

  String? get whatsAppAluno => getField<String>('whatsAppAluno');
  set whatsAppAluno(String? value) => setField<String>('whatsAppAluno', value);

  String? get telAluno => getField<String>('telAluno');
  set telAluno(String? value) => setField<String>('telAluno', value);

  String? get emailAluno => getField<String>('emailAluno');
  set emailAluno(String? value) => setField<String>('emailAluno', value);

  String? get cepAluno => getField<String>('cepAluno');
  set cepAluno(String? value) => setField<String>('cepAluno', value);

  String? get endAluno => getField<String>('endAluno');
  set endAluno(String? value) => setField<String>('endAluno', value);

  String? get numAluno => getField<String>('numAluno');
  set numAluno(String? value) => setField<String>('numAluno', value);

  String? get compAluno => getField<String>('compAluno');
  set compAluno(String? value) => setField<String>('compAluno', value);

  String? get bairroAluno => getField<String>('bairroAluno');
  set bairroAluno(String? value) => setField<String>('bairroAluno', value);

  String? get cidadeAluno => getField<String>('cidadeAluno');
  set cidadeAluno(String? value) => setField<String>('cidadeAluno', value);

  String? get ufAluno => getField<String>('ufAluno');
  set ufAluno(String? value) => setField<String>('ufAluno', value);

  String? get infoAluno => getField<String>('infoAluno');
  set infoAluno(String? value) => setField<String>('infoAluno', value);

  String? get pointGeo => getField<String>('pointGeo');
  set pointGeo(String? value) => setField<String>('pointGeo', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  double? get long => getField<double>('long');
  set long(double? value) => setField<double>('long', value);

  String? get urlFoto => getField<String>('urlFoto');
  set urlFoto(String? value) => setField<String>('urlFoto', value);

  DateTime? get dtNascimento => getField<DateTime>('dtNascimento');
  set dtNascimento(DateTime? value) =>
      setField<DateTime>('dtNascimento', value);

  int? get idEmpresa => getField<int>('idEmpresa');
  set idEmpresa(int? value) => setField<int>('idEmpresa', value);

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get domTurno => getField<String>('domTurno');
  set domTurno(String? value) => setField<String>('domTurno', value);

  int? get idTurma => getField<int>('idTurma');
  set idTurma(int? value) => setField<int>('idTurma', value);

  String? get domSitAluno => getField<String>('domSitAluno');
  set domSitAluno(String? value) => setField<String>('domSitAluno', value);

  bool? get ativo => getField<bool>('ativo');
  set ativo(bool? value) => setField<bool>('ativo', value);

  String? get cpfAluno => getField<String>('cpfAluno');
  set cpfAluno(String? value) => setField<String>('cpfAluno', value);

  int? get idVeiculo => getField<int>('idVeiculo');
  set idVeiculo(int? value) => setField<int>('idVeiculo', value);

  int? get idMotorista => getField<int>('idMotorista');
  set idMotorista(int? value) => setField<int>('idMotorista', value);

  String? get nomeResponsavel => getField<String>('nomeResponsavel');
  set nomeResponsavel(String? value) =>
      setField<String>('nomeResponsavel', value);

  String? get rgResponsavel => getField<String>('rgResponsavel');
  set rgResponsavel(String? value) => setField<String>('rgResponsavel', value);

  String? get telResponsavel => getField<String>('telResponsavel');
  set telResponsavel(String? value) =>
      setField<String>('telResponsavel', value);

  bool? get autorizacaoEntregue => getField<bool>('autorizacaoEntregue');
  set autorizacaoEntregue(bool? value) =>
      setField<bool>('autorizacaoEntregue', value);

  String? get domAlunoFrequente => getField<String>('domAlunoFrequente');
  set domAlunoFrequente(String? value) =>
      setField<String>('domAlunoFrequente', value);

  String? get domSerie => getField<String>('domSerie');
  set domSerie(String? value) => setField<String>('domSerie', value);

  String? get fotoAlunoUrl => getField<String>('fotoAlunoUrl');
  set fotoAlunoUrl(String? value) => setField<String>('fotoAlunoUrl', value);

  DateTime? get dataBase => getField<DateTime>('dataBase');
  set dataBase(DateTime? value) => setField<DateTime>('dataBase', value);

  String? get latlongAluno => getField<String>('latlongAluno');
  set latlongAluno(String? value) => setField<String>('latlongAluno', value);

  dynamic get latlngAluno => getField<dynamic>('latlngAluno');
  set latlngAluno(dynamic value) => setField<dynamic>('latlngAluno', value);

  String? get urlGoogleMaps => getField<String>('urlGoogleMaps');
  set urlGoogleMaps(String? value) => setField<String>('urlGoogleMaps', value);

  int? get seqAlunoMotorista => getField<int>('seqAlunoMotorista');
  set seqAlunoMotorista(int? value) =>
      setField<int>('seqAlunoMotorista', value);
}
