import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/notification_response.dart';
import 'package:enforcea/repository/notification_repository.dart';
import 'package:enforcea/model/request/notification_upload_request.dart';
import 'package:enforcea/model/response/upload_response.dart';
import 'package:enforcea/model/response/history_response.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notifRepository;

  NotificationCubit(this._notifRepository) : super(NotificationInitial());

  Future<void> getNotificationPage() async {
    try {
      emit(new NotificationLoading());
      final taxData = await _notifRepository.getNotification();
      emit(new NotificationLoaded(taxData));
    } catch (e) {
      emit(new NotificationError(e.toString()));
    }
  }

  Future<void> postNotificationFIle(NotificationUpload payload, int id) async {
    try {
      emit(new NotificationUploadLoading());
      final taxData = await _notifRepository.postNotification(payload, id);
      emit(new NotificationUploadLoaded(taxData));
    } catch (e) {
      emit(new NotificationError(e.toString()));
    }
  }

  Future<void> getHistory() async {
    try {
      emit(new NotificationUploadLoading());
      final historyData = await _notifRepository.getHistory();
      emit(new HistoryLoaded(historyData));
    } on NotificationError catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
