import 'package:flutter/material.dart';
import 'package:enforcea/model/response/home/video_response.dart';

class CardPlayer extends StatefulWidget {
  Data vData;
  Image image;
  Function goToPage;
  CardPlayer({Key key, this.vData, this.goToPage, this.image})
      : super(key: key);

  @override
  _CardPlayerState createState() => _CardPlayerState();
}

class _CardPlayerState extends State<CardPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          widget.goToPage();
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.image,
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(widget.vData.title),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
