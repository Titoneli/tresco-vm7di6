import '../database.dart';

class RelcontabilpormotoristaTable
    extends SupabaseTable<RelcontabilpormotoristaRow> {
  @override
  String get tableName => 'relcontabilpormotorista';

  @override
  RelcontabilpormotoristaRow createRow(Map<String, dynamic> data) =>
      RelcontabilpormotoristaRow(data);
}

class RelcontabilpormotoristaRow extends SupabaseDataRow {
  RelcontabilpormotoristaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RelcontabilpormotoristaTable();

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get tipopessoa => getField<String>('tipopessoa');
  set tipopessoa(String? value) => setField<String>('tipopessoa', value);

  String? get pix => getField<String>('pix');
  set pix(String? value) => setField<String>('pix', value);

  String? get mesbase => getField<String>('mesbase');
  set mesbase(String? value) => setField<String>('mesbase', value);

  double? get valliquidoresumo => getField<double>('valliquidoresumo');
  set valliquidoresumo(double? value) =>
      setField<double>('valliquidoresumo', value);

  double? get valretidoinssresumo => getField<double>('valretidoinssresumo');
  set valretidoinssresumo(double? value) =>
      setField<double>('valretidoinssresumo', value);

  double? get valretidoirpfresumo => getField<double>('valretidoirpfresumo');
  set valretidoirpfresumo(double? value) =>
      setField<double>('valretidoirpfresumo', value);

  double? get qtdalunosresumo => getField<double>('qtdalunosresumo');
  set qtdalunosresumo(double? value) =>
      setField<double>('qtdalunosresumo', value);
}
