import 'package:flutter/material.dart';

class CardFeatureView extends StatelessWidget {
  final String label1;
  final String icon1;
  final void Function() page1;
  final String label2;
  final String icon2;
  final void Function() page2;
  final String label3;
  final String icon3;
  final void Function() page3;
  final AnimationController animationController;
  final Animation animation;

  const CardFeatureView(
      {Key key,
      this.label1: "",
      this.icon1,
      this.page1,
      this.label2: "",
      this.icon2,
      this.page2,
      this.label3: "",
      this.icon3,
      this.page3,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation.value), 0.0),
              child: Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  height: 100,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      menu(icon1, label1, page1),
                      Spacer(),
                      menu(icon2, label2, page2),
                      Spacer(),
                      menu(icon3, label3, page3),
                    ],
                  ))),
        );
      },
    );
  }

  Widget menu(String asset, String label, Function function) {
    return Container(
      height: 100,
      width: 110,
      child: Card(
        elevation: 5,
        child: Ink(
          child: InkWell(
            onTap: function,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child:
                        Image(height: 40, width: 40, image: AssetImage(asset)),
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
