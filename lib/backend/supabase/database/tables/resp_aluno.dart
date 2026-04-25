import '../database.dart';

class RespAlunoTable extends SupabaseTable<RespAlunoRow> {
  @override
  String get tableName => 'respAluno';

  @override
  RespAlunoRow createRow(Map<String, dynamic> data) => RespAlunoRow(data);
}

class RespAlunoRow extends SupabaseDataRow {
  RespAlunoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RespAlunoTable();

  int get idRespAluno => getField<int>('idRespAluno')!;
  set idRespAluno(int value) => setField<int>('idRespAluno', value);

  String? get cpfResp => getField<String>('cpfResp');
  set cpfResp(String? value) => setField<String>('cpfResp', value);

  String? get rgResp => getField<String>('rgResp');
  set rgResp(String? value) => setField<String>('rgResp', value);

  String? get emailResp => getField<String>('emailResp');
  set emailResp(String? value) => setField<String>('emailResp', value);

  String? get telResp => getField<String>('telResp');
  set telResp(String? value) => setField<String>('telResp', value);

  String? get whatsAppResp => getField<String>('whatsAppResp');
  set whatsAppResp(String? value) => setField<String>('whatsAppResp', value);

  String? get domParentesco => getField<String>('domParentesco');
  set domParentesco(String? value) => setField<String>('domParentesco', value);

  String? get domRespFinanceiro => getField<String>('domRespFinanceiro');
  set domRespFinanceiro(String? value) =>
      setField<String>('domRespFinanceiro', value);

  String? get domRespPedagogico => getField<String>('domRespPedagogico');
  set domRespPedagogico(String? value) =>
      setField<String>('domRespPedagogico', value);

  String? get domRecebeAluno => getField<String>('domRecebeAluno');
  set domRecebeAluno(String? value) =>
      setField<String>('domRecebeAluno', value);

  String? get cepEndResp => getField<String>('cepEndResp');
  set cepEndResp(String? value) => setField<String>('cepEndResp', value);

  String? get ruaEndResp => getField<String>('ruaEndResp');
  set ruaEndResp(String? value) => setField<String>('ruaEndResp', value);

  String? get numEndResp => getField<String>('numEndResp');
  set numEndResp(String? value) => setField<String>('numEndResp', value);

  String? get compEndResp => getField<String>('compEndResp');
  set compEndResp(String? value) => setField<String>('compEndResp', value);

  String? get bairroEndResp => getField<String>('bairroEndResp');
  set bairroEndResp(String? value) => setField<String>('bairroEndResp', value);

  String? get cidadeEndResp => getField<String>('cidadeEndResp');
  set cidadeEndResp(String? value) => setField<String>('cidadeEndResp', value);

  String? get ufEndResp => getField<String>('ufEndResp');
  set ufEndResp(String? value) => setField<String>('ufEndResp', value);

  String? get domTipoEndereco => getField<String>('domTipoEndereco');
  set domTipoEndereco(String? value) =>
      setField<String>('domTipoEndereco', value);

  int? get idAluno => getField<int>('idAluno');
  set idAluno(int? value) => setField<int>('idAluno', value);
}
