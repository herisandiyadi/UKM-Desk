part of 'voucher_cubit.dart';

@immutable
abstract class VoucherState {
  const VoucherState();
}

class VoucherInitial extends VoucherState {
  const VoucherInitial();
}

class VoucherLoading extends VoucherState {
  const VoucherLoading();
}

class VoucherLoaded extends VoucherState {
  final PaymentResponse paymentData;

  const VoucherLoaded(this.paymentData);
}

class VoucherError extends VoucherState {
  final String message;

  const VoucherError(this.message);
}
