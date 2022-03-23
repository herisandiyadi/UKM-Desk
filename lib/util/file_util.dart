import 'dart:convert';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  FileUtil();

  Future<File> checkFile(String fileName) async {
    final output = (await getExternalStorageDirectories(
            type: StorageDirectory.downloads))[0]
        .path;

    final file = File(output + "/" + fileName);
    if (file.exists() != null) {
      return file;
    } else {
      return null;
    }
  }

  Future<File> saveToStorage(String base64, String filename) async {
    final bytes = base64Decode(base64);
    final output = (await getApplicationDocumentsDirectory()).path;

    final file = File(output + "/" + filename);

    await file
        .writeAsBytes(bytes, mode: FileMode.write, flush: true)
        .catchError(
          (error) => print(
            "error : " + error.toString(),
          ),
        );
    return file;
//        .then((value) => OpenFile.open(value.path));
  }
}
