import '../database.dart';

class AtfTable extends SupabaseTable<AtfRow> {
  @override
  String get tableName => 'atf';

  @override
  AtfRow createRow(Map<String, dynamic> data) => AtfRow(data);
}

class AtfRow extends SupabaseDataRow {
  AtfRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AtfTable();

  int get idAtf => getField<int>('id_atf')!;
  set idAtf(int value) => setField<int>('id_atf', value);

  String get tipoAtf => getField<String>('tipo_atf')!;
  set tipoAtf(String value) => setField<String>('tipo_atf', value);

  int get idUsuarioMotorista => getField<int>('id_usuario_motorista')!;
  set idUsuarioMotorista(int value) =>
      setField<int>('id_usuario_motorista', value);

  int get idVeiculo => getField<int>('id_veiculo')!;
  set idVeiculo(int value) => setField<int>('id_veiculo', value);

  String get placa => getField<String>('placa')!;
  set placa(String value) => setField<String>('placa', value);

  String get origem => getField<String>('origem')!;
  set origem(String value) => setField<String>('origem', value);

  String get destino => getField<String>('destino')!;
  set destino(String value) => setField<String>('destino', value);

  String get dataIda => getField<String>('data_ida')!;
  set dataIda(String value) => setField<String>('data_ida', value);

  String get horaIda => getField<String>('hora_ida')!;
  set horaIda(String value) => setField<String>('hora_ida', value);

  int get kmIda => getField<int>('km_ida')!;
  set kmIda(int value) => setField<int>('km_ida', value);

  String? get dataVolta => getField<String>('data_volta');
  set dataVolta(String? value) => setField<String>('data_volta', value);

  String? get horaVolta => getField<String>('hora_volta');
  set horaVolta(String? value) => setField<String>('hora_volta', value);

  int? get kmVolta => getField<int>('km_volta');
  set kmVolta(int? value) => setField<int>('km_volta', value);

  String? get docFiscal => getField<String>('doc_fiscal');
  set docFiscal(String? value) => setField<String>('doc_fiscal', value);

  String? get serieFiscal => getField<String>('serie_fiscal');
  set serieFiscal(String? value) => setField<String>('serie_fiscal', value);

  String get itinerario => getField<String>('itinerario')!;
  set itinerario(String value) => setField<String>('itinerario', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  String? get numeroAtf => getField<String>('numero_atf');
  set numeroAtf(String? value) => setField<String>('numero_atf', value);

  String? get codVerificador => getField<String>('cod_verificador');
  set codVerificador(String? value) =>
      setField<String>('cod_verificador', value);

  String? get codCrc => getField<String>('cod_crc');
  set codCrc(String? value) => setField<String>('cod_crc', value);

  String? get urlAtf => getField<String>('url_atf');
  set urlAtf(String? value) => setField<String>('url_atf', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
