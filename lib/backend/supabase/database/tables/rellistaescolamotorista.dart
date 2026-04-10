import '../database.dart';

class RellistaescolamotoristaTable
    extends SupabaseTable<RellistaescolamotoristaRow> {
  @override
  String get tableName => 'rellistaescolamotorista';

  @override
  RellistaescolamotoristaRow createRow(Map<String, dynamic> data) =>
      RellistaescolamotoristaRow(data);
}

class RellistaescolamotoristaRow extends SupabaseDataRow {
  RellistaescolamotoristaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RellistaescolamotoristaTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get nomeescola => getField<String>('nomeescola');
  set nomeescola(String? value) => setField<String>('nomeescola', value);

  int? get idMotorista => getField<int>('idMotorista');
  set idMotorista(int? value) => setField<int>('idMotorista', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);
}
