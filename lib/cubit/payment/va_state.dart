part of 'va_cubit.dart';

@immutable
abstract class VAState {
  const VAState();
}

class VAInitial extends VAState {
  const VAInitial();
}

class VALoading extends VAState {
  const VALoading();
}

class VALoaded extends VAState {
  final VAResponse VAData;
  const VALoaded(this.VAData);
}

class InWebViewLoaded extends VAState {
  final InWebViewResponse inWebViewData;
  const InWebViewLoaded(this.inWebViewData);
}

class PaymentSaveLoaded extends VAState {
  final UploadResponse paymentSave;
  const PaymentSaveLoaded(this.paymentSave);
}

class PaymentStatusLoaded extends VAState {
  final PaymentStatus paymentStatus;
  const PaymentStatusLoaded(this.paymentStatus);
}

class SnapLoaded extends VAState {
  final SnapResponse snapData;
  const SnapLoaded(this.snapData);
}

class PaymentMethodLoaded extends VAState {
  final bool isSuccess;
  const PaymentMethodLoaded(this.isSuccess);
}

class VAError extends VAState {
  final String message;

  const VAError(this.message);
}

class PaymentSaveError extends VAState {
  final String message;

  const PaymentSaveError(this.message);
}

class MidtransTokenError extends VAState {
  final String message;

  const MidtransTokenError(this.message);
}
