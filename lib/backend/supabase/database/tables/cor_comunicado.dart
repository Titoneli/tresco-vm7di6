import '../database.dart';

class CorComunicadoTable extends SupabaseTable<CorComunicadoRow> {
  @override
  String get tableName => 'corComunicado';

  @override
  CorComunicadoRow createRow(Map<String, dynamic> data) =>
      CorComunicadoRow(data);
}

class CorComunicadoRow extends SupabaseDataRow {
  CorComunicadoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CorComunicadoTable();

  int get idComunicado => getField<int>('idComunicado')!;
  set idComunicado(int value) => setField<int>('idComunicado', value);

  DateTime get dtCadComunicado => getField<DateTime>('dtCadComunicado')!;
  set dtCadComunicado(DateTime value) =>
      setField<DateTime>('dtCadComunicado', value);

  DateTime? get dtComunicado => getField<DateTime>('dtComunicado');
  set dtComunicado(DateTime? value) =>
      setField<DateTime>('dtComunicado', value);

  PostgresTime? get horaComunicado => getField<PostgresTime>('horaComunicado');
  set horaComunicado(PostgresTime? value) =>
      setField<PostgresTime>('horaComunicado', value);

  String? get domTipoComunicado => getField<String>('domTipoComunicado');
  set domTipoComunicado(String? value) =>
      setField<String>('domTipoComunicado', value);

  String? get msgComunicado => getField<String>('msgComunicado');
  set msgComunicado(String? value) => setField<String>('msgComunicado', value);

  String? get domDestinoComunicado => getField<String>('domDestinoComunicado');
  set domDestinoComunicado(String? value) =>
      setField<String>('domDestinoComunicado', value);
}
