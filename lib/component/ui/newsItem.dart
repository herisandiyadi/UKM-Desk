import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/model/response/home/content_response.dart';
import 'package:enforcea/newsDetail.dart';

class NewsItem extends StatelessWidget {
  Data contentData;
  String type;

  NewsItem({this.contentData, this.type});

  @override
  Widget build(BuildContext context) {
    return ReusableContainer(
      cardChild: newsContent(),
      onPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsDetail(
                    contentID: contentData.id,
                    type: type,
                  )),
        );
      },
    );
  }

  Widget newsContent() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contentData.titleID,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Tanggal: " + contentData.postedDate,
                style: TextStyle(fontSize: 12.0, color: Colors.black),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     GestureDetector(
              //       child: Icon(Icons.mode_comment),
              //       onTap: () {
              //         print("Comment");
              //       },
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     GestureDetector(
              //         onTap: () {
              //           print("Like");
              //         },
              //         child: Icon(Icons.star_border)),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     GestureDetector(
              //         onTap: () {
              //           print("Share");
              //         },
              //         child: Icon(Icons.share))
              //   ],
              // )
            ],
          ),
        ),
        SizedBox(
          height: 10,
          width: 10,
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: Image.network(contentData.icon),
        )
      ],
    );
  }
}
