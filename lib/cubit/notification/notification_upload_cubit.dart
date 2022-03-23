// import 'package:bloc/bloc.dart';
// import 'package:enforcea/model/response/upload_list_response.dart';
// import 'package:enforcea/model/response/upload_response.dart';
// import 'package:enforcea/repository/notification_repository.dart';
// import 'package:enforcea/model/request/notification_upload_request.dart';
// import 'package:meta/meta.dart';

// part 'notification_upload_state.dart';

// class NotificationUploadCubit extends Cubit<NotificationUploadState> {
//   final NotificationRepo _notifRepository;

//   NotificationUploadCubit(this._notifRepository)
//       : super(NotificationUploadInitial());

//   Future<void> postNotificationFIle(NotificationUpload payload, int id) async {
//     try {
//       emit(new NotificationUploadLoading());
//       final taxData = await _notifRepository.postNotification(payload, id);
//       emit(new NotificationUploadLoaded(taxData));
//     } catch (e) {
//       emit(new NotificationUploadError(e.toString()));
//     }
//   }
// }
