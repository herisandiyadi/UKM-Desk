
class PaymentRequest {
  List<Data_produk> _dataProduk;

  List<Data_produk> get dataProduk => _dataProduk;

  PaymentRequest({
      List<Data_produk> dataProduk}){
    _dataProduk = dataProduk;
}

  PaymentRequest.fromJson(dynamic json) {
    if (json["data_produk"] != null) {
      _dataProduk = [];
      json["data_produk"].forEach((v) {
        _dataProduk.add(Data_produk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_dataProduk != null) {
      map["data_produk"] = _dataProduk.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id_produk : "6"
/// harga : 4000000
/// qty : 3

class Data_produk {
  String _idProduk;
  int _harga;
  int _qty;

  String get idProduk => _idProduk;
  int get harga => _harga;
  int get qty => _qty;

  Data_produk({
      String idProduk,
      int harga, 
      int qty}){
    _idProduk = idProduk;
    _harga = harga;
    _qty = qty;
}

  Data_produk.fromJson(dynamic json) {
    _idProduk = json["id_produk"];
    _harga = json["harga"];
    _qty = json["qty"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_produk"] = _idProduk;
    map["harga"] = _harga;
    map["qty"] = _qty;
    return map;
  }

}