part of 'content_detail_cubit.dart';

@immutable
abstract class ContentDetailState {
  const ContentDetailState();
}

class ContentInitial extends ContentDetailState {
  const ContentInitial();
}

class UpdateLoading extends ContentDetailState {
  const UpdateLoading();
}

class UpdateLoaded extends ContentDetailState {
  final bool isSuccess;

  const UpdateLoaded(this.isSuccess);
}

class ContentLoading extends ContentDetailState {
  const ContentLoading();
}

class ContentLoaded extends ContentDetailState {
  final ContentDetailResponse contentData;

  const ContentLoaded(this.contentData);
}

class ContentError extends ContentDetailState {
  final String message;

  const ContentError(this.message);
}
