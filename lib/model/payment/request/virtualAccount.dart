class VitualAccountRequest {
  String _paymentType;
  TransactionDetail _transactionDetail;
  BankTransfer _bankTransfer;
  Echannel _echannel;

  String get paymentType => _paymentType;
  TransactionDetail get transactionDetail => _transactionDetail;
  BankTransfer get bankTransfer => _bankTransfer;

  VitualAccountRequest(String paymentType, TransactionDetail transactionDetail,
      BankTransfer bankTransfer) {
    _paymentType = paymentType;
    _transactionDetail = transactionDetail;
    if (paymentType != "echannel" && paymentType != "permata") {
      _bankTransfer = bankTransfer;
    } else if (paymentType == "echannel") {
      _echannel = Echannel(billInfo1: "Enforcea", billInfo2: "VA");
    }
  }

  VitualAccountRequest.fromJson(dynamic json) {
    _paymentType = json["payment_type"];
    if (_paymentType != "echannel" && _paymentType != "permata") {
      _bankTransfer = BankTransfer.fromJson(json["bank_transfer"]);
    }
    _transactionDetail =
        TransactionDetail.fromJson(json["transaction_details"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["payment_type"] = _paymentType;
    map["transaction_details"] = _transactionDetail;
    if (_paymentType != "echannel" && _paymentType != "permata") {
      map["bank_transfer"] = _bankTransfer;
    } else {
      map["echannel"] = _echannel;
    }

    return map;
  }
}

class BankTransfer {
  String _bank;

  String get bank => _bank;

  BankTransfer({String bank}) {
    _bank = bank;
  }

  BankTransfer.fromJson(dynamic json) {
    _bank = json["bank"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bank"] = _bank;
    return map;
  }
}

class TransactionDetail {
  String _orderID;
  int _grossAmount;

  String get orderID => _orderID;
  int get grossAmount => _grossAmount;

  TransactionDetail({String orderID, int grossAmount}) {
    _orderID = orderID;
    _grossAmount = grossAmount;
  }

  TransactionDetail.fromJson(dynamic json) {
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

class Echannel {
  String _billInfo1;
  String _billInfo2;

  String get billInfo1 => _billInfo1;
  String get billInfo2 => _billInfo2;

  Echannel({String billInfo1, String billInfo2}) {
    _billInfo1 = billInfo1;
    _billInfo2 = billInfo2;
  }

  Echannel.fromJson(dynamic json) {
    _billInfo1 = json["bill_info1"];
    _billInfo2 = json["bill_info2"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bill_info1"] = _billInfo1;
    map["bill_info2"] = _billInfo2;
    return map;
  }
}
