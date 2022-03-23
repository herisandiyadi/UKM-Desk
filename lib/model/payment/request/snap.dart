class SnapRequest {
  String _userID;
  String _code;
  String _total;

  String get userID => _userID;
  String get code => _code;
  String get total => _total;

  SnapRequest(String userID, String code, String total) {
    _userID = userID;
    _code = code;
    _total = total;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = _userID;
    map["code"] = _code;
    map["total"] = _total;

    return map;
  }
}
