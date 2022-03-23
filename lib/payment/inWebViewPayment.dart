import 'package:enforcea/model/payment/request/inWebView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/cubit/payment/va_cubit.dart';
import 'package:enforcea/repository/payment/virtual_account_repository.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:enforcea/repository/cart_repository.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/model/request/cart_payment_reqest.dart';
import 'package:enforcea/paymentDetail.dart';
import 'package:enforcea/component/historyNav.dart';
import 'package:enforcea/home.dart';

class InWebViewPayment extends StatefulWidget {
  final String orderID;
  final int grassAmount;
  final PaymentResponse paymentData;
  bool isUpdate;
  InWebViewPayment(
      {Key key,
      @required this.orderID,
      @required this.grassAmount,
      @required this.paymentData,
      this.isUpdate})
      : super(key: key);

  @override
  _InWebViewPaymentState createState() => _InWebViewPaymentState();
}

class _InWebViewPaymentState extends State<InWebViewPayment> {
  double progress = 0;
  String url = "";
  bool transactionDone = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        if (transactionDone) {
          // Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Home(
                selectedPage: 0,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentDetail(
                paymentData: widget.paymentData,
                isUpdate: true,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 0.0,
        ),
        backgroundColor: Colors.grey[200],
        key: widget.key,
        appBar: AppBar(
          title: Text("Credit Card"),
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
                  // return Column(children: [
                  //   Container(
                  //     child: progress < 1.0
                  //         ? LinearProgressIndicator(value: progress)
                  //         : Container(),
                  //   ),
                  //   Text("size.toString()"),
                  //   Text(size.toString())
                  //   // Container(
                  //   //     height: MediaQuery.of(context).size.height * .8,
                  //   //     child: inWebViewPayment("http://www.google.com")),
                  // ]);
                  if (state is VAInitial) {
                    var uploadCubit = contextC.bloc<VACubit>();

                    final data = CartPaymentRequest(
                        diskon: widget.paymentData.data.diskon,
                        kodePromo: widget.paymentData.data.kodePromo,
                        nilaiPromo: 0,
                        subTotal: widget.paymentData.data.subTotal,
                        paymentID: widget.orderID,
                        paymentMethod: 3);
                    final request = InWebViewRequest(
                      TransactionDetailWebView(
                          grossAmount: widget.grassAmount,
                          orderID: widget.orderID),
                    );
                    uploadCubit.InWebView(request, data, widget.isUpdate);

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
                  } else if (state is InWebViewLoaded) {
                    return Column(children: [
                      Container(
                        child: progress < 1.0
                            ? LinearProgressIndicator(value: progress)
                            : Container(),
                      ),
                      Container(
                          height: size,
                          child: inWebViewPayment(
                              contextC, state.inWebViewData.redirectURL)),
                      transactionDone
                          ? Container(
                              child: ButtonTheme(
                                minWidth: 300.0,
                                // height: 100.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => Home(
                                        selectedPage: 6,
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
                              ),
                            )
                          : SizedBox(),
                    ]);
                  } else if (state is VAError) {
                    // return detailLayout();
                  }
                },
                listener: (context, state) {},
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inWebViewPayment(BuildContext ctx, String url) {
    return InAppWebView(
      initialUrl: url,
      initialHeaders: {},
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
        debuggingEnabled: true,
      )),
      onProgressChanged: (InAppWebViewController controller, int progress) {
        setState(() {
          this.progress = progress / 100;
        });
      },
      onLoadStop: (InAppWebViewController controller, String url) async {
        setState(() {
          this.url = url;
          print(url);
          if (url.contains("https://enforcea.com/payment_done")) {
            transactionDone = true;
            var uploadCubit = ctx.bloc<VACubit>();

            final data = CartPaymentRequest(
                diskon: widget.paymentData.data.diskon,
                kodePromo: widget.paymentData.data.kodePromo,
                nilaiPromo: 0,
                subTotal: widget.paymentData.data.subTotal,
                paymentID: widget.orderID,
                paymentMethod: 3);
            final request = InWebViewRequest(
              TransactionDetailWebView(
                  grossAmount: widget.grassAmount, orderID: widget.orderID),
            );
            uploadCubit.SavePaymentMethod(request, data, 0);
          }
        });
      },
    );
  }
}
