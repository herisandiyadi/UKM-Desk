import 'dart:convert';
import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/upload_list_response.dart';
import 'package:enforcea/util/cache_util.dart';
import 'network_exception.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

abstract class IUploadListRepository {
  Future<UploadListResponse> getUploadList(int pages, String key);
  Future<String> downloadFile(int taxReportId);
}

class UploadListRepository implements IUploadListRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<UploadListResponse> getUploadList(int pages, String key) async {
    final response = await _helper.get(
        "upload_list?pages=" + pages.toString() + "&search=" + key,
        await CacheUtil.getString(CACHE_TOKEN));
    print(response);
    return UploadListResponse.fromJson(response);
  }

  @override
  Future<String> downloadFile(int taxReportId) async {
    final url =
        BASE_URL + "download_data_upload?id_raw_data=" + taxReportId.toString();
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
