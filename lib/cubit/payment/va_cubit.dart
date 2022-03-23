import 'package:bloc/bloc.dart';
import 'package:enforcea/model/payment/response/inWebView.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/payment/virtual_account_repository.dart';
import 'package:enforcea/model/payment/request/virtualAccount.dart';
import 'package:enforcea/model/payment/request/store.dart';
import 'package:enforcea/model/payment/response/virtualAccount.dart';
import 'package:enforcea/model/payment/request/inWebView.dart';
import 'package:enforcea/model/payment/response/paymentStatus.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/model/request/payment_request.dart';
import 'package:enforcea/model/response/upload_response.dart';

import 'package:enforcea/model/request/cart_payment_reqest.dart';
import 'package:enforcea/repository/cart_repository.dart';

import 'package:enforcea/model/response/payment_response.dart';
import 'package:meta/meta.dart';
import 'package:enforcea/model/payment/response/snap.dart';
import 'package:enforcea/model/payment/request/snap.dart';

part 'va_state.dart';

class VACubit extends Cubit<VAState> {
  final VARepository _profileRepository;
  final DatabaseHelper dbHelper;
  final CartRepository cartRepository;

  VACubit(this.dbHelper, this.cartRepository, this._profileRepository)
      : super(VAInitial());

  Future<void> PaymentVA(VitualAccountRequest request, String voucherCode,
      CartPaymentRequest data, bool isUpdate) async {
    try {
      emit(new VALoading());
      bool paymentIsSuccess;
      String paymentMsg;
      if (!isUpdate) {
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
        paymentIsSuccess = payment.success;
        paymentMsg = payment.message;

        if (paymentIsSuccess) {
          await dbHelper.clearCart();
        }
      } else {
        //update payment method
        print(request.transactionDetail.orderID);
        final payment = await cartRepository.updatePayment(
            request.transactionDetail.orderID, data.paymentMethod);
        paymentIsSuccess = payment;
      }

      var VAData;
      if (paymentIsSuccess) {
        VAData = await _profileRepository.checkPayment(request);
      } else {
        emit(VAError(paymentMsg));
      }

      emit(new VALoaded(VAData));
    } on NetworkException catch (e) {
      emit(VAError(e.toString()));
    }
  }

  Future<void> PaymentStore(
      StoreRequest request, CartPaymentRequest data, bool isUpdate) async {
    try {
      emit(new VALoading());
      bool paymentIsSuccess;
      String paymentMsg;
      if (!isUpdate) {
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
        paymentIsSuccess = payment.success;
        paymentMsg = payment.message;
        if (paymentIsSuccess) {
          await dbHelper.clearCart();
        }
      } else {
        //update payment method
        print(request.transactionDetail.orderID);
        final payment = await cartRepository.updatePayment(
            request.transactionDetail.orderID, data.paymentMethod);
        paymentIsSuccess = payment;
      }

      var VAData;
      if (paymentIsSuccess) {
        VAData = await _profileRepository.checkPaymentStore(request);
      } else {
        emit(VAError(paymentMsg));
      }

      emit(new VALoaded(VAData));
    } on NetworkException catch (e) {
      emit(VAError(e.toString()));
    }
  }

  Future<void> InWebView(
      InWebViewRequest request, CartPaymentRequest data, bool isUpdate) async {
    try {
      emit(new VALoading());
      var inWebViewData =
          await _profileRepository.checkPaymentInWebView(request);

      emit(new InWebViewLoaded(inWebViewData));
    } on NetworkException catch (e) {
      emit(VAError(e.toString()));
    }
  }

  Future<void> SavePaymentMethod(InWebViewRequest request,
      CartPaymentRequest data, int paymentMethod) async {
    try {
      emit(new VALoading());
      bool paymentIsSuccess;
      String paymentMsg;
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
      paymentIsSuccess = payment.success;
      paymentMsg = payment.message;

      if (paymentIsSuccess) {
        await dbHelper.clearCart();
        await cartRepository.updatePayment(data.paymentID, paymentMethod);
      } else {
        emit(VAError(paymentMsg));
      }

      emit(new PaymentSaveLoaded(payment));
    } on NetworkException catch (e) {
      emit(VAError(e.toString()));
    }
  }

  Future<void> PaymentStatus(String kodeTransaksi) async {
    try {
      emit(new VALoading());
      final inWebViewData =
          await _profileRepository.checkPaymentStatus(kodeTransaksi);
      emit(new PaymentStatusLoaded(inWebViewData));
    } on NetworkException catch (e) {
      emit(VAError(e.toString()));
    }
  }

  Future<List<CartModel>> getItemOnCart() async {
    List<CartModel> totalResult = await dbHelper.getCartList();
    return totalResult;
  }

  Future<void> MidtransToken(
      SnapRequest snapReq, CartPaymentRequest data) async {
    try {
      final midtransToken = await _profileRepository.midtransToken(snapReq);
      if (!midtransToken.isSuccess) {
        emit(MidtransTokenError("Internal Server Error"));
        return;
      }
      emit(new SnapLoaded(midtransToken));
    } on NetworkException catch (e) {
      emit(MidtransTokenError(e.toString()));
    }
  }

  Future<void> UpdatePaymentMethod(String orderID, int paymentMethod) async {
    try {
      await cartRepository.updatePayment(orderID, paymentMethod);
    } on NetworkException catch (e) {
      emit(MidtransTokenError(e.toString()));
    }
  }
}
