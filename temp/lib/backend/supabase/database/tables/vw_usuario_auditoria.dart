import '../database.dart';

class VwUsuarioAuditoriaTable extends SupabaseTable<VwUsuarioAuditoriaRow> {
  @override
  String get tableName => 'vw_usuario_auditoria';

  @override
  VwUsuarioAuditoriaRow createRow(Map<String, dynamic> data) =>
      VwUsuarioAuditoriaRow(data);
}

class VwUsuarioAuditoriaRow extends SupabaseDataRow {
  VwUsuarioAuditoriaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VwUsuarioAuditoriaTable();

  int? get idhistorico => getField<int>('idhistorico');
  set idhistorico(int? value) => setField<int>('idhistorico', value);

  int? get idusuario => getField<int>('idusuario');
  set idusuario(int? value) => setField<int>('idusuario', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  int? get idempresa => getField<int>('idempresa');
  set idempresa(int? value) => setField<int>('idempresa', value);

  int? get idescola => getField<int>('idescola');
  set idescola(int? value) => setField<int>('idescola', value);

  String? get operacao => getField<String>('operacao');
  set operacao(String? value) => setField<String>('operacao', value);

  String? get campo => getField<String>('campo');
  set campo(String? value) => setField<String>('campo', value);

  String? get valorAnterior => getField<String>('valor_anterior');
  set valorAnterior(String? value) => setField<String>('valor_anterior', value);

  String? get valorAtual => getField<String>('valor_atual');
  set valorAtual(String? value) => setField<String>('valor_atual', value);

  DateTime? get alteradoEm => getField<DateTime>('alterado_em');
  set alteradoEm(DateTime? value) => setField<DateTime>('alterado_em', value);

  String? get usuarioId => getField<String>('usuario_id');
  set usuarioId(String? value) => setField<String>('usuario_id', value);

  String? get usuarioEmail => getField<String>('usuario_email');
  set usuarioEmail(String? value) => setField<String>('usuario_email', value);
}
