import 'package:enforcea/component/ui/consultingItem.dart';
import 'package:enforcea/model/expatData.dart';
import 'package:enforcea/model/consultingData.dart';
import 'package:enforcea/model/listData.dart';
import 'package:enforcea/model/response/api_response.dart';
import 'package:enforcea/model/response/consulting_response.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/component/consultingTab.dart';
import 'package:enforcea/component/ui/loading.dart';
import 'package:enforcea/bottomMenu.dart';

class ExpatriatNav extends StatefulWidget {
  @override
  _ExpatriatNavState createState() => _ExpatriatNavState();
}

class _ExpatriatNavState extends State<ExpatriatNav>
    with SingleTickerProviderStateMixin {
  TabController controller;

  List<Tab> tabs = <Tab>[
    Tab(text: "FDI Tax"),
    Tab(text: "Branch"),
    Tab(text: "Expatriates Tax"),
    Tab(text: "Digital Tax"),
    Tab(text: "Representative"),
  ];
  int _index = 0;
  ExpatData _bloc;

  @override
  void initState() {
    controller = TabController(vsync: this, length: tabs.length);
    super.initState();
    _bloc = ExpatData();
  }

  @override
  void dispose() {
    controller.dispose();
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchConsulting(),
        child: StreamBuilder<ApiResponse<List<ConsultingModel>>>(
          stream: _bloc.consulListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return AppBarDrawer(snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchConsulting(),
                  );
                  break;
              }
              return Text("data");
            }
          },
        ),
      ),
    );
  }

  Widget AppBarDrawer(List<ConsultingModel> listEvent) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text("FDI & Expatriates"),
        backgroundColor: Colors.red[800],
        bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              tabs: tabs,
              onTap: (index) {
                setState(() {
                  _index = index;
                });
              },
              controller: controller,
            ),
            preferredSize: Size.fromHeight(30.0)),
      ),
      body: TabBarView(
        children: [
          new ConsultingTab(data: listEvent, category: ExpatData.FDI_TAX),
          new ConsultingTab(data: listEvent, category: ExpatData.BRANCH),
          new ConsultingTab(
              data: listEvent, category: ExpatData.EXPATRIATES_TAX),
          new ConsultingTab(data: listEvent, category: ExpatData.DIGITAL_TAX),
          new ConsultingTab(
              data: listEvent, category: ExpatData.REPRESENTATIVE),
        ],
        controller: controller,
      ),
    );
  }
}

class ConsultAdvis extends StatelessWidget {
  final ConsultingModel content;
  const ConsultAdvis({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("content.article"),
    );
  }
}
