import 'package:enforcea/component/ui/downloadItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enforcea/cubit/download_ebook/ebook_template_cubit.dart';
import 'package:enforcea/model/response/download_book_response.dart';
import 'package:enforcea/repository/ebook_template_repository.dart';
import 'package:enforcea/bottomMenu.dart';

class DownloadNav extends StatefulWidget {
  final String type;
  const DownloadNav({Key key, this.type}) : super(key: key);
  @override
  _DownloadNavState createState() => _DownloadNavState();
}

class _DownloadNavState extends State<DownloadNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download"),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        child: BlocProvider(
          create: (providerContext) =>
              EBookTemplateCubit(EbookTemplateRepository()),
          child: BlocBuilder<EBookTemplateCubit, EbookTemplateState>(
            builder: (builderContext, state) {
              if (state is EbookTemplateLoaded) {
                if (widget.type == "ebook") {
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: FileList(builderContext,
                                state.ebookTemplateData.ebookData, widget.type),
                          ),
                          SizedBox(
                            height: 70,
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: FileList(builderContext,
                            state.ebookTemplateData.templateData, widget.type),
                      ),
                    ),
                  );
                }
              } else if (state is EbookTemplateError) {
                Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[600],
                    textColor: Colors.white,
                    fontSize: 16.0);
                return Text("No data");
              } else {
                if (state is EbookTemplateInitial) {
                  final cubit = builderContext.bloc<EBookTemplateCubit>();
                  cubit.getEbookTemplate();
                }
                return Padding(
                  padding: EdgeInsets.all(36),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[800]),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Widget FileList(List<Data> data) {
  //   return DownloadItem();
  // }
  List<dynamic> FileList(BuildContext ctx, List<Data> vData, String type) {
    return vData.map((e) {
      return DownloadItem(
        data: e,
        type: type,
      );
    }).toList();
  }
}
