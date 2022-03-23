import 'package:enforcea/component/eventTab.dart';
import 'package:enforcea/model/eventData.dart';
import 'package:flutter/material.dart';

class EventNav extends StatefulWidget {
  @override
  _EventNavState createState() => _EventNavState();
}

class _EventNavState extends State<EventNav>
    with SingleTickerProviderStateMixin {
  TabController controller;
  List<Tab> tabs = <Tab>[
    Tab(text: 'Pelatihan & Event'),
    Tab(text: 'Video'),
    Tab(text: 'Buku & Publikasi'),
    Tab(text: 'Regulasi & Template Pilihan'),
  ];
  int _index = 0;

  @override
  void initState() {
    controller = TabController(vsync: this, length: tabs.length);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = tabs[_index].text;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.red[800],
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.red[800],
            isScrollable: true,
            tabs: tabs,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            controller: controller,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.red[50]
          ),
          child: TabBarView(
            children: [
              new EventTab(data: EventData.listEvent,
                  category: EventData.PELATIHAN_EVENT),
              new EventTab(
                  data: EventData.listEvent, category: EventData.VIDEO),
              new EventTab(data: EventData.listEvent,
                  category: EventData.BUKU_PUBLIKASI),
              new EventTab(
                  data: EventData.listEvent, category: EventData.REGULASI),
            ],
            controller: controller,
          ),
        ));
  }
}
