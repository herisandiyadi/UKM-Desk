import 'package:enforcea/cubit/dashboard/template_report_cubit.dart';
import 'package:enforcea/model/response/template_response.dart';
import 'package:enforcea/repository/tax_report_repository.dart';
import 'package:enforcea/repository/template_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TemplateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (providerContext) => TemplateReportCubit(TemplateRepository()),
        child: BlocBuilder<TemplateReportCubit, TemplateReportState>(
          builder: (builderContext, state) {
            if (state is TemplateReportLoaded) {
              return initialState(state.TemplateReportData.data);
            } else if (state is TaxReportError) {
              Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey[600],
                  textColor: Colors.white,
                  fontSize: 16.0);
              return initialState(List<Data>());
            } else {
              if (state is TemplateReportInitial) {
                final taxCubit = builderContext.bloc<TemplateReportCubit>();
                taxCubit.getTaxReport();
              }
              return Padding(
                padding: EdgeInsets.all(36),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget initialState(List<Data> listData) {
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
                'assets/xls.png',
                width: 40,
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
                        // Text(
                        //   element.reportType,
                        //   textAlign: TextAlign.left,
                        //   overflow: TextOverflow.ellipsis,
                        //   style:
                        //       TextStyle(fontSize: 14, color: Colors.grey[800]),
                        //   maxLines: 1,
                        // ),
                        // Text(
                        //   element.periode,
                        //   textAlign: TextAlign.left,
                        //   overflow: TextOverflow.ellipsis,
                        //   style:
                        //       TextStyle(fontSize: 14, color: Colors.grey[800]),
                        //   maxLines: 1,
                        // ),
                      ],
                    )),
              ),
              BlocProvider(
                create: (providerContext) =>
                    TemplateReportCubit(TemplateRepository()),
                child: BlocBuilder<TemplateReportCubit, TemplateReportState>(
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
                    if (state is DownloadLoaded) {
                      Fluttertoast.showToast(
                          msg: "loaded",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[600],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    return GestureDetector(
                        onTap: () {
                          final taxCubit =
                              builderContext.bloc<TemplateReportCubit>();
                          taxCubit.taxReportDownload(element.id_template);
                        },
                        child:
                            Icon(Icons.file_download, color: Colors.red[800]));
                  }
                }),
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
