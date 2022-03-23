part of 'tax_report_cubit.dart';

@immutable
abstract class TaxReportState {
  const TaxReportState();
}

class TaxReportInitial extends TaxReportState {
  const TaxReportInitial();
}

//class UpdateLoading extends TaxReportState {
//  const UpdateLoading();
//}
//
//class UpdateLoaded extends TaxReportState {
//  final bool isSuccess;
//
//  const UpdateLoaded(this.isSuccess);
//}

class TaxReportLoading extends TaxReportState {
  const TaxReportLoading();
}

class DownloadLoading extends TaxReportState {
  const DownloadLoading();
}

class TaxReportLoaded extends TaxReportState {
  final TaxReportResponse TaxReportData;

  const TaxReportLoaded(this.TaxReportData);
}

class DownloadLoaded extends TaxReportState {
  final String downloadData;

  const DownloadLoaded(this.downloadData);
}

class TaxReportError extends TaxReportState {
  final String message;

  const TaxReportError(this.message);
}
