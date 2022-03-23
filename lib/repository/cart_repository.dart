import 'dart:convert';

import 'package:enforcea/model/request/payment_request.dart';
import 'package:enforcea/model/request/cart_payment_reqest.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/model/response/upload_response.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:http/http.dart' as http;
import 'package:enforcea/api_helper/apiBaseHelper.dart';

import '../constants.dart';
import 'network_exception.dart';

abstract class ICartRepository {
  Future<PaymentResponse> checkPayment(
      PaymentRequest request, String voucherCode);
  Future<UploadResponse> chartPayment(CartPaymentRequest request);
  Future<PaymentResponse> checkVoucher(
      PaymentRequest request, String voucherCode);
  Future<bool> updatePayment(String orderID, int paymentMethod);
  Future<bool> cancelPayment(String orderID);
}

class CartRepository implements ICartRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  @override
  Future<PaymentResponse> checkPayment(
      PaymentRequest request, String voucherCode) async {
    final Map<String, String> header = {
      'Authorization': 'bearer ' + await CacheUtil.getString(CACHE_TOKEN)
    };
    final url = BASE_URL +
        "cek_payment_term?payment_term=fullpayment&kode_promo=" +
        voucherCode;
    print("=>" + url + ":" + jsonEncode(request));
    final response = await http.post(
      url,
      headers: header,
      body: jsonEncode(request),
    );
    print("=> " +
        response.statusCode.toString() +
        " " +
        url +
        ":" +
        response.body);
    final Map<String, dynamic> parsed = json.decode(response.body);
    if (response.statusCode == 200 && parsed['success'] == true) {
      return PaymentResponse.fromJson(json.decode(response.body.toString()));
    }

    throw NetworkException(parsed['message']);
  }

  @override
  Future<UploadResponse> chartPayment(CartPaymentRequest request) async {
    final listData = List();
    for (final reqData in request.dataProduk) {
      Map<String, dynamic> data = {
        "id_produk": reqData.idProduk,
        "produk_name": reqData.productName,
        "harga": reqData.harga,
        "qty": reqData.qty,
        "date": reqData.date,
        "total": reqData.total,
      };
      listData.add(data);
    }

    final body = jsonEncode(<String, dynamic>{
      "kode_promo": request.kodePromo,
      "sub_total": request.subTotal,
      "nilai_promo": request.nilaiPromo,
      "diskon": request.diskon,
      "data_produk": listData,
      "id_payment": request.paymentID,
      "payment_method": request.paymentMethod
    });
    final response = await _helper.post(
        "payment", await CacheUtil.getString(CACHE_TOKEN), body);
    return UploadResponse.fromJson(response);
  }

  @override
  Future<PaymentResponse> checkVoucher(
      PaymentRequest request, String voucherCode) async {
    final Map<String, String> header = {
      'Authorization': 'bearer ' + await CacheUtil.getString(CACHE_TOKEN)
    };
    print(header);
    final url =
        BASE_URL + "promo?payment_term=fullpayment&kode_promo=" + voucherCode;
    print("=>" + url + ":" + jsonEncode(request));
    final response = await http.post(
      url,
      headers: header,
      body: jsonEncode(request),
    );
    print("=> " +
        response.statusCode.toString() +
        " " +
        url +
        ":" +
        response.body);
    final Map<String, dynamic> parsed = json.decode(response.body);
    if (response.statusCode == 200) {
      return PaymentResponse.fromJson(json.decode(response.body.toString()));
    }

    throw NetworkException(parsed['message']);
  }

  @override
  Future<bool> updatePayment(String orderID, int paymentMethod) async {
    final url = "update_payment_method?id_payment=" +
        orderID +
        "&payment_method=" +
        paymentMethod.toString();

    final response =
        await _helper.get(url, await CacheUtil.getString(CACHE_TOKEN));

    if (!response['success']) {
      throw NetworkException(response['message']);
    }
    return response['success'];
  }

  @override
  Future<bool> cancelPayment(String orderID) async {
    final url = "cancel_order?id_payment=" + orderID;

    final response =
        await _helper.get(url, await CacheUtil.getString(CACHE_TOKEN));
    return response['success'];
  }
}
