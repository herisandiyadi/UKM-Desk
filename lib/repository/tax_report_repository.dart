import 'dart:convert';

import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/tax_report_response.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'network_exception.dart';

abstract class ITaxReportRepository {
  Future<TaxReportResponse> getTaxReport();

  Future<String> downloadTaxReport(int taxReportId);
}

class TaxReportRepository implements ITaxReportRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<TaxReportResponse> getTaxReport() async {
    final response =
        await _helper.get("tax_report", await CacheUtil.getString(CACHE_TOKEN));
    return TaxReportResponse.fromJson(response);
  }

  @override
  Future<String> downloadTaxReport(int taxReportId) async {
    final url = BASE_URL + "tax_report_download?id_tax_report="+ taxReportId.toString();
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
