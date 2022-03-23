import 'package:bloc/bloc.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/video_repository.dart';
import 'package:meta/meta.dart';
import 'package:enforcea/model/response/home/video_response.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoRepository _videoRepository;

  VideoCubit(this._videoRepository) : super(VideoInitial());

  Future<void> VideoPodcast(int pageID) async {
    try {
      emit(new VideoLoading());
      final videoData = await _videoRepository.getVideoList(pageID);
      final podcastData = await _videoRepository.getPodcastList(pageID);
      emit(new VideoPodcastLoaded(videoData, podcastData));
    } on NetworkException catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<void> Video(int pageID) async {
    try {
      emit(new VideoLoading());
      final videoData = await _videoRepository.getVideoList(pageID);
      emit(new VideoLoaded(videoData));
    } on NetworkException catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<void> Podcast(int pageID) async {
    try {
      emit(new VideoLoading());
      final videoData = await _videoRepository.getPodcastList(pageID);
      emit(new VideoLoaded(videoData));
    } on NetworkException catch (e) {
      emit(VideoError(e.toString()));
    }
  }
}
