import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:enforcea/model/consultingData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

class ConsultingItem extends StatelessWidget {
  final ConsultingModel consultingData;

  ConsultingItem({this.consultingData});

  @override
  Widget build(BuildContext context) {
    return ReusableContainer(
      cardChild: consultingItemContant(context),
    );
  }

  Widget consultingItemContant(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.network(
            consultingData.image_1,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 10,
          ),
          Html(
            data: consultingData.isi,
            style: {
              "div": Style(textAlign: TextAlign.left),
            },
          ),
          // Text(
          //   consultingData.isi,
          //   style: TextStyle(
          //     fontSize: 16.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.black,
          //   ),
          // ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Email: contact@enforcea.com",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.red[900],
            ),
          ),
          Text(
            "WA: +62 888 0819 7062",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.red[900],
            ),
          ),
        ],
      ),
    );
  }
}
