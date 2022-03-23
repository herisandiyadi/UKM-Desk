import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/repository/content_datail_repository.dart';
import 'package:enforcea/cubit/content_detail/content_detail_cubit.dart';
import 'package:enforcea/model/response/content_detail_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class NewsDetail extends StatelessWidget {
  final int contentID;
  final String type;
  NewsDetail({this.contentID, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loadContentDetail(),
      ),
    );
  }

  Widget loadContentDetail() {
    return BlocProvider(
      create: (providerContext) => ContentCubit(ContentDetailRepository()),
      child: BlocBuilder<ContentCubit, ContentDetailState>(
        builder: (builderContext, state) {
          if (state is ContentLoaded) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getHeaderPage(builderContext, state.contentData.data),
                    getTimePage(builderContext, state.contentData.data),
                    getContentPage(builderContext, state.contentData.data)
                  ],
                ),
              ),
            );
          } else if (state is ContentInitial || state is ContentLoading) {
            if (state is ContentInitial) {
              final contentCubit = builderContext.bloc<ContentCubit>();
              if (type == "Flash") {
                contentCubit.FlashContent(contentID);
              } else if (type == "Article") {
                contentCubit.ArticleContent(contentID);
              } else if (type == "News") {
                contentCubit.NewsContent(contentID);
              }
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
              ),
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }

  Widget getContentPage(BuildContext context, Data cData) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Html(
        data: cData.desc_id,
        style: {
          "div": Style(textAlign: TextAlign.left),
        },
      ),
    );
  }

  Widget getTimePage(BuildContext context, Data cData) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      color: Colors.black12,
      child: Row(
        children: [
          Icon(Icons.access_time),
          SizedBox(width: 10),
          Text(cData.date)
        ],
      ),
    );
  }

  Widget getHeaderPage(BuildContext context, Data cData) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(cData.image_2),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.3),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomAppBar(context),
                SizedBox(
                  height: 24,
                ),
                Text(
                  cData.title_id,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 5,
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row getCustomAppBar(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Spacer(
          flex: 3,
        ),
        Icon(
          Icons.share,
          color: Colors.white,
        ),
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.bookmark,
          color: Colors.white,
        ),
      ],
    );
  }
}
