import 'package:enforcea/component/ui/consultingItem.dart';
import 'package:enforcea/model/consultingData.dart';
import 'package:flutter/material.dart';

class ConsultingTab extends StatelessWidget {
  final List<ConsultingModel> data;
  final category;

  ConsultingTab({this.data, this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: getListWidget()),
      ),
    );
  }

  List<Widget> getListWidget() {
    List<ConsultingModel> list = filterList();
    List<Widget> widgets = new List<Widget>();
    list.forEach((element) {
      widgets.add(ConsultingItem(
        consultingData: element,
      ));
    });
    widgets.add(SizedBox(
      height: 70,
    ));
    return widgets;
  }

  List<ConsultingModel> filterList() {
    if (category == 0) {
      return data;
    } else {
      return data.where((element) => element.type == category).toList();
    }
  }
}
