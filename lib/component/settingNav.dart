import 'package:enforcea/component/ui/settingItem.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingNav extends StatefulWidget {
  @override
  _SettingNavState createState() => _SettingNavState();
}

class _SettingNavState extends State<SettingNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SettingItem(onPress: (){
                Fluttertoast.showToast(
                    msg: 'Download',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[600],
                    textColor: Colors.white,
                    fontSize: 16.0);
              },),
              divider(),
              SettingItem(),
              divider(),
              SettingItem(),
              divider(),
            ],
          ),
        ),
      ),
    );
  }

  Divider divider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 0,
    );
  }
}
