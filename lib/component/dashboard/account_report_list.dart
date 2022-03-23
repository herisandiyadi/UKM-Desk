import 'package:enforcea/cubit/dashboard/accounting_report_cubit.dart';
import 'package:enforcea/model/response/accounting_report_response.dart';
import 'package:enforcea/repository/accounting_report_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountingReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (providerContext) =>
            AccountingReportCubit(AccountingReportRepository()),
        child: BlocBuilder<AccountingReportCubit, AccountingReportState>(
          builder: (builderContext, state) {
            if (state is AccountingReportLoaded) {
              return initialState(state.accountingReportData.data);
            } else if (state is AccountingReportError) {
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
              if (state is AccountingReportInitial) {
                final accountingCubit =
                    builderContext.bloc<AccountingReportCubit>();
                accountingCubit.getAccountingReport();
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
                'assets/pdf.png',
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
                        Text(
                          element.reportType,
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
              BlocProvider(
                create: (providerContext) =>
                    AccountingReportCubit(AccountingReportRepository()),
                child:
                    BlocConsumer<AccountingReportCubit, AccountingReportState>(
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
                            final accounting =
                                builderContext.bloc<AccountingReportCubit>();
                            accounting.accountingReportDownload(
                                element.idAccountReport, element.filename);
                          },
                          child: Icon(Icons.file_download,
                              color: Colors.red[800]));
                    }
                  },
                  listener: (listenerContext, state) {
                    if (state is DownloadAccountingLoaded) {
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

  Widget item() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Accounting",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
