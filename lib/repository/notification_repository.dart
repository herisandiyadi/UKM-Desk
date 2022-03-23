import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/notification_response.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/model/request/notification_upload_request.dart';
import 'package:enforcea/model/response/upload_response.dart';
import 'package:enforcea/model/response/history_response.dart';
import 'dart:convert';

import '../constants.dart';

abstract class _INotificationRepo {
  Future<NotificationResponse> getNotification();
  Future<UploadResponse> postNotification(NotificationUpload request, int id);
}

class NotificationRepo implements _INotificationRepo {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<NotificationResponse> getNotification() async {
    final response =
        await _helper.get("notifikasi", await CacheUtil.getString(CACHE_TOKEN));
    print(response);
    return NotificationResponse.fromJson(response);
  }

  @override
  Future<UploadResponse> postNotification(
      NotificationUpload request, int id) async {
    final body = jsonEncode(<String, String>{
      'nama_file': request.name_file,
      'doc_upload': request.doc_upload
    });

    final response = await _helper.post(
        "notifikasi_upload?id_notifikasi=" + id.toString(),
        await CacheUtil.getString(CACHE_TOKEN),
        body);
    print(response);
    return UploadResponse.fromJson(response);
  }

  @override
  Future<NotificationResponse> getHistory() async {
    final response = await _helper.get(
        "history_transaksi", await CacheUtil.getString(CACHE_TOKEN));
    return NotificationResponse.fromJson(response);
  }
}
