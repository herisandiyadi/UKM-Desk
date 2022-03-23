import 'dart:ffi';

import 'package:enforcea/component/ui/button.dart';
import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:enforcea/model/request/cart_payment_reqest.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/util/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:enforcea/cubit/cart/cart_cubit.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:enforcea/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enforcea/payment/paymentStatus.dart';
import 'package:enforcea/payment/inWebViewPayment.dart';
import 'package:enforcea/home.dart';
import 'package:enforcea/component/ui/reusableNewContainer.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/constants.dart';
import 'package:enforcea/payment/snapPayment.dart';

class PaymentDetail extends StatefulWidget {
  final PaymentResponse paymentData;
  bool isUpdate;
  PaymentDetail({Key key, @required this.paymentData, this.isUpdate = false})
      : super(key: key);

  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  BuildContext contextGlobal;
  int userID;

  void initState() {
    super.initState();
    getUserID();
  }

  void getUserID() async {
    userID = await CacheUtil.getInt(CACHE_ID);
  }

  @override
  Widget build(BuildContext context) {
    LoadingUtil loading = LoadingUtil(context);
    final DatabaseHelper dbHelper = DatabaseHelper();
    return WillPopScope(
      onWillPop: () {
        widget.isUpdate
            ? showAlertDialog(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(
                    selectedPage: 0,
                  ),
                ),
                "The Order will be remove?",
                true)
            : Navigator.of(context, rootNavigator: true)
                .pushReplacement(MaterialPageRoute(
                builder: (context) => Home(
                  selectedPage: 0,
                ),
              ));
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        key: widget.key,
        appBar: AppBar(
          title: Text("Payment Detail"),
          backgroundColor: Colors.red[800],
          automaticallyImplyLeading: false, //remove for test
        ),
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (contextProvider) =>
                CartCubit(DatabaseHelper(), CartRepository()),
            child: BlocConsumer<CartCubit, CartState>(
                builder: (builderContext, state) {
              contextGlobal = builderContext;
              return Container(child: initialPage(builderContext, loading));
            }, listener: (listenerContext, state) {
              if (state is CartLoading) {
                loading.showLoading();
              } else if (state is PaymentLoaded) {
                if (state.paymentData.success) {
                  alertDialog(context, state.paymentData.message, "Sukses");
                  // Navigator.of(context).pushReplacementNamed("/home");
                } else {
                  Fluttertoast.showToast(
                      msg: state.paymentData.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[600],
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
//                     goToPayment( listenerContext,state.paymentData);
              } else if (state is CancelOrder) {}
            }),
          ),
        ),
      ),
    );
  }

  Widget alertDialog(BuildContext context, String msg, String title) {
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.red[800]),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true)
            .pushReplacement(MaterialPageRoute(
          builder: (context) => Home(
            selectedPage: 3,
            drawBottomMenu: true,
          ),
        ));
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

  Widget initialPage(BuildContext context, LoadingUtil loading) {
    return Column(
      children: [
        ReusableNewContainer(
          cardChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cart Totals",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                thickness: 2,
                height: 30,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text(
                    "Subtotal",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  Spacer(),
                  Text(formatValue(widget.paymentData.data.subTotal),
                      style: TextStyle(color: Colors.black, fontSize: 13))
                ],
              ),
              Row(
                children: [
                  Text(
                    "Diskon",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  Spacer(),
                  Text(widget.paymentData.data.diskon,
                      style: TextStyle(color: Colors.black, fontSize: 13))
                ],
              ),
              Row(
                children: [
                  Text(
                    "Nett",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  Spacer(),
                  Text(formatValue(widget.paymentData.data.net),
                      style: TextStyle(color: Colors.black, fontSize: 13))
                ],
              ),
              Row(
                children: [
                  Text(
                    "PPN (10%)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  Spacer(),
                  Text(formatValue(widget.paymentData.data.ppn),
                      style: TextStyle(color: Colors.black, fontSize: 13))
                ],
              ),
              Divider(
                thickness: 2,
                height: 30,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(formatValue(widget.paymentData.data.total),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                ],
              ),
            ],
          ),
        ),
        // paymentList(context),
        // Spacer(),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.red[800],
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacement(MaterialPageRoute(
                    builder: (context) => SnapPayment(
                        key: widget.key,
                        userID: this.userID.toString(),
                        orderID: widget.paymentData.data.idPayment,
                        paymentData: widget.paymentData),
                  ));
                  // cartCubit.payment(data);
                },
                child: Text(
                  "Place Order",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  String formatValue(int value) {
    final format = new NumberFormat.currency(
        locale: 'ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(value).toString();
  }

  Widget paymentList(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Bank Transfer",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        buttonList(
            "assets/payment/bca.png", "BCA ", 20, "bank_transfer", "bca"),
        buttonList(
            "assets/payment/bni.png", "BNI ", 20, "bank_transfer", "bni"),
        buttonList(
            "assets/payment/bri.png", "BRIVA", 20, "bank_transfer", "bri"),
        buttonList("assets/payment/mandiri.png", "Mandiri ", 20, "echannel",
            "mandiri"),
        buttonList("assets/payment/permata.png", "Permata ", 20, "permata", ""),
        SizedBox(
          height: 15,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Convenience Store",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        buttonList("assets/payment/alfamart.png", "Alfamart", 20, "cstore",
            "alfamart"),
        buttonList("assets/payment/indomaret.png", "Indomaret", 20, "cstore",
            "indomaret"),
        SizedBox(
          height: 15,
        ),
        Divider(
          thickness: 1,
          height: 10,
          color: Colors.grey[350],
        ),
        anotherPayment(
            "assets/payment/creditcard.png", "Credit Card", 20, "", ""),
      ],
    );
  }

  Widget buttonList(String logo, String label, double imgSize,
      String paymentType, String bankTransfer) {
    return InkWell(
      onTap: () {
        showAlertDialog(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentStatus(
                      paymentLogo: Image.asset(
                        logo,
                        height: imgSize,
                      ),
                      paymentType: paymentType,
                      grassAmount: widget.paymentData.data.total,
                      orderID: widget.paymentData.data.idPayment,
                      bankTransfer: bankTransfer,
                      paymentData: widget.paymentData,
                      isUpdate: widget.isUpdate,
                    )),
            "Would you like to continue with payment method " + label + "?",
            false);
      },
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Image.asset(
                    logo,
                    height: imgSize,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.chevron_right,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Divider(
            thickness: 1,
            height: 10,
            color: Colors.grey[350],
          ),
        ),
      ]),
    );
  }

  Widget anotherPayment(String logo, String label, double imgSize,
      String paymentType, String bankTransfer) {
    return InkWell(
      onTap: () {
        showAlertDialog(
            context,
            MaterialPageRoute(
                builder: (context) => InWebViewPayment(
                      grassAmount: widget.paymentData.data.total,
                      orderID: widget.paymentData.data.idPayment,
                      paymentData: widget.paymentData,
                      isUpdate: widget.isUpdate,
                    )),
            "Would you like to continue with payment method " + label + "?",
            false);
      },
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Image.asset(
                    logo,
                    height: imgSize,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.chevron_right,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Divider(
            thickness: 1,
            height: 10,
            color: Colors.grey[350],
          ),
        ),
      ]),
    );
  }

  showAlertDialog(
      BuildContext context, dynamic next, String message, bool isRemoveOrder) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        if (isRemoveOrder) {
          final cartCubit = contextGlobal.bloc<CartCubit>();
          cartCubit.cancelOrder(widget.paymentData.data.idPayment);
        }

        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pushReplacement(next);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
