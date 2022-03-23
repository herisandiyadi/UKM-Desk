import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:enforcea/expatriatDetail.dart';
import 'package:flutter/material.dart';

class ExpatriatItem extends StatelessWidget {
  final String title;

  ExpatriatItem({this.title});

  @override
  Widget build(BuildContext context) {
    return ReusableContainer(
      cardChild: expatriatContent(context),
      onPress: () {
        navigationToDetail(context);
      },
    );
  }

  Widget expatriatContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        Image(
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: 300,
          image: NetworkImage(
              "https://www.ghjournal.org/wp-content/uploads/2014/11/forest-ground-200x200.jpg"),
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
          style: TextStyle(fontSize: 20.0, color: Colors.black),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  void navigationToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpatriatDetail(
          title: title,
        ),
      ),
    );
  }
}
