class StoreRequest {
  String _paymentType;
  TransactionDetailStore _transactionDetail;
  CSStore _csStore;

  String get paymentType => _paymentType;
  TransactionDetailStore get transactionDetail => _transactionDetail;
  CSStore get csStore => _csStore;

  StoreRequest(String paymentType, TransactionDetailStore transactionDetail,
      CSStore csStore) {
    _paymentType = paymentType;
    _transactionDetail = transactionDetail;
    _csStore = csStore;
  }

  StoreRequest.fromJson(dynamic json) {
    _paymentType = json["payment_type"];
    _csStore = CSStore.fromJson(json["cstore"]);
    _transactionDetail =
        TransactionDetailStore.fromJson(json["transaction_details"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["payment_type"] = _paymentType;
    map["transaction_details"] = _transactionDetail;
    map["cstore"] = _csStore;

    return map;
  }
}

class CSStore {
  String _store;
  String _message;
  String _freeText1;
  String _freeText2;
  String _freeText3;

  String get store => _store;
  String get message => _message;
  String get freeText1 => _freeText1;
  String get freeText2 => _freeText2;
  String get freeText3 => _freeText3;

  CSStore(
      {String store,
      String message,
      String freeText1,
      String freeText2,
      String freeText3}) {
    _store = store;
    _message = message;
    _freeText1 = freeText1;
    _freeText2 = freeText2;
    _freeText3 = freeText3;
  }

  CSStore.fromJson(dynamic json) {
    _store = json["store"];
    _message = json["message"];
    _freeText1 = json["alfamart_free_text_1"];
    _freeText2 = json["alfamart_free_text_2"];
    _freeText3 = json["alfamart_free_text_3"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["store"] = _store;
    map["message"] = _message;
    map["alfamart_free_text_1"] = _freeText1;
    map["alfamart_free_text_2"] = _freeText2;
    map["alfamart_free_text_3"] = _freeText3;
    return map;
  }
}

class TransactionDetailStore {
  String _orderID;
  int _grossAmount;

  String get orderID => _orderID;
  int get grossAmount => _grossAmount;

  TransactionDetailStore({String orderID, int grossAmount}) {
    _orderID = orderID;
    _grossAmount = grossAmount;
  }

  TransactionDetailStore.fromJson(dynamic json) {
    _orderID = json["order_id"];
    _grossAmount = json["gross_amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["order_id"] = _orderID;
    map["gross_amount"] = _grossAmount;
    return map;
  }
}
