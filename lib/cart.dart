import 'package:enforcea/component/ui/bottomCartItem.dart';
import 'package:enforcea/component/ui/cardItem.dart';
import 'package:enforcea/cubit/cart/cart_cubit.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/model/response/product_response.dart';
import 'package:enforcea/paymentDetail.dart';
import 'package:enforcea/repository/cart_repository.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:enforcea/payment/snapPayment.dart';

import 'constants.dart';
import 'login.dart';

class Cart extends StatefulWidget {
  final Data productData;
  final Function(int total) updateTotal;
  final int monthLeft;

  Cart(
      {Key key,
      @required this.productData,
      @required this.updateTotal,
      this.monthLeft = 0})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DateTime selectedDate = DateTime.now();
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Widget> listItem = List<Widget>();
  List<DateTime> listTime = List<DateTime>();
  int totalItem = 0;
  bool isLogin = false;
  // int userID;

  // void getUserID() async {
  //   userID = await CacheUtil.getInt(CACHE_ID);
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red[800],
              surface: Colors.red[800],
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<bool> _onWillPop() async {
    widget.updateTotal(totalItem);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<CartModel> items = List<CartModel>();
//    LoadingUtil loading = LoadingUtil(context);
    final pr = ProgressDialog(context);

    CacheUtil.getBoolean(CACHE_IS_LOGIN).then((value) {
      if (value) {
        isLogin = value;
      }
    });
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          backgroundColor: Colors.red[800],
        ),
        body: BlocProvider(
          create: (contextProvider) =>
              CartCubit(DatabaseHelper(), CartRepository()),
          child: BlocConsumer<CartCubit, CartState>(
              builder: (builderContext, state) {
            if (state is CartLoaded) {
              items = state.cartData;
              return initView(items, builderContext);
            } else {
              if (state is CartInitial) {
                final cartCubit = builderContext.bloc<CartCubit>();
                cartCubit.getProductList();
              }
              return initView(items, builderContext);
            }
          }, listener: (listenerContext, state) {
            if (state is CartLoading) {
//                pr.show();
            } else if (state is PaymentCheckLoaded) {
//                  pr.hide();
              if (state.paymentData.success) {
                goToPayment(listenerContext, state.paymentData);
              } else {
                alertDialog("Terjadi Kesalahan", "Maaf");
              }
            } else if (state is CartError) {
              alertDialog(state.message, "Maaf");
            }
          }),
        ),
      ),
    );
  }

  Container initView(List<CartModel> itemCart, BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: generateWidget(itemCart, context),
              ),
            ),
            Positioned(
              bottom: 0,
              child: BottomCartItem(
                price: getTotalPrice(itemCart),
                continueFunc: (bool isUsingVoucher, String voucherCode) {
                  if (isLogin) {
                    final cartCubit = context.bloc<CartCubit>();
                    cartCubit.createPayment(isUsingVoucher, voucherCode);
                  } else {
                    Widget okButton = FlatButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.red[800]),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Text("Maaf"),
                      content: Text("Silahkan login terlebih dahulu."),
                      actions: [
                        okButton,
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
            )
          ],
        ));
  }

  int getTotalPrice(List<CartModel> model) {
    int total = 0;
    int totalPrice = 0;
    if (model.length > 0) {
      model.forEach((element) {
        total = total + element.count;
        totalPrice = totalPrice + (element.count * element.price);
      });
    }
    totalItem = total;
//    widget.updateTotal(total);

    return totalPrice;
  }

  void goToPayment(BuildContext context, PaymentResponse paymentData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PaymentDetail(key: widget.key, paymentData: paymentData),
      ),
    );
    // Navigator.of(context, rootNavigator: true)
    //     .pushReplacement(MaterialPageRoute(
    //   builder: (context) =>
    //       PaymentDetail(key: widget.key, paymentData: paymentData),
    //   // SnapPayment(
    //   //     key: widget.key,
    //   //     userID: this.userID.toString(),
    //   //     paymentData: paymentData),
    // ));
  }

  List<Widget> generateWidget(List<CartModel> itemCart, BuildContext context) {
    List<Widget> widgets = List<Widget>();
    if (itemCart.length > 0) {
      itemCart.forEach((element) {
        widgets.add(CartItem(
          monthLeft: widget.monthLeft,
          cartModel: element,
          add: () {
            final cartCubit = context.bloc<CartCubit>();
            cartCubit.addItem(element);
          },
          remove: () {
            if (element.count > 3 || (element.isRenewal && element.count > 1)) {
              final cartCubit = context.bloc<CartCubit>();
              cartCubit.removeItem(element);
            }
          },
          delete: () {
            final cartCubit = context.bloc<CartCubit>();
            cartCubit.deleteItem(element);
          },
        ));
      });
    }
    return widgets;
  }

  Widget alertDialog(String msg, String title) {
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.red[800]),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
