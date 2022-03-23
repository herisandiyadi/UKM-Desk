import 'package:flutter/material.dart';

class ExpatriatDetail extends StatelessWidget {
  final String title;

  ExpatriatDetail({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red[800],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: <Widget>[
              Image(
                image: NetworkImage(
                    "https://www.ghjournal.org/wp-content/uploads/2014/11/forest-ground-200x200.jpg"),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, "
                "remaining essentially unchanged Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
                style: TextStyle(fontSize: 24.0, color: Colors.black),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ),
    );
  }
}
