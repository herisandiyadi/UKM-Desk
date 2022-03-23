/// id : 1
/// count : 2
/// name : "item name"
/// price : 9600
/// image_url : "url"

class CartModel {
  int _id;
  int _count;
  String _name;
  int _price;
  String _imageUrl;
  String _date;
  bool _isRenewal;

  int get id => _id;
  int get count => _count;
  String get name => _name;
  int get price => _price;
  String get imageUrl => _imageUrl;
  String get date => _date;
  bool get isRenewal => _isRenewal;

  CartModel(
      {int id,
      int count,
      String name,
      int price,
      String imageUrl,
      String date}) {
    _id = id;
    _count = count;
    _name = name;
    _price = price;
    _imageUrl = imageUrl;
    _date = date;
  }

  void setRenewalStatus(bool status) {
    _isRenewal = status;
  }

  void setStartDate(String date) {
    _date = date;
  }

  CartModel.fromJson(dynamic json) {
    _isRenewal = json["isRenewal"] == 1 ? true : false;
    _id = json["id"];
    _count = json["count"];
    _name = json["name"];
    _price = json["price"];
    _imageUrl = json["image_url"];
    _date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["count"] = _count;
    map["name"] = _name;
    map["price"] = _price;
    map["image_url"] = _imageUrl;
    map["date"] = _date;
    map["isRenewal"] = _isRenewal == null ? false : _isRenewal;
    return map;
  }
}
