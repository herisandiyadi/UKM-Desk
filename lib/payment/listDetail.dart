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
import 'package:enforcea/model/payment/response/paymentStatus.dart';
import 'package:intl/intl.dart';

class ListDetails extends StatefulWidget {
  final String kodeTransaksi;
  ListDetails({Key key, @required this.kodeTransaksi}) : super(key: key);

  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: widget.key,
      appBar: AppBar(
        title: Text("Transaction Detail"),
        backgroundColor: Colors.red[800],
        // automaticallyImplyLeading: false, //remove for test
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocProvider(
            create: (context) => VACubit(null, null, VARepository()),
            child: BlocConsumer<VACubit, VAState>(
              builder: (contextC, state) {
                if (state is VAInitial) {
                  var uploadCubit = contextC.bloc<VACubit>();
                  uploadCubit.PaymentStatus(widget.kodeTransaksi);
                  return Container();
                }
                if (state is VALoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[800]),
                    ),
                  );
                } else if (state is PaymentStatusLoaded) {
                  if (state.paymentStatus.statusCode != "201" &&
                      state.paymentStatus.statusCode != "200") {
                    return expired();
                  }

                  if (state.paymentStatus.vaNumber == null) {
                    return detailLayoutCC(state.paymentStatus);
                  } else {
                    return detailLayoutVA(state.paymentStatus);
                  }
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

  Widget detailLayoutCC(PaymentStatus vaData) {
    return Column(
      children: [
        SizedBox(
          height: 1,
        ),
        ReusableNewContainer(
          cardChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 1,
                height: 30,
                color: Colors.grey,
              ),
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
                  vaData.paymentType,
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
              generateLabel(
                "Bank:",
                Text(
                  vaData.bank,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              Divider(
                thickness: 1,
                height: 30,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget detailLayoutVA(PaymentStatus vaData) {
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
                    "Time Transaction:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              generateLabel(
                "",
                Text(
                  vaData.transactionTime,
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
                          (vaData.vaNumber[0].bank == 'mandiri'
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
                  vaData.paymentType,
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
              generateLabel(
                "Bank:",
                Text(
                  vaData.vaNumber[0].bank,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              Divider(
                thickness: 1,
                height: 30,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget expired() {
    return Column(
      children: [
        SizedBox(
          height: 1,
        ),
        ReusableNewContainer(
          cardChild: Column(
            children: [
              generateLabel(
                "Order Status:",
                Text(
                  "Expired",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
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
