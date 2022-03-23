import 'dart:convert';
import 'dart:io';

import 'package:enforcea/model/payment/request/virtualAccount.dart';
import 'package:enforcea/model/payment/request/store.dart';
import 'package:enforcea/model/payment/response/virtualAccount.dart';
import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/payment/response/inWebView.dart';
import 'package:enforcea/model/payment/request/inWebView.dart';
import 'package:enforcea/model/payment/response/paymentStatus.dart';
import 'package:enforcea/model/payment/response/snap.dart';
import 'package:enforcea/model/payment/request/snap.dart';
import 'package:enforcea/util/cache_util.dart';
import 'dart:convert';

import '../../constants.dart';
import '../network_exception.dart';

abstract class IVARepository {
  Future<VAResponse> checkPayment(VitualAccountRequest request);
  Future<VAResponse> checkPaymentStore(StoreRequest request);
  Future<InWebViewResponse> checkPaymentInWebView(InWebViewRequest request);
  Future<PaymentStatus> checkPaymentStatus(String kodeTransaksi);
  Future<SnapResponse> midtransToken(SnapRequest snapReq);
}

class VARepository implements IVARepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  @override
  Future<VAResponse> checkPayment(VitualAccountRequest request) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final Map<String, String> header = {
      'Accept': 'application/json',
      'Authorization': 'Basic ' + stringToBase64.encode(SERVER_KEY),
      'Content-Type': 'application/json'
    };

    var client = HttpClient();
    var reqClient = await client.postUrl(Uri.parse(MIDTRANS_URL));
    reqClient.headers.set('content-type', 'application/json;');
    reqClient.headers.add(
      'Accept',
      'application/json',
    );
    reqClient.headers.add(
      'authorization',
      'Basic ' + stringToBase64.encode(SERVER_KEY),
    );
    reqClient.add(utf8.encode(jsonEncode(request)));
    var response = await reqClient.close();
    var reply = await response.transform(utf8.decoder).join();
    print(reply);
    client.close();
    final Map<String, dynamic> parsed = json.decode(reply);
    if (response.statusCode == 200) {
      return VAResponse.fromJson(json.decode(reply.toString()));
    }

    throw NetworkException(parsed['message']);
  }

  @override
  Future<VAResponse> checkPaymentStore(StoreRequest request) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final Map<String, String> header = {
      'Accept': 'application/json',
      'Authorization': 'Basic ' + stringToBase64.encode(SERVER_KEY),
      'Content-Type': 'application/json'
    };

    var client = HttpClient();
    var reqClient = await client.postUrl(Uri.parse(MIDTRANS_URL));
    reqClient.headers.set('content-type', 'application/json;');
    reqClient.headers.add(
      'Accept',
      'application/json',
    );
    reqClient.headers.add(
      'authorization',
      'Basic ' + stringToBase64.encode(SERVER_KEY),
    );
    reqClient.add(utf8.encode(jsonEncode(request)));
    var response = await reqClient.close();
    var reply = await response.transform(utf8.decoder).join();
    print(reply);
    client.close();
    final Map<String, dynamic> parsed = json.decode(reply);
    if (response.statusCode == 200) {
      return VAResponse.fromJson(json.decode(reply.toString()));
    }

    throw NetworkException(parsed['message']);
  }

  @override
  Future<InWebViewResponse> checkPaymentInWebView(
      InWebViewRequest request) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final Map<String, String> header = {
      'Accept': 'application/json',
      'Authorization': 'Basic ' + stringToBase64.encode(SERVER_KEY),
      'Content-Type': 'application/json'
    };

    var client = HttpClient();
    var reqClient = await client.postUrl(Uri.parse(MIDTRANS_SNAP_URL));
    reqClient.headers.set('content-type', 'application/json;');
    reqClient.headers.add(
      'Accept',
      'application/json',
    );
    reqClient.headers.add(
      'authorization',
      'Basic ' + stringToBase64.encode(SERVER_KEY),
    );
    reqClient.add(utf8.encode(jsonEncode(request)));
    var response = await reqClient.close();
    var reply = await response.transform(utf8.decoder).join();
    print(reply);
    client.close();
    final Map<String, dynamic> parsed = json.decode(reply);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return InWebViewResponse.fromJson(json.decode(reply.toString()));
    }

    throw NetworkException(parsed['message']);
  }

  @override
  Future<PaymentStatus> checkPaymentStatus(String kodeTransaksi) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final Map<String, String> header = {
      'Accept': 'application/json',
      'Authorization': 'Basic ' + stringToBase64.encode(SERVER_KEY),
      'Content-Type': 'application/json'
    };

    var client = HttpClient();
    var reqClient = await client.getUrl(Uri.parse(
        BASE_URL + "transaksi_status?transaction_id=" + kodeTransaksi));
    reqClient.headers.set('content-type', 'application/json;');
    reqClient.headers.add(
      'Accept',
      'application/json',
    );
    var response = await reqClient.close();
    var reply = await response.transform(utf8.decoder).join();
    print(reply);
    client.close();
    final Map<String, dynamic> parsed = json.decode(reply);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var resp = PaymentStatusFromBE.fromJson(json.decode(reply.toString()));
      return resp.data;
    }

    throw NetworkException(parsed['message']);
  }

  @override
  Future<SnapResponse> midtransToken(SnapRequest snapReq) async {
    final url = "midtrans_token?user_id=" +
        snapReq.userID +
        "&code=" +
        snapReq.code +
        "&total=" +
        snapReq.total;

    final response =
        await _helper.get(url, await CacheUtil.getString(CACHE_TOKEN));
    return SnapResponse.fromJson(response);
  }
}
