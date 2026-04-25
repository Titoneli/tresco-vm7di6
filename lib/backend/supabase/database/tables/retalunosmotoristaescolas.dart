import '../database.dart';

class RetalunosmotoristaescolasTable
    extends SupabaseTable<RetalunosmotoristaescolasRow> {
  @override
  String get tableName => 'retalunosmotoristaescolas';

  @override
  RetalunosmotoristaescolasRow createRow(Map<String, dynamic> data) =>
      RetalunosmotoristaescolasRow(data);
}

class RetalunosmotoristaescolasRow extends SupabaseDataRow {
  RetalunosmotoristaescolasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RetalunosmotoristaescolasTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  String? get nomeEscola => getField<String>('nomeEscola');
  set nomeEscola(String? value) => setField<String>('nomeEscola', value);

  int? get idUsuario => getField<int>('idUsuario');
  set idUsuario(int? value) => setField<int>('idUsuario', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get valormensal => getField<String>('valormensal');
  set valormensal(String? value) => setField<String>('valormensal', value);

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

  int? get assentosdisponiveis => getField<int>('assentosdisponiveis');
  set assentosdisponiveis(int? value) =>
      setField<int>('assentosdisponiveis', value);

  int? get ocupacao => getField<int>('ocupacao');
  set ocupacao(int? value) => setField<int>('ocupacao', value);

  int? get assentosdisponiveismanha =>
      getField<int>('assentosdisponiveismanha');
  set assentosdisponiveismanha(int? value) =>
      setField<int>('assentosdisponiveismanha', value);

  int? get ocupacaomanha => getField<int>('ocupacaomanha');
  set ocupacaomanha(int? value) => setField<int>('ocupacaomanha', value);

  int? get assentosdisponiveistarde =>
      getField<int>('assentosdisponiveistarde');
  set assentosdisponiveistarde(int? value) =>
      setField<int>('assentosdisponiveistarde', value);

  int? get ocupacaotarde => getField<int>('ocupacaotarde');
  set ocupacaotarde(int? value) => setField<int>('ocupacaotarde', value);

  int? get assentosdisponiveisnoite =>
      getField<int>('assentosdisponiveisnoite');
  set assentosdisponiveisnoite(int? value) =>
      setField<int>('assentosdisponiveisnoite', value);

  int? get ocupacaonoite => getField<int>('ocupacaonoite');
  set ocupacaonoite(int? value) => setField<int>('ocupacaonoite', value);
}
