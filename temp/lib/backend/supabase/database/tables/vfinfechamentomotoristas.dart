import '../database.dart';

class VfinfechamentomotoristasTable
    extends SupabaseTable<VfinfechamentomotoristasRow> {
  @override
  String get tableName => 'vfinfechamentomotoristas';

  @override
  VfinfechamentomotoristasRow createRow(Map<String, dynamic> data) =>
      VfinfechamentomotoristasRow(data);
}

class VfinfechamentomotoristasRow extends SupabaseDataRow {
  VfinfechamentomotoristasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VfinfechamentomotoristasTable();

  int? get idMotorista => getField<int>('idMotorista');
  set idMotorista(int? value) => setField<int>('idMotorista', value);

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get mesbase => getField<String>('mesbase');
  set mesbase(String? value) => setField<String>('mesbase', value);

  String? get whatsappUsuario => getField<String>('whatsappUsuario');
  set whatsappUsuario(String? value) =>
      setField<String>('whatsappUsuario', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get nomeescola => getField<String>('nomeescola');
  set nomeescola(String? value) => setField<String>('nomeescola', value);
}
