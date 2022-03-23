class InWebViewResponse {
  String _token;
  String _redirectURL;

  String get redirectURL => _redirectURL;

  InWebViewResponse(String token, String redirectURL) {
    _token = token;
    _redirectURL = redirectURL;
  }

  InWebViewResponse.fromJson(dynamic json) {
    _token = json["token"];
    _redirectURL = json["redirect_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = _token;
    map["redirect_url"] = _redirectURL;

    return map;
  }
}
