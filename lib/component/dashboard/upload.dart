import 'dart:convert';
import 'dart:io';

import 'package:enforcea/model/request/upload_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/component/ui/button.dart';
import 'package:enforcea/repository/upload_file_repository.dart';
import 'package:enforcea/util/loading_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:enforcea/cubit/dashboard/upload_cubit.dart';
import 'package:enforcea/cubit/dashboard/upload_list_cubit.dart';
import 'package:enforcea/repository/upload_list_repository.dart';
import 'package:enforcea/model/response/upload_list_response.dart';
import 'package:enforcea/component/dashboard/listFile.dart';
import 'package:image_picker/image_picker.dart';

class upload extends StatefulWidget {
  upload({Key key}) : super(key: key);

  @override
  _uploadState createState() => _uploadState();
}

class _uploadState extends State<upload> {
  final picker = ImagePicker();
  File _image;
  DateTime selectedDate = DateTime.now();
  String _valTypes;
  String _filePath;
  List<Data> listData;
  List _listTypes = [
    "Kas & Bank",
    "Penjualan",
    "Pembelian",
    "Biaya",
    "Lain-lain"
  ];

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getGalery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _showSelectionDialog(Function event1, Function event2) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text("Gallery"),
                    ],
                  ),
                  onTap: () {
                    event1();
                    Navigator.pop(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      Text("Camera"),
                    ],
                  ),
                  onTap: () {
                    event2();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        uploadSchem(context),
        loadUploadList(context),
        Button().actionButton(Icons.search, "See Details", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detailList(
                type: "upload_list",
              ),
            ),
          );
        })
      ],
    );
  }

  Widget loadUploadList(BuildContext fcontext) {
    LoadingUtil loading = LoadingUtil(context);
    return BlocProvider(
      create: (providerContext) => UploadListCubit(UploadListRepository()),
      child: BlocBuilder<UploadListCubit, UploadListState>(
        builder: (builderContext, state) {
          if (state is UploadListLoaded) {
            listData = state.UploadList.data;
            return listFiles(builderContext, state.UploadList.data);
          } else if (state is UploadListInitial || state is UploadListLoading) {
            if (state is UploadListInitial) {
              final listCubit = builderContext.bloc<UploadListCubit>();
              listCubit.uploadList(1, "");
              // return Text("data");
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
              ),
            );
          }
          // else {
          //   return initialPage(context);
          // }
        },
      ),
    );
  }

  Widget uploadSchem(BuildContext context) {
    LoadingUtil loading = LoadingUtil(context);
    return BlocProvider(
      create: (contextA) => UploadCubit(UploadRepository()),
      child: BlocConsumer<UploadCubit, UploadState>(
        listener: (contextB, state) {
          if (state is UploadLoading) {
            loading.showLoading();
          } else if (state is UploadLoaded) {
            loading.hideLoading();
            Fluttertoast.showToast(
                msg: state.UploadData.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey[600],
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {
              _image = null;
            });
          } else if (state is UploadError) {
            loading.hideLoading();

            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey[600],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (contextC, state) {
          return initialPage(contextC);
        },
      ),
    );
  }

  Widget initialPage(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Type"),
                SizedBox(
                  width: 100,
                ),
                DropdownButton(
                  hint: Text("Select Type"),
                  value: _valTypes,
                  items: _listTypes.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valTypes = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Periode"),
                SizedBox(
                  width: 100,
                ),
                Text("${selectedDate.year}" + "-" + "${selectedDate.month}"),
                FlatButton(
                  color: Colors.transparent,
                  splashColor: Colors.black26,
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Icon(Icons.calendar_today),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            _image == null
                ? Button().actionButton(Icons.attach_file, "Browse File", () {
                    // getFilePathhi();
                    // getImage();
                    _showSelectionDialog(() {
                      getGalery();
                    }, () {
                      getImage();
                    });
                  })
                : Stack(children: [
                    Image.file(_image),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
            Button().actionButton(Icons.cloud_upload, "Upload", () {
              final uploadCubit = context.bloc<UploadCubit>();
              String img64 = base64Encode(_image.readAsBytesSync());
              File file = new File(_image.path);
              int indexType = _listTypes.indexOf(_valTypes) + 1;
              final uploadReq = UploadFile(
                  type: indexType.toString(),
                  period: selectedDate.toLocal().year.toString() +
                      "-" +
                      selectedDate.toLocal().month.toString(),
                  name_file: _image.path.split('/').last,
                  doc_upload: img64);
              uploadCubit.uploadFile(uploadReq);
            }),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget listFiles(BuildContext context, List<Data> listData) {
    final listWidget = List<Widget>();
    listData.forEach((element) {
      listWidget.add(Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images.png',
                width: 50,
                height: 40,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element.filename + '\n',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          element.type == null ? "" : element.type,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[800]),
                          maxLines: 1,
                        ),
                        Text(
                          element.periode,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[800]),
                          maxLines: 1,
                        ),
                      ],
                    )),
              ),
              //to delete files
              // BlocProvider(
              //   create: (providerContext) =>
              //       TaxReportCubit(TaxReportRepository()),
              //   child: BlocBuilder<TaxReportCubit, TaxReportState>(
              //       builder: (builderContext, state) {
              //     if (state is DownloadLoading) {
              //       return SizedBox(
              //         height: 20,
              //         width: 20,
              //         child: CircularProgressIndicator(
              //           valueColor:
              //               AlwaysStoppedAnimation<Color>(Colors.red[800]),
              //         ),
              //       );
              //     } else {
              //       if (state is DownloadLoaded) {
              //         Fluttertoast.showToast(
              //             msg: "loaded",
              //             toastLength: Toast.LENGTH_SHORT,
              //             gravity: ToastGravity.BOTTOM,
              //             timeInSecForIosWeb: 1,
              //             backgroundColor: Colors.grey[600],
              //             textColor: Colors.white,
              //             fontSize: 16.0);
              //       }
              //       return GestureDetector(
              //           onTap: () {
              //             final taxCubit =
              //                 builderContext.bloc<TaxReportCubit>();
              //             taxCubit.taxReportDownload(element.idTaxReport);
              //           },
              //           child:
              //               Icon(Icons.file_download, color: Colors.red[800]));
              //     }
              //   }),
              // ),
              BlocProvider(
                create: (providerContext) =>
                    UploadListCubit(UploadListRepository()),
                child: BlocConsumer<UploadListCubit, UploadListState>(
                  builder: (builderContext, state) {
                    if (state is DownloadLoading) {
                      return SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red[800]),
                        ),
                      );
                    } else {
                      return GestureDetector(
                          onTap: () {
                            final taxCubit =
                                builderContext.bloc<UploadListCubit>();
                            taxCubit.fileDownload(element.id, element.filename);
                          },
                          child: Icon(Icons.file_download,
                              color: Colors.red[800]));
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
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ));
    });

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: listWidget,
      ),
    );
  }
}
