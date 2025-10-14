import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiLogger {
  static void logRequest(String method, String url, dynamic body) {
    if (kDebugMode) {
      debugPrint("➡️  [$method] $url");
      if (body != null) debugPrint("📦 Request Body: ${jsonEncode(body)}");
    }
  }

  static void logResponse(http.Response response) {
    if (kDebugMode) {
      debugPrint("⬅️  [${response.statusCode}] ${response.request?.url}");
      debugPrint("📩 Response: ${response.body}");
    }
  }
}
