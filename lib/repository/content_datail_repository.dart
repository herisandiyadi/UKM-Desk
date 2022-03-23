import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/content_detail_response.dart';

import 'package:enforcea/util/cache_util.dart';

abstract class _IContentDetailRepository {
  Future<ContentDetailResponse> getContentDetailNews(int id); //flash
  Future<ContentDetailResponse> getContentDetailInsight(int id); //article
  Future<ContentDetailResponse> getContentDetailTaxNews(int id); //Tax Nes
}

class ContentDetailRepository implements _IContentDetailRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<ContentDetailResponse> getContentDetailNews(int id) async {
    final response =
        await _helper.get("news_detail?id_news=" + id.toString(), "");
    return ContentDetailResponse.fromJson(response);
  }

  @override
  Future<ContentDetailResponse> getContentDetailInsight(int id) async {
    final response =
        await _helper.get("insight_detail?id_insight=" + id.toString(), "");
    return ContentDetailResponse.fromJson(response);
  }

  @override
  Future<ContentDetailResponse> getContentDetailTaxNews(int id) async {
    final response =
        await _helper.get("tax_news_detail?id_tax_news=" + id.toString(), "");
    return ContentDetailResponse.fromJson(response);
  }
}
