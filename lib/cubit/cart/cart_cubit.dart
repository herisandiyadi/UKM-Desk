import 'package:bloc/bloc.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/model/request/payment_request.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/model/response/upload_response.dart';
import 'package:enforcea/model/request/cart_payment_reqest.dart';
import 'package:enforcea/repository/cart_repository.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final DatabaseHelper dbHelper;
  final CartRepository cartRepository;

  CartCubit(this.dbHelper, this.cartRepository) : super(CartInitial());

  Future<void> createPayment(bool isUsingVoucher, String voucherCode) async {
    try {
      emit(new CartLoading());
      final items = await getItemOnCart();
      final listProduct = List<Data_produk>();
      items.forEach((element) {
        listProduct.add(Data_produk(
          idProduk: element.id.toString(),
          harga: element.price,
          qty: element.count,
        ));
      });
      var paymentData;
      paymentData = await cartRepository.checkPayment(
          PaymentRequest(dataProduk: listProduct), voucherCode);

      emit(new PaymentCheckLoaded(paymentData));
    } on NetworkException catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> payment(CartPaymentRequest data) async {
    try {
      emit(new CartLoading());
      List<DataProduk> listProduct = List();
      final totalItemInCart = await getItemOnCart();
      for (final reqData in totalItemInCart) {
        var temp = DataProduk(
          date: reqData.date,
          harga: reqData.price,
          idProduk: reqData.id.toString(),
          productName: reqData.name,
          qty: reqData.count,
          total: (reqData.count * reqData.price),
        );
        listProduct.add(temp);
      }
      data.SetListProduct(listProduct);
      final payment = await cartRepository.chartPayment(data);

      if (payment.success) {
        await dbHelper.clearCart();
      }
      emit(PaymentLoaded(payment));
    } on Error catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> getProductList() async {
    try {
      final totalItemInCart = await getItemOnCart();
      emit(new CartLoaded(totalItemInCart));
    } on NetworkException catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addItem(CartModel previousData) async {
    try {
      final updateData = CartModel(
          id: previousData.id,
          count: previousData.count + 1,
          name: previousData.name,
          price: previousData.price,
          imageUrl: previousData.imageUrl,
          date: previousData.date);
      updateData.setRenewalStatus(previousData.isRenewal);
      await dbHelper.update(updateData);
      final totalItemInCart = await getItemOnCart();
      emit(CartLoaded(totalItemInCart));
    } on Error catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeItem(CartModel previousData) async {
    try {
      final updateData = CartModel(
          id: previousData.id,
          count: previousData.count - 1,
          name: previousData.name,
          price: previousData.price,
          imageUrl: previousData.imageUrl,
          date: previousData.date);
      updateData.setRenewalStatus(previousData.isRenewal);
      await dbHelper.update(updateData);
      final totalItemInCart = await getItemOnCart();
      emit(CartLoaded(totalItemInCart));
    } on Error catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> deleteItem(CartModel data) async {
    try {
      dbHelper.delete(data.id);
      final totalItemInCart = await getItemOnCart();
      emit(CartLoaded(totalItemInCart));
    } on Error catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<List<CartModel>> getItemOnCart() async {
    List<CartModel> totalResult = await dbHelper.getCartList();
    return totalResult;
  }

  Future<bool> cancelOrder(String orderID) async {
    try {
      final payment = await cartRepository.cancelPayment(orderID);
      emit(CancelOrder(payment));
    } on Error catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
