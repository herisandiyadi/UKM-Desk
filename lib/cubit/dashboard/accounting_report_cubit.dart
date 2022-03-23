import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/accounting_report_response.dart';
import 'package:enforcea/repository/accounting_report_repository.dart';
import 'package:enforcea/util/file_util.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';

part 'accounting_report_state.dart';

class AccountingReportCubit extends Cubit<AccountingReportState> {
  final AccountingReportRepository _accountingReportRepository;

  AccountingReportCubit(this._accountingReportRepository)
      : super(AccountingReportInitial());

  Future<void> getAccountingReport() async {
    try {
      emit(new AccountingReportLoading());
      final taxData = await _accountingReportRepository.getAccountingReport();
      emit(new AccountingReportLoaded(taxData));
    } catch (e) {
      emit(new AccountingReportError(e.toString()));
    }
  }

  Future<void> accountingReportDownload(
      int accountReportId, String fileName) async {
    try {
      File file;
      emit(new DownloadLoading());
      final finalUtil = FileUtil();
      final accountingData = await _accountingReportRepository
          .downloadAccountingReport(accountReportId);
      file = await finalUtil.saveToStorage(
          json.decode(accountingData)['data']['file'], fileName);
      OpenFile.open(file.path);
      emit(new DownloadAccountingLoaded(fileName));
    } catch (e) {
      print(e.toString());
      emit(new AccountingReportError(e.toString()));
    }
  }
}
