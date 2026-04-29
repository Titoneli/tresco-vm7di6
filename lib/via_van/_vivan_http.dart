import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const _kBase = 'https://app.coopertransmig.com.br/api';
const _kVivan = '$_kBase/vivan';
const _kUsuario = 'gustavo';
const _kSenha = 'gustavo';

/// HTTP helper auto-autenticado para o módulo ViVan.
/// Gerencia cookie de sessão (Set-Cookie: access_token) de forma transparente.
class VivanHttp {
  VivanHttp._();

  static String? _cookie;
  static bool _loggingIn = false;

  static Future<void> _login() async {
    if (_loggingIn) return;
    _loggingIn = true;
    try {
      final res = await http
          .post(
            Uri.parse('$_kBase/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'usuario': _kUsuario, 'senha': _kSenha}),
          )
          .timeout(const Duration(seconds: 10));
      final raw = res.headers['set-cookie'] ?? '';
      final m = RegExp(r'access_token=([^;]+)').firstMatch(raw);
      _cookie = m?.group(1);
      debugPrint('VivanHttp: login ${_cookie != null ? 'OK' : 'sem token'}');
    } catch (e) {
      debugPrint('VivanHttp: login error: $e');
    } finally {
      _loggingIn = false;
    }
  }

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_cookie != null) 'Cookie': 'access_token=$_cookie',
      };

  static Future<dynamic> _exec(
      Future<http.Response> Function() call, String label) async {
    if (_cookie == null) await _login();
    var res = await call();
    if (res.statusCode == 401) {
      _cookie = null;
      await _login();
      res = await call();
    }
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return res.body.isEmpty ? null : json.decode(res.body);
    }
    throw Exception('$label [${res.statusCode}]: ${res.body}');
  }

  static Future<dynamic> get(String path,
      {Map<String, String>? params}) async {
    final uri =
        Uri.parse('$_kVivan$path').replace(queryParameters: params ?? {});
    return _exec(
      () => http.get(uri, headers: _headers).timeout(const Duration(seconds: 15)),
      'GET $path',
    );
  }

  static Future<dynamic> post(String path, Map<String, dynamic> body) =>
      _exec(
        () => http
            .post(Uri.parse('$_kVivan$path'),
                headers: _headers, body: json.encode(body))
            .timeout(const Duration(seconds: 15)),
        'POST $path',
      );

  static Future<dynamic> put(String path, Map<String, dynamic> body) =>
      _exec(
        () => http
            .put(Uri.parse('$_kVivan$path'),
                headers: _headers, body: json.encode(body))
            .timeout(const Duration(seconds: 15)),
        'PUT $path',
      );

  static Future<dynamic> delete(String path) =>
      _exec(
        () => http
            .delete(Uri.parse('$_kVivan$path'), headers: _headers)
            .timeout(const Duration(seconds: 15)),
        'DELETE $path',
      );
}
