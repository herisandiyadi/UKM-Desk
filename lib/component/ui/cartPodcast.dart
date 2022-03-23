import 'package:flutter/material.dart';
import 'package:enforcea/model/response/home/video_response.dart';

class CardPodcast extends StatefulWidget {
  Data vData;
  CardPodcast({Key key, this.vData}) : super(key: key);

  @override
  _CardPodcastState createState() => _CardPodcastState();
}

class _CardPodcastState extends State<CardPodcast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.vData.slide,
                width: 120,
                height: 120,
              ),
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
    );
  }
}
