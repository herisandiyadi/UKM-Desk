part of 'template_report_cubit.dart';

@immutable
abstract class TemplateReportState {
  const TemplateReportState();
}

class TemplateReportInitial extends TemplateReportState {
  const TemplateReportInitial();
}

//class UpdateLoading extends TemplateReportState {
//  const UpdateLoading();
//}
//
//class UpdateLoaded extends TemplateReportState {
//  final bool isSuccess;
//
//  const UpdateLoaded(this.isSuccess);
//}

class TemplateReportLoadin extends TemplateReportState {
  const TemplateReportLoadin();
}

class DownloadLoading extends TemplateReportState {
  const DownloadLoading();
}

class TemplateReportLoaded extends TemplateReportState {
  final TemplateResponse TemplateReportData;

  const TemplateReportLoaded(this.TemplateReportData);
}

class DownloadLoaded extends TemplateReportState {
  final String downloadData;

  const DownloadLoaded(this.downloadData);
}

class TaxReportError extends TemplateReportState {
  final String message;

  const TaxReportError(this.message);
}
