import 'package:enforcea/component/bottomBarViewInside.dart';
import 'package:intl/intl.dart';
import 'package:enforcea/model/tabIconData.dart';
import 'package:enforcea/theme/homeTheme.dart';
import 'package:enforcea/component/headerNav.dart';
import 'package:enforcea/component/headerNav.dart';
import 'package:enforcea/component/profileNav.dart';
import 'package:enforcea/component/notificationNav.dart';
import 'package:enforcea/dashboard.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/constants.dart';

import 'package:enforcea/home.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> with TickerProviderStateMixin {
  AnimationController animationController;
  dynamic tabIconsListUsed;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  List<TabIconData> notLoginTabIcons = TabIconData.tabIconsNotLogin;
  Widget tabBody = Container(
    color: HomeTheme.background,
  );

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animationController.forward();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabIconsListUsed = bottomBar();
    CacheUtil.getBoolean(CACHE_IS_LOGIN).then((value) {
      if (value == null) {
        tabIconsListUsed = simpleBottomBar();
      } else {
        tabIconsListUsed = bottomBar();
      }
      // if (!mounted) return;
      // setState(() {});
    });

    return Container(
      child: tabIconsListUsed,
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarViewInside(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        selectedPage: index,
                      )),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    );
  }

  Widget simpleBottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarViewInside(
          tabIconsList: notLoginTabIcons,
          addClick: () {},
          changeIndex: (int index) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        selectedPage: index,
                      )),
            );
          },
        ),
      ],
    );
  }
}
