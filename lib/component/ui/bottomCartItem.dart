import 'package:enforcea/cubit/vouher/voucher_cubit.dart';
import 'package:enforcea/repository/cart_repository.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../login.dart';

class BottomCartItem extends StatefulWidget {
//  final Function continueFunc;
  final Function(bool, String) continueFunc;
  final int price;
  BottomCartItem({@required this.continueFunc, @required this.price});

  @override
  _BottomCartItemState createState() => _BottomCartItemState();
}

class _BottomCartItemState extends State<BottomCartItem> {
  String value = 'Full';
  bool _isShowInfoText = false;
  bool _isValidVoucher = false;
  TextEditingController voucherController = TextEditingController();
  Color color = Colors.black;
  String infoText = "";
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    CacheUtil.getBoolean(CACHE_IS_LOGIN).then((value) {
      if (value) {
        isLogin = value;
      }
    });
    return BlocProvider(
        create: (contextProvider) =>
            VoucherCubit(DatabaseHelper(), CartRepository()),
        child: BlocConsumer<VoucherCubit, VoucherState>(
          builder: (builderContext, state) {
            if (state is VoucherLoaded) {
              if (state.paymentData.success) {
                _isShowInfoText = true;
                color = Colors.green[600];
                infoText = "Kode voucher valid";
                _isValidVoucher = true;
              } else {
                _isValidVoucher = false;
                _isShowInfoText = true;
                color = Colors.red;
                infoText = "Kode voucher tidak valid.";
              }
            } else {
              _isShowInfoText = false;
              _isValidVoucher = false;
              color = Colors.black;
            }
            return initView(builderContext, state);
          },
          listener: (listenerContext, state) {
            if (state is VoucherLoaded) {
              if (!state.paymentData.success) {
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
                  title: Text("Maaf"),
                  content: Text("Voucher kamu tidak valid."),
                  actions: [
                    okButton,
                  ],
                );

                showDialog(
                  context: listenerContext,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            }
          },
        ));
  }

  Container initView(BuildContext context, VoucherState state) {
    final voucherCubit = context.bloc<VoucherCubit>();
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1.0,
          spreadRadius: 1.0,
        ),
      ]),
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: voucherController,
                      cursorColor: Colors.black,
                      onChanged: (text) {
                        voucherCubit.refresh();
                      },
                      decoration: InputDecoration(
                        hintText: "Kode Voucher",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !_isShowInfoText,
                      child: Text(
                        infoText,
                        style: TextStyle(fontSize: 12, color: color),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
              ),
              getVoucherWidget(context, state)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text("Total Price"),
              Spacer(),
              Text(formatValue(widget.price))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              ButtonTheme(
                minWidth: 300.0,
                child: RaisedButton(
                  onPressed: () {
                    widget.continueFunc(
                        _isValidVoucher, voucherController.text);
                  },
                  child: Text(
                    "Go To Payment ",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[800],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    voucherController.dispose();
    super.dispose();
  }

  String formatValue(int value) {
    final format = new NumberFormat.currency(
        locale: 'ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(value).toString();
  }

  Widget getVoucherWidget(BuildContext context, VoucherState state) {
    if (state is VoucherLoading) {
      return Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
            ),
          ),
        ),
      );
    } else {
      return RaisedButton(
        onPressed: () {
          if (isLogin) {
            final voucherCubit = context.bloc<VoucherCubit>();
            voucherCubit.checkVoucher(voucherController.text);
          } else {
            Widget okButton = FlatButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.red[800]),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                  (Route<dynamic> route) => false,
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
        child: Text(
          "Check",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.red[800],
      );
    }
  }
}
