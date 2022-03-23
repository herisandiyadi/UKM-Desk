import 'package:enforcea/component/downloadNav.dart';
import 'package:enforcea/component/settingNav.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/component/bottomBarView.dart';
import 'package:enforcea/component/headerNav.dart';
import 'package:enforcea/component/profileNav.dart';
import 'package:enforcea/model/tabIconData.dart';
import 'package:enforcea/theme/homeTheme.dart';
import 'package:enforcea/component/notificationNav.dart';
import 'package:enforcea/dashboard.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/bottomMenu.dart';
import 'constants.dart';
import 'dart:async';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:enforcea/component/ContactUs.dart';
import 'package:enforcea/component/historyNav.dart';
import 'package:enforcea/component/newsNav.dart';
import 'package:enforcea/login.dart';
import 'package:enforcea/termAndCondition.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  int selectedPage;
  bool drawBottomMenu;
  Home({Key key, this.selectedPage, this.drawBottomMenu = true})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController animationController;
  int tabIndex = 0;
  bool isLogin = false;
  bool isReinit = false;
  bool isMoreOption = false;
  List _itemsSelected = List();

  final _items = [
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tab/tab_1.png",
          height: 20,
        ),
        activeIcon: Image.asset(
          "assets/tab/tab_1s.png",
          height: 20,
        ),
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        )),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tab/tab_4.png",
          height: 20,
        ),
        activeIcon: Image.asset(
          "assets/tab/tab_4s.png",
          height: 20,
        ),
        title: Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tab/tab_2.png",
          height: 20,
        ),
        activeIcon: Image.asset(
          "assets/tab/tab_2s.png",
          height: 20,
        ),
        title: Text('Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tab/tab_3.png",
          height: 20,
        ),
        activeIcon: Image.asset(
          "assets/tab/tab_3s.png",
          height: 20,
        ),
        title: Text('Notification',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
    BottomNavigationBarItem(
        icon: Icon(Icons.more_vert),
        title: Text('More',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))
  ];

  final _nonLoginItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.person_add), title: Text('Sign In')),
    BottomNavigationBarItem(icon: SizedBox(), title: Text(' ')),
    BottomNavigationBarItem(icon: SizedBox(), title: Text(' ')),
    BottomNavigationBarItem(icon: SizedBox(), title: Text(' ')),
    BottomNavigationBarItem(
        icon: Icon(Icons.more_vert),
        title: Text('More',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))
  ];
  // List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  // List<TabIconData> notLoginTabIcons = TabIconData.tabIconsNotLogin;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget tabBody = Container(
    color: HomeTheme.background,
  );

  @override
  void initState() {
    _itemsSelected = _nonLoginItems;
    CacheUtil.getBoolean(CACHE_IS_LOGIN).then((value) {
      if (value) {
        isLogin = value;
      }
      if (!mounted) return;
      setState(() {
        _itemsSelected = _items;
      });
    });
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listPage = List<Widget>();
    listPage.add(HeaderNavPage(
      animationController: animationController,
      key: widget.key,
    ));
    listPage.add(ProfileNavPage(animationController: animationController));
    listPage.add(Dashboard(animationController: animationController));
    listPage.add(NotificationNav(
      animationController: animationController,
      key: widget.key,
    ));
    listPage.add(SizedBox());
    listPage.add(NewsNav(
      key: widget.key,
      type: "News",
    ));
    listPage.add(HistoryNav());
    listPage.add(DownloadNav());
    listPage.add(ContactUs());
    listPage.add(TermAndCondition());

    if (widget.selectedPage != 0) {
      setState(() {
        // bool test = navigatorKey.currentState.canPop();
        tabIndex = widget.selectedPage;
        widget.selectedPage = 0;
        if (!widget.drawBottomMenu) {
          // widget.drawBottomMenu = false;
          isReinit = true;
        }
      });
      // navigatorKey.currentState.pop();
    }

    return Container(
      color: HomeTheme.background,
      child: WillPopScope(
        onWillPop: () {
          bool test = navigatorKey.currentState.canPop();
          if (test) {
            navigatorKey.currentState.maybePop();
          } else if (isMoreOption) {
            setState(() => {tabIndex = 0});
            isMoreOption = false;
          } else {
            _onBackPressed();
          }
        },
        child: Scaffold(
            key: widget.key,
            bottomNavigationBar: defaultBottomBar(),
            backgroundColor: Colors.transparent,
            body: CustomNavigator(
              navigatorKey: navigatorKey,
              home: listPage[tabIndex],
              pageRoute: PageRoutes.materialPageRoute,
            )),
      ),
    );
  }

  Widget defaultBottomBar() {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.purple[800],
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.grey))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex < _itemsSelected.length ? tabIndex : 0,
        items: _itemsSelected,
        onTap: (index) {
          if (index == 4) {
            modalBottomPopup(context);
          } else if (isLogin) {
            bool test = navigatorKey.currentState.canPop();
            if (test || isReinit) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(
                    selectedPage: index,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            } else {
              setState(() => {tabIndex = index});
            }
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(''),
            content: new Text('Anda yakin ingin keluar dari aplikasi?'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => {SystemNavigator.pop()},
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget modalBottomPopup(context) {
    bool isLogin = false;
    String name = "Sign In";
    CacheUtil.getBoolean(CACHE_IS_LOGIN).then((value) {
      if (value) {
        isLogin = value;
      }
    });
    CacheUtil.getString(CACHE_NAME).then((value) => {
          if (value != null) {name = value}
        });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          color: Colors.black54.withOpacity(0.6),
          height: isLogin
              ? MediaQuery.of(context).size.height * .46
              : MediaQuery.of(context).size.height * .37,
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 40,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red[800],
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  Container(
                    decoration: boxDecoration(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => NewsNav(
                        //             key: widget.key,
                        //             type: "News",
                        //           )),
                        // );
                        setState(() => {tabIndex = 5});
                        isMoreOption = true;
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => NewsNav(
                        //             type: "News",
                        //           )),
                        // );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.library_books,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "News & Insight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  isLogin
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => HistoryNav()),
                              // );
                              setState(() => {tabIndex = 6});

                              isMoreOption = true;
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "History",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => DownloadNav()),
                        // );
                        setState(() => {tabIndex = 7});

                        isMoreOption = true;
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.file_download,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Download",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ContactUs()));
                        setState(() => {tabIndex = 8});

                        isMoreOption = true;
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Contact Us",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: boxDecoration(),
                  ),
                  isLogin
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Home(
                              //             selectedPage: 0,
                              //           )),
                              // );
                              setState(() => {tabIndex = 1});

                              isMoreOption = true;
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Settings",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  size: 25,
                                ),
                              ],
                            ),
                          ))
                      : SizedBox(),
                  Padding(
                      padding: const EdgeInsets.only(left: 8, top: 5),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() => {tabIndex = 9});
                          },
                          child: Row(children: [
                            Icon(
                              Icons.security,
                              size: 15,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Privacy & Terms",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ))),
                            Spacer(),
                            Icon(
                              Icons.chevron_right,
                              size: 25,
                            ),
                          ]))),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (isLogin) {
                          Navigator.of(context).pushReplacementNamed("/home");
                          CacheUtil.clear();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              isLogin ? "Logout" : "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          //                    <--- top side
          color: Colors.black54,
          width: 3.0,
        ),
      ),
    );
  }
}
