part of 'upload_list_cubit.dart';

@immutable
abstract class UploadListState {
  const UploadListState();
}

class UploadListInitial extends UploadListState {
  const UploadListInitial();
}

class UploadListLoading extends UploadListState {
  const UploadListLoading();
}

class DownloadLoading extends UploadListState {
  const DownloadLoading();
}

class UploadListLoaded extends UploadListState {
  final UploadListResponse UploadList;
  const UploadListLoaded(this.UploadList);
}

class DownloadLoaded extends UploadListState {
  final String downloadData;

  const DownloadLoaded(this.downloadData);
}

class UploadListError extends UploadListState {
  final String message;

  const UploadListError(this.message);
}
