import '../database.dart';

class DocumentoTable extends SupabaseTable<DocumentoRow> {
  @override
  String get tableName => 'documento';

  @override
  DocumentoRow createRow(Map<String, dynamic> data) => DocumentoRow(data);
}

class DocumentoRow extends SupabaseDataRow {
  DocumentoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DocumentoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get dtcadastro => getField<DateTime>('dtcadastro')!;
  set dtcadastro(DateTime value) => setField<DateTime>('dtcadastro', value);

  int? get idusuario => getField<int>('idusuario');
  set idusuario(int? value) => setField<int>('idusuario', value);

  int? get idveiculo => getField<int>('idveiculo');
  set idveiculo(int? value) => setField<int>('idveiculo', value);

  int? get idescola => getField<int>('idescola');
  set idescola(int? value) => setField<int>('idescola', value);

  int? get idempresa => getField<int>('idempresa');
  set idempresa(int? value) => setField<int>('idempresa', value);

  int? get idaluno => getField<int>('idaluno');
  set idaluno(int? value) => setField<int>('idaluno', value);

  String get categoria => getField<String>('categoria')!;
  set categoria(String value) => setField<String>('categoria', value);

  String get tipoDocumento => getField<String>('tipo_documento')!;
  set tipoDocumento(String value) => setField<String>('tipo_documento', value);

  String get nomeArquivo => getField<String>('nome_arquivo')!;
  set nomeArquivo(String value) => setField<String>('nome_arquivo', value);

  int? get tamanhoBytes => getField<int>('tamanho_bytes');
  set tamanhoBytes(int? value) => setField<int>('tamanho_bytes', value);

  String? get mimeType => getField<String>('mime_type');
  set mimeType(String? value) => setField<String>('mime_type', value);

  String get bucket => getField<String>('bucket')!;
  set bucket(String value) => setField<String>('bucket', value);

  String get caminhoStorage => getField<String>('caminho_storage')!;
  set caminhoStorage(String value) =>
      setField<String>('caminho_storage', value);

  bool get ativo => getField<bool>('ativo')!;
  set ativo(bool value) => setField<bool>('ativo', value);

  String? get observacao => getField<String>('observacao');
  set observacao(String? value) => setField<String>('observacao', value);

  String? get usuarioCriacao => getField<String>('usuario_criacao');
  set usuarioCriacao(String? value) =>
      setField<String>('usuario_criacao', value);

  DateTime? get dtatualizacao => getField<DateTime>('dtatualizacao');
  set dtatualizacao(DateTime? value) =>
      setField<DateTime>('dtatualizacao', value);
}
