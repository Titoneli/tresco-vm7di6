import '../database.dart';

class RettotalunosmotoristaTable
    extends SupabaseTable<RettotalunosmotoristaRow> {
  @override
  String get tableName => 'rettotalunosmotorista';

  @override
  RettotalunosmotoristaRow createRow(Map<String, dynamic> data) =>
      RettotalunosmotoristaRow(data);
}

class RettotalunosmotoristaRow extends SupabaseDataRow {
  RettotalunosmotoristaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotalunosmotoristaTable();

  int? get idmotorista => getField<int>('idmotorista');
  set idmotorista(int? value) => setField<int>('idmotorista', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get cpfUsuario => getField<String>('cpfUsuario');
  set cpfUsuario(String? value) => setField<String>('cpfUsuario', value);

  double? get valAluno => getField<double>('valAluno');
  set valAluno(double? value) => setField<double>('valAluno', value);

  String? get domTipoPessoa => getField<String>('domTipoPessoa');
  set domTipoPessoa(String? value) => setField<String>('domTipoPessoa', value);

  String? get codINSS => getField<String>('codINSS');
  set codINSS(String? value) => setField<String>('codINSS', value);

  double? get qtddependentesir => getField<double>('qtddependentesir');
  set qtddependentesir(double? value) =>
      setField<double>('qtddependentesir', value);

  String? get pix => getField<String>('pix');
  set pix(String? value) => setField<String>('pix', value);

  String? get valdescontocooperativa =>
      getField<String>('valdescontocooperativa');
  set valdescontocooperativa(String? value) =>
      setField<String>('valdescontocooperativa', value);

  double? get valdescontoextra => getField<double>('valdescontoextra');
  set valdescontoextra(double? value) =>
      setField<double>('valdescontoextra', value);

  String? get matriculaCooperativa => getField<String>('matriculaCooperativa');
  set matriculaCooperativa(String? value) =>
      setField<String>('matriculaCooperativa', value);

  int? get idVeiculo => getField<int>('idVeiculo');
  set idVeiculo(int? value) => setField<int>('idVeiculo', value);

  String? get placa => getField<String>('placa');
  set placa(String? value) => setField<String>('placa', value);

  String? get capacidade => getField<String>('capacidade');
  set capacidade(String? value) => setField<String>('capacidade', value);

  int? get assentosocupados => getField<int>('assentosocupados');
  set assentosocupados(int? value) => setField<int>('assentosocupados', value);

  int? get assentosocupadosmanha => getField<int>('assentosocupadosmanha');
  set assentosocupadosmanha(int? value) =>
      setField<int>('assentosocupadosmanha', value);

  int? get assentosocupadostarde => getField<int>('assentosocupadostarde');
  set assentosocupadostarde(int? value) =>
      setField<int>('assentosocupadostarde', value);

  int? get assentosocupadosnoite => getField<int>('assentosocupadosnoite');
  set assentosocupadosnoite(int? value) =>
      setField<int>('assentosocupadosnoite', value);

  String? get escolasigla => getField<String>('escolasigla');
  set escolasigla(String? value) => setField<String>('escolasigla', value);

  double? get totvalmensal => getField<double>('totvalmensal');
  set totvalmensal(double? value) => setField<double>('totvalmensal', value);

  double? get totcapacidade => getField<double>('totcapacidade');
  set totcapacidade(double? value) => setField<double>('totcapacidade', value);

  double? get totassentosocupados => getField<double>('totassentosocupados');
  set totassentosocupados(double? value) =>
      setField<double>('totassentosocupados', value);

  double? get totassentosdisponiveis =>
      getField<double>('totassentosdisponiveis');
  set totassentosdisponiveis(double? value) =>
      setField<double>('totassentosdisponiveis', value);

  double? get totassentosocupadosmanha =>
      getField<double>('totassentosocupadosmanha');
  set totassentosocupadosmanha(double? value) =>
      setField<double>('totassentosocupadosmanha', value);

  double? get totassentosdisponiveismanha =>
      getField<double>('totassentosdisponiveismanha');
  set totassentosdisponiveismanha(double? value) =>
      setField<double>('totassentosdisponiveismanha', value);

  double? get totassentosocupadostarde =>
      getField<double>('totassentosocupadostarde');
  set totassentosocupadostarde(double? value) =>
      setField<double>('totassentosocupadostarde', value);

  double? get totassentosdisponiveistarde =>
      getField<double>('totassentosdisponiveistarde');
  set totassentosdisponiveistarde(double? value) =>
      setField<double>('totassentosdisponiveistarde', value);

  double? get totassentosocupadosnoite =>
      getField<double>('totassentosocupadosnoite');
  set totassentosocupadosnoite(double? value) =>
      setField<double>('totassentosocupadosnoite', value);

  double? get totassentosdisponiveisnoite =>
      getField<double>('totassentosdisponiveisnoite');
  set totassentosdisponiveisnoite(double? value) =>
      setField<double>('totassentosdisponiveisnoite', value);
}
