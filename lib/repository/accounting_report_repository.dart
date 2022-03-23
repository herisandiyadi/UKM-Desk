import 'dart:convert';

import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/accounting_report_response.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'network_exception.dart';

abstract class IAccountingReportRepository {
  Future<AccountingReportResponse> getAccountingReport();

  Future<String> downloadAccountingReport(int accountReportId);
}

class AccountingReportRepository implements IAccountingReportRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<AccountingReportResponse> getAccountingReport() async {
    final response = await _helper.get(
        "accounting_report", await CacheUtil.getString(CACHE_TOKEN));
    return AccountingReportResponse.fromJson(response);
  }

  @override
  Future<String> downloadAccountingReport(int accountReportId) async {
//    final response = await _helper.get(
//        "accounting_report_download?id_account_report=" + accountReportId.toString(),
//        await CacheUtil.getString(CACHE_TOKEN));
    final url = BASE_URL + "accounting_report_download?id_account_report="+ accountReportId.toString();
    final Map<String, String> header = {
      'Authorization': 'bearer ' + await CacheUtil.getString(CACHE_TOKEN)
    };

    print("GET ==> " + url + header.toString());

    final response = await http.get(url, headers: header);
    print("GET <== " +
        response.statusCode.toString() +
        " " +
        url +
        ":" +
        response.body);
    final Map<String, dynamic> parsed = json.decode(response.body);
    if (response.statusCode == 200) {
      print("json Decode:" + parsed["success"].toString());
      final bool isSuccess = parsed["success"];
      if (!isSuccess) {
        throw NetworkException(parsed["message"]);
      }
      return response.body;
    }
    throw NetworkException(parsed["message"]);
  }
}
