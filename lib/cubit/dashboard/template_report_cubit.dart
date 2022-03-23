import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/template_response.dart';
import 'package:enforcea/repository/template_repository.dart';
import 'package:meta/meta.dart';
import 'package:enforcea/util/file_util.dart';
import 'package:open_file/open_file.dart';

part 'template_report_state.dart';

class TemplateReportCubit extends Cubit<TemplateReportState> {
  final TemplateRepository _templateReportRepository;

  TemplateReportCubit(this._templateReportRepository)
      : super(TemplateReportInitial());

  Future<void> getTaxReport() async {
    try {
      emit(new TemplateReportLoadin());
      final taxData = await _templateReportRepository.fetchTemplate();
      emit(new TemplateReportLoaded(taxData));
    } catch (e) {
      emit(new TaxReportError(e.toString()));
    }
  }

  Future<void> taxReportDownload(int templateID) async {
    try {
      File file;
      emit(new DownloadLoading());
      final finalUtil = FileUtil();
      final taxData =
          await _templateReportRepository.downloadReport(templateID);
      print(taxData['success']);
      file = await finalUtil.saveToStorage(
          taxData['data']['file'], taxData['data']['file_name']);
      OpenFile.open(file.path);
      emit(new DownloadLoaded(taxData));
    } catch (e) {
      print(e.toString());
      emit(new TaxReportError(e.toString()));
    }
  }
}
