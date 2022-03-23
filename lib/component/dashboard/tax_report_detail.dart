import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/cubit/dashboard/tax_report_cubit.dart';
import 'package:enforcea/repository/tax_report_repository.dart';
import 'package:enforcea/model/response/tax_report_response.dart';
import 'package:enforcea/util/loading_util.dart';

import 'package:fluttertoast/fluttertoast.dart';

class TaxReportDetail extends StatefulWidget {
  final String type;

  TaxReportDetail({@required this.type});
  _TaxReportDetailState createState() => _TaxReportDetailState();
}

class _TaxReportDetailState extends State<TaxReportDetail> {
  TextEditingController _textController = TextEditingController();
  int pages = 1;
  bool isLoadMore = false;
  bool isLastPage = false;
  List<Data> listData = new List();
  List<Data> _newData = [];
  BuildContext bContext;
  _onChanged(String value) {
    // setState(() {
    listData.clear();
    final contentCubit = bContext.bloc<TaxReportCubit>();
    contentCubit.getTaxReport();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 120,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Search files',
                    hintStyle: TextStyle(color: Colors.white)),
                onSubmitted: _onChanged,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Icon(Icons.search)
          ],
        ),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        child: loadUploadList(context),
      ),
    );
  }

  Widget loadUploadList(BuildContext fcontext) {
    LoadingUtil loading = LoadingUtil(context);
    return BlocProvider(
      create: (providerContext) => TaxReportCubit(TaxReportRepository()),
      child: BlocBuilder<TaxReportCubit, TaxReportState>(
        builder: (builderContext, state) {
          if (state is TaxReportLoaded) {
            bContext = builderContext;
            listData.clear();
            listData.addAll(state.TaxReportData.data);
            state.TaxReportData.data.clear();
            isLoadMore = false;
            return generateListView(builderContext);
          } else if (state is TaxReportInitial || state is TaxReportLoading) {
            if (state is TaxReportInitial) {
              final listCubit = builderContext.bloc<TaxReportCubit>();
              listCubit.getTaxReport();
              // return Text("data");
            }
            return getLoadingView(context);
          }
          // else {
          //   return initialPage(context);
          // }
        },
      ),
    );
  }

  Widget getLoadingView(BuildContext context) {
    if (isLoadMore) {
      return generateListView(context);
    } else {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
        ),
      );
    }
  }

  Widget generateListView(BuildContext context) {
    int itemCount = listData.length;
    if (isLoadMore) {
      itemCount++;
    }
    return Column(children: <Widget>[
      Expanded(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroolInfo) {
            if (!isLoadMore &&
                scroolInfo.metrics.pixels ==
                    scroolInfo.metrics.maxScrollExtent) {
              if (!isLastPage) {
                pages++;
                isLoadMore = true;
                final contentCubit = context.bloc<TaxReportCubit>();
                contentCubit.getTaxReport();
              }
            }
            return false;
          },
          child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == listData.length) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[800]),
                    )),
                  );
                }

                return listItem(
                  listData[index],
                );
              }),
        ),
      ),
    ]);
  }

  Widget listItem(Data element) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images.png',
              width: 50,
              height: 40,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.filename + '\n',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        element.reportType == null ? "" : element.reportType,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                        maxLines: 1,
                      ),
                      Text(
                        element.periode,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                        maxLines: 1,
                      ),
                    ],
                  )),
            ),
            BlocProvider(
              create: (providerContext) =>
                  TaxReportCubit(TaxReportRepository()),
              child: BlocConsumer<TaxReportCubit, TaxReportState>(
                builder: (builderContext, state) {
                  if (state is DownloadLoading) {
                    return SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.red[800]),
                      ),
                    );
                  } else {
                    return GestureDetector(
                        onTap: () {
                          final taxCubit =
                              builderContext.bloc<TaxReportCubit>();
                          taxCubit.taxReportDownload(
                              element.idTaxReport, element.filename);
                        },
                        child:
                            Icon(Icons.file_download, color: Colors.red[800]));
                  }
                },
                listener: (listenerContext, state) {
                  if (state is DownloadLoaded) {
                    Fluttertoast.showToast(
                        msg: "Success download " + state.downloadData,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
