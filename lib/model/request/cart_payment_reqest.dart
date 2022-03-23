class CartPaymentRequest {
  String _payementID;
  String _kodePromo;
  int _subTotal;
  int _nilaiPromo;
  String _diskon;
  int _paymentMethod;
  List<DataProduk> _dataProduk;

  List<DataProduk> get dataProduk => _dataProduk;
  String get paymentID => _payementID;
  String get kodePromo => _kodePromo;
  int get subTotal => _subTotal;
  int get nilaiPromo => _nilaiPromo;
  int get paymentMethod => _paymentMethod;
  String get diskon => _diskon;

  SetListProduct(List<DataProduk> dataProduct) {
    _dataProduk = dataProduct;
  }

  CartPaymentRequest(
      {List<DataProduk> dataProduk,
      String paymentID,
      String kodePromo,
      int subTotal,
      int nilaiPromo,
      String diskon,
      int paymentMethod}) {
    _dataProduk = dataProduk;
    _payementID = paymentID;
    _kodePromo = kodePromo;
    _subTotal = subTotal;
    _nilaiPromo = nilaiPromo;
    _diskon = diskon;
    _paymentMethod = paymentMethod;
  }

  CartPaymentRequest.fromJson(dynamic json) {
    _payementID = json["id_payment"];
    _kodePromo = json["kode_promo"];
    _subTotal = json["sub_total"];
    _nilaiPromo = json["nilai_promo"];
    _diskon = json["diskon"];
    _paymentMethod = json["payment_method"];
    if (json["data_produk"] != null) {
      _dataProduk = [];
      json["data_produk"].forEach((v) {
        _dataProduk.add(DataProduk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_payment"] = _payementID;
    map["kode_promo"] = _kodePromo;
    map["sub_total"] = _subTotal;
    map["nilai_promo"] = _nilaiPromo;
    map["diskon"] = _diskon;
    map["payment_method"] = _paymentMethod;
    if (_dataProduk != null) {
      map["data_produk"] = _dataProduk.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id_produk : "6"
/// harga : 4000000
/// qty : 3

class DataProduk {
  String _idProduk;
  String _productName;
  int _harga;
  int _qty;
  String _date;
  int _total;

  String get idProduk => _idProduk;
  String get productName => _productName;
  int get harga => _harga;
  int get qty => _qty;
  String get date => _date;
  int get total => _total;

  DataProduk(
      {String idProduk,
      String productName,
      int harga,
      int qty,
      String date,
      int total}) {
    _idProduk = idProduk;
    _productName = productName;
    _harga = harga;
    _qty = qty;
    _date = date;
    _total = total;
  }

  DataProduk.fromJson(dynamic json) {
    _idProduk = json["id_produk"];
    _productName = json["produk_name"];
    _harga = json["harga"];
    _qty = json["qty"];
    _date = json["date"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_produk"] = _idProduk;
    map["product_name"] = _productName;
    map["harga"] = _harga;
    map["qty"] = _qty;
    map["date"] = _date;
    map["total"] = _total;
    return map;
  }
}
