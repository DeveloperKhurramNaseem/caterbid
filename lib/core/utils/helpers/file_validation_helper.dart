import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

/// Result model for file validation
class FileValidationResult {
  final bool isValid;
  final String? message;

  const FileValidationResult({required this.isValid, this.message});
}

/// Helper for validating picked image/file before upload
class FileValidationHelper {
  static const List<String> allowedExtensions = ['.jpg', '.jpeg', '.png', '.pdf'];
  static const int maxSize = 3 * 1024 * 1024; // 1MB

  /// Validates a file and returns [FileValidationResult]
  static Future<FileValidationResult> validateFile(File file) async {
    final extension = path.extension(file.path).toLowerCase();
    final fileSize = await file.length();

    if (!allowedExtensions.contains(extension)) {
      return const FileValidationResult(
        isValid: false,
        message: 'Only .jpg, .jpeg, .png, and .pdf files are allowed',
      );
    }

    if (fileSize > maxSize) {
      return const FileValidationResult(
        isValid: false,
        message: 'File size exceeds 1MB limit',
      );
    }

    return const FileValidationResult(isValid: true);
  }

  /// (Optional) A convenience method for showing validation errors directly.
  static Future<bool> validateAndShow(BuildContext context, File file) async {
    final result = await validateFile(file);
    if (!result.isValid && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message ?? 'Invalid file')),
      );
    }
    return result.isValid;
  }
}
