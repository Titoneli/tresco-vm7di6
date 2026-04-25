import '../database.dart';

class CorDominioTable extends SupabaseTable<CorDominioRow> {
  @override
  String get tableName => 'corDominio';

  @override
  CorDominioRow createRow(Map<String, dynamic> data) => CorDominioRow(data);
}

class CorDominioRow extends SupabaseDataRow {
  CorDominioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CorDominioTable();

  String get idDominio => getField<String>('idDominio')!;
  set idDominio(String value) => setField<String>('idDominio', value);

  String get nomeDominio => getField<String>('nomeDominio')!;
  set nomeDominio(String value) => setField<String>('nomeDominio', value);

  String? get descricaoDominio => getField<String>('descricaoDominio');
  set descricaoDominio(String? value) =>
      setField<String>('descricaoDominio', value);

  double? get ordemDominio => getField<double>('ordemDominio');
  set ordemDominio(double? value) => setField<double>('ordemDominio', value);

  String? get idIndicadorMst => getField<String>('idIndicadorMst');
  set idIndicadorMst(String? value) =>
      setField<String>('idIndicadorMst', value);

  int? get idEmpresa => getField<int>('idEmpresa');
  set idEmpresa(int? value) => setField<int>('idEmpresa', value);

  double? get valFaixaInicial => getField<double>('valFaixaInicial');
  set valFaixaInicial(double? value) =>
      setField<double>('valFaixaInicial', value);

  double? get valFaixaFinal => getField<double>('valFaixaFinal');
  set valFaixaFinal(double? value) => setField<double>('valFaixaFinal', value);

  double? get valBase => getField<double>('valBase');
  set valBase(double? value) => setField<double>('valBase', value);

  double? get valDependente => getField<double>('valDependente');
  set valDependente(double? value) => setField<double>('valDependente', value);
}
