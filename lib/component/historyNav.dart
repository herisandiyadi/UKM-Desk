import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/notificationItem.dart';
import 'package:enforcea/repository/notification_repository.dart';
import 'package:enforcea/cubit/notification/notification_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/payment/listDetail.dart';
import 'package:enforcea/payment/snap.dart';
import 'dart:io';
import 'dart:convert';

class HistoryNav extends StatefulWidget {
  @override
  _HistoryNavState createState() => _HistoryNavState();
}

class _HistoryNavState extends State<HistoryNav> {
  List<Widget> _widget = List();
  var uploadCubit;
  var list;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(NotificationRepo()),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is NotificationLoading ||
              state is NotificationUploadLoading) {
            if (state is NotificationInitial) {
              uploadCubit = context.bloc<NotificationCubit>();
              uploadCubit.getHistory();
            }
            return defaultPage();
          } else if (state is HistoryLoaded) {
            _widget = drawList(state.historyData.data);
            return defaultPage();
          } else if (state is NotificationError) {
            return defaultPage();
          }
        },
        builder: (contextC, state) {
          if (state is NotificationInitial) {
            uploadCubit = contextC.bloc<NotificationCubit>();
            uploadCubit.getHistory();
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
              ),
            );
          }
          return defaultPage();
        },
      ),
    );
  }

  defaultPage() {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Colors.red[800],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _widget == null
                ? SizedBox(
                    height: 100,
                  )
                : _widget,
          ),
        ),
      ),
    );
  }

  drawList(notifyData) {
    List<NotificationItem> list = List();
    notifyData.forEach((it) {
      list.add(NotificationItem(
          title: it.type == null ? "" : it.type,
          status: it.status,
          image:
              it.status == "Pending" ? Icons.move_to_inbox : Icons.cloud_done,
          isSeen: true,
          date: it.created_at,
          addClick: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListDetails(
                    kodeTransaksi: it.kodeTransaksi,
                  ),
                  // builder: (context) => SnapPage(),
                ));
          }));
    });
    return list;
  }

  Widget alertDialog(BuildContext context, String msg, String title) {
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.red[800]),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
