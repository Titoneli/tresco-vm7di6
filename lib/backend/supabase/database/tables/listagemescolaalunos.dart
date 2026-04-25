import '../database.dart';

class ListagemescolaalunosTable extends SupabaseTable<ListagemescolaalunosRow> {
  @override
  String get tableName => 'listagemescolaalunos';

  @override
  ListagemescolaalunosRow createRow(Map<String, dynamic> data) =>
      ListagemescolaalunosRow(data);
}

class ListagemescolaalunosRow extends SupabaseDataRow {
  ListagemescolaalunosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ListagemescolaalunosTable();

  String? get nomeAluno => getField<String>('nomeAluno');
  set nomeAluno(String? value) => setField<String>('nomeAluno', value);

  String? get nomeEscola => getField<String>('nomeEscola');
  set nomeEscola(String? value) => setField<String>('nomeEscola', value);

  String? get domTurno => getField<String>('domTurno');
  set domTurno(String? value) => setField<String>('domTurno', value);

  String? get domSitAluno => getField<String>('domSitAluno');
  set domSitAluno(String? value) => setField<String>('domSitAluno', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);
}
