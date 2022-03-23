part of 'ebook_template_cubit.dart';

@immutable
abstract class EbookTemplateState {
  const EbookTemplateState();
}

class EbookTemplateInitial extends EbookTemplateState {
  const EbookTemplateInitial();
}

class EbookTemplateLoading extends EbookTemplateState {
  const EbookTemplateLoading();
}

class DownloadLoading extends EbookTemplateState {
  const DownloadLoading();
}

class EbookTemplateLoaded extends EbookTemplateState {
  final DownloadEbookResponse ebookTemplateData;

  const EbookTemplateLoaded(this.ebookTemplateData);
}

class DownloadLoaded extends EbookTemplateState {
  final String downloadData;

  const DownloadLoaded(this.downloadData);
}

class EbookTemplateError extends EbookTemplateState {
  final String message;

  const EbookTemplateError(this.message);
}
