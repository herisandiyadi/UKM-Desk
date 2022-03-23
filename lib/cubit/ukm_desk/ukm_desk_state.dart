part of 'ukm_desk_cubit.dart';

@immutable
abstract class UkmDeskState {
  const UkmDeskState();
}

class UkmDeskInitial extends UkmDeskState {

  const UkmDeskInitial();
}

class UkmDeskLoading extends UkmDeskState {
  const UkmDeskLoading();
}

class UkmDeskLoaded extends UkmDeskState {
  final ProductResponse productResponse;
  final int totalItemInCart;

  const UkmDeskLoaded(this.productResponse,this.totalItemInCart);
}

class AddItem extends UkmDeskState {
  final int totalItemInCart;

  const AddItem(this.totalItemInCart);
}

class UkmDeskError extends UkmDeskState {
  final String message;

  const UkmDeskError(this.message);
}
