import 'package:badges/badges.dart';
import 'package:enforcea/constants.dart';
import 'package:enforcea/cubit/ukm_desk/ukm_desk_cubit.dart';
import 'package:enforcea/model/response/product_response.dart';
import 'package:enforcea/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:enforcea/bottomMenu.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cart.dart';
import 'model/cart_model.dart';

class UKMDesk extends StatefulWidget {
  UKMDesk({Key key}) : super(key: key);

  @override
  _UKMDeskState createState() => _UKMDeskState();
}

class _UKMDeskState extends State<UKMDesk> with TickerProviderStateMixin {
  AnimationController animationController;
  var small, medium, premium;
  FToast fToast;

  ProductResponse _productResponse;
  int _selectedPosition = 0;
  int _totalCart = 0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animationController.forward();
    small = false;
    medium = false;
    premium = false;
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("UKM Desk"),
          backgroundColor: Colors.red[800],
        ),
        body: BlocProvider(
          create: (contextProvider) => UkmDeskCubit(ProductRepository()),
          child: BlocConsumer<UkmDeskCubit, UkmDeskState>(
            builder: (builderContext, state) {
              if (state is UkmDeskLoaded) {
                _productResponse = state.productResponse;
                _totalCart = state.totalItemInCart;
                return initView(builderContext);
              } else if (state is UkmDeskInitial || state is UkmDeskLoading) {
                if (state is UkmDeskInitial) {
                  final ukmDeskCubit = builderContext.bloc<UkmDeskCubit>();
                  ukmDeskCubit.getProductList();
                }
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
                  ),
                );
              } else {
                return initView(builderContext);
              }
            },
            listener: (listenerContext, state) {
              if (state is AddItem) {
                _totalCart = state.totalItemInCart;
              } else if (state is UkmDeskError) {
                alertDialog(context, state.message, "maaf");
              }
            },
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

  Widget initView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                    'https://www.enforcea.com/assets/img3/ukmdesk_banner.gif'),
                Row(
                  children: createList(_productResponse),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Mengapa UMKM sulit berkembang?",
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Pengelolaan perusahaan yang tidak jelas dan minimnya literasi keuangan menjadi sebab.",
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Waktu menjadi hambatan karena UMKM umumnya solopreneur, bergantung pada pemilik, dan minimnya sumber daya. Akibatnya kinerja bisnis tidak tercatat dengan baik dan tidak dapat diukur. Layanan pembukuan dan pajak UKM Desk kami mengatasi permasalahan tersebut. Mudah dan terpercaya dengan dukungan teknologi yang kami kembangkan. Anda tinggal upload dokumen atau ambil foto selanjutnya biarkan kami yang menyelesaikannya untuk Anda.",
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Bergabung dengan layanan UKM Desk kami agar usaha Anda jelas dan maju! Beli paket yang sesuai kebutuhan bisnis Anda!",
                    textAlign: TextAlign.left),
                Card(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Html(
                      data: _productResponse
                          .data[_selectedPosition].productContent),
                )),
                buyButton(context, Icons.add_shopping_cart, "Add to cart"),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Badge(
            badgeContent: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(_totalCart.toString(),
                  style: TextStyle(color: Colors.white)),
            ),
            badgeColor: Colors.red[800],
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(
                      productData: _productResponse.data[_selectedPosition],
                      updateTotal: (total) {
                        setState(() {
                          _totalCart = total;
                        });
                      },
                    ),
                  ),
                );
//                Navigator.pushNamed(context, '/cart');
              },
              elevation: 10,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buyButton(BuildContext context, IconData icon, String label) {
    return SizedBox(
      width: double.infinity,
      child: ButtonTheme(
        child: RaisedButton.icon(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(color: Colors.white)),
          onPressed: () {
            setState(() {
              final ukmDeskCubit = context.bloc<UkmDeskCubit>();
              DateTime now = DateTime.now();
              String formattedDate = DateFormat('yyyy-MM').format(now);
              ukmDeskCubit.addItemToCart(
                CartModel(
                    id: _productResponse.data[_selectedPosition].productId,
                    count: 6,
                    date: formattedDate,
                    name: _productResponse.data[_selectedPosition].productName,
                    price: int.parse(
                        _productResponse.data[_selectedPosition].productPrice),
                    imageUrl:
                        _productResponse.data[_selectedPosition].productThumb),
              );
            });
            _showToast();
          },
          color: Colors.red[800],
          textColor: Colors.white,
          label: Text(label.toUpperCase(), style: TextStyle(fontSize: 14)),
          icon: Icon(icon),
        ),
      ),
    );
  }

  Widget textList(Icon icon, String text, bool isSlash) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13.0, 0.0, 13.0, 0.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              decoration:
                  isSlash ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          Spacer(),
          icon,
        ],
      ),
    );
  }

  List<Widget> createList(ProductResponse data) {
    List<Widget> listWidget = List<Widget>();
    for (int i = 0; i < data.data.length; i++) {
      if (i == 1) {
        listWidget.add(createBestProductCard(i, data.data[i]));
      } else {
        listWidget.add(createProductCard(i, data.data[i]));
      }
    }
    return listWidget;
  }

  Widget createProductCard(int position, Data productDetail) {
    return Expanded(
      flex: 3,
      child: AspectRatio(
        aspectRatio: 100 / 100,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 130,
              width: constraints.maxWidth,
              child: Card(
                  shape: (position == _selectedPosition)
                      ? new RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0))
                      : new RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0)),
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPosition = position;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Image.network(
                            productDetail.productImages,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        Text(
                          productDetail.productName,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          formatValue(int.parse(productDetail.productPrice)),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  Widget createBestProductCard(int position, Data productDetail) {
    return Expanded(
      flex: 3,
      child: AspectRatio(
        aspectRatio: 100 / 100,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 130,
              width: constraints.maxWidth,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Card(
                      color: Colors.blueGrey[900],
                      shape: (position == _selectedPosition)
                          ? new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0))
                          : new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0)),
                      elevation: 3,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedPosition = position;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Image.network(
                                productDetail.productImages,
                                width: 40,
                                height: 40,
                              ),
                            ),
                            Text(
                              productDetail.productName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              formatValue(
                                  int.parse(productDetail.productPrice)),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    alignment: Alignment(1, -1),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 16,
                          ),
                          Text(
                            "Best",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String formatValue(int value) {
    final format = new NumberFormat.currency(
        locale: 'ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(value).toString();
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Product Berhasil Ditambahkan"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
