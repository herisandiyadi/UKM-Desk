/// success : true
/// data : [{"id_account_report":9,"report_type":"Neraca","periode":"Jun 2020","filename":"PT Jurnal Information_Neraca_Jun_2020.pdf","status":"Finall"},{"id_account_report":10,"report_type":"Laba Rugi","periode":"Jun 2020","filename":"PT Jurnal Information_Laba Rugi_Jun_2020.pdf","status":"Finall"},{"id_account_report":11,"report_type":"Arus Kas","periode":"Jun 2020","filename":"PT Jurnal Information_Arus Kas_Jun_2020.pdf","status":"Finall"}]

class AccountingReportResponse {
  bool _success;
  List<Data> _data;

  int _total;

  bool get success => _success;
  List<Data> get data => _data;

  int get total => _total;

  AccountingReportResponse({bool success, List<Data> data}) {
    _success = success;
    _data = data;
  }

  AccountingReportResponse.fromJson(dynamic json) {
    _success = json["success"];
    _total = json["data"]["jumlah_data"];
    if (json["data"]["list"] != null) {
      _data = [];
      json["data"]["list"].forEach((v) {
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

/// id_account_report : 9
/// report_type : "Neraca"
/// periode : "Jun 2020"
/// filename : "PT Jurnal Information_Neraca_Jun_2020.pdf"
/// status : "Finall"

class Data {
  int _idAccountReport;
  String _reportType;
  String _periode;
  String _filename;
  String _status;

  int get idAccountReport => _idAccountReport;
  String get reportType => _reportType;
  String get periode => _periode;
  String get filename => _filename;
  String get status => _status;

  Data(
      {int idAccountReport,
      String reportType,
      String periode,
      String filename,
      String status}) {
    _idAccountReport = idAccountReport;
    _reportType = reportType;
    _periode = periode;
    _filename = filename;
    _status = status;
  }

  Data.fromJson(dynamic json) {
    _idAccountReport = json["id_account_report"];
    _reportType = json["report_type"];
    _periode = json["periode"];
    _filename = json["filename"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_account_report"] = _idAccountReport;
    map["report_type"] = _reportType;
    map["periode"] = _periode;
    map["filename"] = _filename;
    map["status"] = _status;
    return map;
  }
}
