/// success : true
/// data : [{"id_tax_report":1,"report_type":"PPN","periode":"Aug 2020","filename":"Liveindo_SPT PPN 0919.pdf","status":"Draft"}]

class TaxReportResponse {
  bool _success;
  List<Data> _data;
  int _total;

  bool get success => _success;
  List<Data> get data => _data;
  int get total => _total;

  TaxReportResponse({bool success, List<Data> data}) {
    _success = success;
    _data = data;
  }

  TaxReportResponse.fromJson(dynamic json) {
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

/// id_tax_report : 1
/// report_type : "PPN"
/// periode : "Aug 2020"
/// filename : "Liveindo_SPT PPN 0919.pdf"
/// status : "Draft"

class Data {
  int _idTaxReport;
  String _reportType;
  String _periode;
  String _filename;
  String _status;

  int get idTaxReport => _idTaxReport;
  String get reportType => _reportType;
  String get periode => _periode;
  String get filename => _filename;
  String get status => _status;

  Data(
      {int idTaxReport,
      String reportType,
      String periode,
      String filename,
      String status}) {
    _idTaxReport = idTaxReport;
    _reportType = reportType;
    _periode = periode;
    _filename = filename;
    _status = status;
  }

  Data.fromJson(dynamic json) {
    _idTaxReport = json["id_tax_report"];
    _reportType = json["report_type"];
    _periode = json["periode"];
    _filename = json["filename"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_tax_report"] = _idTaxReport;
    map["report_type"] = _reportType;
    map["periode"] = _periode;
    map["filename"] = _filename;
    map["status"] = _status;
    return map;
  }
}
