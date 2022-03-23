/// success : true
/// data : [{"id":1,"question":"Apa yang dapat saya lihat dari halaman Dashboard?","answer":"Melalui halaman Dashboard, Anda akan mendapatkan Laporan Pajak dan Laporan Pembukuan perusahaan Anda setiap bulan. Selain itu, Anda dapat melihat Frequently Asked Question untuk memandu Anda."},{"id":2,"question":"Bagaimana saya mengkonfirmasi pembayaran saya?","answer":"Anda dapat mengkonfirmasi pembayaran dengan upload bukti pembayaran di halaman Notifikasi sesuai dengan pesanan Anda."},{"id":3,"question":"Bagaimana cara untuk melihat data perusahaan saya di website Enforce A?","answer":"Anda dapat melihat data perusahaan Anda di halaman Profil. Anda juga dapat mengubah data jika diperlukan. Namun Anda tidak dapat mengubah Nama Perusahaan, NPWP, Email dan Status Keanggotaan."},{"id":4,"question":"Apakah saya dapat melakukan reorder atas pesanan sebelumnya?","answer":"Benar, Anda dapat melakukan reorder untuk pemesanan yang sama dengan sebelumnya dari halaman Riwayat. Dengan reorder, Anda melakukan pemesanan dengan lebih cepat dan mudah."}]

class FaqResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  FaqResponse({
      bool success, 
      List<Data> data}){
    _success = success;
    _data = data;
}

  FaqResponse.fromJson(dynamic json) {
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

/// id : 1
/// question : "Apa yang dapat saya lihat dari halaman Dashboard?"
/// answer : "Melalui halaman Dashboard, Anda akan mendapatkan Laporan Pajak dan Laporan Pembukuan perusahaan Anda setiap bulan. Selain itu, Anda dapat melihat Frequently Asked Question untuk memandu Anda."

class Data {
  int _id;
  String _question;
  String _answer;

  int get id => _id;
  String get question => _question;
  String get answer => _answer;

  Data({
      int id, 
      String question, 
      String answer}){
    _id = id;
    _question = question;
    _answer = answer;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _question = json["question"];
    _answer = json["answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["question"] = _question;
    map["answer"] = _answer;
    return map;
  }

}