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

  int get id => _id;
  int get count => _count;
  String get name => _name;
  int get price => _price;
  String get imageUrl => _imageUrl;

  CartModel({
      int id, 
      int count, 
      String name, 
      int price, 
      String imageUrl}){
    _id = id;
    _count = count;
    _name = name;
    _price = price;
    _imageUrl = imageUrl;
}

  CartModel.fromJson(dynamic json) {
    _id = json["id"];
    _count = json["count"];
    _name = json["name"];
    _price = json["price"];
    _imageUrl = json["image_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["count"] = _count;
    map["name"] = _name;
    map["price"] = _price;
    map["image_url"] = _imageUrl;
    return map;
  }

}