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
import 'package:enforcea/model/payment/response/snap.dart';
import 'package:enforcea/model/payment/request/snap.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/constants.dart';

class SnapPayment extends StatefulWidget {
  final String userID;
  final String orderID;
  final int grassAmount;
  final PaymentResponse paymentData;
  bool isUpdate;
  SnapPayment(
      {Key key,
      @required this.userID,
      @required this.orderID,
      @required this.grassAmount,
      @required this.paymentData,
      this.isUpdate})
      : super(key: key);

  @override
  _SnapPaymentState createState() => _SnapPaymentState();
}

class _SnapPaymentState extends State<SnapPayment> {
  double progress = 0;
  String url = "";
  bool transactionDone = false;
  int paymentMethod = 0;
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
        }
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 0.0,
        ),
        backgroundColor: Colors.grey[200],
        key: widget.key,
        appBar: AppBar(
          toolbarHeight: 1,
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

                    final request = SnapRequest(
                        widget.userID,
                        widget.paymentData.data.idPayment,
                        widget.paymentData.data.total.toString());
                    final data = CartPaymentRequest(
                        diskon: widget.paymentData.data.diskon,
                        kodePromo: widget.paymentData.data.kodePromo,
                        subTotal: widget.paymentData.data.subTotal,
                        paymentID: widget.orderID);
                    uploadCubit.MidtransToken(request, data);

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
                  } else if (state is SnapLoaded) {
                    return Column(children: [
                      Container(
                        child: progress < 1.0
                            ? LinearProgressIndicator(value: progress)
                            : Container(),
                      ),
                      Container(
                          height: size * .962,
                          child: Column(
                            children: [
                              Expanded(
                                  child: inWebViewPayment(
                                      contextC, state.snapData.redirectURL)),
                            ],
                          )),
                    ]);
                  } else if (state is PaymentSaveLoaded) {
                    return Column(children: [
                      Container(
                        child: progress < 1.0
                            ? LinearProgressIndicator(value: progress)
                            : Container(),
                      ),
                      Container(
                          height: size * .962,
                          child: Column(
                            children: [
                              Expanded(
                                  child: inWebViewPayment(contextC,
                                      "https://enforcea.com/payment_done")),
                            ],
                          )),
                      Container(
                        child: ButtonTheme(
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
                        ),
                      )
                    ]);
                  } else if (state is VAError) {
                    // return detailLayout();
                  }
                },
                listener: (context, state) {
                  // if (state is PaymentSaveLoaded) {
                  //   Container(
                  //     child: ButtonTheme(
                  //       minWidth: 300.0,
                  //       // height: 100.0,
                  //       child: RaisedButton(
                  //         onPressed: () {
                  //           Navigator.of(context, rootNavigator: true)
                  //               .pushReplacement(MaterialPageRoute(
                  //             builder: (context) => Home(
                  //               selectedPage: 3,
                  //               drawBottomMenu: true,
                  //             ),
                  //           ));
                  //         },
                  //         child: Text(
                  //           "Go To Order Status",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //         color: Colors.red[700],
                  //       ),
                  //     ),
                  //   );
                  // }
                },
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
              preferredContentMode: UserPreferredContentMode.DESKTOP)),
      onProgressChanged: (InAppWebViewController controller, int progress) {
        setState(() {
          this.progress = progress / 100;
        });
      },
      onLoadStop: (InAppWebViewController controller, String url) async {
        setState(() {
          this.url = url;
          print(url);
          if (!transactionDone &&
              url.contains("https://enforcea.com/payment_done")) {
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
            uploadCubit.SavePaymentMethod(request, data, paymentMethod);
          } else if (url.contains("/bank-transfer")) {
            //update payment
            paymentMethod = 1;
            // var payment = ctx.bloc<VACubit>();
            // payment.UpdatePaymentMethod(widget.orderID, 1);
          } else if (url.contains("/credit-card")) {
            // var payment = ctx.bloc<VACubit>();
            // payment.UpdatePaymentMethod(widget.orderID, 3);
            paymentMethod = 3;
          } else if (url.contains("/indomaret") || url.contains("/alfamart")) {
            // var payment = ctx.bloc<VACubit>();
            // payment.UpdatePaymentMethod(widget.orderID, 2);
            paymentMethod = 2;
          }
        });
      },
    );
  }
}
