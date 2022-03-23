/// success : true
/// api_token : "18d4b01e56c002a7b485fe412fe526c4696c086c"
/// data : {"id":70,"name":"Test Limited.inc","username":null,"email":"situmeang@gmail.com","email_verified_at":null,"address":"Jakarta Selatan","phone":"021123123","img":null,"is_admin":0,"is_client":1,"membership":1,"path":"files/situmeang@gmail.com/","npwp":"12.121.212.1-212.121","pic":5,"flag":"","verified":"1","role_id":null,"id_pic":null,"api_token":"18d4b01e56c002a7b485fe412fe526c4696c086c","created_at":"2020-07-10 01:13:53","updated_at":"2020-08-27 14:35:07"}

class LoginResponse {
  bool _success;
  String _apiToken;
  Data _data;

  bool get success => _success;
  String get apiToken => _apiToken;
  Data get data => _data;

  LoginResponse({
      bool success, 
      String apiToken, 
      Data data}){
    _success = success;
    _apiToken = apiToken;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _success = json["success"];
    _apiToken = json["apiToken"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["apiToken"] = _apiToken;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// id : 70
/// name : "Test Limited.inc"
/// username : null
/// email : "situmeang@gmail.com"
/// email_verified_at : null
/// address : "Jakarta Selatan"
/// phone : "021123123"
/// img : null
/// is_admin : 0
/// is_client : 1
/// membership : 1
/// path : "files/situmeang@gmail.com/"
/// npwp : "12.121.212.1-212.121"
/// pic : 5
/// flag : ""
/// verified : "1"
/// role_id : null
/// id_pic : null
/// api_token : "18d4b01e56c002a7b485fe412fe526c4696c086c"
/// created_at : "2020-07-10 01:13:53"
/// updated_at : "2020-08-27 14:35:07"

class Data {
  int _id;
  String _name;
  dynamic _username;
  String _email;
  dynamic _emailVerifiedAt;
  String _address;
  String _phone;
  dynamic _img;
  int _isAdmin;
  int _isClient;
  int _membership;
  String _path;
  String _npwp;
  int _pic;
  String _flag;
  String _verified;
  dynamic _roleId;
  dynamic _idPic;
  String _apiToken;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  dynamic get username => _username;
  String get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String get address => _address;
  String get phone => _phone;
  dynamic get img => _img;
  int get isAdmin => _isAdmin;
  int get isClient => _isClient;
  int get membership => _membership;
  String get path => _path;
  String get npwp => _npwp;
  int get pic => _pic;
  String get flag => _flag;
  String get verified => _verified;
  dynamic get roleId => _roleId;
  dynamic get idPic => _idPic;
  String get apiToken => _apiToken;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Data({
      int id, 
      String name, 
      dynamic username, 
      String email, 
      dynamic emailVerifiedAt, 
      String address, 
      String phone, 
      dynamic img, 
      int isAdmin, 
      int isClient, 
      int membership, 
      String path, 
      String npwp, 
      int pic, 
      String flag, 
      String verified, 
      dynamic roleId, 
      dynamic idPic, 
      String apiToken, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _address = address;
    _phone = phone;
    _img = img;
    _isAdmin = isAdmin;
    _isClient = isClient;
    _membership = membership;
    _path = path;
    _npwp = npwp;
    _pic = pic;
    _flag = flag;
    _verified = verified;
    _roleId = roleId;
    _idPic = idPic;
    _apiToken = apiToken;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _username = json["username"];
    _email = json["email"];
    _emailVerifiedAt = json["emailVerifiedAt"];
    _address = json["address"];
    _phone = json["phone"];
    _img = json["img"];
    _isAdmin = json["isAdmin"];
    _isClient = json["isClient"];
    _membership = json["membership"];
    _path = json["path"];
    _npwp = json["npwp"];
    _pic = json["pic"];
    _flag = json["flag"];
    _verified = json["verified"];
    _roleId = json["roleId"];
    _idPic = json["idPic"];
    _apiToken = json["apiToken"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["username"] = _username;
    map["email"] = _email;
    map["emailVerifiedAt"] = _emailVerifiedAt;
    map["address"] = _address;
    map["phone"] = _phone;
    map["img"] = _img;
    map["isAdmin"] = _isAdmin;
    map["isClient"] = _isClient;
    map["membership"] = _membership;
    map["path"] = _path;
    map["npwp"] = _npwp;
    map["pic"] = _pic;
    map["flag"] = _flag;
    map["verified"] = _verified;
    map["roleId"] = _roleId;
    map["idPic"] = _idPic;
    map["apiToken"] = _apiToken;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    return map;
  }

}