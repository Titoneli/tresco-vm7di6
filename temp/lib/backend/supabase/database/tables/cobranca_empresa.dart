import '../database.dart';

class CobrancaEmpresaTable extends SupabaseTable<CobrancaEmpresaRow> {
  @override
  String get tableName => 'cobrancaEmpresa';

  @override
  CobrancaEmpresaRow createRow(Map<String, dynamic> data) =>
      CobrancaEmpresaRow(data);
}

class CobrancaEmpresaRow extends SupabaseDataRow {
  CobrancaEmpresaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CobrancaEmpresaTable();

  int get idCobrancaEmpresa => getField<int>('idCobrancaEmpresa')!;
  set idCobrancaEmpresa(int value) => setField<int>('idCobrancaEmpresa', value);

  String? get domEnviarCobranca => getField<String>('domEnviarCobranca');
  set domEnviarCobranca(String? value) =>
      setField<String>('domEnviarCobranca', value);

  String? get domTolerDiasAtraso => getField<String>('domTolerDiasAtraso');
  set domTolerDiasAtraso(String? value) =>
      setField<String>('domTolerDiasAtraso', value);

  String? get domTipoMulta => getField<String>('domTipoMulta');
  set domTipoMulta(String? value) => setField<String>('domTipoMulta', value);

  int? get idEmpresa => getField<int>('idEmpresa');
  set idEmpresa(int? value) => setField<int>('idEmpresa', value);
}
