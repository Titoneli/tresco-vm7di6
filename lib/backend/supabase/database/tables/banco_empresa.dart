import '../database.dart';

class BancoEmpresaTable extends SupabaseTable<BancoEmpresaRow> {
  @override
  String get tableName => 'bancoEmpresa';

  @override
  BancoEmpresaRow createRow(Map<String, dynamic> data) => BancoEmpresaRow(data);
}

class BancoEmpresaRow extends SupabaseDataRow {
  BancoEmpresaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => BancoEmpresaTable();

  int get idBancoEmpresa => getField<int>('idBancoEmpresa')!;
  set idBancoEmpresa(int value) => setField<int>('idBancoEmpresa', value);

  DateTime get dtCadBancoEmpresa => getField<DateTime>('dtCadBancoEmpresa')!;
  set dtCadBancoEmpresa(DateTime value) =>
      setField<DateTime>('dtCadBancoEmpresa', value);

  String? get nomeConta => getField<String>('nomeConta');
  set nomeConta(String? value) => setField<String>('nomeConta', value);

  String? get domContaPrincipal => getField<String>('domContaPrincipal');
  set domContaPrincipal(String? value) =>
      setField<String>('domContaPrincipal', value);

  String? get domNomeBanco => getField<String>('domNomeBanco');
  set domNomeBanco(String? value) => setField<String>('domNomeBanco', value);

  String? get agencia => getField<String>('agencia');
  set agencia(String? value) => setField<String>('agencia', value);

  String? get conta => getField<String>('conta');
  set conta(String? value) => setField<String>('conta', value);

  String? get chavePix => getField<String>('chavePix');
  set chavePix(String? value) => setField<String>('chavePix', value);

  String? get domChavePix => getField<String>('domChavePix');
  set domChavePix(String? value) => setField<String>('domChavePix', value);

  double? get saldoInicial => getField<double>('saldoInicial');
  set saldoInicial(double? value) => setField<double>('saldoInicial', value);

  int? get idEmpresa => getField<int>('idEmpresa');
  set idEmpresa(int? value) => setField<int>('idEmpresa', value);
}
