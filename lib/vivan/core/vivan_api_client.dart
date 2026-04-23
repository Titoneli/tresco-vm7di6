import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'vivan_config.dart';

export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

/// Cliente HTTP centralizado para o módulo ViVan.
///
/// Gerencia autenticação JWT (cookie-based) e headers.
/// Quando virar app separado, basta trocar a implementação do token store.
class VivanApiClient {
  VivanApiClient._();

  // Token storage — hoje usa FFAppState, futuro pode usar secure_storage
  static String? _accessToken;

  /// Define o token de acesso (obtido após login)
  static void setAccessToken(String? token) {
    _accessToken = token;
  }

  /// Headers padrão com auth
  static Map<String, String> get _authHeaders => {
        'Content-Type': 'application/json',
        if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
      };

  /// GET request
  static Future<ApiCallResponse> get(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ViVan_GET_$endpoint',
      apiUrl: '${VivanConfig.vivanUrl}$endpoint',
      callType: ApiCallType.GET,
      headers: _authHeaders,
      params: params ?? {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  /// POST request
  static Future<ApiCallResponse> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ViVan_POST_$endpoint',
      apiUrl: '${VivanConfig.vivanUrl}$endpoint',
      callType: ApiCallType.POST,
      headers: _authHeaders,
      params: {},
      body: body != null ? json.encode(body) : null,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  /// PUT request
  static Future<ApiCallResponse> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ViVan_PUT_$endpoint',
      apiUrl: '${VivanConfig.vivanUrl}$endpoint',
      callType: ApiCallType.PUT,
      headers: _authHeaders,
      params: {},
      body: body != null ? json.encode(body) : null,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  /// DELETE request
  static Future<ApiCallResponse> delete(String endpoint) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ViVan_DELETE_$endpoint',
      apiUrl: '${VivanConfig.vivanUrl}$endpoint',
      callType: ApiCallType.DELETE,
      headers: _authHeaders,
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  /// Login — obtém JWT e armazena
  static Future<ApiCallResponse> login(
      String usuario, String senha) async {
    final response = await ApiManager.instance.makeApiCall(
      callName: 'ViVan_Auth_Login',
      apiUrl: VivanConfig.authLoginUrl,
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: json.encode({'usuario': usuario, 'senha': senha}),
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
    // Extrair token do response
    if (response.succeeded) {
      final token = getJsonField(response.jsonBody, r'''$.accessToken''')
          ?.toString();
      if (token != null) {
        setAccessToken(token);
      }
    }
    return response;
  }
}
