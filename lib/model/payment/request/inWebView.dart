class InWebViewRequest {
  List<String> _enablePayment;
  TransactionDetailWebView _transactionDetail;

  TransactionDetailWebView get transactionDetail => _transactionDetail;

  InWebViewRequest(TransactionDetailWebView transactionDetail) {
    _transactionDetail = transactionDetail;
    _enablePayment = [
      "credit_card",
    ];
  }

  InWebViewRequest.fromJson(dynamic json) {
    _enablePayment = json["enabled_payments"];
    _transactionDetail =
        TransactionDetailWebView.fromJson(json["transaction_details"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["enabled_payments"] = _enablePayment;
    map["transaction_details"] = _transactionDetail;

    return map;
  }
}

class TransactionDetailWebView {
  String _orderID;
  int _grossAmount;

  String get orderID => _orderID;
  int get grossAmount => _grossAmount;

  TransactionDetailWebView({String orderID, int grossAmount}) {
    _orderID = orderID;
    _grossAmount = grossAmount;
  }

  TransactionDetailWebView.fromJson(dynamic json) {
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
