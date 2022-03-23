import 'package:flutter/material.dart';
import 'package:enforcea/model/response/upload_list_response.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:enforcea/cubit/dashboard/upload_cubit.dart';
import 'package:enforcea/cubit/dashboard/upload_list_cubit.dart';
import 'package:enforcea/repository/upload_list_repository.dart';
import 'package:enforcea/model/response/upload_list_response.dart';
import 'package:enforcea/util/loading_util.dart';

import 'package:fluttertoast/fluttertoast.dart';

class detailList extends StatefulWidget {
  final String type;

  detailList({@required this.type});
  _detailListState createState() => _detailListState();
}

class _detailListState extends State<detailList> {
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
    final contentCubit = bContext.bloc<UploadListCubit>();
    contentCubit.uploadList(0, value);
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
      create: (providerContext) => UploadListCubit(UploadListRepository()),
      child: BlocBuilder<UploadListCubit, UploadListState>(
        builder: (builderContext, state) {
          if (state is UploadListLoaded) {
            bContext = builderContext;
            listData.addAll(state.UploadList.data);
            state.UploadList.data.clear();
            isLoadMore = false;
            return generateListView(builderContext);
          } else if (state is UploadListInitial || state is UploadListLoading) {
            if (state is UploadListInitial) {
              final listCubit = builderContext.bloc<UploadListCubit>();
              listCubit.uploadList(1, "");
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
                final contentCubit = context.bloc<UploadListCubit>();
                contentCubit.uploadList(pages, "");
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
                        element.type == null ? "" : element.type,
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
                  UploadListCubit(UploadListRepository()),
              child: BlocConsumer<UploadListCubit, UploadListState>(
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
                              builderContext.bloc<UploadListCubit>();
                          taxCubit.fileDownload(element.id, element.filename);
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
