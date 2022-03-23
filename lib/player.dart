import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:enforcea/component/ui/cartPlayer.dart';

import 'package:enforcea/repository/video_repository.dart';
import 'package:enforcea/cubit/video/video_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/model/response/home/video_response.dart';
import 'package:enforcea/bottomMenu.dart';

class PlayerPage extends StatefulWidget {
  final String link;
  final String title;

  const PlayerPage({Key key, this.link, this.title}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  YoutubePlayerController _controller;
  int page = 1;
  bool isLoadMore = false;
  List<Data> listData = new List();
  bool isLastPage = false;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.link));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text(""),
            backgroundColor: Colors.red[800],
          ),
          body: Column(mainAxisSize: MainAxisSize.max, children: [
            player(),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(child: loadVideo())
          ])),
    );
  }

  Widget player() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }

  Widget loadVideo() {
    return BlocProvider(
      create: (providerContext) => VideoCubit(VideoRepository()),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (builderContext, state) {
          if (state is VideoLoaded) {
            if (state.videoData.data.length == 0) {
              isLastPage = true;
            }
            listData.addAll(state.videoData.data);
            state.videoData.data.clear();
            isLoadMore = false;
            return generateListView(builderContext);
          } else if (state is VideoInitial || state is VideoLoading) {
            if (state is VideoInitial) {
              final videoCubit = builderContext.bloc<VideoCubit>();
              // if (type == "video") {
              videoCubit.Video(page);
              // } else if (type == "podcast") {
              //   videoCubit.Podcast(1);
              // }
            }
            return getLoadingView(builderContext);
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }

  //Container(
  //              child: SingleChildScrollView(
  //                child: Column(
  //                  children: drawList(builderContext, state.videoData.data),
  //                ),
  //              ),
  //            );

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
                page++;
                isLoadMore = true;
                final videoCubit = context.bloc<VideoCubit>();
                // if (type == "video") {
                videoCubit.Video(page);
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
                return CardPlayer(
                  vData: listData[index],
                  goToPage: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerPage(
                                link: listData[index].url,
                                title: listData[index].title,
                              )),
                    );
                  },
                  image: Image.network(
                    listData[index].slide,
                    width: 120,
                    height: 120,
                  ),
                );
              }),
        ),
      ),
    ]);
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

//  Widget podcastVideo() {
//    return BlocProvider(
//      create: (providerContext) => VideoCubit(VideoRepository()),
//      child: BlocBuilder<VideoCubit, VideoState>(
//        builder: (builderContext, state) {
//          if (state is VideoLoaded) {
//            return Container(
//              child: SingleChildScrollView(
//                child: Column(
//                  children: drawList(builderContext, state.videoData.data),
//                ),
//              ),
//            );
//          } else if (state is VideoInitial || state is VideoLoading) {
//            if (state is VideoInitial) {
//              final videoCubit = builderContext.bloc<VideoCubit>();
//              // if (type == "video") {
//              videoCubit.Podcast(page);
//              // } else if (type == "podcast") {
//              //   videoCubit.Podcast(1);
//              // }
//            }
//            return Center(
//              child: CircularProgressIndicator(
//                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
//              ),
//            );
//          } else {
//            return Text("No Data");
//          }
//        },
//      ),
//    );
//  }

  List<dynamic> drawList(BuildContext ctx, List<Data> vData) {
    return vData.map((e) {
      return CardPlayer(
        vData: e,
      );
    }).toList();
  }
}
