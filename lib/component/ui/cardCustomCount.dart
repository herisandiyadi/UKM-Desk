import 'package:flutter/material.dart';



class CardCustomCount extends StatefulWidget {
  final String label1;
  final Icon icon1;
  final void Function() page1;
  final String descLabel1;
  final String label2;
  final Icon icon2;
  final void Function() page2;
  final String descLabel2;
  final String label3;
  final Icon icon3;
  final void Function() page3;
  final String descLabel3;
  final String label4;
  final Icon icon4;
  final void Function() page4;
  final String descLabel4;
  final String label5;
  final Icon icon5;
  final void Function() page5;
  final String descLabel5;
  final AnimationController animationController;
  final Animation animation;

  const CardCustomCount(
      {Key key,
      this.label1: "",
      this.icon1,
      this.page1,
      this.descLabel1,
      this.label2: "",
      this.icon2,
      this.page2,
      this.descLabel2,
      this.label3: "",
      this.icon3,
      this.page3,
      this.descLabel3,
      this.label4: "",
      this.icon4,
      this.page4,
      this.descLabel4,
      this.label5: "",
      this.icon5,
      this.page5,
      this.descLabel5,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  _CardCustomCountState createState() => _CardCustomCountState();
}

class _CardCustomCountState extends State<CardCustomCount> {
  bool selectedCard1 =false;
  bool selectedCard2 =false;
  bool selectedCard3 =false;
  bool selectedCard4 =false;
  bool selectedCard5 =false;
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
                  height: 100,
                  width: double.maxFinite,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
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
                                this.selectedCard4 = false ; 
                                this.selectedCard5 = false ;  
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.descLabel1,
                                  style: TextStyle(
                                      fontSize: 10,),
                                ),
                              ],
                            ),
                          ),
                          )
                        ),
                      ),
                      if (widget.label2 != "") 
                        Container(
                          height: 120,
                          width: 110,
                          child: InkWell(
                              onTap: (){
                                setState(() {
                                  this.selectedCard1 = false ; 
                                  this.selectedCard2 = true ; 
                                  this.selectedCard3 = false ; 
                                  this.selectedCard4 = false ; 
                                  this.selectedCard5 = false ; 
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
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: widget.icon2,
                                    ),
                                    Text(
                                      widget.label2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                        fontWeight: FontWeight.bold,),
                                    ),
                                    Text(
                                      widget.descLabel2,
                                      style: TextStyle(
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                      if (widget.label3 != "") 
                        Container(
                          height: 120,
                          width: 110,
                          child: InkWell(
                              onTap: (){
                                setState(() {
                                  this.selectedCard1 = false ; 
                                  this.selectedCard2 = false ; 
                                  this.selectedCard3 = true ;
                                  this.selectedCard4 = false ; 
                                  this.selectedCard5 = false ;  
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
                                          fontSize: 12,
                                        fontWeight: FontWeight.bold,),
                                    ),
                                    Text(
                                      widget.descLabel3,
                                      style: TextStyle(
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (widget.label4 != "") 
                        Container(
                          height: 120,
                          width: 110,
                          child: InkWell(
                              onTap: (){
                                setState(() {
                                  this.selectedCard1 = false ; 
                                  this.selectedCard2 = false ; 
                                  this.selectedCard3 = false ; 
                                  this.selectedCard4 = true ; 
                                  this.selectedCard5 = false ; 
                                });
                                widget.page4();
                              },
                              child: Card(
                                shape: selectedCard4
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
                                      child: widget.icon4,
                                    ),
                                    Text(
                                      widget.label4,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                        fontWeight: FontWeight.bold,),
                                    ),
                                    Text(
                                      widget.descLabel4,
                                      style: TextStyle(
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (widget.label5 != "") 
                        Container(
                          height: 120,
                          width: 110,
                          child: InkWell(
                              onTap: (){
                                setState(() {
                                  this.selectedCard1 = false ; 
                                  this.selectedCard2 = false ; 
                                  this.selectedCard3 = false ; 
                                  this.selectedCard4 = false ; 
                                  this.selectedCard5 = true ; 
                                });
                                widget.page5();
                              },
                              child: Card(
                                shape: selectedCard5
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
                                      child: widget.icon5,
                                    ),
                                    Text(
                                      widget.label5,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                        fontWeight: FontWeight.bold,),
                                    ),
                                    Text(
                                      widget.descLabel5,
                                      style: TextStyle(
                                          fontSize: 10),
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
