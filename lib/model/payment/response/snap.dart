class SnapResponse {
  bool _success;
  String _token;
  String _redirectURL;

  String get redirectURL => _redirectURL;
  bool get isSuccess => _success;

  SnapResponse(bool success, String token, String redirectURL) {
    _success = success;
    _token = token;
    _redirectURL = redirectURL;
  }

  SnapResponse.fromJson(dynamic json) {
    _success = json["success"];
    _token = json["token"];
    _redirectURL = json["redirect_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["token"] = _token;
    map["redirect_url"] = _redirectURL;

    return map;
  }
}
