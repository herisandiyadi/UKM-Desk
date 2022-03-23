import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/template_response.dart';
import 'package:enforcea/util/cache_util.dart';
import '../constants.dart';

abstract class _ITemplateRepository {
  Future<TemplateResponse> fetchTemplate();
  Future<dynamic> downloadReport(int taxReportId);
}

class TemplateRepository implements _ITemplateRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<TemplateResponse> fetchTemplate() async {
    final response =
        await _helper.get("template", await CacheUtil.getString(CACHE_TOKEN));
    return TemplateResponse.fromJson(response);
  }

  @override
  Future<dynamic> downloadReport(int taxReportId) async {
    final response = await _helper.get(
        "template_download?id_template=" + taxReportId.toString(),
        await CacheUtil.getString(CACHE_TOKEN));
    return response;
  }
}
