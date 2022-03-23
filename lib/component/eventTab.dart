import 'package:enforcea/component/ui/eventItem.dart';
import 'package:enforcea/model/eventData.dart';
import 'package:flutter/material.dart';

class EventTab extends StatelessWidget {
  final List<EventData> data;
  final category;

  EventTab({this.data, this.category});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(
        child: Column(children: getListWidget()),
      ),
    );
  }

  List<Widget> getListWidget() {
    List<EventData> list = filterList();
    List<Widget> widgets = new List<Widget>();
    list.forEach((element) {
      widgets.add(EventItem(
        eventData: element,
      ));
    });
    return widgets;
  }

  List<EventData> filterList() {
    if (category == 0) {
      return data;
    } else {
      return data.where((element) => element.type == category).toList();
    }
  }
}
