import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FileStorage {
  final String directoryPath;

  FileStorage(this.directoryPath);

  Future<List<dynamic>> readJsonData(String filename) async {
    try {
      if (kIsWeb) {
        final contents = await rootBundle.loadString('data/$filename');
        return jsonDecode(contents);
      } else {
        final file = File('$directoryPath/$filename');
        if (await file.exists()) {
          final contents = await file.readAsString();
          return jsonDecode(contents);
        }
        try {
          final contents = await rootBundle.loadString('data/$filename');
          return jsonDecode(contents);
        } catch (e) {
          return [];
        }
      }
    } catch (err) {
      debugPrint('Error reading $filename: $err');
      return [];
    }
  }

  Future<void> writeJson(String filename, List<dynamic> jsonList) async {
    if (kIsWeb) {
      debugPrint('Write operations are not supported on web platform');
      return;
    }
    
    debugPrint('Writing to: $directoryPath/$filename');
    
    // Create directory if it doesn't exist
    final dir = Directory(directoryPath);
    if (!await dir.exists()) {
      debugPrint('Directory does not exist, creating: $directoryPath');
      await dir.create(recursive: true);
      debugPrint('Directory created successfully');
    }
    
    final file = File('$directoryPath/$filename');
    final contents = jsonEncode(jsonList);
    debugPrint('Writing content: $contents');
    await file.writeAsString(contents);
    debugPrint('File written successfully to ${file.path}');
  }
}