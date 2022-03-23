import 'package:flutter/material.dart';

class CardLable extends StatelessWidget {
  final String label1;
  final Icon icon1;
  final String label2;
  final Icon icon2;
  final String label3;
  final Icon icon3;
  final AnimationController animationController;
  final Animation animation;

  const CardLable(
      {Key key,
      this.label1: "",
      this.icon1,
      this.label2: "",
      this.icon2,
      this.label3: "",
      this.icon3,
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
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  height: 150,
                  width: double.maxFinite,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 110,
                        width: 110,
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: <Widget>[
                                Image(
                                    height: 80,
                                    image:
                                        AssetImage("assets/update/logo.png")),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 110,
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Image(
                                    height: 70,
                                    image: AssetImage(
                                        "assets/update/podcast.png")),
                                Text(
                                  label2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 110,
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Image(
                                    height: 70,
                                    image: AssetImage(
                                        "assets/update/youtube.png")),
                                Text(
                                  label3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        );
      },
    );
  }
}
