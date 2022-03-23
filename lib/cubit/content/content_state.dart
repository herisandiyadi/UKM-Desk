part of 'content_cubit.dart';

@immutable
abstract class ContentState {
  const ContentState();
}

class ContentInitial extends ContentState {
  const ContentInitial();
}

class UpdateLoading extends ContentState {
  const UpdateLoading();
}

class UpdateLoaded extends ContentState {
  final bool isSuccess;

  const UpdateLoaded(this.isSuccess);
}

class ContentLoading extends ContentState {
  const ContentLoading();
}

class ContentLoaded extends ContentState {
  final ContentResponse contentData;

  const ContentLoaded(this.contentData);
}


class ContentError extends ContentState {
  final String message;

  const ContentError(this.message);
}
