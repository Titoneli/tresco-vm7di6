import '../database.dart';

class RelcontabilmotescTable extends SupabaseTable<RelcontabilmotescRow> {
  @override
  String get tableName => 'relcontabilmotesc';

  @override
  RelcontabilmotescRow createRow(Map<String, dynamic> data) =>
      RelcontabilmotescRow(data);
}

class RelcontabilmotescRow extends SupabaseDataRow {
  RelcontabilmotescRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RelcontabilmotescTable();

  String? get nome => getField<String>('nome');
  set nome(String? value) => setField<String>('nome', value);

  String? get pix => getField<String>('pix');
  set pix(String? value) => setField<String>('pix', value);

  String? get nomeescola => getField<String>('nomeescola');
  set nomeescola(String? value) => setField<String>('nomeescola', value);

  String? get valliquidoresumo => getField<String>('valliquidoresumo');
  set valliquidoresumo(String? value) =>
      setField<String>('valliquidoresumo', value);

  String? get valretidoinssresumo => getField<String>('valretidoinssresumo');
  set valretidoinssresumo(String? value) =>
      setField<String>('valretidoinssresumo', value);

  String? get valretidoirpfresumo => getField<String>('valretidoirpfresumo');
  set valretidoirpfresumo(String? value) =>
      setField<String>('valretidoirpfresumo', value);

  int? get qtdalunosresumo => getField<int>('qtdalunosresumo');
  set qtdalunosresumo(int? value) => setField<int>('qtdalunosresumo', value);
}
