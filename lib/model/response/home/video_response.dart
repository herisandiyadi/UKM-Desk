class VideoResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  VideoResponse({bool success, List<Data> data}) {
    _success = success;
    _data = data;
  }

  VideoResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  int _id;
  String _title;
  String _url;
  String _status;
  String _slide;

  int get id => _id;
  String get title => _title;
  String get url => _url;
  String get status => _status;
  String get slide => _slide;

  Data({int id, String title, String url, String status, String slide}) {
    _id = id;
    _title = title;
    _url = url;
    _status = status;
    _slide = slide;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _url = json["url"];
    _status = json["status"];
    var temp = json["url"].split("/");
    var youtubeID = temp[temp.length - 1].split("?");
    _slide = "https://img.youtube.com/vi/" + youtubeID[0] + "/0.jpg";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["url"] = _url;
    map["status"] = _status;
    map["slide"] = _slide;
    return map;
  }
}
