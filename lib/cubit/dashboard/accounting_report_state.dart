part of 'accounting_report_cubit.dart';

@immutable
abstract class AccountingReportState {
  const AccountingReportState();
}

class AccountingReportInitial extends AccountingReportState {
  const AccountingReportInitial();
}

class AccountingReportLoading extends AccountingReportState {
  const AccountingReportLoading();
}

class DownloadLoading extends AccountingReportState {
  const DownloadLoading();
}

class AccountingReportLoaded extends AccountingReportState {
  final AccountingReportResponse accountingReportData;

  const AccountingReportLoaded(this.accountingReportData);
}

class DownloadAccountingLoaded extends AccountingReportState {
  final String downloadData;

  const DownloadAccountingLoaded(this.downloadData);
}

class AccountingReportError extends AccountingReportState {
  final String message;

  const AccountingReportError(this.message);
}
