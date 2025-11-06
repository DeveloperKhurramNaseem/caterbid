import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerHelper {
  static Future<File?> pickFile(BuildContext context) async {
    return await showModalBottomSheet<File?>(
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
              onTap: () async {
                final picked = await _pickImage(ImageSource.camera);
                Navigator.pop(context, picked);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.teal),
              title: const Text("Choose from gallery"),
              onTap: () async {
                final picked = await _pickImage(ImageSource.gallery);
                Navigator.pop(context, picked);
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file, color: Colors.teal),
              title: const Text("Choose a file"),
              onTap: () async {
                final picked = await _pickFile();
                Navigator.pop(context, picked);
              },
            ),
          ],
        ),
      ),
    );
  }

  static Future<File?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<File?> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    return result != null && result.files.single.path != null
        ? File(result.files.single.path!)
        : null;
  }
}