import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'dart:io';
import 'package:enforcea/model/response/upload_list_response.dart';
import 'package:enforcea/repository/upload_list_repository.dart';
import 'package:enforcea/util/file_util.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';

part 'upload_list_state.dart';

class UploadListCubit extends Cubit<UploadListState> {
  final UploadListRepository _uploadListRepository;

  UploadListCubit(this._uploadListRepository) : super(UploadListInitial());

  Future<void> uploadList(int pages, String key) async {
    try {
      emit(new UploadListLoading());
      final listData = await _uploadListRepository.getUploadList(pages, key);
      emit(new UploadListLoaded(listData));
    } catch (e) {
      emit(new UploadListError(e.toString()));
    }
  }

  Future<void> fileDownload(int id, String fileName) async {
    try {
      File file;
      emit(new DownloadLoading());
      final finalUtil = FileUtil();
      final taxData = await _uploadListRepository.downloadFile(id);
      file = await finalUtil.saveToStorage(
          json.decode(taxData)['data']['file'], fileName);
      OpenFile.open(file.path);

      emit(new DownloadLoaded(fileName));
    } catch (e) {
      print(e.toString());
      emit(new UploadListError(e.toString()));
    }
  }
}
