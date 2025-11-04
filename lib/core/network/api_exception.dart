import 'dart:io';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final Map<String, dynamic>? details;

  ApiException({this.statusCode, required this.message, this.details});

  @override
  String toString() => message; // Only show the message for user
}

class ApiErrorHandler {

   static String errorMessage(String error) {
    switch (error.toLowerCase()) {
      case 'network_error':
        return 'Network error. Please check your connection and try again.';
      case 'invalid_request':
        return 'Invalid bid data. Please check your inputs.';
      case 'server_error':
        return 'Server error. Please try again later.';
      default:
        return 'An error occurred: $error';
    }
  }

  /// Handle common exceptions (network, timeout, format)
  static ApiException handle(dynamic error) {
    if (error is ApiException) return error;

    if (error is SocketException) {
      return ApiException(message: "No internet connection.");
    } else if (error is FormatException) {
      return ApiException(message: "Invalid response format.");
    } else if (error.toString().contains("TimeoutException")) {
      return ApiException(message: "Request timed out.");
    } else {
      return ApiException(message: "Something went wrong.");
    }
  }

  /// Parse backend API response errors
  static ApiException fromResponse(int statusCode, dynamic body) {
    String message = "Something went wrong";
    Map<String, dynamic>? errors;

    if (body is Map<String, dynamic>) {
      // Use backend message or first validation error if exists
      errors = body['errors'];
      if (errors != null && errors.isNotEmpty) {
        final firstKey = errors.keys.first;
        final firstError = errors[firstKey];
        if (firstError is List && firstError.isNotEmpty) {
          message = firstError.first.toString();
        } else if (firstError != null) {
          message = firstError.toString();
        }
      } else if (body['message'] != null) {
        message = body['message'];
      } else if (body['error'] != null) {
        message = body['error'];
      }
    }

    // Map HTTP status codes to user-friendly messages
    switch (statusCode) {
      case 400:
      case 422:
        return ApiException(
          statusCode: statusCode,
          message: message,
          details: errors,
        );
      case 401:
        return ApiException(
          statusCode: statusCode,
          message: message.isNotEmpty
              ? message
              : "Unauthorized. Please log in.",
        );
      case 403:
        if (body is Map<String, dynamic> && body['isOTPverified'] == false) {
          return ApiException(
            statusCode: statusCode,
            message: message,
            details: body,
          );
        }
        return ApiException(statusCode: statusCode, message: message);
      case 404:
        return ApiException(
          statusCode: statusCode,
          message: message.isNotEmpty ? message : "Resource not found.",
        );
      case 409:
        return ApiException(
          statusCode: statusCode,
          message: "Conflict: $message",
        );
      case 500:
      default:
        return ApiException(
          statusCode: statusCode,
          message: "Server error. Please try again later.",
        );
    }
  }
}

