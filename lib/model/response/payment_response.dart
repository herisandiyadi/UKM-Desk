/// success : true
/// data : {"kode_promo":"","sub_total":13500000,"promo":0,"diskon":0,"net":13500000,"ppn":1350000,"total":14850000}

class PaymentResponse {
  bool _success;
  DataPayment _data;

  bool get success => _success;
  DataPayment get data => _data;

  PaymentResponse({bool success, DataPayment data}) {
    _success = success;
    _data = data;
  }

  PaymentResponse.fromJson(dynamic json) {
    _success = json["success"];
    _data = json["data"] != null ? DataPayment.fromJson(json["data"]) : null;
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

/// kode_promo : ""
/// sub_total : 13500000
/// promo : 0
/// diskon : 0
/// net : 13500000
/// ppn : 1350000
/// total : 14850000

class DataPayment {
  String _idPayment;
  String _kodePromo;
  int _subTotal;
  int _promo;
  String _diskon;
  int _net;
  int _ppn;
  int _total;

  String get idPayment => _idPayment;
  String get kodePromo => _kodePromo;
  int get subTotal => _subTotal;
  int get promo => _promo;
  String get diskon => _diskon;
  int get net => _net;
  int get ppn => _ppn;
  int get total => _total;

  DataPayment(
      {String kodePromo,
      int subTotal,
      int promo,
      String diskon,
      int net,
      int ppn,
      int total}) {
    _kodePromo = kodePromo;
    _subTotal = subTotal;
    _promo = promo;
    _diskon = diskon;
    _net = net;
    _ppn = ppn;
    _total = total;
  }

  DataPayment.fromJson(dynamic json) {
    _idPayment = json["id_payment"];
    _kodePromo = json["kode_promo"];
    _subTotal = json["sub_total"];
    _promo = json["promo"];
    _diskon = json["diskon"];
    _net = json["net"];
    _ppn = json["ppn"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_payment"] = _idPayment;
    map["kode_promo"] = _kodePromo;
    map["sub_total"] = _subTotal;
    map["promo"] = _promo;
    map["diskon"] = _diskon;
    map["net"] = _net;
    map["ppn"] = _ppn;
    map["total"] = _total;
    return map;
  }
}
