import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static const String fileName = 'data.txt';

  static Future<String> _getCurrentPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getFile(String fileName) async {
    final directory = await _getCurrentPath();
    print('File path: $directory/$fileName');

    File file = File('$directory/$fileName');
    if (!file.existsSync()) {
      return file.create();
    }
    return file;
  }

  static Future<void> saveFile(String fileName, String content) async {
    final file = await getFile(fileName);
    if (!file.existsSync()) {
      await file.create();
    }
    await file.writeAsString(content);
  }
}
