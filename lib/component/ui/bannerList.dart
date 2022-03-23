import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerList extends StatefulWidget {
  // BannerList({Key key}) : super(key: key);
  @override
  _BannerListState createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  int _current = 0;
  static final List<String> imgSlider = [
    'elektronik.jpeg',
    'fashion.jpg',
    'food.jpg',
    'rendang.jpg',
    'sport.jpg'
  ];

  final List<Widget> imageSliders = imgSlider
      .map((item) => Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/slider/${item}',
                width: 10000,
                fit: BoxFit.cover,
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
      ),
    );
  }
}
