class DownloadEbookResponse {
  bool _success;
  List<Data> _ebookData;
  List<Data> _templateData;

  bool get success => _success;
  List<Data> get ebookData => _ebookData;
  List<Data> get templateData => _templateData;

  DownloadEbookResponse.fromJson(dynamic json) {
    _success = json["success"];

    if (json["data"]["ebook"] != null) {
      _ebookData =
          (json["data"]["ebook"] as List).map((e) => Data.fromJson(e)).toList();
    }

    if (json["data"]["template"] != null) {
      _templateData = (json["data"]["template"] as List)
          .map((e) => Data.fromJson(e))
          .toList();
    }
  }
}

class Data {
  int _id;
  String _title;
  String _desc;
  String _fileName;
  String _image;

  int get id => _id;
  String get title => _title;
  String get desc => _desc;
  String get fileName => _fileName;
  String get image => _image;

  Data({int id, String title, String desc, String fileName, String image}) {
    _id = id;
    _title = title;
    _desc = desc;
    _fileName = fileName;
    _image = image;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _desc = json["desc"];
    _fileName = json["filename"];
    _image = json["img"];
  }
}
