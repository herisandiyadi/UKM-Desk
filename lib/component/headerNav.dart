import 'package:enforcea/component/TaxServicesNav.dart';
import 'package:enforcea/component/consultingNav.dart';
import 'package:enforcea/component/downloadNav.dart';
import 'package:enforcea/component/eventNav.dart';
import 'package:enforcea/component/expatriatNav.dart';
import 'package:enforcea/component/searchNav.dart';
import 'package:enforcea/component/ui/onlineConsultingNav.dart';
import 'package:enforcea/component/underConstruction.dart';
import 'package:enforcea/taxTools.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/component/ui/titleView.dart';
import 'package:enforcea/component/ui/cardLable.dart';
import 'package:enforcea/component/ui/cardView.dart';
import 'package:enforcea/component/ui/cardFeatureView.dart';
import 'package:enforcea/theme/homeTheme.dart';
import 'package:enforcea/component/bannerNav.dart';
import 'package:enforcea/component/bannerVideo.dart';
import 'package:enforcea/component/bannerNewsNav.dart';
import 'package:enforcea/ukmDesk.dart';
import 'package:enforcea/component/newsNav.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/cubit/home/home_cubit.dart';
import 'package:enforcea/model/response/home/banner_response.dart';
import 'package:enforcea/repository/home/banner_repository.dart';
import 'package:enforcea/cubit/ukm_desk/ukm_desk_cubit.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/playerList.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class HeaderNavPage extends StatefulWidget {
  const HeaderNavPage({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  _HeaderNavPageState createState() => _HeaderNavPageState();
}

class _HeaderNavPageState extends State<HeaderNavPage> {
  bool isloaded = false;
  List<Widget> listViews = <Widget>[];
  int monthLeft = 0;
  CartModel cartModelPack;

  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  final data = [
    'One',
  ];

  int value = 1000;

  ScrollController _scrollController;
  bool lastStatus = true;
  Future<dynamic> futureCard;
  List<dynamic> dataList = [];
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 &&
          _scrollController.offset >= 0) {
        if (topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();
  }

  Future<dynamic> fetchCard() async {
    CacheUtil.getString(CACHE_NAME).then((value) => {
          if (value == null) {dataList.add("-")} else {dataList.add(value)}
        });

    int _totalCart = 0;
    List<CartModel> totalResult = await dbHelper.getCartList();
    if (totalResult.length > 0) {
      totalResult.forEach((element) {
        _totalCart = _totalCart + (element.price * element.count);
      });
    }
    value = _totalCart;
    dataList.add(_totalCart);
    print(dataList.length);
    return Future.value(dataList);
  }

  Future refreshData() async {
    // setState(() {
    listViews.removeAt(0);
    futureCard = fetchCard();
    listViews.insert(
      0,
      FutureBuilder(
        future: futureCard,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data[0].toString() != "-") {
            return CardView(
              titleTxt: snapshot.data[0].toString(),
              subTxt: '',
              montLeft: monthLeft < 0 ? 0 : monthLeft,
              cart: value,
              animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / 9) * 0, 1.0,
                          curve: Curves.fastOutSlowIn))),
              animationController: widget.animationController,
              cartModel: cartModelPack,
            );
          } else {
            return Image.network(
                "https://www.enforcea.com/static/banner_top.gif");
          }
        },
      ),
    );
    setState(() {});
  }

  void addAllListData() {
    futureCard = fetchCard();
    const int count = 9;
    listViews.add(
      FutureBuilder(
        future: futureCard,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data[0].toString() != "-") {
            return CardView(
              titleTxt: snapshot.data[0].toString(),
              subTxt: '',
              montLeft: monthLeft < 0 ? 0 : monthLeft,
              cart: value,
              animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / count) * 0, 1.0,
                          curve: Curves.fastOutSlowIn))),
              animationController: widget.animationController,
              cartModel: cartModelPack,
            );
          } else {
            return Image.network(
                "https://www.enforcea.com/static/banner_top.gif");
          }
        },
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Our Services',
        subTxt: '',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      CardFeatureView(
        label1: 'UKM Desk',
        icon1: "assets/services/UKM Desk.png",
        page1: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => UKMDesk(
                      key: widget.key,
                    )),
          );
        },
        label2: "Online Consulting",
        icon2: "assets/services/Online Consulting.png",
        page2: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnlineConsulting()),
          );
        },
        label3: "Tax Services",
        icon3: "assets/services/Tax Services.png",
        page3: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaxServicesNav()),
          );
        },
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
      CardFeatureView(
        label1: 'PE & Expat',
        icon1: "assets/services/PE _ Expat.png",
        page1: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExpatriatNav()),
          );
        },
        label2: "Literacy",
        icon2: "assets/services/Literacy.png",
        page2: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DownloadNav(
                      type: "ebook",
                    )),
          );
        },
        label3: "Tax Tools",
        icon3: "assets/services/Tax Tools.png",
        page3: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaxTools()),
          );
        },
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: BlocProvider(
        create: (providerContext) => HomeCubit(BannerRepository()),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (builderContext, state) {
            if (state is HomeLoaded) {
              if (!isloaded) {
                addAllListData();
                monthLeft = state.monthLeft != null ? state.monthLeft.data : 0;
                addSliderList(state.bannerData.data, state.articleData.data,
                    state.newsData.data, state.videoData.data);

                if (state.renewalPack != null && state.renewalPack.success) {
                  final renewPack = state.renewalPack;
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM').format(now);
                  cartModelPack = CartModel(
                      id: renewPack.data.id,
                      count: 1,
                      name: renewPack.data.productName,
                      imageUrl: renewPack.data.image,
                      price: renewPack.data.price,
                      date: formattedDate);
                  cartModelPack.setRenewalStatus(true);
                }
                isloaded = true;
              }

              return drawHomePage();
            } else if (state is HomeInitial || state is HomeLoading) {
              if (state is HomeInitial) {
                final homeCubit = builderContext.bloc<HomeCubit>();
                homeCubit.getHomePage();
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
                ),
              );
            } else {
              return drawHomePage();
            }
          },
        ),
      ),
    );
  }

  Widget drawHomePage() {
    return Container(
      color: HomeTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HomeTheme.white.withOpacity(topBarOpacity),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color:
                              HomeTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 10 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 35.0,
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      child: TextField(
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          showSearch(
                                              context: context,
                                              delegate: SearchNav());
                                        },
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          height: 2.0,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 10.0),
                                          border: InputBorder.none,
                                          hintText: "Search app",
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    showSearch(
                                        context: context,
                                        delegate: SearchNav());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  addSliderList(banner, articles, news, videos) {
    int count = 9;
    if (banner != null) {
      listViews.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleView(
            titleTxt: 'Tax Flash',
            subTxt: 'See Details',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsNav(
                          type: "Flash",
                        )),
              );
            },
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / 9) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
        ),
      );
      listViews.add(
        BannerNav(
          mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve:
                      Interval((1 / 9) * 3, 1.0, curve: Curves.fastOutSlowIn))),
          mainScreenAnimationController: widget.animationController,
          imgList: banner,
          type: "Flash",
        ),
      );
    }

    listViews.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TitleView(
          titleTxt: 'Video & Podcast',
          subTxt: 'See Details',
          onTab: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayerListPage()),
            );
          },
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve:
                      Interval((1 / 9) * 2, 1.0, curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      BannerVideo(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve:
                    Interval((1 / 9) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        imgList: videos,
      ),
    );

    if (articles != null) {
      listViews.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleView(
            titleTxt: 'Article',
            subTxt: 'See Details',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsNav(
                          type: "Article",
                        )),
              );
            },
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / 9) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
        ),
      );
      listViews.add(
        BannerNav(
          mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve:
                      Interval((1 / 9) * 3, 1.0, curve: Curves.fastOutSlowIn))),
          mainScreenAnimationController: widget.animationController,
          imgList: articles,
          type: "Article",
        ),
      );
    }

    listViews.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TitleView(
          titleTxt: 'News & Regulation',
          subTxt: 'See Details',
          onTab: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsNav(
                        type: "News",
                      )),
            );
          },
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 2, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );

    listViews.add(
      BannerNav(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve:
                    Interval((1 / 9) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        imgList: news,
        type: "News",
      ),
    );
  }
}
