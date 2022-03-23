import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerNewsNav extends StatefulWidget {
  const BannerNewsNav(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  @override
  _BannerNewsNavState createState() => _BannerNewsNavState();
}

class _BannerNewsNavState extends State<BannerNewsNav> with TickerProviderStateMixin {
  AnimationController animationController;
  int _current = 0;
  static final List<String> imgSlider = [
    'news1.jpeg',
    'news2.jpg',
    'news3.jpg',
  ];

  final List<Widget> imageSliders = imgSlider
      .map((item) => Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/news/${item}',
                width: 10000,
                fit: BoxFit.cover,
              ),
            ),
          ))
      .toList();

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
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgSlider.map((url) {
                      int index = imgSlider.indexOf(url);
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
