part of 'cart_cubit.dart';

@immutable
abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartModel> cartData;

  const CartLoaded(this.cartData);
}

class PaymentCheckLoaded extends CartState {
  final PaymentResponse paymentData;

  const PaymentCheckLoaded(this.paymentData);
}

class PaymentLoaded extends CartState {
  final UploadResponse paymentData;

  const PaymentLoaded(this.paymentData);
}

class CancelOrder extends CartState {
  final bool isSuccess;
  const CancelOrder(this.isSuccess);
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}
