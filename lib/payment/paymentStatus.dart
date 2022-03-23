import 'package:flutter/material.dart';
import 'package:enforcea/component/ui/reusableNewContainer.dart';
import 'package:flutter/services.dart';
import 'package:enforcea/cubit/payment/va_cubit.dart';
import 'package:enforcea/model/payment/request/virtualAccount.dart';
import 'package:enforcea/model/payment/request/store.dart';
import 'package:enforcea/model/payment/response/virtualAccount.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/repository/payment/virtual_account_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enforcea/model/request/cart_payment_reqest.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:enforcea/repository/cart_repository.dart';
import 'package:enforcea/home.dart';
import 'package:intl/intl.dart';

class PaymentStatus extends StatefulWidget {
  final Image paymentLogo;
  final String orderID;
  final int grassAmount;
  final String paymentType;
  final String bankTransfer;
  final PaymentResponse paymentData;
  bool isUpdate;
  PaymentStatus(
      {Key key,
      @required this.paymentLogo,
      @required this.orderID,
      @required this.grassAmount,
      @required this.paymentType,
      @required this.bankTransfer,
      @required this.paymentData,
      this.isUpdate})
      : super(key: key);

  @override
  _PaymentStatusState createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: widget.key,
      appBar: AppBar(
        title: Text("Transaction Status"),
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: false, //remove for test
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocProvider(
            create: (context) =>
                VACubit(DatabaseHelper(), CartRepository(), VARepository()),
            child: BlocConsumer<VACubit, VAState>(
              builder: (contextC, state) {
                if (state is VAInitial) {
                  var uploadCubit = contextC.bloc<VACubit>();
                  if (widget.paymentType == "cstore") {
                    final data = CartPaymentRequest(
                        diskon: widget.paymentData.data.diskon,
                        kodePromo: widget.paymentData.data.kodePromo,
                        nilaiPromo: 0,
                        subTotal: widget.paymentData.data.subTotal,
                        paymentID: widget.orderID,
                        paymentMethod: 2);
                    final request = StoreRequest(
                        widget.paymentType,
                        TransactionDetailStore(
                            grossAmount: widget.grassAmount,
                            orderID: widget.orderID),
                        CSStore(
                            store: widget.bankTransfer, freeText1: "Enforcea"));

                    uploadCubit.PaymentStore(request, data, widget.isUpdate);
                  } else {
                    final data = CartPaymentRequest(
                        diskon: widget.paymentData.data.diskon,
                        kodePromo: widget.paymentData.data.kodePromo,
                        nilaiPromo: 0,
                        subTotal: widget.paymentData.data.subTotal,
                        paymentID: widget.orderID,
                        paymentMethod: 1);
                    final request = VitualAccountRequest(
                        widget.paymentType,
                        TransactionDetail(
                            grossAmount: widget.grassAmount,
                            orderID: widget.orderID),
                        BankTransfer(bank: widget.bankTransfer));
                    uploadCubit.PaymentVA(
                        request,
                        widget.paymentData.data.kodePromo,
                        data,
                        widget.isUpdate);
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[800]),
                    ),
                  );
                }
                if (state is VALoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[800]),
                    ),
                  );
                } else if (state is VALoaded) {
                  return detailLayout(state.VAData);
                } else if (state is VAError) {
                  // return detailLayout();
                }
              },
              listener: (context, state) {},
            ),
          ),
        ),
      ),
    );
  }

  Widget detailLayout(VAResponse vaData) {
    return Column(
      children: [
        SizedBox(
          height: 1,
        ),
        ReusableNewContainer(
          cardChild: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Time limit:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              generateLabel(
                vaData.transactionTime,
                Text(
                  "23:49:49",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ReusableNewContainer(
          cardChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  vaData.paymentType != "cstore"
                      ? Text(
                          (widget.bankTransfer == "mandiri"
                                  ? "Biller Key: "
                                  : "Virtual Account: ") +
                              vaData.vaNumber[0].vaNumber,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "Payment Code: " + vaData.vaNumber[0].vaNumber,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: vaData.vaNumber[0].vaNumber));
                      Fluttertoast.showToast(
                          msg: "Copy",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[600],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: Icon(
                      Icons.content_copy,
                      color: Colors.grey[500],
                      size: 18,
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 1,
                height: 30,
                color: Colors.grey,
              ),
              vaData.vaNumber[0].billerCode != null
                  ? generateLabel(
                      "Biller Code:",
                      Text(
                        vaData.vaNumber[0].billerCode,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    )
                  : Container(),
              generateLabel(
                "Total:",
                Text(
                  formatValue(vaData.grossAmount),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              generateLabel(
                "Payment Type:",
                Text(
                  "Bank Transfer",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              generateLabel(
                "Payment Status:",
                Text(
                  vaData.transactionStatus,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              generateLabel("Payment Methode:", widget.paymentLogo),
              Divider(
                thickness: 1,
                height: 30,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ButtonTheme(
          minWidth: 300.0,
          // height: 100.0,
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                builder: (context) => Home(
                  selectedPage: 3,
                  drawBottomMenu: true,
                ),
              ));
            },
            child: Text(
              "Go To Order Status",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red[700],
          ),
        )
      ],
    );
  }

  Widget generateLabel(String title, Widget value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          Spacer(),
          value,
        ],
      ),
    );
  }

  String formatValue(String value) {
    int price = int.parse(value.split(".")[0]);
    final format = new NumberFormat.currency(
        locale: 'ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(price).toString();
  }
}
