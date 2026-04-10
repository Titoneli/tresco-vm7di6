import '../database.dart';

class FinfechamentoBkpTable extends SupabaseTable<FinfechamentoBkpRow> {
  @override
  String get tableName => 'finfechamento_bkp';

  @override
  FinfechamentoBkpRow createRow(Map<String, dynamic> data) =>
      FinfechamentoBkpRow(data);
}

class FinfechamentoBkpRow extends SupabaseDataRow {
  FinfechamentoBkpRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FinfechamentoBkpTable();

  int? get idEscola => getField<int>('idEscola');
  set idEscola(int? value) => setField<int>('idEscola', value);

  int? get idMotorista => getField<int>('idMotorista');
  set idMotorista(int? value) => setField<int>('idMotorista', value);

  int? get qtdalunos => getField<int>('qtdalunos');
  set qtdalunos(int? value) => setField<int>('qtdalunos', value);

  String? get valbruto => getField<String>('valbruto');
  set valbruto(String? value) => setField<String>('valbruto', value);

  String? get nomeUsuario => getField<String>('nomeUsuario');
  set nomeUsuario(String? value) => setField<String>('nomeUsuario', value);

  String? get cpfUsuario => getField<String>('cpfUsuario');
  set cpfUsuario(String? value) => setField<String>('cpfUsuario', value);

  String? get valaluno => getField<String>('valaluno');
  set valaluno(String? value) => setField<String>('valaluno', value);

  String? get domTipoPessoa => getField<String>('domTipoPessoa');
  set domTipoPessoa(String? value) => setField<String>('domTipoPessoa', value);

  String? get codINSS => getField<String>('codINSS');
  set codINSS(String? value) => setField<String>('codINSS', value);

  double? get qtddependentesir => getField<double>('qtddependentesir');
  set qtddependentesir(double? value) =>
      setField<double>('qtddependentesir', value);

  String? get pix => getField<String>('pix');
  set pix(String? value) => setField<String>('pix', value);

  String? get valDescontoCooperativa =>
      getField<String>('valDescontoCooperativa');
  set valDescontoCooperativa(String? value) =>
      setField<String>('valDescontoCooperativa', value);

  String? get matriculaCooperativa => getField<String>('matriculaCooperativa');
  set matriculaCooperativa(String? value) =>
      setField<String>('matriculaCooperativa', value);

  String? get valalunosinss => getField<String>('valalunosinss');
  set valalunosinss(String? value) => setField<String>('valalunosinss', value);

  String? get baseretencaoinss => getField<String>('baseretencaoinss');
  set baseretencaoinss(String? value) =>
      setField<String>('baseretencaoinss', value);

  String? get valretidoinss => getField<String>('valretidoinss');
  set valretidoinss(String? value) => setField<String>('valretidoinss', value);

  String? get valretidoalunoinss => getField<String>('valretidoalunoinss');
  set valretidoalunoinss(String? value) =>
      setField<String>('valretidoalunoinss', value);

  String? get valliquidoapagarinss => getField<String>('valliquidoapagarinss');
  set valliquidoapagarinss(String? value) =>
      setField<String>('valliquidoapagarinss', value);

  String? get valalunosirpf => getField<String>('valalunosirpf');
  set valalunosirpf(String? value) => setField<String>('valalunosirpf', value);

  String? get baseretencaopporalunoirpf =>
      getField<String>('baseretencaopporalunoirpf');
  set baseretencaopporalunoirpf(String? value) =>
      setField<String>('baseretencaopporalunoirpf', value);

  int? get qtdalunosirpf => getField<int>('qtdalunosirpf');
  set qtdalunosirpf(int? value) => setField<int>('qtdalunosirpf', value);

  String? get valbrutoalunosirpf => getField<String>('valbrutoalunosirpf');
  set valbrutoalunosirpf(String? value) =>
      setField<String>('valbrutoalunosirpf', value);

  String? get valinssretidoirpf => getField<String>('valinssretidoirpf');
  set valinssretidoirpf(String? value) =>
      setField<String>('valinssretidoirpf', value);

  String? get baseretencaoalunoirpf =>
      getField<String>('baseretencaoalunoirpf');
  set baseretencaoalunoirpf(String? value) =>
      setField<String>('baseretencaoalunoirpf', value);

  String? get aliquotairpf => getField<String>('aliquotairpf');
  set aliquotairpf(String? value) => setField<String>('aliquotairpf', value);

  String? get parceladeduzirirpf => getField<String>('parceladeduzirirpf');
  set parceladeduzirirpf(String? value) =>
      setField<String>('parceladeduzirirpf', value);

  String? get valbrutosemretencaoirpf =>
      getField<String>('valbrutosemretencaoirpf');
  set valbrutosemretencaoirpf(String? value) =>
      setField<String>('valbrutosemretencaoirpf', value);

  String? get valimpostosemdependirpf =>
      getField<String>('valimpostosemdependirpf');
  set valimpostosemdependirpf(String? value) =>
      setField<String>('valimpostosemdependirpf', value);

  String? get valpordependenteirpf => getField<String>('valpordependenteirpf');
  set valpordependenteirpf(String? value) =>
      setField<String>('valpordependenteirpf', value);

  String? get valadeduzirdependirpf =>
      getField<String>('valadeduzirdependirpf');
  set valadeduzirdependirpf(String? value) =>
      setField<String>('valadeduzirdependirpf', value);

  String? get valareterirpf => getField<String>('valareterirpf');
  set valareterirpf(String? value) => setField<String>('valareterirpf', value);

  String? get valreteralunoirpf => getField<String>('valreteralunoirpf');
  set valreteralunoirpf(String? value) =>
      setField<String>('valreteralunoirpf', value);

  int? get qtdalunosresumo => getField<int>('qtdalunosresumo');
  set qtdalunosresumo(int? value) => setField<int>('qtdalunosresumo', value);

  String? get valalunoresumo => getField<String>('valalunoresumo');
  set valalunoresumo(String? value) =>
      setField<String>('valalunoresumo', value);

  String? get valbrutoresumo => getField<String>('valbrutoresumo');
  set valbrutoresumo(String? value) =>
      setField<String>('valbrutoresumo', value);

  String? get valretidoinssresumo => getField<String>('valretidoinssresumo');
  set valretidoinssresumo(String? value) =>
      setField<String>('valretidoinssresumo', value);

  double? get valretidoinssresumonum =>
      getField<double>('valretidoinssresumonum');
  set valretidoinssresumonum(double? value) =>
      setField<double>('valretidoinssresumonum', value);

  String? get valretidoirpfresumo => getField<String>('valretidoirpfresumo');
  set valretidoirpfresumo(String? value) =>
      setField<String>('valretidoirpfresumo', value);

  double? get valretidoirpfresumonum =>
      getField<double>('valretidoirpfresumonum');
  set valretidoirpfresumonum(double? value) =>
      setField<double>('valretidoirpfresumonum', value);

  String? get valdescontosresumo => getField<String>('valdescontosresumo');
  set valdescontosresumo(String? value) =>
      setField<String>('valdescontosresumo', value);

  String? get valdeducaoresumo => getField<String>('valdeducaoresumo');
  set valdeducaoresumo(String? value) =>
      setField<String>('valdeducaoresumo', value);

  String? get valliquidoresumo => getField<String>('valliquidoresumo');
  set valliquidoresumo(String? value) =>
      setField<String>('valliquidoresumo', value);

  double? get valliquidoresumonum => getField<double>('valliquidoresumonum');
  set valliquidoresumonum(double? value) =>
      setField<double>('valliquidoresumonum', value);

  String? get valliquidoresumopj => getField<String>('valliquidoresumopj');
  set valliquidoresumopj(String? value) =>
      setField<String>('valliquidoresumopj', value);

  double? get valliquidoresumopjnum =>
      getField<double>('valliquidoresumopjnum');
  set valliquidoresumopjnum(double? value) =>
      setField<double>('valliquidoresumopjnum', value);

  String? get valinssporalunodetalhe =>
      getField<String>('valinssporalunodetalhe');
  set valinssporalunodetalhe(String? value) =>
      setField<String>('valinssporalunodetalhe', value);

  String? get valirpfporalunodetalhe =>
      getField<String>('valirpfporalunodetalhe');
  set valirpfporalunodetalhe(String? value) =>
      setField<String>('valirpfporalunodetalhe', value);

  String? get valliquidoalunodetalhe =>
      getField<String>('valliquidoalunodetalhe');
  set valliquidoalunodetalhe(String? value) =>
      setField<String>('valliquidoalunodetalhe', value);

  String? get datarepasse => getField<String>('datarepasse');
  set datarepasse(String? value) => setField<String>('datarepasse', value);

  String? get mesreferente => getField<String>('mesreferente');
  set mesreferente(String? value) => setField<String>('mesreferente', value);

  String? get mesbase => getField<String>('mesbase');
  set mesbase(String? value) => setField<String>('mesbase', value);

  String? get nomeescola => getField<String>('nomeescola');
  set nomeescola(String? value) => setField<String>('nomeescola', value);

  int get idfechamento => getField<int>('idfechamento')!;
  set idfechamento(int value) => setField<int>('idfechamento', value);
}
