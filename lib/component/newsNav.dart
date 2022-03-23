import 'package:enforcea/component/ui/newsItem.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/repository/home/banner_repository.dart';
import 'package:enforcea/cubit/content/content_cubit.dart';
import 'package:enforcea/model/response/home/content_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/bottomMenu.dart';

class NewsNav extends StatefulWidget {
  final String type;

  const NewsNav({Key key, this.type}) : super(key: key);

  @override
  _NewsNavState createState() => _NewsNavState();
}

class _NewsNavState extends State<NewsNav> {
  int pages = 1;
  bool isLoadMore = false;
  List<Data> listData = new List();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        title: Text(widget.type),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        child: loadContent(),
      ),
    );
  }

  Widget loadContent() {
    return BlocProvider(
      create: (providerContext) => ContentCubit(BannerRepository()),
      child: BlocBuilder<ContentCubit, ContentState>(
        builder: (builderContext, state) {
          if (state is ContentLoaded) {
            if (state.contentData.data.length == 0) {
              isLastPage = true;
            }
            listData.addAll(state.contentData.data);
            state.contentData.data.clear();
            isLoadMore = false;
            print("list length : " + listData.length.toString());
            return generateListView(builderContext);
          } else if (state is ContentInitial || state is ContentLoading) {
            if (state is ContentInitial) {
              final contentCubit = builderContext.bloc<ContentCubit>();
              if (widget.type == "Flash") {
                contentCubit.FlashContent(pages);
              } else if (widget.type == "Article") {
                contentCubit.ArticleContent(pages);
              } else if (widget.type == "News") {
                contentCubit.NewsContent(pages);
              }
            }
            return getLoadingView(builderContext);
          } else {
            return Text("No Data");
          }
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
                final contentCubit = context.bloc<ContentCubit>();
                if (widget.type == "Flash") {
                  contentCubit.FlashContent(pages);
                } else if (widget.type == "Article") {
                  contentCubit.ArticleContent(pages);
                } else if (widget.type == "News") {
                  contentCubit.NewsContent(pages);
                }
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

                return NewsItem(
                  contentData: listData[index],
                  type: widget.type,
                );
              }),
        ),
      ),
    ]);
  }

//  List<dynamic> drawList(BuildContext ctx, List<Data> vData) {
//    listWidget.addAll(vData.map((e) {
//      NewsItem(
//        contentData: e,
//        type: widget.type,
//      );
//    }).toList());
//    return listWidget;
//  }
}
