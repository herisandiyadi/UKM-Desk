import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/model/response/home/video_response.dart';
import 'package:enforcea/player.dart';
import 'package:enforcea/playerList.dart';

class BannerVideo extends StatefulWidget {
  const BannerVideo(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.imgList})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final List<Data> imgList;
  @override
  _BannerVideoState createState() => _BannerVideoState();
}

class _BannerVideoState extends State<BannerVideo>
    with TickerProviderStateMixin {
  AnimationController animationController;
  int _current = 0;

  @override
  void initState() {
    print(widget.imgList[0].slide);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.mainScreenAnimationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: widget.mainScreenAnimation,
              child: Column(
                children: <Widget>[
                  CarouselSlider(
                    items: widget.imgList
                        .map((item) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayerPage(
                                            link: item.url,
                                            title: item.title,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        item.slide,
                                        width: 10000,
                                        fit: BoxFit.cover,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.play_circle_outline,
                                          size: 80,
                                          color: Colors.grey[500],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),

                  //tambah padding
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.imgList[_current].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imgList.map((url) {
                      int index = widget.imgList.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ));
        });
  }
}
