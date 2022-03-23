import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/home/video_response.dart';

abstract class _IVideoRepository {
  Future<VideoResponse> getVideoList(int pageID);
  Future<VideoResponse> getPodcastList(int pageID);
}

class VideoRepository implements _IVideoRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<VideoResponse> getVideoList(int pageID) async {
    final response =
        await _helper.get("list_video?pages=" + pageID.toString(), "");
    print(response);
    return VideoResponse.fromJson(response);
  }

  @override
  Future<VideoResponse> getPodcastList(int pageID) async {
    final response =
        await _helper.get("list_podcast?pages=" + pageID.toString(), "");
    return VideoResponse.fromJson(response);
  }
}
