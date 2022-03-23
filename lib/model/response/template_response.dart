class TemplateResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  TemplateResponse.fromJson(dynamic json) {
    _success = json["success"];
    print(json["data"]);

    if (json["data"] != null) {
      _data = (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map["success"] = _success;
  //   if (_data != null) {
  //     map["data"] = _data.toJson();
  //   }
  //   return map;
  // }
}

class Data {
  int id_template;
  String type;
  String filename;

  Data({
    this.id_template,
    this.type,
    this.filename,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id_template: json["id_template"],
        type: json["type"],
        filename: json["filename"],
      );

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map["id_template"] = _id_template;
  //   map["type"] = _type;
  //   map["filename"] = _filename;
  //   return map;
  // }
}
