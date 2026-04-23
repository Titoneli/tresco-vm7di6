import 'dart:convert';

import 'package:flutter/material.dart';

import '/backend/schema/structs/index.dart';

import '/backend/supabase/supabase.dart';

import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';

/// SERIALIZATION HELPERS

String dateTimeRangeToString(DateTimeRange dateTimeRange) {
  final startStr = dateTimeRange.start.millisecondsSinceEpoch.toString();
  final endStr = dateTimeRange.end.millisecondsSinceEpoch.toString();
  return '$startStr|$endStr';
}

String placeToString(FFPlace place) => jsonEncode({
      'latLng': place.latLng.serialize(),
      'name': place.name,
      'address': place.address,
      'city': place.city,
      'state': place.state,
      'country': place.country,
      'zipCode': place.zipCode,
    });

String uploadedFileToString(FFUploadedFile uploadedFile) =>
    uploadedFile.serialize();

String? serializeParam(
  dynamic param,
  ParamType paramType, {
  bool isList = false,
}) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final serializedValues = (param as Iterable)
          .map((p) => serializeParam(p, paramType, isList: false))
          .where((p) => p != null)
          .map((p) => p!)
          .toList();
      return json.encode(serializedValues);
    }
    String? data;
    switch (paramType) {
      case ParamType.int:
        data = param.toString();
      case ParamType.double:
        data = param.toString();
      case ParamType.String:
        data = param;
      case ParamType.bool:
        data = param ? 'true' : 'false';
      case ParamType.DateTime:
        data = (param as DateTime).millisecondsSinceEpoch.toString();
      case ParamType.DateTimeRange:
        data = dateTimeRangeToString(param as DateTimeRange);
      case ParamType.LatLng:
        data = (param as LatLng).serialize();
      case ParamType.Color:
        data = (param as Color).toCssString();
      case ParamType.FFPlace:
        data = placeToString(param as FFPlace);
      case ParamType.FFUploadedFile:
        data = uploadedFileToString(param as FFUploadedFile);
      case ParamType.JSON:
        data = json.encode(param);

      case ParamType.DataStruct:
        data = param is BaseStruct ? param.serialize() : null;

      case ParamType.SupabaseRow:
        return json.encode((param as SupabaseDataRow).data);

      default:
        data = null;
    }
    return data;
  } catch (e) {
    print('Error serializing parameter: $e');
    return null;
  }
}

/// END SERIALIZATION HELPERS

/// DESERIALIZATION HELPERS

DateTimeRange? dateTimeRangeFromString(String dateTimeRangeStr) {
  final pieces = dateTimeRangeStr.split('|');
  if (pieces.length != 2) {
    return null;
  }
  return DateTimeRange(
    start: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.first)),
    end: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.last)),
  );
}

LatLng? latLngFromString(String? latLngStr) {
  final pieces = latLngStr?.split(',');
  if (pieces == null || pieces.length != 2) {
    return null;
  }
  return LatLng(
    double.parse(pieces.first.trim()),
    double.parse(pieces.last.trim()),
  );
}

FFPlace placeFromString(String placeStr) {
  final serializedData = jsonDecode(placeStr) as Map<String, dynamic>;
  final data = {
    'latLng': serializedData.containsKey('latLng')
        ? latLngFromString(serializedData['latLng'] as String)
        : const LatLng(0.0, 0.0),
    'name': serializedData['name'] ?? '',
    'address': serializedData['address'] ?? '',
    'city': serializedData['city'] ?? '',
    'state': serializedData['state'] ?? '',
    'country': serializedData['country'] ?? '',
    'zipCode': serializedData['zipCode'] ?? '',
  };
  return FFPlace(
    latLng: data['latLng'] as LatLng,
    name: data['name'] as String,
    address: data['address'] as String,
    city: data['city'] as String,
    state: data['state'] as String,
    country: data['country'] as String,
    zipCode: data['zipCode'] as String,
  );
}

FFUploadedFile uploadedFileFromString(String uploadedFileStr) =>
    FFUploadedFile.deserialize(uploadedFileStr);

enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DateTimeRange,
  LatLng,
  Color,
  FFPlace,
  FFUploadedFile,
  JSON,

  DataStruct,
  SupabaseRow,
}

dynamic deserializeParam<T>(
  String? param,
  ParamType paramType,
  bool isList, {
  StructBuilder<T>? structBuilder,
}) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final paramValues = json.decode(param);
      if (paramValues is! Iterable || paramValues.isEmpty) {
        return null;
      }
      return paramValues
          .where((p) => p is String)
          .map((p) => p as String)
          .map((p) => deserializeParam<T>(
                p,
                paramType,
                false,
                structBuilder: structBuilder,
              ))
          .where((p) => p != null)
          .map((p) => p! as T)
          .toList();
    }
    switch (paramType) {
      case ParamType.int:
        return int.tryParse(param);
      case ParamType.double:
        return double.tryParse(param);
      case ParamType.String:
        return param;
      case ParamType.bool:
        return param == 'true';
      case ParamType.DateTime:
        final milliseconds = int.tryParse(param);
        return milliseconds != null
            ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
            : null;
      case ParamType.DateTimeRange:
        return dateTimeRangeFromString(param);
      case ParamType.LatLng:
        return latLngFromString(param);
      case ParamType.Color:
        return fromCssColor(param);
      case ParamType.FFPlace:
        return placeFromString(param);
      case ParamType.FFUploadedFile:
        return uploadedFileFromString(param);
      case ParamType.JSON:
        return json.decode(param);

      case ParamType.SupabaseRow:
        final data = json.decode(param) as Map<String, dynamic>;
        switch (T) {
          case UsuarioHistoricoArquivoRow:
            return UsuarioHistoricoArquivoRow(data);
          case TotalunosescolasRow:
            return TotalunosescolasRow(data);
          case AlunoHistoricoRow:
            return AlunoHistoricoRow(data);
          case VvalidaFechamentoRow:
            return VvalidaFechamentoRow(data);
          case RespAlunoRow:
            return RespAlunoRow(data);
          case RetdadosalunosRow:
            return RetdadosalunosRow(data);
          case CobrancaEmpresaRow:
            return CobrancaEmpresaRow(data);
          case EscolaRow:
            return EscolaRow(data);
          case AlunoImportadoRow:
            return AlunoImportadoRow(data);
          case VretfichamentomesbaseRow:
            return VretfichamentomesbaseRow(data);
          case CorComunicadoRow:
            return CorComunicadoRow(data);
          case RettotalunosativosRow:
            return RettotalunosativosRow(data);
          case VgcrVeiculosRow:
            return VgcrVeiculosRow(data);
          case RelcontabilpormotoristaRow:
            return RelcontabilpormotoristaRow(data);
          case RetalunosmotoristaescolasRow:
            return RetalunosmotoristaescolasRow(data);
          case RettotalunosmotoristaRow:
            return RettotalunosmotoristaRow(data);
          case RetdadosveiculoRow:
            return RetdadosveiculoRow(data);
          case RellistaescolamotoristaRow:
            return RellistaescolamotoristaRow(data);
          case EmpresaRow:
            return EmpresaRow(data);
          case VgcrBoletosRow:
            return VgcrBoletosRow(data);
          case ListagemescolaalunosRow:
            return ListagemescolaalunosRow(data);
          case VSumAlunosEscolaTurmaRow:
            return VSumAlunosEscolaTurmaRow(data);
          case ContratoAlunoRow:
            return ContratoAlunoRow(data);
          case FinfechamentoRow:
            return FinfechamentoRow(data);
          case VeiculoRow:
            return VeiculoRow(data);
          case TransladoRow:
            return TransladoRow(data);
          case VfinfechamentototalmotRow:
            return VfinfechamentototalmotRow(data);
          case VgcrRastreadoresRow:
            return VgcrRastreadoresRow(data);
          case AppAlunosConferenciaRow:
            return AppAlunosConferenciaRow(data);
          case RettotalunosescolasRow:
            return RettotalunosescolasRow(data);
          case RetdadosdashboardRow:
            return RetdadosdashboardRow(data);
          case RettotmotoristaRow:
            return RettotmotoristaRow(data);
          case RettotalunosmotoristaescolaRow:
            return RettotalunosmotoristaescolaRow(data);
          case ItinerarioAlunoRow:
            return ItinerarioAlunoRow(data);
          case VwAlunoAuditoriaRow:
            return VwAlunoAuditoriaRow(data);
          case VfinfechamentomotoristasRow:
            return VfinfechamentomotoristasRow(data);
          case RettotdashboardRow:
            return RettotdashboardRow(data);
          case RetalunosmotoristaRow:
            return RetalunosmotoristaRow(data);
          case KeepAliveRow:
            return KeepAliveRow(data);
          case ControleRefreshViewRow:
            return ControleRefreshViewRow(data);
          case FinfechconfirmadoRow:
            return FinfechconfirmadoRow(data);
          case VwUsuarioAuditoriaRow:
            return VwUsuarioAuditoriaRow(data);
          case TotvalalunosescolasRow:
            return TotvalalunosescolasRow(data);
          case RellistagemalunosmotescRow:
            return RellistagemalunosmotescRow(data);
          case ReldemonstrantivomotoristafechamentoRow:
            return ReldemonstrantivomotoristafechamentoRow(data);
          case FilesRow:
            return FilesRow(data);
          case CorDominioRow:
            return CorDominioRow(data);
          case VgcrChipsGetrakRow:
            return VgcrChipsGetrakRow(data);
          case TurmaRow:
            return TurmaRow(data);
          case RettotescolaRow:
            return RettotescolaRow(data);
          case UsuarioRow:
            return UsuarioRow(data);
          case DocumentsRow:
            return DocumentsRow(data);
          case RetalunosescolasRow:
            return RetalunosescolasRow(data);
          case AlunoRow:
            return AlunoRow(data);
          case ReldemonstrantivomotoristaRow:
            return ReldemonstrantivomotoristaRow(data);
          case DualRow:
            return DualRow(data);
          case AlunoHistoricoArquivoRow:
            return AlunoHistoricoArquivoRow(data);
          case UsuarioHistoricoRow:
            return UsuarioHistoricoRow(data);
          case RettotalunosRow:
            return RettotalunosRow(data);
          case BancoEmpresaRow:
            return BancoEmpresaRow(data);
          case RelcontabilmotescRow:
            return RelcontabilmotescRow(data);
          case RetdempfpjRow:
            return RetdempfpjRow(data);
          default:
            return null;
        }

      case ParamType.DataStruct:
        final data = json.decode(param) as Map<String, dynamic>? ?? {};
        return structBuilder != null ? structBuilder(data) : null;

      default:
        return null;
    }
  } catch (e) {
    print('Error deserializing parameter: $e');
    return null;
  }
}
