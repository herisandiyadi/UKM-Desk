import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final Function onPress;
  final Widget cardChild;

  ReusableContainer({this.onPress, @required this.cardChild});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: cardChild,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
            ]),
      ),
    );
  }

}
