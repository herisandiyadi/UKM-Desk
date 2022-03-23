part of 'faq_cubit.dart';

@immutable
abstract class FaqState {
  const FaqState();
}

class FaqInitial extends FaqState {
  const FaqInitial();
}

class FaqLoading extends FaqState {
  const FaqLoading();
}

class FaqLoaded extends FaqState {
  final FaqResponse faqData;

  const FaqLoaded(this.faqData);
}

class FaqError extends FaqState {
  final String message;

  const FaqError(this.message);
}
