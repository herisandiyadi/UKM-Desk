import 'package:enforcea/component/ui/consultingItem.dart';
import 'package:enforcea/model/consultingData.dart';
import 'package:enforcea/model/listData.dart';
import 'package:enforcea/model/response/api_response.dart';
import 'package:enforcea/model/response/consulting_response.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/component/consultingTab.dart';
import 'package:enforcea/component/ui/loading.dart';

class TaxServices extends StatefulWidget {
  @override
  _TaxServicesState createState() => _TaxServicesState();
}

class _TaxServicesState extends State<TaxServices>
    with SingleTickerProviderStateMixin {
  TabController controller;

  List<Tab> tabs = <Tab>[
    Tab(text: "Advis Umum"),
    Tab(text: "Reviu Pajak"),
    Tab(text: "SPT Tahunan"),
    Tab(text: "Pengembalian"),
    Tab(text: "Keberatan"),
    Tab(text: "Manajemen"),
  ];
  int _index = 0;
  ConsultingData _bloc;

  @override
  void initState() {
    controller = TabController(vsync: this, length: tabs.length);
    super.initState();
    _bloc = ConsultingData();
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
        title: Text("Tax Services"),
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
          new ConsultingTab(
              data: listEvent, category: ConsultingData.ADVIS_UMUM),
          new ConsultingTab(
              data: listEvent, category: ConsultingData.REVIU_PAJAK),
          new ConsultingTab(
              data: listEvent, category: ConsultingData.SPT_TAHUNAN),
          new ConsultingTab(
              data: listEvent, category: ConsultingData.PENGENBALIAN_PAJAK),
          new ConsultingTab(
              data: listEvent, category: ConsultingData.KEBERATAN_PAJAK),
          new ConsultingTab(
              data: listEvent, category: ConsultingData.MANAJEMEN),
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
