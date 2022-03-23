import 'package:enforcea/util/cache_util.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'constants.dart';
// import 'package:enforcea/home.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  void initState() {
    super.initState();
    splashScreenStart();
  }

  splashScreenStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      // Navigator.of(context).pushReplacementNamed("/home");
      CacheUtil.getBoolean(CACHE_IS_LOGIN)
          .then((value) => navigationHandler(value ?? false));
    });
  }

  void navigationHandler(bool isLogin) {
    // print("is login : " + isLogin.toString());
    // if (isLogin) {
    Navigator.of(context).pushReplacementNamed("/home");
    // } else {
    //   Navigator.of(context).pushReplacementNamed("/login");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[800],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 170,
          ),
          Image(
              width: 200, height: 200, image: AssetImage("assets/enforce.png")),
          SizedBox(
            height: 170,
          ),
          Text(
            "Versi 1.1",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ],
      )),
    );
  }
}
