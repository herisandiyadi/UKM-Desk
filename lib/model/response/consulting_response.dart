class ConsultingResponse {
  bool _success;
  Data _data;

  bool get success => _success;
  Data get data => _data;

  ConsultingResponse.fromJson(dynamic json) {
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
  String _isi;
  String _image_1;
  String _image_2;

  String get isi => _isi;
  String get image_1 => _image_1;
  String get image_2 => _image_2;

  Data({
    String isi,
    String image_1,
    String image_2,
  }) {
    _isi = isi;
    _image_1 = image_1;
    _image_2 = image_2;
  }

  Data.fromJson(dynamic json) {
    print(json["images_1"]);
    _isi = json["isi"];
    _image_1 = json["images_1"];
    _image_2 = json["images_2"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isi"] = _isi;
    map["images_1"] = _image_1;
    map["images_2"] = _image_2;
    return map;
  }
}
