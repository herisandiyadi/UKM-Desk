class MonthLeftResponse {
  bool _success;
  int _data;

  bool get success => _success;
  int get data => _data;

  MonthLeftResponse({bool success, int data}) {
    _success = success;
    _data = data;
  }

  MonthLeftResponse.fromJson(dynamic json) {
    _success = json["success"];
    _data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["data"] = _data;
    return map;
  }
}
