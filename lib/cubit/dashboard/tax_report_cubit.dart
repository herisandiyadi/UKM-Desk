
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/tax_report_response.dart';
import 'package:enforcea/repository/tax_report_repository.dart';
import 'package:enforcea/util/file_util.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';

part 'tax_report_state.dart';

class TaxReportCubit extends Cubit<TaxReportState> {
  final TaxReportRepository _taxReportRepository;

  TaxReportCubit(this._taxReportRepository) : super(TaxReportInitial());

  Future<void> getTaxReport() async {
    try {
      emit(new TaxReportLoading());
      final taxData = await _taxReportRepository.getTaxReport();
      emit(new TaxReportLoaded(taxData));
    } catch (e) {
      emit(new TaxReportError(e.toString()));
    }
  }

  Future<void> taxReportDownload(int taxReportId, String fileName) async {
    try {
      File file;
      emit(new DownloadLoading());
      final finalUtil = FileUtil();
      final taxData = await _taxReportRepository.downloadTaxReport(taxReportId);
      file = await finalUtil.saveToStorage(json.decode(taxData)['data']['file'], fileName);
      OpenFile.open(file.path);

      emit(new DownloadLoaded(fileName));
    } catch (e) {
      print(e.toString());
      emit(new TaxReportError(e.toString()));
    }
  }
}
