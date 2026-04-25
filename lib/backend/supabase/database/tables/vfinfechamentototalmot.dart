import '../database.dart';

class VfinfechamentototalmotTable
    extends SupabaseTable<VfinfechamentototalmotRow> {
  @override
  String get tableName => 'vfinfechamentototalmot';

  @override
  VfinfechamentototalmotRow createRow(Map<String, dynamic> data) =>
      VfinfechamentototalmotRow(data);
}

class VfinfechamentototalmotRow extends SupabaseDataRow {
  VfinfechamentototalmotRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VfinfechamentototalmotTable();

  int? get idMotorista => getField<int>('idMotorista');
  set idMotorista(int? value) => setField<int>('idMotorista', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get domTipoPessoa => getField<String>('domTipoPessoa');
  set domTipoPessoa(String? value) => setField<String>('domTipoPessoa', value);

  String? get mesbase => getField<String>('mesbase');
  set mesbase(String? value) => setField<String>('mesbase', value);

  int? get sumAlunos => getField<int>('sum_alunos');
  set sumAlunos(int? value) => setField<int>('sum_alunos', value);

  String? get reais => getField<String>('reais');
  set reais(String? value) => setField<String>('reais', value);

  double? get valor => getField<double>('valor');
  set valor(double? value) => setField<double>('valor', value);
}
