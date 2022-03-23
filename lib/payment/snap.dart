import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:enforcea/model/response/payment_response.dart';
import 'package:enforcea/home.dart';

class SnapPage extends StatefulWidget {
  final PaymentResponse paymentData;
  SnapPage({Key key, @required this.paymentData}) : super(key: key);

  @override
  _SnapPageState createState() => _SnapPageState();
}

class _SnapPageState extends State<SnapPage> {
  InAppWebViewController webView;
  double progress = 0;
  String url = "";
  bool transactionDone = false;

  @override
  Widget build(BuildContext context) {
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
        // else {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => PaymentDetail(
        //         paymentData: widget.paymentData,
        //         isUpdate: true,
        //       ),
        //     ),
        //   );
        // }
      },
      child: Scaffold(
          appBar: AppBar(title: Text("InAppWebView")),
          body: Container(
              child: Column(children: <Widget>[
            Container(
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container(),
            ),
            Expanded(
              child: Container(
                child: InAppWebView(
                  // initialFile: "assets/index.html",
                  initialUrl:
                      "https://app.sandbox.midtrans.com/snap/v2/vtweb/7f0032bc-76e0-4a75-a021-eef2ecb6d25e",
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                  )),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart:
                      (InAppWebViewController controller, String url) {},
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  onLoadStop:
                      (InAppWebViewController controller, String url) async {
                    setState(() {
                      this.url = url;
                      print(url);
                      if (url.contains("https://enforcea.com/payment_done")) {
                        transactionDone = true;
                      }
                    });
                  },
                ),
              ),
            ),
          ]))),
    );
  }
}
