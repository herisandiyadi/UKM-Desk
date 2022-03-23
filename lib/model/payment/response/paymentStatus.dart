class PaymentStatusFromBE {
  bool _success;
  PaymentStatus _data;

  bool get success => _success;
  PaymentStatus get data => _data;

  PaymentStatusFromBE.fromJson(dynamic json) {
    _success = json["success"];
    _data = PaymentStatus.fromJson(json["data"]);
  }
}

class PaymentStatus {
  String _transactionTime;
  String _grossAmount;
  String _currency;
  String _orderID;
  String _paymentType;
  String _signatureKey;
  String _statusCode;
  String _transcationStatus;
  String _bank;
  String _channelResponseMessage;
  String _cardType;
  String _store;
  List<VaNumber> _vaNumber;

  String get transactionTime => _transactionTime;
  String get grossAmount => _grossAmount;
  String get currency => _currency;
  String get orderID => _orderID;
  String get paymentType => _paymentType;
  String get signatureKey => _signatureKey;
  String get transactionStatus => _transcationStatus;
  String get bank => _bank;
  String get channelResponseMessage => _channelResponseMessage;
  String get cardType => _cardType;
  String get store => _store;
  List<VaNumber> get vaNumber => _vaNumber;
  String get statusCode => _statusCode;

  PaymentStatus.fromJson(dynamic json) {
    _transactionTime = json["transaction_time"];
    _grossAmount = json["gross_amount"];
    _currency = json["currency"];
    _orderID = json["order_id"];
    _paymentType = json["payment_type"];
    _signatureKey = json["signature_key"];
    _statusCode = json["status_code"];
    _transcationStatus = json["transaction_status"];
    _channelResponseMessage = json["channel_response_message"];
    _cardType = json["card_type"];
    _store = json["store"];
    if (_paymentType == 'cstore') {
      _vaNumber = [];
      _vaNumber.add(VaNumber(json["store"], json["payment_code"], ""));
    } else if (_paymentType == 'bank_transfer') {
      _vaNumber = [];

      if (json["permata_va_number"] != "" &&
          json["permata_va_number"] != null) {
        _vaNumber.add(VaNumber("permata", json["permata_va_number"], ""));
      } else {
        json["va_numbers"].forEach((v) {
          _vaNumber.add(VaNumber.fromJson(v));
        });
      }
    } else if (_paymentType == 'echannel' && json["bill_key"] != "") {
      _vaNumber = [];
      _vaNumber.add(VaNumber("mandiri", json["bill_key"], json["biller_code"]));
    } else {
      _bank = json["bank"];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["transaction_time"] = _transactionTime;
    map["gross_amount"] = _grossAmount;
    map["currency"] = _currency;
    map["order_id"] = _orderID;
    map["payment_type"] = _paymentType;
    map["signature_key"] = _signatureKey;
    map["status_code"] = _statusCode;
    map["transaction_status"] = _transcationStatus;
    map["bank"] = _bank;
    map["channel_response_message"] = _channelResponseMessage;
    map["card_type"] = _cardType;

    return map;
  }
}

class VaNumber {
  String _bank;
  String _vaNumber;
  String _billerCode;

  String get bank => _bank;
  String get vaNumber => _vaNumber;
  String get billerCode => _billerCode;

  VaNumber(String bank, String vaNumber, String billerCode) {
    _bank = bank;
    _vaNumber = vaNumber;
    _billerCode = billerCode;
  }

  VaNumber.fromJson(dynamic json) {
    _bank = json["bank"];
    _vaNumber = json["va_number"];
  }
}
