import 'package:flutter/material.dart';
import 'package:enforcea/splashscreen.dart';
import 'package:enforcea/home.dart';
import 'package:enforcea/component/notificationNav.dart';
import 'package:enforcea/login.dart';
import 'package:enforcea/newsDetail.dart';
import 'package:enforcea/customBottomMenu.dart';
import 'cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enforcea',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(
              selectedPage: 0,
            ),
        // '/home': (BuildContext context) => CustomBotomMenu(),
        '/login': (BuildContext context) => Login(),
        '/detail_news': (BuildContext context) => NewsDetail(),
        '/cart': (BuildContext context) => Cart(),
        // '/notification': (BuildContext context) => NotificationNav(),
        '/notification': (BuildContext context) => Home(
              selectedPage: 3,
            ),
      },
    );
  }
}
