import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'download_service.dart';

class OfflineDownloadService {
  static const String _downloadedMaterialsKey =
      'downloaded_learning_materials';

  // Save a learning material for offline reading.
  static Future<void> saveMaterial({
    required String id,
    required String title,
    required String content,
  }) async {
    // Create a safe file name from the material title.
    final safeFileName = _createSafeFileName('$id-$title.txt');

    final filePath = await DownloadService.getFilePath(safeFileName);

    final file = File(filePath);

    // Save the actual learning material content.
    await file.writeAsString(content);

    // Save information about the downloaded material.
    final prefs = await SharedPreferences.getInstance();

    final downloadedMaterials =
        prefs.getStringList(_downloadedMaterialsKey) ?? [];

    final materialData = jsonEncode({
      'id': id,
      'title': title,
      'fileName': safeFileName,
      'filePath': filePath,
    });

    // Remove an older record for the same material.
    downloadedMaterials.removeWhere((item) {
      try {
        final data = jsonDecode(item);
        return data['id'] == id;
      } catch (_) {
        return false;
      }
    });

    downloadedMaterials.add(materialData);

    await prefs.setStringList(
      _downloadedMaterialsKey,
      downloadedMaterials,
    );
  }

  // Get all downloaded learning materials.
  static Future<List<Map<String, dynamic>>> getDownloadedMaterials() async {
    final prefs = await SharedPreferences.getInstance();

    final downloadedMaterials =
        prefs.getStringList(_downloadedMaterialsKey) ?? [];

    final List<Map<String, dynamic>> materials = [];

    for (final item in downloadedMaterials) {
      try {
        final data = jsonDecode(item);

        final filePath = data['filePath'] as String;
        final file = File(filePath);

        // Only show materials whose files still exist.
        if (await file.exists()) {
          materials.add(Map<String, dynamic>.from(data));
        }
      } catch (_) {
        // Ignore invalid saved records.
      }
    }

    return materials;
  }

  // Check whether a particular material has been downloaded.
  static Future<bool> isMaterialDownloaded(String id) async {
    final materials = await getDownloadedMaterials();

    return materials.any((material) => material['id'] == id);
  }

  // Read a downloaded learning material.
  static Future<String?> readMaterial(String id) async {
    final materials = await getDownloadedMaterials();

    for (final material in materials) {
      if (material['id'] == id) {
        final file = File(material['filePath'] as String);

        if (await file.exists()) {
          return file.readAsString();
        }
      }
    }

    return null;
  }

  // Delete a downloaded learning material.
  static Future<void> deleteMaterial(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final downloadedMaterials =
        prefs.getStringList(_downloadedMaterialsKey) ?? [];

    String? filePath;

    downloadedMaterials.removeWhere((item) {
      try {
        final data = jsonDecode(item);

        if (data['id'] == id) {
          filePath = data['filePath'] as String;
          return true;
        }
      } catch (_) {
        // Ignore invalid records.
      }

      return false;
    });

    // Delete the actual downloaded file.
    if (filePath != null) {
      final file = File(filePath!);

      if (await file.exists()) {
        await file.delete();
      }
    }

    // Update the saved download list.
    await prefs.setStringList(
      _downloadedMaterialsKey,
      downloadedMaterials,
    );
  }

  // Create a file name that is safe to use on the device.
  static String _createSafeFileName(String fileName) {
    return fileName
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
        .replaceAll(RegExp(r'\s+'), '_');
  }
}