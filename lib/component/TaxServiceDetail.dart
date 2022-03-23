import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/model/response/consulting_response.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:enforcea/bottomMenu.dart';

class TaxServicesDetail extends StatelessWidget {
  final Data data;

  TaxServicesDetail({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Tax Services"),
              backgroundColor: Colors.red[800],
            ),
            body: initDisplay()));
  }

  Widget initDisplay() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  height: 240,
                  child: Image.network(
                    data.image_1,
                    fit: BoxFit.fill,
                  )),
              // Container(
              //   alignment: Alignment.center,
              //   height: 240,
              //   child: Image.network(
              //     data.image_2,
              //     width: 190,
              //   ),
              // )
            ],
          ),
          Html(
            data: data.isi,
            style: {
              "div": Style(textAlign: TextAlign.left),
              "h2": Style(fontSize: FontSize.large, textAlign: TextAlign.left)
            },
          ),
          SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}
