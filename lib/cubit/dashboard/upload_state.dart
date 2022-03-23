part of 'upload_cubit.dart';

@immutable
abstract class UploadState {
  const UploadState();
}

class UploadInitial extends UploadState {
  const UploadInitial();
}

class UploadLoading extends UploadState {
  const UploadLoading();
}

class UploadLoaded extends UploadState {
  final UploadResponse UploadData;
  const UploadLoaded(this.UploadData);
}

class UploadError extends UploadState {
  final String message;

  const UploadError(this.message);
}
