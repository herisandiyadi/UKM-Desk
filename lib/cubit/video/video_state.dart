part of 'video_cubit.dart';

@immutable
abstract class VideoState {
  const VideoState();
}

class VideoInitial extends VideoState {
  const VideoInitial();
}

class UpdateLoading extends VideoState {
  const UpdateLoading();
}

class UpdateLoaded extends VideoState {
  final bool isSuccess;

  const UpdateLoaded(this.isSuccess);
}

class VideoLoading extends VideoState {
  const VideoLoading();
}

class VideoLoaded extends VideoState {
  final VideoResponse videoData;

  const VideoLoaded(this.videoData);
}

class VideoPodcastLoaded extends VideoState {
  final VideoResponse vData;
  final VideoResponse pData;

  const VideoPodcastLoaded(this.vData, this.pData);
}

class VideoError extends VideoState {
  final String message;

  const VideoError(this.message);
}
