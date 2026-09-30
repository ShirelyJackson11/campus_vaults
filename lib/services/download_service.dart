import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<String> getDownloadDirectory() async {
    final directory = await getApplicationDocumentsDirectory();

    final downloadDirectory = Directory(
      '${directory.path}/downloads',
    );

    if (!await downloadDirectory.exists()) {
      await downloadDirectory.create(recursive: true);
    }

    return downloadDirectory.path;
  }

  static Future<String> getFilePath(String fileName) async {
    final directory = await getDownloadDirectory();

    return '$directory/$fileName';
  }

  static Future<bool> fileExists(String fileName) async {
    final filePath = await getFilePath(fileName);
    final file = File(filePath);

    return file.exists();
  }

  static Future<void> deleteFile(String fileName) async {
    final filePath = await getFilePath(fileName);
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
  }
}