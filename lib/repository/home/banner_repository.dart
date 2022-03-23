import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/home/banner_response.dart';
import 'package:enforcea/model/response/home/video_response.dart';
import 'package:enforcea/model/response/home/renewal_response.dart';
import 'package:enforcea/model/response/home/mont_left_response.dart';
import 'package:enforcea/model/response/home/content_response.dart';

import 'package:enforcea/util/cache_util.dart';

import '../../constants.dart';

abstract class _IBannerRepository {
  Future<ContentResponse> getBannerList(int pageID);
  Future<ContentResponse> getArticleList(int pageID);
  Future<ContentResponse> getNewsList(int pageID);
  Future<VideoResponse> getVideoList();
  Future<RenewalResponse> getRenewalPack();
  Future<MonthLeftResponse> getMonthLeft();
}

class BannerRepository implements _IBannerRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<ContentResponse> getBannerList(int pageID) async {
    final response =
        await _helper.get("news_list?pages=" + pageID.toString(), "");

    return ContentResponse.fromJson(response);
  }

  @override
  Future<ContentResponse> getNewsList(int pageID) async {
    final response =
        await _helper.get("tax_news_list?pages=" + pageID.toString(), "");

    return ContentResponse.fromJson(response);
  }

  @override
  Future<ContentResponse> getArticleList(int pageID) async {
    final response =
        await _helper.get("insight_list?pages=" + pageID.toString(), "");
    return ContentResponse.fromJson(response);
  }

  @override
  Future<VideoResponse> getVideoList() async {
    final response = await _helper.get("video_banner", "");
    return VideoResponse.fromJson(response);
  }

  @override
  Future<RenewalResponse> getRenewalPack() async {
    final token = await CacheUtil.getString(CACHE_TOKEN);

    if (token != null) {
      final response = await _helper.get("renew", token);
      return RenewalResponse.fromJson(response);
    }
    return null;
  }

  @override
  Future<MonthLeftResponse> getMonthLeft() async {
    final token = await CacheUtil.getString(CACHE_TOKEN);

    if (token != null) {
      final response = await _helper.get("month_left", token);
      return MonthLeftResponse.fromJson(response);
    }
    return null;
  }
}
