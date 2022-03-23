import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/faq_response.dart';
import 'package:enforcea/util/cache_util.dart';

import '../constants.dart';

abstract class _IFAQRepository {
  Future<FaqResponse> getFAQ();
}

class FAQRepository implements _IFAQRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<FaqResponse> getFAQ() async {
    final response =
    await _helper.get("faq_dashboard", await CacheUtil.getString(CACHE_TOKEN));
    return FaqResponse.fromJson(response);
  }
}