class ContentResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  ContentResponse({bool success, List<Data> data}) {
    _success = success;
    _data = data;
  }

  ContentResponse.fromJson(dynamic json) {
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
  String _title_en;
  String _title_id;
  String _icon;
  String _posted_date;

  int get id => _id;
  String get titleEn => _title_en;
  String get titleID => _title_id;
  String get icon => _icon;
  String get postedDate => _posted_date;

  Data(
      {int id,
      String titleEn,
      String titleID,
      String icon,
      String postedDate}) {
    _id = id;
    _title_en = titleEn;
    _title_id = titleID;
    _icon = icon;
    _posted_date = postedDate;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _title_en = json["title_en"];
    _title_id = json["title_id"];
    _icon = json["icon"];
    _posted_date = json["posted_date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title_en"] = _title_en;
    map["title_id"] = _title_id;
    map["icon"] = _icon;
    map["posted_date"] = _posted_date;
    return map;
  }
}
