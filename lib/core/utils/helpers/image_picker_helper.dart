import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> pickImage(BuildContext context) async {
    final picker = ImagePicker();

    final source = await _showImageSourceDialog(context);
    if (source == null) return null;

    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.teal),
              title: const Text("Take a photo"),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.teal),
              title: const Text("Choose from gallery"),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
