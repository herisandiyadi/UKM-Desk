import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/upload_response.dart';
import 'package:enforcea/repository/upload_file_repository.dart';
import 'package:enforcea/model/request/upload_request.dart';
import 'package:meta/meta.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final UploadRepository _uploadRepositoru;

  UploadCubit(this._uploadRepositoru) : super(UploadInitial());

  Future<void> uploadFile(UploadFile request) async {
    try {
      emit(new UploadLoading());
      final taxData = await _uploadRepositoru.postUpload(request);
      emit(new UploadLoaded(taxData));
    } catch (e) {
      emit(new UploadError(e.toString()));
    }
  }
}
