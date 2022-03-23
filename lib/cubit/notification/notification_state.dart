part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationUploadLoading extends NotificationState {
  const NotificationUploadLoading();
}

class DownloadLoading extends NotificationState {
  const DownloadLoading();
}

class NotificationLoaded extends NotificationState {
  final NotificationResponse notifData;
  const NotificationLoaded(this.notifData);
}

class HistoryLoaded extends NotificationState {
  final NotificationResponse historyData;

  const HistoryLoaded(this.historyData);
}

class NotificationUploadLoaded extends NotificationState {
  final UploadResponse notifData;
  const NotificationUploadLoaded(this.notifData);
}

class DownloadLoaded extends NotificationState {
  final String downloadData;

  const DownloadLoaded(this.downloadData);
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);
}

class NotificationUploadError extends NotificationState {
  final String message;

  const NotificationUploadError(this.message);
}
