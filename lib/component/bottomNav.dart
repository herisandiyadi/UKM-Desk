import 'package:flutter/material.dart';
import 'package:enforcea/component/bannerNav.dart';
import 'package:enforcea/component/headerNav.dart';

class BottomNav extends StatefulWidget {
  // BannerNav({Key key, @required this.pageList}) : super(key: key);
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      BannerNav(),
      HeaderNavPage(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Sign Up')),
      BottomNavigationBarItem(icon: Icon(Icons.more), title: Text('More')),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: selectedTabIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      onTap: _onNavBarTapped,
    );

    return Scaffold(
      body: Center(
        child: _listPage[selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
