import '../database.dart';

class TotvalalunosescolasTable extends SupabaseTable<TotvalalunosescolasRow> {
  @override
  String get tableName => 'totvalalunosescolas';

  @override
  TotvalalunosescolasRow createRow(Map<String, dynamic> data) =>
      TotvalalunosescolasRow(data);
}

class TotvalalunosescolasRow extends SupabaseDataRow {
  TotvalalunosescolasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TotvalalunosescolasTable();

  int? get alunosescola => getField<int>('alunosescola');
  set alunosescola(int? value) => setField<int>('alunosescola', value);

  int? get alunosmotorista => getField<int>('alunosmotorista');
  set alunosmotorista(int? value) => setField<int>('alunosmotorista', value);

  int? get alunossemmotorista => getField<int>('alunossemmotorista');
  set alunossemmotorista(int? value) =>
      setField<int>('alunossemmotorista', value);

  String? get valalunosmotorista => getField<String>('valalunosmotorista');
  set valalunosmotorista(String? value) =>
      setField<String>('valalunosmotorista', value);

  String? get valalunosapagar => getField<String>('valalunosapagar');
  set valalunosapagar(String? value) =>
      setField<String>('valalunosapagar', value);
}
