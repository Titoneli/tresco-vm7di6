import '../database.dart';

class ReldemonstrantivomotoristaTable
    extends SupabaseTable<ReldemonstrantivomotoristaRow> {
  @override
  String get tableName => 'reldemonstrantivomotorista';

  @override
  ReldemonstrantivomotoristaRow createRow(Map<String, dynamic> data) =>
      ReldemonstrantivomotoristaRow(data);
}

class ReldemonstrantivomotoristaRow extends SupabaseDataRow {
  ReldemonstrantivomotoristaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ReldemonstrantivomotoristaTable();

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

  int? get altair => getField<int>('altair');
  set altair(int? value) => setField<int>('altair', value);

  int? get geteco => getField<int>('geteco');
  set geteco(int? value) => setField<int>('geteco', value);

  int? get gervasio => getField<int>('gervasio');
  set gervasio(int? value) => setField<int>('gervasio', value);

  int? get bicalho => getField<int>('bicalho');
  set bicalho(int? value) => setField<int>('bicalho', value);

  int? get lafaiete => getField<int>('lafaiete');
  set lafaiete(int? value) => setField<int>('lafaiete', value);

  int? get leonina => getField<int>('leonina');
  set leonina(int? value) => setField<int>('leonina', value);

  int? get murgy => getField<int>('murgy');
  set murgy(int? value) => setField<int>('murgy', value);

  int? get itamar => getField<int>('itamar');
  set itamar(int? value) => setField<int>('itamar', value);

  int? get prodor => getField<int>('prodor');
  set prodor(int? value) => setField<int>('prodor', value);

  int? get raul => getField<int>('raul');
  set raul(int? value) => setField<int>('raul', value);

  int? get grupao => getField<int>('grupao');
  set grupao(int? value) => setField<int>('grupao', value);

  int? get tancredo => getField<int>('tancredo');
  set tancredo(int? value) => setField<int>('tancredo', value);
}
