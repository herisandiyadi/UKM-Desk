import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:enforcea/model/response/download_book_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enforcea/cubit/download_ebook/ebook_template_cubit.dart';
import 'package:enforcea/model/response/download_book_response.dart';
import 'package:enforcea/repository/ebook_template_repository.dart';

class DownloadItem extends StatefulWidget {
  final Data data;
  final String type;
  const DownloadItem({
    Key key,
    this.data,
    this.type,
  }) : super(key: key);
  @override
  _DownloadItemState createState() => _DownloadItemState();
}

class _DownloadItemState extends State<DownloadItem> {
  @override
  Widget build(BuildContext context) {
    return ReusableContainer(
      cardChild: downloadItemContent(context),
    );
  }

  Widget downloadItemContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.data.image != ""
                  ? Image.network(
                      widget.data.image,
                      width: 120,
                    )
                  : "",
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.data.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Html(
                data: widget.data.desc,
                style: {
                  "p": Style(textAlign: TextAlign.justify),
                },
              ),
              BlocProvider(
                create: (providerContext) =>
                    EBookTemplateCubit(EbookTemplateRepository()),
                child: BlocConsumer<EBookTemplateCubit, EbookTemplateState>(
                  builder: (builderContext, state) {
                    if (state is DownloadLoading) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.red[800]),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.red[800],
                        onPressed: () {
                          final taxCubit =
                              builderContext.bloc<EBookTemplateCubit>();
                          if (widget.type == "ebook") {
                            taxCubit.ebookDownload(
                                widget.data.id, widget.data.fileName);
                          } else {
                            taxCubit.templateDownload(
                                widget.data.id, widget.data.fileName);
                          }
                        },
                        child: Text(
                          'Download',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                  listener: (listenerContext, state) {
                    if (state is DownloadLoaded) {
                      Fluttertoast.showToast(
                          msg: "Success download " + state.downloadData,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[600],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
