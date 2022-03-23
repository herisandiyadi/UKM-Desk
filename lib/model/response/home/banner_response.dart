class BannerResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  BannerResponse({bool success, List<Data> data}) {
    _success = success;
    _data = data;
  }

  BannerResponse.fromJson(dynamic json) {
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
  String _slide;
  String _link;

  String get slide => _slide;
  String get link => _link;

  Data({int id, String slide, String link}) {
    _slide = slide;
    _link = link;
  }

  Data.fromJson(dynamic json) {
    _slide = json["slide"];
    _link = json["link"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["slide"] = _slide;
    map["link"] = _link;
    return map;
  }
}
