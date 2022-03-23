import 'package:flutter/material.dart';

import 'package:enforcea/bottomMenu.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Tools"),
        backgroundColor: Colors.red[800],
      ),
      body: Center(
        child: Image.asset("assets/under-construction.jpg"),
      ),
    );
  }
}
