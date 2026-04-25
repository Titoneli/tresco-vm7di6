import '../database.dart';

class UsuarioTable extends SupabaseTable<UsuarioRow> {
  @override
  String get tableName => 'usuario';

  @override
  UsuarioRow createRow(Map<String, dynamic> data) => UsuarioRow(data);
}

class UsuarioRow extends SupabaseDataRow {
  UsuarioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsuarioTable();

  int get idUsuario => getField<int>('idUsuario')!;
  set idUsuario(int value) => setField<int>('idUsuario', value);

  DateTime get dtUsuario => getField<DateTime>('dtUsuario')!;
  set dtUsuario(DateTime value) => setField<DateTime>('dtUsuario', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get cnhUsuario => getField<String>('cnhUsuario');
  set cnhUsuario(String? value) => setField<String>('cnhUsuario', value);

  String get cpfUsuario => getField<String>('cpfUsuario')!;
  set cpfUsuario(String value) => setField<String>('cpfUsuario', value);

  String? get whatsappUsuario => getField<String>('whatsappUsuario');
  set whatsappUsuario(String? value) =>
      setField<String>('whatsappUsuario', value);

  String? get domGrupoUsuario => getField<String>('domGrupoUsuario');
  set domGrupoUsuario(String? value) =>
      setField<String>('domGrupoUsuario', value);

  DateTime? get dtAdmissao => getField<DateTime>('dtAdmissao');
  set dtAdmissao(DateTime? value) => setField<DateTime>('dtAdmissao', value);

  DateTime? get dtVencCNH => getField<DateTime>('dtVencCNH');
  set dtVencCNH(DateTime? value) => setField<DateTime>('dtVencCNH', value);

  bool? get loginLiberado => getField<bool>('loginLiberado');
  set loginLiberado(bool? value) => setField<bool>('loginLiberado', value);

  bool? get ativo => getField<bool>('ativo');
  set ativo(bool? value) => setField<bool>('ativo', value);

  String get usuario => getField<String>('usuario')!;
  set usuario(String value) => setField<String>('usuario', value);

  String? get senha => getField<String>('senha');
  set senha(String? value) => setField<String>('senha', value);

  String? get emailUsuario => getField<String>('emailUsuario');
  set emailUsuario(String? value) => setField<String>('emailUsuario', value);

  String? get domCargo => getField<String>('domCargo');
  set domCargo(String? value) => setField<String>('domCargo', value);

  int? get idEmpresa => getField<int>('idEmpresa');
  set idEmpresa(int? value) => setField<int>('idEmpresa', value);

  bool? get domAdministrador => getField<bool>('domAdministrador');
  set domAdministrador(bool? value) =>
      setField<bool>('domAdministrador', value);

  String? get codEmpresa => getField<String>('codEmpresa');
  set codEmpresa(String? value) => setField<String>('codEmpresa', value);

  String? get observacao => getField<String>('observacao');
  set observacao(String? value) => setField<String>('observacao', value);

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get codPermPrefeitura => getField<String>('codPermPrefeitura');
  set codPermPrefeitura(String? value) =>
      setField<String>('codPermPrefeitura', value);

  DateTime? get dtPermPrefeitura => getField<DateTime>('dtPermPrefeitura');
  set dtPermPrefeitura(DateTime? value) =>
      setField<DateTime>('dtPermPrefeitura', value);

  String? get codPermDER => getField<String>('codPermDER');
  set codPermDER(String? value) => setField<String>('codPermDER', value);

  DateTime? get dtPermDER => getField<DateTime>('dtPermDER');
  set dtPermDER(DateTime? value) => setField<DateTime>('dtPermDER', value);

  int? get idUsuarioMst => getField<int>('idUsuarioMst');
  set idUsuarioMst(int? value) => setField<int>('idUsuarioMst', value);

  double? get valAluno => getField<double>('valAluno');
  set valAluno(double? value) => setField<double>('valAluno', value);

  String? get domTipoPessoa => getField<String>('domTipoPessoa');
  set domTipoPessoa(String? value) => setField<String>('domTipoPessoa', value);

  String? get codINSS => getField<String>('codINSS');
  set codINSS(String? value) => setField<String>('codINSS', value);

  double? get qtdDependentesIR => getField<double>('qtdDependentesIR');
  set qtdDependentesIR(double? value) =>
      setField<double>('qtdDependentesIR', value);

  String? get chavePIX => getField<String>('chavePIX');
  set chavePIX(String? value) => setField<String>('chavePIX', value);

  String? get domTipoChavePIX => getField<String>('domTipoChavePIX');
  set domTipoChavePIX(String? value) =>
      setField<String>('domTipoChavePIX', value);

  String? get valDescontoCooperativa =>
      getField<String>('valDescontoCooperativa');
  set valDescontoCooperativa(String? value) =>
      setField<String>('valDescontoCooperativa', value);

  String? get matriculaCooperativa => getField<String>('matriculaCooperativa');
  set matriculaCooperativa(String? value) =>
      setField<String>('matriculaCooperativa', value);

  int? get idEscolaDesconto => getField<int>('idEscolaDesconto');
  set idEscolaDesconto(int? value) => setField<int>('idEscolaDesconto', value);

  double? get valDescontoExtra => getField<double>('valDescontoExtra');
  set valDescontoExtra(double? value) =>
      setField<double>('valDescontoExtra', value);

  String? get urlFoto => getField<String>('urlFoto');
  set urlFoto(String? value) => setField<String>('urlFoto', value);

  String? get nomeApelido => getField<String>('nome_apelido');
  set nomeApelido(String? value) => setField<String>('nome_apelido', value);
}
