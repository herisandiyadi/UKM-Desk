import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  String title = "Title";
  String status = "";
  IconData image = Icons.fiber_new;
  bool isSeen = false;
  String date = "10 Jul";
  Function addClick;

  NotificationItem(
      {Key key,
      this.title,
      this.status,
      this.image,
      this.isSeen,
      this.date,
      this.addClick});

  @override
  _NotificationItemState createState() =>
      _NotificationItemState(title, status, image, isSeen, date);
}

class _NotificationItemState extends State<NotificationItem> {
  String title = "Title";
  String status = "Title";
  IconData image;
  bool isSeen = false;
  String date = "10 Jul";

  _NotificationItemState(
      this.title, this.status, this.image, this.isSeen, this.date);

  @override
  Widget build(BuildContext context) {
    // return OutlineButton(
    //     onPressed: () => null,
    //     child: Stack(
    //       children: <Widget>[
    //         Align(
    //             alignment: Alignment.centerLeft,
    //             child: Icon(Icons.access_alarm)),
    //         Align(
    //             alignment: Alignment.center,
    //             child: Text(
    //               "Testing",
    //               textAlign: TextAlign.center,
    //             ))
    //       ],
    //     ),
    //     highlightedBorderColor: Colors.orange,
    //     color: Colors.green,
    //     borderSide: new BorderSide(color: Colors.green),
    //     shape: new RoundedRectangleBorder(
    //         borderRadius: new BorderRadius.circular(5.0)));
    return GestureDetector(
      onTap: () {
        widget.addClick();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.center,
              end: FractionalOffset.bottomCenter,
              colors: [Colors.white, Colors.grey],
              stops: [0.9, 1]),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Icon(image),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  status,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: status == "Unpaid" ? Colors.red : Colors.green),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 215,
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
