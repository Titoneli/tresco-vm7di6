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

  String get id => getField<String>('id')!;
  String? get tipoAtf => getField<String>('tipo_atf');
  String? get origem => getField<String>('origem');
  String? get destino => getField<String>('destino');
  String? get itinerario => getField<String>('itinerario');
  DateTime? get dataIda => getField<DateTime>('data_ida');
  String? get horaIda => getField<String>('hora_ida');
  double? get kmIda => getField<double>('km_ida');
  DateTime? get dataVolta => getField<DateTime>('data_volta');
  String? get horaVolta => getField<String>('hora_volta');
  double? get kmVolta => getField<double>('km_volta');
  String? get docFiscal => getField<String>('doc_fiscal');
  String? get serieFiscal => getField<String>('serie_fiscal');
  String? get status => getField<String>('status');
  String? get idUsuarioMotorista => getField<String>('id_usuario_motorista');
  String? get idVeiculo => getField<String>('id_veiculo');
  DateTime get createdAt => getField<DateTime>('created_at')!;
}