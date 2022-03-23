import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:enforcea/cubit/profile/profile_cubit.dart';
import 'package:enforcea/cubit/side_menu/faq/faq_cubit.dart';
import 'package:enforcea/model/response/faq_response.dart';
import 'package:enforcea/repository/faq_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqDetail extends StatelessWidget {
  final String question;
  final String answer;

  FaqDetail({this.question, this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FAQ"),
          backgroundColor: Colors.red[800],
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Question :",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                question,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
                height: 40,
              ),
              Text(
                "Answer :",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                answer,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ));
  }

  Widget listFaqView(List<Data> listData) {
    final listWidget = List<Widget>();
    listData.forEach((element) {
      listWidget.add(faqItem(element.question, element.answer));
    });
    return Container(
      child: Column(
        children: listWidget,
      ),
    );
  }

  ReusableContainer faqItem(String question, String answer) {
    return ReusableContainer(
      cardChild: Column(
        children: [
          Text(
            question,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Text(
            answer,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
