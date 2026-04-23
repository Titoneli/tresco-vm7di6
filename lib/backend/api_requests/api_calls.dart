import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';

import 'package:ff_commons/api_requests/api_paging_params.dart';

export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class WhvalidausuarioCall {
  static Future<ApiCallResponse> call({
    String? usuario = '',
    String? senha = '',
    String? empresa = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WHVALIDAUSUARIO',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/wh_valida_usuario_tresco',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'usuario': usuario,
        'senha': senha,
        'empresa': empresa,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idUsuario(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.idUsuario''',
      ));
  static String? nomeUsuario(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.nomeUsuario''',
      ));
  static String? loginLiberado(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.loginLiberado''',
      ));
  static String? ativo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.ativo''',
      ));
  static String? domCargo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.domCargo''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.idEmpresa''',
      ));
  static String? nomeEmpresa(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.nomeEmpresa''',
      ));
  static String? usuario(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.usuario''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.idEscola''',
      ));
}

class WhgeraautorizacaorespCall {
  static Future<ApiCallResponse> call({
    String? nomeAluno = '',
    String? idAluno = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WHGERAAUTORIZACAORESP',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/gerarAutorizacaoResp',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'nomeAluno': nomeAluno,
        'idAluno': idAluno,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? urlArquivo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.urlArquivo''',
      ));
}

class WhgeradempfpjCall {
  static Future<ApiCallResponse> call({
    String? idEscola = '',
    String? idMotorista = '',
    String? mesbase = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WHGERADEMPFPJ',
      apiUrl: 'https://webhook.n8ncp.vigicar.com.br/webhook/geradempfpj',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'idMotorista': idMotorista,
        'idEscola': idEscola,
        'mesbase': mesbase,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? urlArquivo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.urlArquivo''',
      ));
}

class WhgeraurlgooglemapsCall {
  static Future<ApiCallResponse> call({
    String? idAluno = '',
    String? sys = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WHGERAURLGOOGLEMAPS',
      apiUrl: 'https://webhook.n8ncp.vigicar.com.br/webhook/gerarurlgooglemaps',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'idAluno': idAluno,
        'sys': sys,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
  static String? latitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.latitude''',
      ));
  static String? longitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.longitude''',
      ));
  static double? dolatitude(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.dolatitude''',
      ));
  static double? dolongitude(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.dolongitude''',
      ));
}

class WhretconexaoevolutionCall {
  static Future<ApiCallResponse> call({
    String? instanceName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WHRETCONEXAOEVOLUTION',
      apiUrl: 'https://webhook.n8ncp.vigicar.com.br/webhook/whretornainstancia',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'aw_FJllBHPDivXBchnW186MmMQ4mI1MrtHWYMamAzCE0EUFfGAXSzY9hEpmZm0tq',
      },
      params: {
        'instanceName': instanceName,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? instanceinstanceName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.instanceName''',
      ));
  static dynamic? instance(dynamic response) => getJsonField(
        response,
        r'''$.instance''',
      );
  static String? instanceinstanceId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.instanceId''',
      ));
  static String? instanceintegrationwebhookwabusiness(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.integration.webhook_wa_business''',
      ));
  static String? instanceintegrationtoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.integration.token''',
      ));
  static dynamic? instanceintegration(dynamic response) => getJsonField(
        response,
        r'''$.instance.integration''',
      );
  static String? instanceapikey(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.apikey''',
      ));
  static String? instanceserverUrl(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.serverUrl''',
      ));
  static String? instancestatus(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.status''',
      ));
  static String? instanceprofilePictureUrl(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.profilePictureUrl''',
      ));
  static String? instanceprofileName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.profileName''',
      ));
  static String? instanceowner(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.instance.owner''',
      ));
}

class SearchUsuarioCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? codEmpresa,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchUsuario',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/usuario?nomeUsuario=ilike.*${searchString}*&domAdministrador=eq.False&select=*&order=nomeUsuario',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? idEmpresa(dynamic response) => (getJsonField(
        response,
        r'''$[:].idEmpresa''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? domCargo(dynamic response) => (getJsonField(
        response,
        r'''$[:].domCargo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? emailUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].emailUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? senha(dynamic response) => (getJsonField(
        response,
        r'''$[:].senha''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? usuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].usuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? ativo(dynamic response) => (getJsonField(
        response,
        r'''$[:].ativo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? loginLiberado(dynamic response) => (getJsonField(
        response,
        r'''$[:].loginLiberado''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? dtVencCNH(dynamic response) => getJsonField(
        response,
        r'''$[:].dtVencCNH''',
        true,
      ) as List?;
  static List<String>? dtAdmissao(dynamic response) => (getJsonField(
        response,
        r'''$[:].dtAdmissao''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? domGrupoUsuario(dynamic response) => getJsonField(
        response,
        r'''$[:].domGrupoUsuario''',
        true,
      ) as List?;
  static List<String>? whatsappUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].whatsappUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? cpfUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].cpfUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? cnhUsuario(dynamic response) => getJsonField(
        response,
        r'''$[:].cnhUsuario''',
        true,
      ) as List?;
  static List<String>? nomeUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].nomeUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dtUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].dtUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? idUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].idUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class SearchAlunoCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? codEmpresa,
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchAluno',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/aluno?nomeAluno=ilike.*${searchString}*&select=*&limit=${limit}&offset=${offset}&order=domSitAluno,nomeAluno',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchAlunoBuscaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? idEscola,
    int? limit,
    int? offset,
    double? lastPage,
    String? sitAluno = '',
    bool? checkAluno = true,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchAlunoBusca',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retdadosalunos?nomeAluno=ilike.*${searchString}*&domSitAluno=eq.${sitAluno}&domCheckAluno=eq.${checkAluno}&select=*&order=nomeAluno, domSitAluno',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchAlunoBuscaEscolaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchEscola,
    int? limit,
    int? offset,
    double? lastPage,
    String? searchDomSitAluno = 'Ativo',
    bool? checkAluno = true,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchAlunoBuscaEscola',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retdadosalunos?idEscola=eq.${searchEscola}&nomeAluno=ilike.*${searchString}*&domSitAluno=eq.${searchDomSitAluno}&domCheckAluno=eq.${checkAluno}&select=*&order=nomeAluno, domSitAluno',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchAlunoBuscaMotoristaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchMotorista,
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchAlunoBuscaMotorista',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retdadosalunos?idMotorista=eq.${searchMotorista}&nomeAluno=ilike.*${searchString}*&select=*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static List? telAluno(dynamic response) => getJsonField(
        response,
        r'''$[:].telAluno''',
        true,
      ) as List?;
  static String? emailAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].emailAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static List? domTipoAluno(dynamic response) => getJsonField(
        response,
        r'''$[:].domTipoAluno''',
        true,
      ) as List?;
  static String? cepAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].cepAluno''',
      ));
  static String? endAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].endAluno''',
      ));
  static String? numAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].numAluno''',
      ));
  static String? compAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].compAluno''',
      ));
  static String? bairroAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].bairroAluno''',
      ));
  static String? cidadeAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].cidadeAluno''',
      ));
  static String? ufAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].ufAluno''',
      ));
  static String? infoAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].infoAluno''',
      ));
  static List? pointGeo(dynamic response) => getJsonField(
        response,
        r'''$[:].pointGeo''',
        true,
      ) as List?;
  static List<double>? lat(dynamic response) => (getJsonField(
        response,
        r'''$[:].lat''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? long(dynamic response) => (getJsonField(
        response,
        r'''$[:].long''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static String? urlFoto(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].urlFoto''',
      ));
  static List? dtNascimento(dynamic response) => getJsonField(
        response,
        r'''$[:].dtNascimento''',
        true,
      ) as List?;
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idTurma(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idTurma''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? cpfAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].cpfAluno''',
      ));
  static List? idVeiculo(dynamic response) => getJsonField(
        response,
        r'''$[:].idVeiculo''',
        true,
      ) as List?;
  static int? idMotorista(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idMotorista''',
      ));
  static String? nomeResponsavel(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].nomeResponsavel''',
      ));
  static String? rgResponsavel(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].rgResponsavel''',
      ));
  static String? telResponsavel(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].telResponsavel''',
      ));
  static bool? autorizacaoEntregue(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$[:].autorizacaoEntregue''',
      ));
  static String? domAlunoFrequente(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domAlunoFrequente''',
      ));
  static List<String>? domSerie(dynamic response) => (getJsonField(
        response,
        r'''$[:].domSerie''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? fotoAlunoUrl(dynamic response) => getJsonField(
        response,
        r'''$[:].fotoAlunoUrl''',
        true,
      ) as List?;
  static String? nomeescola(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].nomeescola''',
      ));
  static String? nometurma(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nometurma''',
      ));
  static String? placaveiculo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].placaveiculo''',
      ));
  static String? nomemotorista(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].nomemotorista''',
      ));
  static String? cidadeestado(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].cidadeestado''',
      ));
  static String? endcompleto(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].endcompleto''',
      ));
  static int? valalunomotorista(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$[:].valalunomotorista''',
      ));
}

class SearchEscolaMotoristaAlunoCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchMotorista,
    int? searchEscola,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchEscolaMotoristaAluno',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retdadosalunos?idMotorista=eq.${searchMotorista}&stescola=ilike.*${searchEscola}*&nomeAluno=ilike.*${searchString}*&select=*&order=nomeAluno,domTurno',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static List? telAluno(dynamic response) => getJsonField(
        response,
        r'''$[:].telAluno''',
        true,
      ) as List?;
  static String? emailAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].emailAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static List? domTipoAluno(dynamic response) => getJsonField(
        response,
        r'''$[:].domTipoAluno''',
        true,
      ) as List?;
  static String? cepAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].cepAluno''',
      ));
  static String? endAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].endAluno''',
      ));
  static String? numAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].numAluno''',
      ));
  static String? compAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].compAluno''',
      ));
  static String? bairroAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].bairroAluno''',
      ));
  static String? cidadeAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].cidadeAluno''',
      ));
  static String? ufAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].ufAluno''',
      ));
  static String? infoAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].infoAluno''',
      ));
  static List? pointGeo(dynamic response) => getJsonField(
        response,
        r'''$[:].pointGeo''',
        true,
      ) as List?;
  static List<double>? lat(dynamic response) => (getJsonField(
        response,
        r'''$[:].lat''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? long(dynamic response) => (getJsonField(
        response,
        r'''$[:].long''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static String? urlFoto(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].urlFoto''',
      ));
  static List? dtNascimento(dynamic response) => getJsonField(
        response,
        r'''$[:].dtNascimento''',
        true,
      ) as List?;
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idTurma(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idTurma''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? cpfAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].cpfAluno''',
      ));
  static List? idVeiculo(dynamic response) => getJsonField(
        response,
        r'''$[:].idVeiculo''',
        true,
      ) as List?;
  static int? idMotorista(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idMotorista''',
      ));
  static String? nomeResponsavel(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].nomeResponsavel''',
      ));
  static String? rgResponsavel(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].rgResponsavel''',
      ));
  static String? telResponsavel(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].telResponsavel''',
      ));
  static bool? autorizacaoEntregue(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$[:].autorizacaoEntregue''',
      ));
  static String? domAlunoFrequente(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domAlunoFrequente''',
      ));
  static List<String>? domSerie(dynamic response) => (getJsonField(
        response,
        r'''$[:].domSerie''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? fotoAlunoUrl(dynamic response) => getJsonField(
        response,
        r'''$[:].fotoAlunoUrl''',
        true,
      ) as List?;
  static String? nomeescola(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].nomeescola''',
      ));
  static String? nometurma(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nometurma''',
      ));
  static String? placaveiculo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].placaveiculo''',
      ));
  static String? nomemotorista(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].nomemotorista''',
      ));
  static String? cidadeestado(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].cidadeestado''',
      ));
  static String? endcompleto(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].endcompleto''',
      ));
  static int? valalunomotorista(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$[:].valalunomotorista''',
      ));
  static String? dataBase(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dataBase''',
      ));
  static String? latlongAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].latlongAluno''',
      ));
  static String? urlGoogleMaps(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].urlGoogleMaps''',
      ));
  static int? seqAlunoMotorista(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$[:].seqAlunoMotorista''',
      ));
  static bool? domCheckAluno(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].domCheckAluno''',
      ));
  static bool? domsitalunoativo(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$[:].domsitalunoativo''',
      ));
  static bool? domsitalunoaguardando(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$[:].domsitalunoaguardando''',
      ));
  static bool? domsitalunoinativo(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$[:].domsitalunoinativo''',
      ));
  static double? valaluno(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$[:].valaluno''',
      ));
}

class SearchMotoristaListaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? codEmpresa,
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchMotoristaLista',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retalunosmotorista?nomeUsuario=ilike.*${searchString}*&select=*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchEscolaMotoristaListaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    String? searchEscola = '',
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchEscolaMotoristaLista',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retalunosmotoristaescolas?idEscola=eq.${searchEscola}&nomeUsuario=ilike.*${searchString}*&select=*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? idEscola(dynamic response) => (getJsonField(
        response,
        r'''$[:].idEscola''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? nomeEscola(dynamic response) => (getJsonField(
        response,
        r'''$[:].nomeEscola''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? idUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].idUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? nomeUsuario(dynamic response) => (getJsonField(
        response,
        r'''$[:].nomeUsuario''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? valAluno(dynamic response) => (getJsonField(
        response,
        r'''$[:].valAluno''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosocupadostarde(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosocupadostarde''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? idveiculo(dynamic response) => (getJsonField(
        response,
        r'''$[:].idveiculo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? placa(dynamic response) => (getJsonField(
        response,
        r'''$[:].placa''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? capacidade(dynamic response) => (getJsonField(
        response,
        r'''$[:].capacidade''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosocupados(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosocupados''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosocupadosmanha(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosocupadosmanha''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosocupadosnoite(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosocupadosnoite''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? valormensal(dynamic response) => (getJsonField(
        response,
        r'''$[:].valormensal''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosdisponiveis(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosdisponiveis''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? ocupacao(dynamic response) => (getJsonField(
        response,
        r'''$[:].ocupacao''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosdisponiveismanha(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosdisponiveismanha''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? ocupacaomanha(dynamic response) => (getJsonField(
        response,
        r'''$[:].ocupacaomanha''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosdisponiveistarde(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosdisponiveistarde''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? ocupacaotarde(dynamic response) => (getJsonField(
        response,
        r'''$[:].ocupacaotarde''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? assentosdisponiveisnoite(dynamic response) => (getJsonField(
        response,
        r'''$[:].assentosdisponiveisnoite''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? ocupacaonoite(dynamic response) => (getJsonField(
        response,
        r'''$[:].ocupacaonoite''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SearchEscolaListaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchEscola,
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchEscolaLista',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retalunosescolas?nomeEscola=ilike.*${searchString}*&select=*&order=nomeEscola',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchDashboardAdminEscolaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchEscola,
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchDashboardAdminEscola',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retdadosdashboard?nomeescola=ilike.*${searchString}*&select=*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchDashboardAdminMotoristaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchEscola,
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchDashboardAdminMotorista',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retdadosdashboard?idEscola=eq.${searchEscola}&nomemotorista=ilike.*${searchString}*&select=*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchDashboardAdminAlunosCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchEscola,
    int? searchMotorista,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchDashboardAdminAlunos',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retdadosdashboard?idEscola=eq.${searchEscola}&idMotorista=eq.${searchMotorista}&nomeAluno=ilike.*${searchString}*&select=*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchEscolaListaDashEscolaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? searchEscola,
    int? limit,
    int? offset,
    double? lastPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchEscolaListaDashEscola',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/retalunosescolas?idEscola=eq.${searchEscola}&nomeEscola=ilike.*${searchString}*&select=*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idAluno(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idAluno''',
      ));
  static bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].ativo''',
      ));
  static String? domSitAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitAluno''',
      ));
  static String? domTurno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domTurno''',
      ));
  static int? idEscola(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEscola''',
      ));
  static int? idEmpresa(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? whatsAppAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].whatsAppAluno''',
      ));
  static String? domTipoAluno(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoAluno''',
      ));
  static String? nomeAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].nomeAluno''',
      ));
  static String? dtAluno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].dtAluno''',
      ));
}

class SearchEscolasCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    int? codEmpresa,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchEscolas',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/escola?nomeEscola=ilike.*${searchString}*&select=*%order=nomeEscola',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SearchEscolaCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    String? codEmpresa = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchEscola',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/escola?nomeEscola=ilike.*${searchString}*&select=*&order=nomeEscola',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? domSituacao(dynamic response) => (getJsonField(
        response,
        r'''$[:].domSituacao''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? idEmpresa(dynamic response) => (getJsonField(
        response,
        r'''$[:].idEmpresa''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? long(dynamic response) => getJsonField(
        response,
        r'''$[:].long''',
        true,
      ) as List?;
  static List? lat(dynamic response) => getJsonField(
        response,
        r'''$[:].lat''',
        true,
      ) as List?;
  static List<String>? pointGeo(dynamic response) => (getJsonField(
        response,
        r'''$[:].pointGeo''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? infoEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].infoEscola''',
        true,
      ) as List?;
  static List? ufEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].ufEscola''',
        true,
      ) as List?;
  static List? cidadeEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].cidadeEscola''',
        true,
      ) as List?;
  static List? bairroEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].bairroEscola''',
        true,
      ) as List?;
  static List? compEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].compEscola''',
        true,
      ) as List?;
  static List? numEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].numEscola''',
        true,
      ) as List?;
  static List? endEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].endEscola''',
        true,
      ) as List?;
  static List? cepEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].cepEscola''',
        true,
      ) as List?;
  static List? emailEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].emailEscola''',
        true,
      ) as List?;
  static List? telEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].telEscola''',
        true,
      ) as List?;
  static List? whatsAppEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].whatsAppEscola''',
        true,
      ) as List?;
  static List? domTipoEscola(dynamic response) => getJsonField(
        response,
        r'''$[:].domTipoEscola''',
        true,
      ) as List?;
  static List<String>? nomeEscola(dynamic response) => (getJsonField(
        response,
        r'''$[:].nomeEscola''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dtEscola(dynamic response) => (getJsonField(
        response,
        r'''$[:].dtEscola''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? idEscola(dynamic response) => (getJsonField(
        response,
        r'''$[:].idEscola''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class SearchVeiculoCall {
  static Future<ApiCallResponse> call({
    String? searchString = '',
    String? codEmpresa = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchVeiculo',
      apiUrl:
          'https://zumnfejbzehanlosreno.supabase.co/rest/v1/veiculo?placa=ilike.*${searchString}*&select=*&order=placa',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
        'Authorization':
            'BearereyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bW5mZWpiemVoYW5sb3NyZW5vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzYwMDk4NywiZXhwIjoyMDU5MTc2OTg3fQ.245YZXm7ek8feRxK553qM63K6ZZ0rwXdI3eCJR0vtqY',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? idVeiculo(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].idVeiculo''',
      ));
  static String? dtVediculo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].dtVediculo''',
      ));
  static String? placa(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].placa''',
      ));
  static String? renavam(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].renavam''',
      ));
  static String? chassis(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].chassis''',
      ));
  static String? anoModelo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].anoModelo''',
      ));
  static String? corVeiculo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].corVeiculo''',
      ));
  static String? domCapacidade(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domCapacidade''',
      ));
  static String? domMarca(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domMarca''',
      ));
  static String? domModelo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].domModelo''',
      ));
  static dynamic idMotorista(dynamic response) => getJsonField(
        response,
        r'''$[:].idMotorista''',
      );
  static String? domTipoVeiculo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domTipoVeiculo''',
      ));
  static String? idEmpresa(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].idEmpresa''',
      ));
  static String? domSitVeiculo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].domSitVeiculo''',
      ));
  static String? codEmpresa(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].codEmpresa''',
      ));
}

class GeoCodeReverseCall {
  static Future<ApiCallResponse> call({
    String? lat = '',
    String? long = '',
    String? key = '670d19d17a50e887519388wvu50dca1',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GeoCodeReverse',
      apiUrl:
          'https://geocode.maps.co/reverse?lat=${lat}&lon=${long}&apikey=${key}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? placeid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.place_id''',
      ));
  static String? licence(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.licence''',
      ));
  static String? osmtype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.osm_type''',
      ));
  static int? osmid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.osm_id''',
      ));
  static String? lat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.lat''',
      ));
  static String? lon(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.lon''',
      ));
  static String? displayname(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.display_name''',
      ));
  static dynamic? address(dynamic response) => getJsonField(
        response,
        r'''$.address''',
      );
  static String? addresscity(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.city''',
      ));
  static String? addressmunicipality(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.municipality''',
      ));
  static String? addresscounty(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.county''',
      ));
  static String? addressstatedistrict(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.state_district''',
      ));
  static String? addressstate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.state''',
      ));
  static String? addressregion(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.region''',
      ));
  static String? addresspostcode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.postcode''',
      ));
  static String? addresscountry(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.country''',
      ));
  static String? addresscountrycode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.country_code''',
      ));
  static List<String>? boundingbox(dynamic response) => (getJsonField(
        response,
        r'''$.boundingbox''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? addressroad(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.road''',
      ));
  static String? addressneighbourhood(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.neighbourhood''',
      ));
  static String? addresssuburb(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.suburb''',
      ));
  static String? addresscitydistrict(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.city_district''',
      ));
}

class GeoCodeAddressCall {
  static Future<ApiCallResponse> call({
    String? address = 'Rua Agariba 123, Sao Benedito, Santa Luzia',
    String? apiKey = '682b3595d3af9859302934tch5d6338',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GeoCodeAddress',
      apiUrl: 'https://geocode.maps.co/search?q=${address}&api_key=${apiKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? placeid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].place_id''',
      ));
  static String? licence(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].licence''',
      ));
  static String? osmtype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].osm_type''',
      ));
  static int? osmid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].osm_id''',
      ));
  static List<String>? boundingbox(dynamic response) => (getJsonField(
        response,
        r'''$[:].boundingbox''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? lat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].lat''',
      ));
  static String? lon(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].lon''',
      ));
  static String? displayname(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].display_name''',
      ));
  static String? classe(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].class''',
      ));
  static String? type(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].type''',
      ));
  static double? importance(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$[:].importance''',
      ));
}

class GetAddressGoogleCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAddressGoogle',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AlertaNovoAlunoCall {
  static Future<ApiCallResponse> call({
    String? escola = '',
    String? turma = '',
    String? aluno = '',
    String? whatsApp = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'alertaNovoAluno',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/whTrescoAlertaNovoAluno',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'escola': escola,
        'turma': turma,
        'aluno': aluno,
        'whatsApp': whatsApp,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RetListagemAlunosMotEscCall {
  static Future<ApiCallResponse> call({
    String? idMotorista = '',
    String? idEscola = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'retListagemAlunosMotEsc',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/b2999d7f-9a4c-4fdc-b115-95582a8420a2',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'idMotorista': idMotorista,
        'idEscola': idEscola,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RetFaturamentoSinteticoMotCall {
  static Future<ApiCallResponse> call({
    String? idMotorista = '',
    String? idEscola = '',
    String? mesbase = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'retFaturamentoSinteticoMot',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/retFaturamentoSinteticoMot',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'idMotorista': idMotorista,
        'idEscola': idEscola,
        'mesbase': mesbase,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RetContabilPorMotoristaCall {
  static Future<ApiCallResponse> call({
    String? idMotorista = '',
    String? idEscola = '',
    String? mesbase = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'retContabilPorMotorista',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/retContabilPorMotorista',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'idMotorista': idMotorista,
        'idEscola': idEscola,
        'mesbase': mesbase,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RetFechamentoGeralExcelCall {
  static Future<ApiCallResponse> call({
    String? idMotorista = '',
    String? idEscola = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'retFechamentoGeralExcel',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/c658af97-6e32-4de0-a528-d7317e7858aa',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'idMotorista': idMotorista,
        'idEscola': idEscola,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RetFechamentoGeralCall {
  static Future<ApiCallResponse> call({
    String? idMotorista = '',
    String? idEscola = '',
    String? mesbase = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'retFechamentoGeral',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/geraRelFechamentoGeral',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'idMotorista': idMotorista,
        'idEscola': idEscola,
        'mesbase': mesbase,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WhgravarfechamentoCall {
  static Future<ApiCallResponse> call({
    String? tipoFechamento = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WHGRAVARFECHAMENTO',
      apiUrl: 'https://webhook.n8ncp.vigicar.com.br/webhook/finfechamento',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'tipoFechamento': tipoFechamento,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EnviarComunicadoZapCall {
  static Future<ApiCallResponse> call({
    String? mensagem = '',
    String? idMotorista = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'EnviarComunicadoZap',
      apiUrl:
          'https://webhook.n8ncp.vigicar.com.br/webhook/enviarcomunicadozap',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'mensagem': mensagem,
        'idMotorista': idMotorista,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RefreshViewsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'refreshViews',
      apiUrl: 'https://webhook.n8ncp.vigicar.com.br/webhook/refesheviews',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WhGeraATFCall {
  static Future<ApiCallResponse> call({
    int? idAtf,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'whGeraATF',
      apiUrl: 'https://webhook.n8ncp.vigicar.com.br/webhook/atf_grava_imprime',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'id_atf': idAtf,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

// ============================================================
// ViVan API Calls
// Base URL: https://app.coopertransmig.com.br/api/vivan
// ============================================================

const String _vivanBaseUrl = 'https://app.coopertransmig.com.br/api/vivan';

// --- Dashboard ---

class VivanDashboardResumoCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanDashboardResumo',
      apiUrl: '$_vivanBaseUrl/dashboard/resumo',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'motorista_id': motoristaId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? totalPassageiros(dynamic response) => castToType<int>(getJsonField(response, r'''$.total_passageiros'''));
  static int? totalAtivos(dynamic response) => castToType<int>(getJsonField(response, r'''$.total_ativos'''));
  static int? totalContratos(dynamic response) => castToType<int>(getJsonField(response, r'''$.total_contratos'''));
  static double? receitaMensal(dynamic response) => castToType<double>(getJsonField(response, r'''$.receita_mensal'''));
  static double? despesaMensal(dynamic response) => castToType<double>(getJsonField(response, r'''$.despesa_mensal'''));
  static double? saldoMensal(dynamic response) => castToType<double>(getJsonField(response, r'''$.saldo_mensal'''));
  static int? mensalidadesPendentes(dynamic response) => castToType<int>(getJsonField(response, r'''$.mensalidades_pendentes'''));
  static int? presencasHoje(dynamic response) => castToType<int>(getJsonField(response, r'''$.presencas_hoje'''));
}

class VivanDashboardCapacidadeCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanDashboardCapacidade',
      apiUrl: '$_vivanBaseUrl/dashboard/capacidade',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'motorista_id': motoristaId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? escolas(dynamic response) => getJsonField(response, r'''$.escolas''', true) as List<dynamic>?;
  static int? capacidadeTotal(dynamic response) => castToType<int>(getJsonField(response, r'''$.capacidade_total'''));
  static int? ocupacaoTotal(dynamic response) => castToType<int>(getJsonField(response, r'''$.ocupacao_total'''));
}

// --- Passageiros ---

class VivanPassageirosListCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? busca,
    String? status,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPassageirosList',
      apiUrl: '$_vivanBaseUrl/passageiros',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'motorista_id': motoristaId,
        'busca': busca,
        'status': status,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? passageiros(dynamic response) => getJsonField(response, r'''$.passageiros''', true) as List<dynamic>?;
  static int? total(dynamic response) => castToType<int>(getJsonField(response, r'''$.total'''));
}

class VivanPassageiroGetCall {
  static Future<ApiCallResponse> call({
    int? passageiroId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPassageiroGet',
      apiUrl: '$_vivanBaseUrl/passageiros/$passageiroId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(response, r'''$.id'''));
  static String? nome(dynamic response) => castToType<String>(getJsonField(response, r'''$.nome'''));
  static String? cpf(dynamic response) => castToType<String>(getJsonField(response, r'''$.cpf'''));
  static String? escola(dynamic response) => castToType<String>(getJsonField(response, r'''$.escola'''));
  static String? endereco(dynamic response) => castToType<String>(getJsonField(response, r'''$.endereco'''));
  static String? foto(dynamic response) => castToType<String>(getJsonField(response, r'''$.foto'''));
  static String? status(dynamic response) => castToType<String>(getJsonField(response, r'''$.status'''));
  static List<dynamic>? responsaveis(dynamic response) => getJsonField(response, r'''$.responsaveis''', true) as List<dynamic>?;
}

class VivanPassageiroCreateCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? nome,
    String? cpf,
    int? escolaId,
    String? endereco,
    String? foto,
  }) async {
    final ffApiRequestBody = '''
{
  "motorista_id": $motoristaId,
  "nome": "$nome",
  "cpf": "$cpf",
  "escola_id": $escolaId,
  "endereco": "$endereco",
  "foto": "$foto"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPassageiroCreate',
      apiUrl: '$_vivanBaseUrl/passageiros',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(response, r'''$.id'''));
}

class VivanPassageiroUpdateCall {
  static Future<ApiCallResponse> call({
    int? passageiroId,
    String? nome,
    String? cpf,
    int? escolaId,
    String? endereco,
    String? foto,
  }) async {
    final ffApiRequestBody = '''
{
  "nome": "$nome",
  "cpf": "$cpf",
  "escola_id": $escolaId,
  "endereco": "$endereco",
  "foto": "$foto"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPassageiroUpdate',
      apiUrl: '$_vivanBaseUrl/passageiros/$passageiroId',
      callType: ApiCallType.PUT,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanPassageiroDeleteCall {
  static Future<ApiCallResponse> call({
    int? passageiroId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPassageiroDelete',
      apiUrl: '$_vivanBaseUrl/passageiros/$passageiroId',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

// --- Responsáveis ---

class VivanResponsaveisListCall {
  static Future<ApiCallResponse> call({
    int? passageiroId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanResponsaveisList',
      apiUrl: '$_vivanBaseUrl/passageiros/$passageiroId/responsaveis',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? responsaveis(dynamic response) => getJsonField(response, r'''$.responsaveis''', true) as List<dynamic>?;
}

class VivanResponsavelCreateCall {
  static Future<ApiCallResponse> call({
    int? passageiroId,
    String? nome,
    String? cpf,
    String? telefone,
    String? parentesco,
  }) async {
    final ffApiRequestBody = '''
{
  "nome": "$nome",
  "cpf": "$cpf",
  "telefone": "$telefone",
  "parentesco": "$parentesco"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanResponsavelCreate',
      apiUrl: '$_vivanBaseUrl/passageiros/$passageiroId/responsaveis',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(response, r'''$.id'''));
}

class VivanResponsavelUpdateCall {
  static Future<ApiCallResponse> call({
    int? responsavelId,
    String? nome,
    String? cpf,
    String? telefone,
    String? parentesco,
  }) async {
    final ffApiRequestBody = '''
{
  "nome": "$nome",
  "cpf": "$cpf",
  "telefone": "$telefone",
  "parentesco": "$parentesco"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanResponsavelUpdate',
      apiUrl: '$_vivanBaseUrl/responsaveis/$responsavelId',
      callType: ApiCallType.PUT,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanResponsavelDeleteCall {
  static Future<ApiCallResponse> call({
    int? responsavelId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanResponsavelDelete',
      apiUrl: '$_vivanBaseUrl/responsaveis/$responsavelId',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

// --- Contratos ---

class VivanContratosListCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? status,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratosList',
      apiUrl: '$_vivanBaseUrl/contratos',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'motorista_id': motoristaId,
        'status': status,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? contratos(dynamic response) => getJsonField(response, r'''$.contratos''', true) as List<dynamic>?;
  static int? total(dynamic response) => castToType<int>(getJsonField(response, r'''$.total'''));
}

class VivanContratoGetCall {
  static Future<ApiCallResponse> call({
    int? contratoId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoGet',
      apiUrl: '$_vivanBaseUrl/contratos/$contratoId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(response, r'''$.id'''));
  static String? status(dynamic response) => castToType<String>(getJsonField(response, r'''$.status'''));
  static double? valorMensal(dynamic response) => castToType<double>(getJsonField(response, r'''$.valor_mensal'''));
  static String? passageiroNome(dynamic response) => castToType<String>(getJsonField(response, r'''$.passageiro_nome'''));
  static int? passageiroId(dynamic response) => castToType<int>(getJsonField(response, r'''$.passageiro_id'''));
  static String? dataInicio(dynamic response) => castToType<String>(getJsonField(response, r'''$.data_inicio'''));
  static String? dataFim(dynamic response) => castToType<String>(getJsonField(response, r'''$.data_fim'''));
  static String? condicoes(dynamic response) => castToType<String>(getJsonField(response, r'''$.condicoes'''));
}

class VivanContratoCreateCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    int? passageiroId,
    double? valorMensal,
    String? dataInicio,
    String? dataFim,
    String? condicoes,
  }) async {
    final ffApiRequestBody = '''
{
  "motorista_id": $motoristaId,
  "passageiro_id": $passageiroId,
  "valor_mensal": $valorMensal,
  "data_inicio": "$dataInicio",
  "data_fim": "$dataFim",
  "condicoes": "$condicoes"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoCreate',
      apiUrl: '$_vivanBaseUrl/contratos',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(response, r'''$.id'''));
}

class VivanContratoUpdateCall {
  static Future<ApiCallResponse> call({
    int? contratoId,
    double? valorMensal,
    String? dataInicio,
    String? dataFim,
    String? condicoes,
  }) async {
    final ffApiRequestBody = '''
{
  "valor_mensal": $valorMensal,
  "data_inicio": "$dataInicio",
  "data_fim": "$dataFim",
  "condicoes": "$condicoes"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoUpdate',
      apiUrl: '$_vivanBaseUrl/contratos/$contratoId',
      callType: ApiCallType.PUT,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanContratoEnviarAssinaturaCall {
  static Future<ApiCallResponse> call({
    int? contratoId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoEnviarAssinatura',
      apiUrl: '$_vivanBaseUrl/contratos/$contratoId/enviar-assinatura',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanContratoAtivarCall {
  static Future<ApiCallResponse> call({
    int? contratoId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoAtivar',
      apiUrl: '$_vivanBaseUrl/contratos/$contratoId/ativar',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanContratoSuspenderCall {
  static Future<ApiCallResponse> call({
    int? contratoId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoSuspender',
      apiUrl: '$_vivanBaseUrl/contratos/$contratoId/suspender',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanContratoCancelarCall {
  static Future<ApiCallResponse> call({
    int? contratoId,
    String? motivo,
  }) async {
    final ffApiRequestBody = '''
{
  "motivo": "$motivo"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoCancelar',
      apiUrl: '$_vivanBaseUrl/contratos/$contratoId/cancelar',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanContratoHistoricoCall {
  static Future<ApiCallResponse> call({
    int? contratoId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanContratoHistorico',
      apiUrl: '$_vivanBaseUrl/contratos/$contratoId/historico',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? historico(dynamic response) => getJsonField(response, r'''$.historico''', true) as List<dynamic>?;
}

// --- Mensalidades ---

class VivanMensalidadesListCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? mes,
    String? status,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanMensalidadesList',
      apiUrl: '$_vivanBaseUrl/mensalidades',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'motorista_id': motoristaId,
        'mes': mes,
        'status': status,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? mensalidades(dynamic response) => getJsonField(response, r'''$.mensalidades''', true) as List<dynamic>?;
  static int? total(dynamic response) => castToType<int>(getJsonField(response, r'''$.total'''));
  static double? totalValor(dynamic response) => castToType<double>(getJsonField(response, r'''$.total_valor'''));
}

class VivanMensalidadeGetCall {
  static Future<ApiCallResponse> call({
    int? mensalidadeId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanMensalidadeGet',
      apiUrl: '$_vivanBaseUrl/mensalidades/$mensalidadeId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(response, r'''$.id'''));
  static String? status(dynamic response) => castToType<String>(getJsonField(response, r'''$.status'''));
  static double? valor(dynamic response) => castToType<double>(getJsonField(response, r'''$.valor'''));
  static String? vencimento(dynamic response) => castToType<String>(getJsonField(response, r'''$.vencimento'''));
  static String? passageiroNome(dynamic response) => castToType<String>(getJsonField(response, r'''$.passageiro_nome'''));
  static String? pixUrl(dynamic response) => castToType<String>(getJsonField(response, r'''$.pix_url'''));
  static String? pixQrCode(dynamic response) => castToType<String>(getJsonField(response, r'''$.pix_qr_code'''));
}

class VivanMensalidadePagamentoManualCall {
  static Future<ApiCallResponse> call({
    int? mensalidadeId,
    String? formaPagamento,
    String? observacao,
  }) async {
    final ffApiRequestBody = '''
{
  "forma_pagamento": "$formaPagamento",
  "observacao": "$observacao"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanMensalidadePagamentoManual',
      apiUrl: '$_vivanBaseUrl/mensalidades/$mensalidadeId/pagamento-manual',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanMensalidadeAbonarCall {
  static Future<ApiCallResponse> call({
    int? mensalidadeId,
    String? motivo,
  }) async {
    final ffApiRequestBody = '''
{
  "motivo": "$motivo"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanMensalidadeAbonar',
      apiUrl: '$_vivanBaseUrl/mensalidades/$mensalidadeId/abonar',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanMensalidadeCancelarAbonoCall {
  static Future<ApiCallResponse> call({
    int? mensalidadeId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanMensalidadeCancelarAbono',
      apiUrl: '$_vivanBaseUrl/mensalidades/$mensalidadeId/cancelar-abono',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

// --- Despesas ---

class VivanDespesasListCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? mes,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanDespesasList',
      apiUrl: '$_vivanBaseUrl/despesas',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'motorista_id': motoristaId,
        'mes': mes,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? despesas(dynamic response) => getJsonField(response, r'''$.despesas''', true) as List<dynamic>?;
  static double? totalValor(dynamic response) => castToType<double>(getJsonField(response, r'''$.total_valor'''));
}

class VivanDespesaCreateCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? categoria,
    double? valor,
    String? descricao,
    int? veiculoId,
    String? comprovante,
    String? data,
  }) async {
    final ffApiRequestBody = '''
{
  "motorista_id": $motoristaId,
  "categoria": "$categoria",
  "valor": $valor,
  "descricao": "$descricao",
  "veiculo_id": $veiculoId,
  "comprovante": "$comprovante",
  "data": "$data"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanDespesaCreate',
      apiUrl: '$_vivanBaseUrl/despesas',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(response, r'''$.id'''));
}

class VivanDespesaUpdateCall {
  static Future<ApiCallResponse> call({
    int? despesaId,
    String? categoria,
    double? valor,
    String? descricao,
    int? veiculoId,
    String? comprovante,
    String? data,
  }) async {
    final ffApiRequestBody = '''
{
  "categoria": "$categoria",
  "valor": $valor,
  "descricao": "$descricao",
  "veiculo_id": $veiculoId,
  "comprovante": "$comprovante",
  "data": "$data"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanDespesaUpdate',
      apiUrl: '$_vivanBaseUrl/despesas/$despesaId',
      callType: ApiCallType.PUT,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanDespesaDeleteCall {
  static Future<ApiCallResponse> call({
    int? despesaId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanDespesaDelete',
      apiUrl: '$_vivanBaseUrl/despesas/$despesaId',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

// --- Presença ---

class VivanPresencasListCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? data,
    String? dataInicio,
    String? dataFim,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPresencasList',
      apiUrl: '$_vivanBaseUrl/presencas',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'motorista_id': motoristaId,
        'data': data,
        'data_inicio': dataInicio,
        'data_fim': dataFim,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? presencas(dynamic response) => getJsonField(response, r'''$.presencas''', true) as List<dynamic>?;
  static int? totalPresentes(dynamic response) => castToType<int>(getJsonField(response, r'''$.total_presentes'''));
  static int? totalFaltas(dynamic response) => castToType<int>(getJsonField(response, r'''$.total_faltas'''));
}

class VivanPresencaCreateCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    int? passageiroId,
    String? data,
    String? status,
    double? latitude,
    double? longitude,
  }) async {
    final ffApiRequestBody = '''
{
  "motorista_id": $motoristaId,
  "passageiro_id": $passageiroId,
  "data": "$data",
  "status": "$status",
  "latitude": $latitude,
  "longitude": $longitude
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPresencaCreate',
      apiUrl: '$_vivanBaseUrl/presencas',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VivanPresencaLoteCall {
  static Future<ApiCallResponse> call({
    int? motoristaId,
    String? data,
    double? latitude,
    double? longitude,
    String? presencasJson,
  }) async {
    final ffApiRequestBody = '''
{
  "motorista_id": $motoristaId,
  "data": "$data",
  "latitude": $latitude,
  "longitude": $longitude,
  "presencas": $presencasJson
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VivanPresencaLote',
      apiUrl: '$_vivanBaseUrl/presencas/lote',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? registrados(dynamic response) => castToType<int>(getJsonField(response, r'''$.registrados'''));
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
