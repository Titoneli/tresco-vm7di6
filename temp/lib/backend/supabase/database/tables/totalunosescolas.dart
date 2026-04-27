import '../database.dart';

class TotalunosescolasTable extends SupabaseTable<TotalunosescolasRow> {
  @override
  String get tableName => 'totalunosescolas';

  @override
  TotalunosescolasRow createRow(Map<String, dynamic> data) =>
      TotalunosescolasRow(data);
}

class TotalunosescolasRow extends SupabaseDataRow {
  TotalunosescolasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TotalunosescolasTable();

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
