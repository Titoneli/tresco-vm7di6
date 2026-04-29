import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import 'vivan_config.dart';

export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

/// Cliente HTTP centralizado para o módulo ViVan.
class VivanApiClient {
  final String _baseUrl;
  final String _vivanUrl;

  VivanApiClient({String? baseUrl})
      : _baseUrl = baseUrl ?? VivanConfig.baseUrl,
        _vivanUrl = (baseUrl ?? VivanConfig.baseUrl) + VivanConfig.vivanPrefix;

  static String? _accessToken;

  /// Define o token de acesso (obtido após login)
  static void setAccessToken(String? token) {
    _accessToken = token;
  }

  static bool get isAuthenticated => _accessToken != null;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
      };

  /// Login — obtém JWT e armazena. Retorna true se sucesso.
  Future<bool> login(String email, String senha) async {
    final response = await ApiManager.instance.makeApiCall(
      callName: 'ViVan_Auth_Login',
      apiUrl: '$_baseUrl/auth/login',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: json.encode({'usuario': email, 'senha': senha}),
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
    if (response.succeeded) {
      final data = response.jsonBody;
      final token = data is Map ? data['accessToken']?.toString() : null;
      if (token != null) setAccessToken(token);
    }
    return response.succeeded;
  }

  /// GET request — returns parsed JSON body (Map or List)
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await ApiManager.instance.makeApiCall(
      callName: 'ViVan_GET_$endpoint',
      apiUrl: '$_vivanUrl$endpoint',
      callType: ApiCallType.GET,
      headers: _headers,
      params: queryParams ?? {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
    if (!response.succeeded) {
      throw Exception(
          'API GET $endpoint failed [${response.statusCode}]: ${response.bodyText}');
    }
    return response.jsonBody;
  }

  /// POST request — returns parsed JSON body
  Future<dynamic> post(
    String endpoint, {
    dynamic body,
  }) async {
    final encodedBody = body != null ? json.encode(body) : null;
    final response = await ApiManager.instance.makeApiCall(
      callName: 'ViVan_POST_$endpoint',
      apiUrl: '$_vivanUrl$endpoint',
      callType: ApiCallType.POST,
      headers: _headers,
      params: {},
      body: encodedBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
    if (!response.succeeded) {
      throw Exception(
          'API POST $endpoint failed [${response.statusCode}]: ${response.bodyText}');
    }
    return response.jsonBody;
  }

  /// PUT request — returns parsed JSON body
  Future<dynamic> put(
    String endpoint, {
    dynamic body,
  }) async {
    final encodedBody = body != null ? json.encode(body) : null;
    final response = await ApiManager.instance.makeApiCall(
      callName: 'ViVan_PUT_$endpoint',
      apiUrl: '$_vivanUrl$endpoint',
      callType: ApiCallType.PUT,
      headers: _headers,
      params: {},
      body: encodedBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
    if (!response.succeeded) {
      throw Exception(
          'API PUT $endpoint failed [${response.statusCode}]: ${response.bodyText}');
    }
    return response.jsonBody;
  }

  /// DELETE request — returns parsed JSON body (may be null)
  Future<dynamic> delete(String endpoint) async {
    final response = await ApiManager.instance.makeApiCall(
      callName: 'ViVan_DELETE_$endpoint',
      apiUrl: '$_vivanUrl$endpoint',
      callType: ApiCallType.DELETE,
      headers: _headers,
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
    if (!response.succeeded) {
      throw Exception(
          'API DELETE $endpoint failed [${response.statusCode}]: ${response.bodyText}');
    }
    return response.jsonBody;
  }
}
