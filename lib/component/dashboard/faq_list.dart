import 'package:enforcea/component/faqDetail.dart';
import 'package:enforcea/cubit/side_menu/faq/faq_cubit.dart';
import 'package:enforcea/model/response/faq_response.dart';
import 'package:enforcea/repository/faq_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (providerContext) => FaqCubit(FAQRepository()),
      child: BlocBuilder<FaqCubit, FaqState>(
        builder: (builderContext, state) {
          if (state is FaqLoaded) {
            return listFaqView(builderContext,state.faqData.data);
          } else if (state is FaqInitial || state is FaqLoading) {
            if (state is FaqInitial) {
              final faqCubit = builderContext.bloc<FaqCubit>();
              faqCubit.getFaq();
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
              ),
            );
          } else {
            return listFaqView(builderContext,List<Data>());
          }
        },
      ),
    );
  }

  Widget listFaqView(BuildContext context,List<Data> listData) {
    final listWidget = List<Widget>();
    listData.forEach((element) {
      listWidget.add(faqItem(context,element.question, element.answer));
    });
    return Container(
      child: Column(
        children: listWidget,
      ),
    );
  }

  Widget faqItem(BuildContext context,String question, String answer) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: Ink(
        child: InkWell(
          onTap: (){
            navigationToDetail(context, question,answer);

          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    question,
                    style: TextStyle(
                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_right,)
            ],),
          ),
        ),
      ),
    );
  }

  void navigationToDetail(BuildContext context,String question, String answer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FaqDetail(
          question:question,
          answer: answer,
        ),
      ),
    );
  }
}
