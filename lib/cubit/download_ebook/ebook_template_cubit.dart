import 'package:bloc/bloc.dart';

import 'dart:io';
import 'dart:convert';
import 'package:enforcea/model/response/download_book_response.dart';
import 'package:enforcea/repository/ebook_template_repository.dart';
import 'package:meta/meta.dart';
import 'package:enforcea/util/file_util.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';
part 'ebook_template_state.dart';

class EBookTemplateCubit extends Cubit<EbookTemplateState> {
  final EbookTemplateRepository _ebookTemplateRepository;

  EBookTemplateCubit(this._ebookTemplateRepository)
      : super(EbookTemplateInitial());

  Future<void> getEbookTemplate() async {
    try {
      emit(new EbookTemplateLoading());
      final taxData = await _ebookTemplateRepository.getFileList();
      emit(new EbookTemplateLoaded(taxData));
    } catch (e) {
      emit(new EbookTemplateError(e.toString()));
    }
  }

  Future<void> ebookDownload(int templateID, String fileName) async {
    try {
      File file;
      emit(new DownloadLoading());
      final finalUtil = FileUtil();
      final taxData =
          await _ebookTemplateRepository.downloadFileEbook(templateID);
      file = await finalUtil.saveToStorage(taxData, fileName);
      OpenFile.open(file.path);
      emit(new DownloadLoaded(fileName));
    } catch (e) {
      print(e.toString());
      emit(new EbookTemplateError(e.toString()));
    }
  }

  Future<void> templateDownload(int templateID, String fileName) async {
    try {
      File file;
      emit(new DownloadLoading());
      final finalUtil = FileUtil();
      final taxData =
          await _ebookTemplateRepository.downloadFileTemplate(templateID);
      file = await finalUtil.saveToStorage(taxData, fileName);
      OpenFile.open(file.path);
      emit(new DownloadLoaded(fileName));
    } catch (e) {
      print(e.toString());
      emit(new EbookTemplateError(e.toString()));
    }
  }
}
