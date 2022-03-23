import 'package:flutter/material.dart';

class Button {
  Widget actionButton(IconData icon, String label, Function event) {
    return ButtonTheme(
      minWidth: 250,
      child: RaisedButton.icon(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          event();
        },
        color: Colors.red[800],
        textColor: Colors.white,
        label: Text(label.toUpperCase(), style: TextStyle(fontSize: 14)),
        icon: Icon(icon),
      ),
    );
  }
}
