import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:caterbid/core/utils/logger.dart';
import 'package:http_parser/http_parser.dart'; // Added for MediaType

import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:path/path.dart' as path;

class ApiService {
  final Map<String, String> _baseHeaders = {
    'Content-Type': 'application/json',
  };

  Future<Map<String, String>> _getHeaders() async {
    final token = await SecureStorage.getToken();
    if (token != null) {
      return {
        ..._baseHeaders,
        'Authorization': 'Bearer $token',
      };
    }
    return _baseHeaders;
  }

  // -------------------------------------------------
  //  Standard JSON POST
  // -------------------------------------------------
  Future<dynamic> post(
    String url,
    Map<String, dynamic> body, {
    bool includeAuth = true,
  }) async {
    final headers = includeAuth ? await _getHeaders() : _baseHeaders;
    _logRequest("POST", url, body);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  // -------------------------------------------------
  //  GET
  // -------------------------------------------------
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

  // -------------------------------------------------
  //  PUT
  // -------------------------------------------------
  Future<dynamic> put(
    String url,
    Map<String, dynamic> body, {
    bool includeAuth = true,
  }) async {
    final headers = includeAuth ? await _getHeaders() : _baseHeaders;
    _logRequest("PUT", url, body);
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  // -------------------------------------------------
  // Multipart POST (Form-Data)
  // -------------------------------------------------
  Future<dynamic> postMultipart(
    String url, {
    required Map<String, String> fields,
    File? file,
    String? fileFieldName = "attachment",
    bool includeAuth = true,
  }) async {

  print('📤 PUT endpoint called: $url');

    final headers = await _getHeaders();
    headers.remove('Content-Type'); // Let http handle multipart content type

    _logRequest("POST (Multipart)", url, fields);

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(fields)
      ..headers.addAll(headers);

    if (file != null) {
      final extension = path.extension(file.path).toLowerCase();
      String mimeType;
      switch (extension) {
        case '.jpg':
        case '.jpeg':
          mimeType = 'image/jpeg';
          break;
        case '.png':
          mimeType = 'image/png';
          break;
        case '.pdf':
          mimeType = 'application/pdf';
          break;
        default:
          mimeType = 'application/octet-stream';
          AppLogger.log('Warning: Unknown file extension $extension, using fallback MIME type');
      }

      AppLogger.log(
        'Uploading file: ${file.path}, '
        'Extension: $extension, '
        'MIME Type: $mimeType, '
        'Size: ${await file.length()} bytes',
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          fileFieldName!,
          file.path,
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      AppLogger.log('Response Status: ${response.statusCode}, Body: ${response.body}');
      return _handleResponse(response);
    } catch (error) {
      AppLogger.log('Error uploading file: $error');
      throw ApiErrorHandler.handle(error);
    }
  }

    // -------------------------------------------------
  // Multipart PUT (Form-Data)
  // -------------------------------------------------

  Future<dynamic> putMultipart(
  String url, {
  required Map<String, String> fields,
  File? file,
  String? fileFieldName = "attachment",
  bool includeAuth = true,
}) async {

  
  final headers = await _getHeaders();
  headers.remove('Content-Type'); // Let http handle multipart

  _logRequest("PUT (Multipart)", url, fields);

  final request = http.MultipartRequest('PUT', Uri.parse(url))
    ..fields.addAll(fields)
    ..headers.addAll(headers);

  if (file != null) {
    final extension = path.extension(file.path).toLowerCase();
    String mimeType;
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        mimeType = 'image/jpeg';
        break;
      case '.png':
        mimeType = 'image/png';
        break;
      case '.pdf':
        mimeType = 'application/pdf';
        break;
      default:
        mimeType = 'application/octet-stream';
        AppLogger.log('Warning: Unknown file extension $extension, using fallback MIME type');
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        fileFieldName!,
        file.path,
        contentType: MediaType.parse(mimeType),
      ),
    );
  }

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    AppLogger.log('Response Status: ${response.statusCode}, Body: ${response.body}');
    return _handleResponse(response);
  } catch (error) {
    AppLogger.log('Error uploading file: $error');
    throw ApiErrorHandler.handle(error);
  }
}


  // -------------------------------------------------
  //  Response Handler
  // -------------------------------------------------
  dynamic _handleResponse(http.Response response) {
    _logResponse(response);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic> || decoded is List) return decoded;
      throw ApiException(message: "Invalid JSON structure");
    } else {
      final body =
          response.body.isNotEmpty ? jsonDecode(response.body) : {};
      throw ApiErrorHandler.fromResponse(response.statusCode, body);
    }
  }

  // -------------------------------------------------
  //  Logging Helpers
  // -------------------------------------------------
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
