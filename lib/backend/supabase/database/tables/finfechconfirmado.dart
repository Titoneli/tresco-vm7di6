import '../database.dart';

class FinfechconfirmadoTable extends SupabaseTable<FinfechconfirmadoRow> {
  @override
  String get tableName => 'finfechconfirmado';

  @override
  FinfechconfirmadoRow createRow(Map<String, dynamic> data) =>
      FinfechconfirmadoRow(data);
}

class FinfechconfirmadoRow extends SupabaseDataRow {
  FinfechconfirmadoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FinfechconfirmadoTable();

  int get idfechamento => getField<int>('idfechamento')!;
  set idfechamento(int value) => setField<int>('idfechamento', value);

  DateTime get dtconfusuario => getField<DateTime>('dtconfusuario')!;
  set dtconfusuario(DateTime value) =>
      setField<DateTime>('dtconfusuario', value);

  int get idescola => getField<int>('idescola')!;
  set idescola(int value) => setField<int>('idescola', value);

  String? get nomeescola => getField<String>('nomeescola');
  set nomeescola(String? value) => setField<String>('nomeescola', value);

  int get idusuario => getField<int>('idusuario')!;
  set idusuario(int value) => setField<int>('idusuario', value);

  String get nomeusuario => getField<String>('nomeusuario')!;
  set nomeusuario(String value) => setField<String>('nomeusuario', value);

  int? get qtdalunosconfusuario => getField<int>('qtdalunosconfusuario');
  set qtdalunosconfusuario(int? value) =>
      setField<int>('qtdalunosconfusuario', value);

  double? get valconfusuario => getField<double>('valconfusuario');
  set valconfusuario(double? value) =>
      setField<double>('valconfusuario', value);

  String? get mesreferente => getField<String>('mesreferente');
  set mesreferente(String? value) => setField<String>('mesreferente', value);

  String? get mesbase => getField<String>('mesbase');
  set mesbase(String? value) => setField<String>('mesbase', value);

  String get domsitpagamento => getField<String>('domsitpagamento')!;
  set domsitpagamento(String value) =>
      setField<String>('domsitpagamento', value);

  DateTime? get dtsitpagamento => getField<DateTime>('dtsitpagamento');
  set dtsitpagamento(DateTime? value) =>
      setField<DateTime>('dtsitpagamento', value);

  String get domsitconfirmacao => getField<String>('domsitconfirmacao')!;
  set domsitconfirmacao(String value) =>
      setField<String>('domsitconfirmacao', value);

  DateTime? get dtsitconfirmacao => getField<DateTime>('dtsitconfirmacao');
  set dtsitconfirmacao(DateTime? value) =>
      setField<DateTime>('dtsitconfirmacao', value);
}
