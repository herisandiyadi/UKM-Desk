



import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/history_response.dart';
import 'package:enforcea/util/cache_util.dart';

import '../constants.dart';

abstract class _IHistoryRepository {
  Future<HistoryResponse> getHistory();
}

class HistoryRepository implements _IHistoryRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<HistoryResponse> getHistory() async {
    final response =
    await _helper.get("history_transaksi", await CacheUtil.getString(CACHE_TOKEN));
    return HistoryResponse.fromJson(response);
  }
}