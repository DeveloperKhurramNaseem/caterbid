import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:caterbid/core/utils/logger.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/core/network/api_exception.dart';

class ApiService {
  final Map<String, String> _baseHeaders = {'Content-Type': 'application/json'};

  Future<Map<String, String>> _getHeaders() async {
    final token = await SecureStorage.getToken();
    if (token != null) {
      return {..._baseHeaders, 'Authorization': 'Bearer $token'};
    }
    return _baseHeaders;
  }

  // POST
  Future<dynamic> post(
    String url,
    Map<String, dynamic> body, {
    bool includeAuth = true,
  }) async {
    final headers = includeAuth ? await _getHeaders() : _baseHeaders;
    _logRequest("POST", url, body);
    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
      return _handleResponse(response);
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  // GET
  Future<dynamic> get(String url, {bool includeAuth = true}) async {
    final headers = includeAuth ? await _getHeaders() : _baseHeaders;
    _logRequest("GET", url);
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  // Response handler
  dynamic _handleResponse(http.Response response) {
    _logResponse(response);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic> || decoded is List) return decoded;
      throw ApiException(message: "Invalid JSON structure");
    } else {
      final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      throw ApiErrorHandler.fromResponse(response.statusCode, body);
    }
  }

  // Logging
  void _logRequest(String method, String url, [Map<String, dynamic>? body]) {
    assert(() {
      AppLogger.log("📤 [$method] $url");
      if (body != null) AppLogger.log("🧾 Body: $body");
      return true;
    }());
  }

  void _logResponse(http.Response response) {
    assert(() {
      AppLogger.log("📥 [${response.statusCode}] ${response.request?.url}");
      AppLogger.log("Response: ${response.body}");
      return true;
    }());
  }
}
