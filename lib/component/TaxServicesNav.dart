import 'package:enforcea/component/ui/newsItem.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/repository/consulting_repository.dart';
import 'package:enforcea/cubit/tax_services/tax_services_cubit.dart';
import 'package:enforcea/model/response/consulting_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:enforcea/component/TaxServiceDetail.dart';
import 'package:enforcea/bottomMenu.dart';

class TaxServicesNav extends StatefulWidget {
  final String type;

  const TaxServicesNav({Key key, this.type}) : super(key: key);

  @override
  _TaxServicesNavState createState() => _TaxServicesNavState();
}

class _TaxServicesNavState extends State<TaxServicesNav> {
  int pages = 1;
  bool isLoadMore = false;
  List<Data> listData = new List();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Services"),
        backgroundColor: Colors.red[800],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: loadContent(),
        ),
      ),
    );
  }

  Widget loadContent() {
    return BlocProvider(
      create: (providerContext) => TaxServiceCubit(ConsultingRepository()),
      child: BlocBuilder<TaxServiceCubit, TaxServicesState>(
        builder: (builderContext, state) {
          if (state is TaxServicesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  generateList(state.advisUmum.data),
                  generateList(state.kebPajak.data),
                  generateList(state.management.data),
                  generateList(state.pengPajak.data),
                  generateList(state.reviuPajak.data),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            );
          } else if (state is TaxServicesInitial ||
              state is TaxServicesLoading) {
            if (state is TaxServicesInitial) {
              final contentCubit = builderContext.bloc<TaxServiceCubit>();
              contentCubit.LoadTaxServices();
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
              ),
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }

  Widget generateList(Data data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaxServicesDetail(
                      data: data,
                    )));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                      decoration: new BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      height: 180,
                      child: Image.network(
                        data.image_1,
                        width: 130,
                      )),
                  // Container(
                  //   alignment: Alignment.center,
                  //   height: 180,
                  //   child: Image.network(
                  //     data.image_2,
                  //     width: 140,
                  //   ),
                  // )
                ],
              ),
              Flexible(
                child: Html(
                  data: data.isi.split(". ")[0] + "...",
                  style: {
                    "div": Style(textAlign: TextAlign.start),
                    "h2": Style(
                        fontSize: FontSize.medium, textAlign: TextAlign.left)
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
