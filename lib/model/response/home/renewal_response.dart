class RenewalResponse {
  bool _success;
  Product _data;

  bool get success => _success;
  Product get data => _data;

  RenewalResponse({bool success, Product data}) {
    _success = success;
    _data = data;
  }

  RenewalResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (_success) {
      _data = Product.fromJson(json["data"]["produk"]);
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["data"] = _data;
    return map;
  }
}

class Product {
  int _id;
  String _image;
  String _productName;
  String _date;
  int _price;
  int _qty;

  int get id => _id;
  String get image => _image;
  String get productName => _productName;
  String get date => _date;
  int get price => _price;
  int get qty => _qty;

  Product(
      {int id,
      String image,
      String productName,
      String date,
      int price,
      int qty}) {
    _id = id;
    _image = image;
    _productName = productName;
    _date = date;
    _price = price;
    _qty = qty;
  }

  Product.fromJson(dynamic json) {
    _id = json["id_produk"];
    _image = json["img"];
    _productName = json["produk_name"];
    _date = json["date"];
    _price = int.parse(json["price"]);
    _qty = json["qty"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_produk"] = _id;
    map["img"] = _image;
    map["product_name"] = _productName;
    map["date"] = _date;
    map["price"] = _price;
    map["qty"] = _qty;
    return map;
  }
}
