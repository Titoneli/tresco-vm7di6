import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'vivan_config.dart';

export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

/// Cliente HTTP centralizado para o módulo ViVan.
/// Usa http package diretamente para poder ler Set-Cookie do login.
class VivanApiClient {
  final String _baseUrl;
  final String _vivanUrl;

  VivanApiClient({String? baseUrl})
      : _baseUrl = baseUrl ?? VivanConfig.baseUrl,
        _vivanUrl = (baseUrl ?? VivanConfig.baseUrl) + VivanConfig.vivanPrefix;

  static String? _accessToken;
  static bool _isLoggingIn = false;

  static void setAccessToken(String? token) {
    _accessToken = token;
  }

  static bool get isAuthenticated => _accessToken != null;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_accessToken != null) 'Cookie': 'access_token=$_accessToken',
      };

  /// Auto-login com credenciais fixas do motorista ViVan.
  Future<void> _ensureToken() async {
    if (_accessToken != null) return;
    if (_isLoggingIn) return;
    _isLoggingIn = true;
    try {
      await login(VivanConfig.usuario, VivanConfig.senha);
    } catch (e) {
      debugPrint('VivanApiClient: auto-login failed: $e');
    } finally {
      _isLoggingIn = false;
    }
  }

  /// Login — faz POST direto com http para poder ler Set-Cookie.
  Future<bool> login(String usuario, String senha) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'usuario': usuario, 'senha': senha}),
          )
          .timeout(const Duration(seconds: VivanConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        // Token vem via Set-Cookie: access_token=<jwt>
        final setCookie = response.headers['set-cookie'] ?? '';
        final match = RegExp(r'access_token=([^;]+)').firstMatch(setCookie);
        final token = match?.group(1);
        if (token != null) {
          setAccessToken(token);
          debugPrint('VivanApiClient: login OK, token extraído do cookie');
          return true;
        }
        // Fallback: tenta extrair do body JSON (caso API mude)
        final data = json.decode(response.body);
        final bodyToken = data is Map ? data['accessToken']?.toString() : null;
        if (bodyToken != null) {
          setAccessToken(bodyToken);
          return true;
        }
        debugPrint('VivanApiClient: login 200 mas sem token na resposta');
      } else {
        debugPrint('VivanApiClient: login falhou [${response.statusCode}]: ${response.body}');
      }
    } catch (e) {
      debugPrint('VivanApiClient: login exception: $e');
    }
    return false;
  }

  /// Executa request com retry em 401.
  Future<http.Response> _callWithRetry(Future<http.Response> Function() call) async {
    await _ensureToken();
    var response = await call();
    if (response.statusCode == 401 && !_isLoggingIn) {
      _accessToken = null;
      await _ensureToken();
      response = await call();
    }
    return response;
  }

  dynamic _parseBody(http.Response response, String label) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    }
    throw Exception('$label failed [${response.statusCode}]: ${response.body}');
  }

  /// GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse('$_vivanUrl$endpoint').replace(
      queryParameters: queryParams?.map((k, v) => MapEntry(k, v.toString())),
    );
    final response = await _callWithRetry(() => http
        .get(uri, headers: _headers)
        .timeout(const Duration(seconds: VivanConfig.timeoutSeconds)));
    return _parseBody(response, 'API GET $endpoint');
  }

  /// POST request
  Future<dynamic> post(String endpoint, {dynamic body}) async {
    final response = await _callWithRetry(() => http
        .post(
          Uri.parse('$_vivanUrl$endpoint'),
          headers: _headers,
          body: body != null ? json.encode(body) : null,
        )
        .timeout(const Duration(seconds: VivanConfig.timeoutSeconds)));
    return _parseBody(response, 'API POST $endpoint');
  }

  /// PUT request
  Future<dynamic> put(String endpoint, {dynamic body}) async {
    final response = await _callWithRetry(() => http
        .put(
          Uri.parse('$_vivanUrl$endpoint'),
          headers: _headers,
          body: body != null ? json.encode(body) : null,
        )
        .timeout(const Duration(seconds: VivanConfig.timeoutSeconds)));
    return _parseBody(response, 'API PUT $endpoint');
  }

  /// PATCH request
  Future<dynamic> patch(String endpoint, {dynamic body}) async {
    final response = await _callWithRetry(() => http
        .patch(
          Uri.parse('$_vivanUrl$endpoint'),
          headers: _headers,
          body: body != null ? json.encode(body) : null,
        )
        .timeout(const Duration(seconds: VivanConfig.timeoutSeconds)));
    return _parseBody(response, 'API PATCH $endpoint');
  }

  /// DELETE request
  Future<dynamic> delete(String endpoint) async {
    final response = await _callWithRetry(() => http
        .delete(Uri.parse('$_vivanUrl$endpoint'), headers: _headers)
        .timeout(const Duration(seconds: VivanConfig.timeoutSeconds)));
    return _parseBody(response, 'API DELETE $endpoint');
  }
}
