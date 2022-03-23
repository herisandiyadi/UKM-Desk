import 'dart:io';

import 'package:enforcea/component/dashboard/account_report_list.dart';
import 'package:enforcea/component/dashboard/faq_list.dart';
import 'package:enforcea/component/dashboard/tax_report_list.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/component/ui/bannerList.dart';
import 'package:enforcea/component/ui/cardCustomCount.dart';

import 'package:enforcea/component/dashboard/template.dart';
import 'package:enforcea/component/dashboard/upload.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  bool selectedUpload = false;
  bool selectedTax = false;
  bool selectedAccounting = false;
  bool selectedTemplate = false;
  bool selectedFAQ = false;

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
          backgroundColor: Colors.red[800],
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.network(
                    "https://www.enforcea.com/assets/img3/pagetitle-bg-14.jpg"),
                CardCustomCount(
                  label1: 'Upload',
                  descLabel1: '',
                  icon1: Icon(
                    Icons.cloud_upload,
                    size: 40,
                  ),
                  page1: () {
                    setState(() {
                      this.selectedUpload = true;
                      this.selectedTax = false;
                      this.selectedAccounting = false;
                      this.selectedTemplate = false;
                      this.selectedFAQ = false;
                    });
                  },
                  label2: "Tax Report",
                  descLabel2: '',
                  icon2: Icon(
                    Icons.content_paste,
                    size: 40,
                  ),
                  page2: () {
                    setState(() {
                      this.selectedUpload = false;
                      this.selectedTax = true;
                      this.selectedAccounting = false;
                      this.selectedTemplate = false;
                      this.selectedFAQ = false;
                    });
                  },
                  label3: "Accounting",
                  descLabel3: '',
                  icon3: Icon(
                    Icons.broken_image,
                    size: 40,
                  ),
                  page3: () {
                    setState(() {
                      this.selectedUpload = false;
                      this.selectedTax = false;
                      this.selectedAccounting = true;
                      this.selectedTemplate = false;
                      this.selectedFAQ = false;
                    });
                  },
                  label4: "Template",
                  descLabel4: '',
                  icon4: Icon(
                    Icons.tab,
                    size: 40,
                  ),
                  page4: () {
                    setState(() {
                      this.selectedUpload = false;
                      this.selectedTax = false;
                      this.selectedAccounting = false;
                      this.selectedTemplate = true;
                      this.selectedFAQ = false;
                    });
                  },
                  label5: "FAQ",
                  descLabel5: '',
                  icon5: Icon(
                    Icons.question_answer,
                    size: 40,
                  ),
                  page5: () {
                    setState(() {
                      this.selectedUpload = false;
                      this.selectedTax = false;
                      this.selectedAccounting = false;
                      this.selectedTemplate = false;
                      this.selectedFAQ = true;
                    });
                  },
                  animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.animationController,
                          curve: Interval((1 / 3) * 0, 1.0,
                              curve: Curves.fastOutSlowIn))),
                  animationController: widget.animationController,
                ),
                AnimatedBuilder(
                    animation: widget.animationController,
                    builder: (BuildContext context, Widget child) {
                      return FadeTransition(
                          opacity: widget.animationController,
                          child: new Transform(
                            transform: new Matrix4.translationValues(
                                0.0,
                                30 * (1.0 - widget.animationController.value),
                                0.0),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              width: double.maxFinite,
                              child: bodyFunc(),
                            ),
                          ));
                    }),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyFunc() {
    return this.selectedUpload
        ? upload()
        : this.selectedTax
            ? TaxReportList()
            : this.selectedAccounting
                ? AccountingReportList()
                : this.selectedTemplate
                    ? TemplateList()
                    : this.selectedFAQ
                        ? FaqList()
                        : SizedBox(
                            height: 10,
                          );
  }

  Widget genButton(IconData icon, String label, Function event) {
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

  Widget textList(Icon icon, String text, bool isSlash) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13.0, 0.0, 13.0, 0.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              decoration:
                  isSlash ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          Spacer(),
          icon,
        ],
      ),
    );
  }
}
