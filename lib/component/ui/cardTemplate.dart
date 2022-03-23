import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class CardTemplate extends StatefulWidget {
  final String type;
  final String fileName;
  final String fileLink;
  final Icon icon1;
  final AnimationController animationController;
  final Animation animation;

  const CardTemplate(
      {Key key,
      this.type: "",
      this.fileName: "",
      this.fileLink: "",
      this.icon1,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  _CardTemplateState createState() => _CardTemplateState();
}

class _CardTemplateState extends State<CardTemplate> {
  bool isDownloaded = false;
  bool downloading = false;
  String progress = '0';

  Future<void> downloadFile(uri, fileName) async {
    setState(() {
      downloading = true;
    });

    String savePath = await getFilePath(fileName);

    Dio dio = Dio();

    dio.download(
      uri,
      savePath,
      onReceiveProgress: (rcv, total) {
        print(
            'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
        setState(() {
          progress = ((rcv / total) * 100).toStringAsFixed(0);
        });

        if (progress == '100') {
          setState(() {
            isDownloaded = true;
          });
        } else if (double.parse(progress) < 100) {}
      },
      deleteOnError: true,
    ).then((_) {
      setState(() {
        if (progress == '100') {
          isDownloaded = true;
        }

        downloading = false;
      });
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName.pdf';

    return path;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      downloadFile(widget.fileLink, widget.fileName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Image.asset(
                                'assets/pdf.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.fileName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "Type: " + widget.type,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              !isDownloaded
                                  ? Icon(
                                      Icons.file_download,
                                      size: 30,
                                    )
                                  : Text('$progress%'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
