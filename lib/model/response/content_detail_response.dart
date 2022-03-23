class ContentDetailResponse {
  bool _success;
  Data _data;

  bool get success => _success;
  Data get data => _data;

  ContentDetailResponse.fromJson(dynamic json) {
    _success = json["success"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;

    print(_data);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }
}

class Data {
  int _id;
  String _title;
  String _desc_id;
  String _image_1;
  String _image_2;
  String _date;

  int get id => _id;
  String get title_id => _title;
  String get desc_id => _desc_id;
  String get image_1 => _image_1;
  String get image_2 => _image_2;
  String get date => _date;

  Data({
    int id,
    String title,
    String desc_id,
    String image_1,
    String image_2,
    String date,
  }) {
    _id = id;
    _title = title;
    _desc_id = desc_id;
    _image_1 = image_1;
    _image_2 = image_2;
    _date = date;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title_id"];
    _desc_id = json["desc_id"];
    _image_1 = json["img_thumb"];
    _image_2 = json["icon"];
    _date = json["posted_date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["desc_id"] = _desc_id;
    map["images_1"] = _image_1;
    map["images_2"] = _image_2;
    map["date"] = _date;
    return map;
  }
}
