/// success : true
/// data : [{"transaction_id":4,"transaction_date":"2020-07-10 15:19:05","product_name":"UKM Desk Small","product_price":"2700000","qty":7,"total":"18900000","date":"2020-08"},{"transaction_id":19,"transaction_date":null,"product_name":"UKM Desk Small","product_price":"4000000","qty":3,"total":"12000000","date":"2020-08"}]

class HistoryResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  HistoryResponse({
      bool success, 
      List<Data> data}){
    _success = success;
    _data = data;
}

  HistoryResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// transaction_id : 4
/// transaction_date : "2020-07-10 15:19:05"
/// product_name : "UKM Desk Small"
/// product_price : "2700000"
/// qty : 7
/// total : "18900000"
/// date : "2020-08"

class Data {
  int _transactionId;
  String _transactionDate;
  String _productName;
  String _productPrice;
  int _qty;
  String _total;
  String _date;

  int get transactionId => _transactionId;
  String get transactionDate => _transactionDate;
  String get productName => _productName;
  String get productPrice => _productPrice;
  int get qty => _qty;
  String get total => _total;
  String get date => _date;

  Data({
      int transactionId, 
      String transactionDate, 
      String productName, 
      String productPrice, 
      int qty, 
      String total, 
      String date}){
    _transactionId = transactionId;
    _transactionDate = transactionDate;
    _productName = productName;
    _productPrice = productPrice;
    _qty = qty;
    _total = total;
    _date = date;
}

  Data.fromJson(dynamic json) {
    _transactionId = json["transaction_id"];
    _transactionDate = json["transaction_date"];
    _productName = json["product_name"];
    _productPrice = json["product_price"];
    _qty = json["qty"];
    _total = json["total"];
    _date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["transaction_id"] = _transactionId;
    map["transaction_date"] = _transactionDate;
    map["product_name"] = _productName;
    map["product_price"] = _productPrice;
    map["qty"] = _qty;
    map["total"] = _total;
    map["date"] = _date;
    return map;
  }

}