/// nama_perusahan : "PT. Maju Mundur"
/// npwp : "23.232.323.2-323.232"
/// email : "n70.ronald182@gmail.com"
/// phone : "08125563764"
/// alamat : "jalan-jalan"
/// password : "1234"
/// password_confirm : "1234"
/// pic : "1"

class RegisterRequest {
  String _namaPerusahan;
  String _npwp;
  String _email;
  String _phone;
  String _alamat;
  String _password;
  String _passwordConfirm;
  String _pic;

  String get namaPerusahan => _namaPerusahan;
  String get npwp => _npwp;
  String get email => _email;
  String get phone => _phone;
  String get alamat => _alamat;
  String get password => _password;
  String get passwordConfirm => _passwordConfirm;
  String get pic => _pic;

  RegisterRequest({
      String namaPerusahan, 
      String npwp, 
      String email, 
      String phone, 
      String alamat, 
      String password, 
      String passwordConfirm, 
      String pic}){
    _namaPerusahan = namaPerusahan;
    _npwp = npwp;
    _email = email;
    _phone = phone;
    _alamat = alamat;
    _password = password;
    _passwordConfirm = passwordConfirm;
    _pic = pic;
}

  RegisterRequest.fromJson(dynamic json) {
    _namaPerusahan = json["namaPerusahan"];
    _npwp = json["npwp"];
    _email = json["email"];
    _phone = json["phone"];
    _alamat = json["alamat"];
    _password = json["password"];
    _passwordConfirm = json["passwordConfirm"];
    _pic = json["pic"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["nama_perusahan"] = _namaPerusahan;
    map["npwp"] = _npwp;
    map["email"] = _email;
    map["phone"] = _phone;
    map["alamat"] = _alamat;
    map["password"] = _password;
    map["password_confirm"] = _passwordConfirm;
    map["pic"] = _pic;
    return map;
  }

}