import 'package:flutter/foundation.dart';

class UploadFile {
  String type;
  String period;
  String name_file;
  String doc_upload;

  UploadFile({
    @required this.type,
    @required this.period,
    @required this.name_file,
    @required this.doc_upload,
  });
}
