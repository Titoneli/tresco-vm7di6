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

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get idAtf => getField<int>('id')!;

  String? get origem => getField<String>('origem');
  set origem(String? value) => setField<String>('origem', value);

  String? get destino => getField<String>('destino');
  set destino(String? value) => setField<String>('destino', value);

  DateTime? get dataIda => getField<DateTime>('data_ida');
  set dataIda(DateTime? value) => setField<DateTime>('data_ida', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  int? get idUsuarioMotorista => getField<int>('id_usuario_motorista');
  set idUsuarioMotorista(int? value) => setField<int>('id_usuario_motorista', value);

  String? get numeroAtf => getField<String>('numero_atf');
  set numeroAtf(String? value) => setField<String>('numero_atf', value);

  String? get codVerificador => getField<String>('cod_verificador');
  set codVerificador(String? value) => setField<String>('cod_verificador', value);

  String? get codCrc => getField<String>('cod_crc');
  set codCrc(String? value) => setField<String>('cod_crc', value);

  String? get placa => getField<String>('placa');
  set placa(String? value) => setField<String>('placa', value);

  String? get horaIda => getField<String>('hora_ida');
  set horaIda(String? value) => setField<String>('hora_ida', value);
}
