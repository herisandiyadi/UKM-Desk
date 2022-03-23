class VAResponse {
  String _statusCode;
  String _statusMessage;
  String _transactionID;
  String _orderID;
  String _grossAmount;
  String _paymentType;
  String _transactionTime;
  String _transactionStatus;
  String _fraudStatus;
  String _currency;
  List<VANumber> _vaNumber;

  String get statusCode => _statusCode;
  String get statusMessage => _statusMessage;
  String get transactionID => _transactionID;
  String get orderID => _orderID;
  String get grossAmount => _grossAmount;
  String get paymentType => _paymentType;
  String get transactionTime => _transactionTime;
  String get transactionStatus => _transactionStatus;
  String get froudStatus => _fraudStatus;
  String get currency => _currency;
  List<VANumber> get vaNumber => _vaNumber;

  VAResponse(
      {String statusCode,
      String statusMessage,
      String transactionID,
      String orderID,
      String grossAmount,
      String paymentType,
      String transactionTime,
      String transactionStatus,
      String fraudStatus,
      String currency,
      List<VANumber> vaNumber}) {
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _transactionID = transactionID;
    _orderID = orderID;
    _grossAmount = grossAmount;
    _paymentType = paymentType;
    _transactionTime = transactionStatus;
    _transactionStatus = transactionStatus;
    _fraudStatus = fraudStatus;
    _currency = currency;
    _vaNumber = vaNumber;
  }

  VAResponse.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _statusMessage = json["status_message"];
    _transactionID = json["transaction_id"];
    _orderID = json["order_id"];
    _grossAmount = json["gross_amount"];
    _paymentType = json["payment_type"];
    _transactionTime = json["transaction_time"];
    _transactionStatus = json["transaction_status"];
    _fraudStatus = json["fraud_status"];
    _currency = json["currency"];
    _vaNumber = [];

    if (_paymentType == "echannel") {
      _vaNumber.add(VANumber(
          bank: "mandiri",
          vaNumber: json["bill_key"],
          billerCode: json["biller_code"]));
    } else if (json["va_numbers"] != null) {
      json["va_numbers"].forEach((v) {
        _vaNumber.add(VANumber.fromJson(v));
      });
    } else if (_paymentType == "cstore") {
      _vaNumber
          .add(VANumber(bank: json["store"], vaNumber: json["payment_code"]));
    } else if (json["permata_va_number"] != null) {
      _vaNumber
          .add(VANumber(bank: "permata", vaNumber: json["permata_va_number"]));
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["status_message"] = _statusMessage;
    map["transaction_id"] = _transactionID;
    map["order_id"] = _orderID;
    map["gross_amount"] = _grossAmount;
    map["payment_type"] = _paymentType;
    map["transaction_time"] = _transactionTime;
    map["transaction_status"] = _transactionStatus;
    map["fraud_status"] = _fraudStatus;
    map["currency"] = _currency;
    map["va_numbers"] = _vaNumber;
    return map;
  }
}

/// id : 1
/// question : "Apa yang dapat saya lihat dari halaman Dashboard?"
/// answer : "Melalui halaman Dashboard, Anda akan mendapatkan Laporan Pajak dan Laporan Pembukuan perusahaan Anda setiap bulan. Selain itu, Anda dapat melihat Frequently Asked Question untuk memandu Anda."

class VANumber {
  String _bank;
  String _billerCode;
  String _vaNumber;

  String get bank => _bank;
  String get vaNumber => _vaNumber;
  String get billerCode => _billerCode;

  VANumber({String bank, String vaNumber, String billerCode}) {
    _bank = bank;
    _vaNumber = vaNumber;
    _billerCode = billerCode;
  }

  VANumber.fromJson(dynamic json) {
    _bank = json["bank"];
    _vaNumber = json["va_number"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bank"] = _bank;
    map["va_number"] = _vaNumber;
    return map;
  }
}
