import 'dart:convert';
import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/download_book_response.dart';
import '../constants.dart';

abstract class IEbookTemplateRepository {
  Future<DownloadEbookResponse> getFileList();
  Future<String> downloadFileEbook(int id);
  Future<String> downloadFileTemplate(int id);
}

class EbookTemplateRepository implements IEbookTemplateRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<DownloadEbookResponse> getFileList() async {
    final response = await _helper.get("ebook_template", "");
    return DownloadEbookResponse.fromJson(response);
  }

  @override
  Future<String> downloadFileEbook(int id) async {
    final response = await _helper.get("ebook_download/" + id.toString(), "");
    final bool isSuccess = response["success"];
    if (!isSuccess) {
      return null;
    }
    print(response["data"]['file']);
    return response["data"]['file'];
  }

  @override
  Future<String> downloadFileTemplate(int id) async {
    final response =
        await _helper.get("template_download/" + id.toString(), "");
    final bool isSuccess = response["success"];
    if (!isSuccess) {
      return null;
    }
    return response["data"]['file'];
  }
}
