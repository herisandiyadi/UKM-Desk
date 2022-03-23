import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/model/response/home/content_response.dart';
import 'package:enforcea/newsDetail.dart';

class BannerNav extends StatefulWidget {
  const BannerNav({
    Key key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
    this.imgList,
    this.type,
  }) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final List<Data> imgList;
  final String type;
  @override
  _BannerNavState createState() => _BannerNavState();
}

class _BannerNavState extends State<BannerNav> with TickerProviderStateMixin {
  AnimationController animationController;
  int _current = 0;

  @override
  void initState() {
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsDetail(
                                  contentID: widget.imgList[_current].id,
                                  type: widget.type,
                                )),
                      );
                    },
                    child: CarouselSlider(
                      items: widget.imgList
                          .map((item) => Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image.network(
                                    item.icon,
                                    width: 100000,
                                    fit: BoxFit.fill,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.imgList[_current].titleID,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
