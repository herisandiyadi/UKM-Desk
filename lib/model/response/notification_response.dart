class NotificationResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  NotificationResponse({bool success, List<Data> data}) {
    _success = success;
    _data = data;
  }

  NotificationResponse.fromJson(dynamic json) {
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
  String _kodeTransaksi;
  String _total;
  String _created_at;
  String _status;
  String _type;

  int get id => _id;
  String get kodeTransaksi => _kodeTransaksi;
  String get total => _total;
  String get created_at => _created_at;
  String get status => _status;
  String get type => _type;

  Data({int id, String total, String created_at, String status, String type}) {
    _id = id;
    _total = total;
    _created_at = created_at;
    _status = status;
    _type = type;
  }

  Data.fromJson(dynamic json) {
    _id = json["id_transaction"];
    _kodeTransaksi = json["kode"];
    _total = json["total"];
    _created_at = json["created_at"];
    _status = json["status"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["kode"] = _kodeTransaksi;
    map["total"] = _total;
    map["created_at"] = _created_at;
    map["status"] = _status;
    map["type"] = _type;
    return map;
  }
}
