import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/home/video_response.dart';

import 'package:enforcea/util/cache_util.dart';

abstract class _IPodcastRepository {
  Future<VideoResponse> getPodcastList();
}

class PodcastRepository implements _IPodcastRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<VideoResponse> getPodcastList() async {
    final response = await _helper.get("podcast_banner", "");
    return VideoResponse.fromJson(response);
  }
}
