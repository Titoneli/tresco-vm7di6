// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ListagemEscolaAlunosStruct extends BaseStruct {
  ListagemEscolaAlunosStruct({
    /// Aluno
    String? nomeAluno,

    /// Escola
    String? nomeEscola,

    /// Turno
    String? domTurno,
  })  : _nomeAluno = nomeAluno,
        _nomeEscola = nomeEscola,
        _domTurno = domTurno;

  // "nomeAluno" field.
  String? _nomeAluno;
  String get nomeAluno => _nomeAluno ?? '';
  set nomeAluno(String? val) => _nomeAluno = val;

  bool hasNomeAluno() => _nomeAluno != null;

  // "nomeEscola" field.
  String? _nomeEscola;
  String get nomeEscola => _nomeEscola ?? '';
  set nomeEscola(String? val) => _nomeEscola = val;

  bool hasNomeEscola() => _nomeEscola != null;

  // "domTurno" field.
  String? _domTurno;
  String get domTurno => _domTurno ?? '';
  set domTurno(String? val) => _domTurno = val;

  bool hasDomTurno() => _domTurno != null;

  static ListagemEscolaAlunosStruct fromMap(Map<String, dynamic> data) =>
      ListagemEscolaAlunosStruct(
        nomeAluno: data['nomeAluno'] as String?,
        nomeEscola: data['nomeEscola'] as String?,
        domTurno: data['domTurno'] as String?,
      );

  static ListagemEscolaAlunosStruct? maybeFromMap(dynamic data) => data is Map
      ? ListagemEscolaAlunosStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'nomeAluno': _nomeAluno,
        'nomeEscola': _nomeEscola,
        'domTurno': _domTurno,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'nomeAluno': serializeParam(
          _nomeAluno,
          ParamType.String,
        ),
        'nomeEscola': serializeParam(
          _nomeEscola,
          ParamType.String,
        ),
        'domTurno': serializeParam(
          _domTurno,
          ParamType.String,
        ),
      }.withoutNulls;

  static ListagemEscolaAlunosStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ListagemEscolaAlunosStruct(
        nomeAluno: deserializeParam(
          data['nomeAluno'],
          ParamType.String,
          false,
        ),
        nomeEscola: deserializeParam(
          data['nomeEscola'],
          ParamType.String,
          false,
        ),
        domTurno: deserializeParam(
          data['domTurno'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ListagemEscolaAlunosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ListagemEscolaAlunosStruct &&
        nomeAluno == other.nomeAluno &&
        nomeEscola == other.nomeEscola &&
        domTurno == other.domTurno;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([nomeAluno, nomeEscola, domTurno]);
}

ListagemEscolaAlunosStruct createListagemEscolaAlunosStruct({
  String? nomeAluno,
  String? nomeEscola,
  String? domTurno,
}) =>
    ListagemEscolaAlunosStruct(
      nomeAluno: nomeAluno,
      nomeEscola: nomeEscola,
      domTurno: domTurno,
    );
