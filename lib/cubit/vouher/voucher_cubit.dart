import 'package:bloc/bloc.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/model/request/payment_request.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/repository/cart_repository.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:meta/meta.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  final DatabaseHelper dbHelper;
  final CartRepository cartRepository;

  VoucherCubit(this.dbHelper, this.cartRepository)
      : super(new VoucherInitial());

  Future<void> checkVoucher(String voucherCode) async {
    try {
      emit(new VoucherLoading());
      final items = await getItemOnCart();
      final listProduct = List<Data_produk>();
      items.forEach((element) {
        listProduct.add(Data_produk(
          idProduk: element.id.toString(),
          harga: element.price * element.count,
          qty: element.count,
        ));
      });
      PaymentResponse paymentData;
      paymentData = PaymentResponse(success: false);
      if (voucherCode != "") {
        paymentData = await cartRepository.checkVoucher(
            PaymentRequest(dataProduk: listProduct), voucherCode);
      }
      emit(new VoucherLoaded(paymentData));
    } on NetworkException catch (e) {
      emit(VoucherError(e.toString()));
    }
  }

  void refresh() {
    emit(new VoucherInitial());
  }

  Future<List<CartModel>> getItemOnCart() async {
    List<CartModel> totalResult = await dbHelper.getCartList();
    return totalResult;
  }
}
