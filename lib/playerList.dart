import 'package:flutter/material.dart';
import 'package:enforcea/component/ui/cartPlayer.dart';
import 'package:enforcea/repository/video_repository.dart';
import 'package:enforcea/cubit/video/video_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/model/response/home/video_response.dart';
import 'package:enforcea/player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:enforcea/bottomMenu.dart';

class PlayerListPage extends StatefulWidget {
  const PlayerListPage({Key key}) : super(key: key);

  @override
  _PlayerListPageState createState() => _PlayerListPageState();
}

class _PlayerListPageState extends State<PlayerListPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  int page = 1;
  bool isLoadMore = false;
  List<Data> listData = new List();
  bool isLastPage = false;

  int podcastPage = 1;
  bool isPodcastLoadMore = false;
  List<Data> listDataPodcast = new List();
  bool isPodcastLastPage = false;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Media List"),
            backgroundColor: Colors.red[800],
            bottom: TabBar(
              controller: controller,
              //source code lanjutan
              tabs: <Widget>[
                Tab(
                  text: "Youtube",
                ),
                Tab(
                  text: "Podcast",
                ),
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              controller: controller,
              children: [
                // Text("No Content"),
                loadVideo(),
                podcastVideo(),
                // Text("No Content"),
              ],
            ),
          )),
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

  Widget podcastVideo() {
    return BlocProvider(
      create: (providerContext) => VideoCubit(VideoRepository()),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (builderContext, state) {
          if (state is VideoLoaded) {
            if (state.videoData.data.length == 0) {
              isPodcastLastPage = true;
            }
            listDataPodcast.addAll(state.videoData.data);
            state.videoData.data.clear();
            isPodcastLoadMore = false;
            return generatePodcastListView(builderContext);
          } else if (state is VideoInitial || state is VideoLoading) {
            if (state is VideoInitial) {
              final videoCubit = builderContext.bloc<VideoCubit>();
              videoCubit.Podcast(podcastPage);
            }
            return getPocastLoadingView(context);
          } else {
            return Text("No Data");
          }
        },
      ),
    );
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

  Widget generatePodcastListView(BuildContext context) {
    int itemCount = listDataPodcast.length;
    if (isPodcastLoadMore) {
      itemCount++;
    }
    return Column(children: <Widget>[
      Expanded(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroolInfo) {
            if (!isPodcastLoadMore &&
                scroolInfo.metrics.pixels ==
                    scroolInfo.metrics.maxScrollExtent) {
              if (!isPodcastLastPage) {
                podcastPage++;
                isPodcastLoadMore = true;
                final videoCubit = context.bloc<VideoCubit>();
                videoCubit.Podcast(podcastPage);
              }
            }
            return false;
          },
          child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == listDataPodcast.length) {
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
                  vData: listDataPodcast[index],
                  goToPage: () {
                    _launchURL(listDataPodcast[index].url);
                  },
                  image: Image.asset(
                    "assets/slider/spotify.png",
                    width: 120,
                    height: 120,
                  ),
                );
              }),
        ),
      ),
    ]);
  }

//  List<dynamic> drawList(BuildContext ctx, List<Data> vData) {
//    return vData.map((e) {
//      return CardPlayer(
//        vData: e,
//        goToPage: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => PlayerPage(
//                      link: e.url,
//                      title: e.title,
//                    )),
//          );
//        },
//        image: Image.network(
//          e.slide,
//          width: 120,
//          height: 120,
//        ),
//      );
//    }).toList();
//  }

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

  Widget getPocastLoadingView(BuildContext context) {
    if (isPodcastLoadMore) {
      return generatePodcastListView(context);
    } else {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
        ),
      );
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
