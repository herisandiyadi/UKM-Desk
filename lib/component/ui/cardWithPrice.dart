import 'package:flutter/material.dart';



class CardWithPrice extends StatefulWidget {
  final String label1;
  final Icon icon1;
  final void Function() page1;
  final String price1;
  final String label2;
  final Icon icon2;
  final void Function() page2;
  final String price2;
  final String label3;
  final Icon icon3;
  final void Function() page3;
  final String price3;
  final AnimationController animationController;
  final Animation animation;

  const CardWithPrice(
      {Key key,
      this.label1: "",
      this.icon1,
      this.page1,
      this.price1,
      this.label2: "",
      this.icon2,
      this.page2,
      this.price2,
      this.label3: "",
      this.icon3,
      this.page3,
      this.price3,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  _CardWithPriceState createState() => _CardWithPriceState();
}

class _CardWithPriceState extends State<CardWithPrice> {
  bool selectedCard1 =false;
  bool selectedCard2 =false;
  bool selectedCard3 =false;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation.value), 0.0),
              child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  height: 150,
                  width: double.maxFinite,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 120,
                        width: 110,
                        child: Card(
                          shape: selectedCard1
                          ? new RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0))
                          : new RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0)),
                          elevation: 3,
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                this.selectedCard1 = true ; 
                                this.selectedCard2 = false ; 
                                this.selectedCard3 = false ; 
                              });
                              widget.page1();
                              },
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: widget.icon1,
                                ),
                                Text(
                                  widget.label1,
                                  style: TextStyle(
                                      fontSize: 12),
                                ),
                                Text(
                                  widget.price1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,),
                                ),
                              ],
                            ),
                          ),
                          )
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 110,
                        child: InkWell(
                           onTap: (){
                              setState(() {
                                this.selectedCard1 = false ; 
                                this.selectedCard2 = true ; 
                                this.selectedCard3 = false ; 
                              });
                              widget.page2();
                            },
                          child: Card(
                            shape: selectedCard2
                          ? new RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0))
                          : new RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0)),
                            color: Colors.grey[850],
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                      children: <Widget>[
                                           Padding(
                                             padding: const EdgeInsets.only(left: 20, bottom: 5),
                                             child: widget.icon2,
                                           ),
                                          Row(
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                ),
                                                Icon(Icons.check_circle_outline, color: Colors.green,),
                                              ],
                                            ) 
                                      ]
                                  ),
                                 
                                  Text(
                                    widget.label2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,),
                                  ),
                                   Text(
                                     widget.price2,
                                    style: TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,color: Colors.red[300]),
                                  ),
//                                  Text(
//                                    widget.price2,
//                                    style: TextStyle(
//                                        fontSize: 12, fontWeight: FontWeight.bold,
//                                        color: Colors.white,),
//                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 110,
                        child: InkWell(
                            onTap: (){
                              setState(() {
                                this.selectedCard1 = false ; 
                                this.selectedCard2 = false ; 
                                this.selectedCard3 = true ; 
                              });
                              widget.page3();
                            },
                            child: Card(
                              shape: selectedCard3
                          ? new RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0))
                          : new RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0)),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: widget.icon3,
                                  ),
                                  Text(
                                    widget.label3,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12),
                                  ),
                                  Text(
                                    widget.price3,
                                    style: TextStyle(
                                        fontSize: 12,
                                      fontWeight: FontWeight.bold,),
                                  ),
                                ],
                              ),
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
