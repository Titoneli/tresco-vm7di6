import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _nomeSistema = prefs.getString('ff_nomeSistema') ?? _nomeSistema;
    });
    _safeInit(() {
      _usuario = prefs.getString('ff_usuario') ?? _usuario;
    });
    _safeInit(() {
      _idEscolaUsuario = prefs.getInt('ff_idEscolaUsuario') ?? _idEscolaUsuario;
    });
    _safeInit(() {
      _googleApiKey = prefs.getString('ff_googleApiKey') ?? _googleApiKey;
    });
    _safeInit(() {
      _senha = prefs.getString('ff_senha') ?? _senha;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _nomeEmpresa = '';
  String get nomeEmpresa => _nomeEmpresa;
  set nomeEmpresa(String value) {
    _nomeEmpresa = value;
  }

  bool _menuExpandido = false;
  bool get menuExpandido => _menuExpandido;
  set menuExpandido(bool value) {
    _menuExpandido = value;
  }

  String _nomeUsuario = '';
  String get nomeUsuario => _nomeUsuario;
  set nomeUsuario(String value) {
    _nomeUsuario = value;
  }

  String _cargoUsuario = '';
  String get cargoUsuario => _cargoUsuario;
  set cargoUsuario(String value) {
    _cargoUsuario = value;
  }

  String _nomeSistema = 'Tresco';
  String get nomeSistema => _nomeSistema;
  set nomeSistema(String value) {
    _nomeSistema = value;
    prefs.setString('ff_nomeSistema', value);
  }

  String _usuario = '';
  String get usuario => _usuario;
  set usuario(String value) {
    _usuario = value;
    prefs.setString('ff_usuario', value);
  }

  int _idEmpresa = 0;
  int get idEmpresa => _idEmpresa;
  set idEmpresa(int value) {
    _idEmpresa = value;
  }

  int _idUsuario = 0;
  int get idUsuario => _idUsuario;
  set idUsuario(int value) {
    _idUsuario = value;
  }

  String _enderecoAluno = '';
  String get enderecoAluno => _enderecoAluno;
  set enderecoAluno(String value) {
    _enderecoAluno = value;
  }

  LatLng? _latLongAluno = LatLng(-19.7922135, -43.9389577);
  LatLng? get latLongAluno => _latLongAluno;
  set latLongAluno(LatLng? value) {
    _latLongAluno = value;
  }

  List<LatLng> _lstLatLongAluno = [];
  List<LatLng> get lstLatLongAluno => _lstLatLongAluno;
  set lstLatLongAluno(List<LatLng> value) {
    _lstLatLongAluno = value;
  }

  void addToLstLatLongAluno(LatLng value) {
    lstLatLongAluno.add(value);
  }

  void removeFromLstLatLongAluno(LatLng value) {
    lstLatLongAluno.remove(value);
  }

  void removeAtIndexFromLstLatLongAluno(int index) {
    lstLatLongAluno.removeAt(index);
  }

  void updateLstLatLongAlunoAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    lstLatLongAluno[index] = updateFn(_lstLatLongAluno[index]);
  }

  void insertAtIndexInLstLatLongAluno(int index, LatLng value) {
    lstLatLongAluno.insert(index, value);
  }

  String _enderecoVeiculo = '';
  String get enderecoVeiculo => _enderecoVeiculo;
  set enderecoVeiculo(String value) {
    _enderecoVeiculo = value;
  }

  LatLng? _latLongVeiculo;
  LatLng? get latLongVeiculo => _latLongVeiculo;
  set latLongVeiculo(LatLng? value) {
    _latLongVeiculo = value;
  }

  List<LatLng> _lstLatLongVeiculo = [];
  List<LatLng> get lstLatLongVeiculo => _lstLatLongVeiculo;
  set lstLatLongVeiculo(List<LatLng> value) {
    _lstLatLongVeiculo = value;
  }

  void addToLstLatLongVeiculo(LatLng value) {
    lstLatLongVeiculo.add(value);
  }

  void removeFromLstLatLongVeiculo(LatLng value) {
    lstLatLongVeiculo.remove(value);
  }

  void removeAtIndexFromLstLatLongVeiculo(int index) {
    lstLatLongVeiculo.removeAt(index);
  }

  void updateLstLatLongVeiculoAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    lstLatLongVeiculo[index] = updateFn(_lstLatLongVeiculo[index]);
  }

  void insertAtIndexInLstLatLongVeiculo(int index, LatLng value) {
    lstLatLongVeiculo.insert(index, value);
  }

  List<LatLng> _lstLatLongRotaVeiculo = [];
  List<LatLng> get lstLatLongRotaVeiculo => _lstLatLongRotaVeiculo;
  set lstLatLongRotaVeiculo(List<LatLng> value) {
    _lstLatLongRotaVeiculo = value;
  }

  void addToLstLatLongRotaVeiculo(LatLng value) {
    lstLatLongRotaVeiculo.add(value);
  }

  void removeFromLstLatLongRotaVeiculo(LatLng value) {
    lstLatLongRotaVeiculo.remove(value);
  }

  void removeAtIndexFromLstLatLongRotaVeiculo(int index) {
    lstLatLongRotaVeiculo.removeAt(index);
  }

  void updateLstLatLongRotaVeiculoAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    lstLatLongRotaVeiculo[index] = updateFn(_lstLatLongRotaVeiculo[index]);
  }

  void insertAtIndexInLstLatLongRotaVeiculo(int index, LatLng value) {
    lstLatLongRotaVeiculo.insert(index, value);
  }

  int _totAlunos = 0;
  int get totAlunos => _totAlunos;
  set totAlunos(int value) {
    _totAlunos = value;
  }

  int _indexAluno = 0;
  int get indexAluno => _indexAluno;
  set indexAluno(int value) {
    _indexAluno = value;
  }

  List<int> _lstContaAlunos = [];
  List<int> get lstContaAlunos => _lstContaAlunos;
  set lstContaAlunos(List<int> value) {
    _lstContaAlunos = value;
  }

  void addToLstContaAlunos(int value) {
    lstContaAlunos.add(value);
  }

  void removeFromLstContaAlunos(int value) {
    lstContaAlunos.remove(value);
  }

  void removeAtIndexFromLstContaAlunos(int index) {
    lstContaAlunos.removeAt(index);
  }

  void updateLstContaAlunosAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    lstContaAlunos[index] = updateFn(_lstContaAlunos[index]);
  }

  void insertAtIndexInLstContaAlunos(int index, int value) {
    lstContaAlunos.insert(index, value);
  }

  int _idddwEscola = 0;
  int get idddwEscola => _idddwEscola;
  set idddwEscola(int value) {
    _idddwEscola = value;
  }

  int _idddwTurma = 0;
  int get idddwTurma => _idddwTurma;
  set idddwTurma(int value) {
    _idddwTurma = value;
  }

  String _domSitAlunoAtivo = 'Ativo';
  String get domSitAlunoAtivo => _domSitAlunoAtivo;
  set domSitAlunoAtivo(String value) {
    _domSitAlunoAtivo = value;
  }

  /// Código da Escola caso o usuário seja do Tipo Cargo: Escola
  int _idEscolaUsuario = 0;
  int get idEscolaUsuario => _idEscolaUsuario;
  set idEscolaUsuario(int value) {
    _idEscolaUsuario = value;
    prefs.setInt('ff_idEscolaUsuario', value);
  }

  String _latGeoCodeAddress = '';
  String get latGeoCodeAddress => _latGeoCodeAddress;
  set latGeoCodeAddress(String value) {
    _latGeoCodeAddress = value;
  }

  String _lngGeoCodeAddress = '';
  String get lngGeoCodeAddress => _lngGeoCodeAddress;
  set lngGeoCodeAddress(String value) {
    _lngGeoCodeAddress = value;
  }

  String _googleApiKey = '';
  String get googleApiKey => _googleApiKey;
  set googleApiKey(String value) {
    _googleApiKey = value;
    prefs.setString('ff_googleApiKey', value);
  }

  LatLng? _defaultLocation;
  LatLng? get defaultLocation => _defaultLocation;
  set defaultLocation(LatLng? value) {
    _defaultLocation = value;
  }

  String _googlePlaceID = '';
  String get googlePlaceID => _googlePlaceID;
  set googlePlaceID(String value) {
    _googlePlaceID = value;
  }

  double _latitudeAluno = 0.0;
  double get latitudeAluno => _latitudeAluno;
  set latitudeAluno(double value) {
    _latitudeAluno = value;
  }

  double _longitudeAluno = 0.0;
  double get longitudeAluno => _longitudeAluno;
  set longitudeAluno(double value) {
    _longitudeAluno = value;
  }

  bool _boAtualizaTela = false;
  bool get boAtualizaTela => _boAtualizaTela;
  set boAtualizaTela(bool value) {
    _boAtualizaTela = value;
  }

  bool _boExpEscola = false;
  bool get boExpEscola => _boExpEscola;
  set boExpEscola(bool value) {
    _boExpEscola = value;
  }

  bool _boExpMotorista = false;
  bool get boExpMotorista => _boExpMotorista;
  set boExpMotorista(bool value) {
    _boExpMotorista = value;
  }

  bool _boExpAluno = false;
  bool get boExpAluno => _boExpAluno;
  set boExpAluno(bool value) {
    _boExpAluno = value;
  }

  String _domSitAlunoAguardando = 'Aguardando';
  String get domSitAlunoAguardando => _domSitAlunoAguardando;
  set domSitAlunoAguardando(String value) {
    _domSitAlunoAguardando = value;
  }

  String _domSitAlunoInativo = 'Inativo';
  String get domSitAlunoInativo => _domSitAlunoInativo;
  set domSitAlunoInativo(String value) {
    _domSitAlunoInativo = value;
  }

  String _senha = '';
  String get senha => _senha;
  set senha(String value) {
    _senha = value;
    prefs.setString('ff_senha', value);
  }

  String _nomeEscolaUsuario = '';
  String get nomeEscolaUsuario => _nomeEscolaUsuario;
  set nomeEscolaUsuario(String value) {
    _nomeEscolaUsuario = value;
  }

  bool _isOptionsExpanded = false;
  bool get isOptionsExpanded => _isOptionsExpanded;
  set isOptionsExpanded(bool value) {
    _isOptionsExpanded = value;
  }

  int _recCountAlunosLista = 0;
  int get recCountAlunosLista => _recCountAlunosLista;
  set recCountAlunosLista(int value) {
    _recCountAlunosLista = value;
  }

  List<ListagemEscolaAlunosStruct> _alunosLista = [];
  List<ListagemEscolaAlunosStruct> get alunosLista => _alunosLista;
  set alunosLista(List<ListagemEscolaAlunosStruct> value) {
    _alunosLista = value;
  }

  void addToAlunosLista(ListagemEscolaAlunosStruct value) {
    alunosLista.add(value);
  }

  void removeFromAlunosLista(ListagemEscolaAlunosStruct value) {
    alunosLista.remove(value);
  }

  void removeAtIndexFromAlunosLista(int index) {
    alunosLista.removeAt(index);
  }

  void updateAlunosListaAtIndex(
    int index,
    ListagemEscolaAlunosStruct Function(ListagemEscolaAlunosStruct) updateFn,
  ) {
    alunosLista[index] = updateFn(_alunosLista[index]);
  }

  void insertAtIndexInAlunosLista(int index, ListagemEscolaAlunosStruct value) {
    alunosLista.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
