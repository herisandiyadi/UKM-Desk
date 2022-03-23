import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/upload_response.dart';
import 'package:enforcea/model/request/upload_request.dart';
import 'package:enforcea/util/cache_util.dart';
import 'dart:convert';
import '../constants.dart';

abstract class _IUploadRepository {
  Future<UploadResponse> postUpload(UploadFile request);
}

class UploadRepository implements _IUploadRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<UploadResponse> postUpload(UploadFile request) async {
    final body = jsonEncode(<String, String>{
      'type': request.type,
      'period': request.period,
      'name_file': request.name_file,
      'doc_upload': request.doc_upload
    });
    final response = await _helper.post(
        "upload_data", await CacheUtil.getString(CACHE_TOKEN), body);
    return UploadResponse.fromJson(response);
  }
}
