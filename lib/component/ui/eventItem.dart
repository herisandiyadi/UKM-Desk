import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:enforcea/model/eventData.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final EventData eventData;

  EventItem({this.eventData});

  @override
  Widget build(BuildContext context) {
    return ReusableContainer(
      cardChild: eventItemContent(context),
    );
  }

  Widget eventItemContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Image.asset(
          'assets/event_1.jpeg',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
//        SizedBox(
//          width: 10,
//        ),
//        Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisSize: MainAxisSize.max,
//          children: [
//            Text(eventData.title),
//            Text(eventData.value),
//          ],
//        ),
      SizedBox(height: 10,),
        Text(
          eventData.title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8,),

        Text(
          eventData.value,
          style: TextStyle(fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ],
    );
  }
}
