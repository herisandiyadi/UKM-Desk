/// success : true
/// data : [{"id":1,"question":"Apa yang dapat saya lihat dari halaman Dashboard?","answer":"Melalui halaman Dashboard, Anda akan mendapatkan Laporan Pajak dan Laporan Pembukuan perusahaan Anda setiap bulan. Selain itu, Anda dapat melihat Frequently Asked Question untuk memandu Anda."},{"id":2,"question":"Bagaimana saya mengkonfirmasi pembayaran saya?","answer":"Anda dapat mengkonfirmasi pembayaran dengan upload bukti pembayaran di halaman Notifikasi sesuai dengan pesanan Anda."},{"id":3,"question":"Bagaimana cara untuk melihat data perusahaan saya di website Enforce A?","answer":"Anda dapat melihat data perusahaan Anda di halaman Profil. Anda juga dapat mengubah data jika diperlukan. Namun Anda tidak dapat mengubah Nama Perusahaan, NPWP, Email dan Status Keanggotaan."},{"id":4,"question":"Apakah saya dapat melakukan reorder atas pesanan sebelumnya?","answer":"Benar, Anda dapat melakukan reorder untuk pemesanan yang sama dengan sebelumnya dari halaman Riwayat. Dengan reorder, Anda melakukan pemesanan dengan lebih cepat dan mudah."}]

class UploadListResponse {
  bool _success;
  List<Data> _data;
  int _total;

  bool get success => _success;
  List<Data> get data => _data;
  int get total => _total;

  UploadListResponse({bool success, List<Data> data}) {
    _success = success;
    _data = data;
  }

  UploadListResponse.fromJson(dynamic json) {
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

/// id : 1
/// question : "Apa yang dapat saya lihat dari halaman Dashboard?"
/// answer : "Melalui halaman Dashboard, Anda akan mendapatkan Laporan Pajak dan Laporan Pembukuan perusahaan Anda setiap bulan. Selain itu, Anda dapat melihat Frequently Asked Question untuk memandu Anda."

class Data {
  int _id;
  String _type;
  String _periode;
  String _filename;

  int get id => _id;
  String get type => _type;
  String get periode => _periode;
  String get filename => _filename;

  Data({int id, String type, String periode, String filename}) {
    _id = id;
    _type = type;
    _periode = periode;
    _filename = filename;
  }

  Data.fromJson(dynamic json) {
    _id = json["id_raw_data"];
    _type = json["type"];
    _periode = json["periode"];
    _filename = json["filename"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_raw_data"] = _id;
    map["type"] = _type;
    map["periode"] = _periode;
    map["filename"] = _filename;
    return map;
  }
}
