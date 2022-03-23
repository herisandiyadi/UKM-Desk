import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:enforcea/theme/homeTheme.dart';
import 'package:enforcea/util/hexColor.dart';
import 'package:enforcea/util/curvePainter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/cubit/ukm_desk/ukm_desk_cubit.dart';
import 'package:enforcea/repository/product_repository.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/cart.dart';

class CardView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final int montLeft;
  final int cart;
  final AnimationController animationController;
  final Animation animation;
  final CartModel cartModel;

  const CardView(
      {Key key,
      this.titleTxt: "",
      this.subTxt: "",
      this.montLeft: 0,
      this.cart: 0,
      this.cartModel,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: BlocProvider(
                create: (contextProvider) => UkmDeskCubit(ProductRepository()),
                child: BlocConsumer<UkmDeskCubit, UkmDeskState>(
                  builder: (builderContext, state) {
                    return generateCard(builderContext);
                  },
                  listener: (listenerContext, state) {
                    if (state is AddItem) {
                      navigateToCart(context);
                    } else if (state is UkmDeskError) {
                      alertDialog(context, state.message, "Maaf");
                    }
                  },
                )),
          ),
        );
      },
    );
  }

  Widget generateCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 230,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [Colors.red[600], Colors.red[800]]),
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: AssetImage("assets/card_bg.jpg"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 9, 10, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.account_balance,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                titleTxt,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "YourRoute");
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            subTxt,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Center(
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: HomeTheme.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                            border: new Border.all(
                                                width: 4,
                                                color: Colors.red
                                                    .withOpacity(0.2)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${(montLeft * animation.value).toInt()}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      HomeTheme.fontName,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 24,
                                                  letterSpacing: 0.0,
                                                  color:
                                                      HomeTheme.nearlyDarkBlue,
                                                ),
                                              ),
                                              Text(
                                                'Month left',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      HomeTheme.fontName,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  color: HomeTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomPaint(
                                          painter: CurvePainter(
                                              colors: [
                                                Colors.red[900],
                                                HexColor("#8A98E8"),
                                                HexColor("#8A98E8")
                                              ],
                                              angle: (montLeft * 20) +
                                                  (360 - (montLeft * 20)) *
                                                      (1.0 - animation.value)),
                                          child: SizedBox(
                                            width: 108,
                                            height: 108,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        onPressed: () {
                          if (cartModel != null) {
                            final ukmDeskCubit = context.bloc<UkmDeskCubit>();
                            ukmDeskCubit.addItemToCart(cartModel);
                          }
                        },
                        color: Colors.black.withOpacity(0.2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.repeat,
                                  color: cartModel != null
                                      ? Colors.white
                                      : Colors.white38),
                            ),
                            Text("Renewal",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: cartModel != null
                                        ? Colors.white
                                        : Colors.white38)),
                          ],
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 170,
                        child: FlatButton(
                          onPressed: () {
                            navigateToCart(context);
                          },
                          color: Colors.black.withOpacity(0.2),
                          textColor: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(formatValue(cart),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add_shopping_cart,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  void navigateToCart(BuildContext context) {
    var cart = Cart(
      productData: null,
      updateTotal: (total) {},
      monthLeft: montLeft,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => cart,
      ),
    );
  }

  String formatValue(int value) {
    final format = new NumberFormat.currency(
        locale: 'ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(value).toString();
  }

  Widget alertDialog(BuildContext context, String msg, String title) {
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
