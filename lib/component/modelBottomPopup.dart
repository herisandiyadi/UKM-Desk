import 'package:enforcea/component/ContactUs.dart';
import 'package:enforcea/component/historyNav.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/component/newsNav.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/component/downloadNav.dart';
import 'package:enforcea/constants.dart';
import 'package:enforcea/home.dart';
import '../login.dart';

class ModalBottomPopup extends StatefulWidget {
  ModalBottomPopup({Key key}) : super(key: key);

  @override
  _ModalBottomPopupState createState() => _ModalBottomPopupState();
}

class _ModalBottomPopupState extends State<ModalBottomPopup> {
  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          //                    <--- top side
          color: Colors.black54,
          width: 3.0,
        ),
      ),
    );
  }

  Widget modalBottomPopup(context) {
    bool isLogin = false;
    String name = "Sign In";
    CacheUtil.getBoolean(CACHE_IS_LOGIN).then((value) {
      if (value) {
        isLogin = value;
      }
    });
    CacheUtil.getString(CACHE_NAME).then((value) => {
          if (value != null) {name = value}
        });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          color: Colors.black54.withOpacity(0.6),
          height: isLogin
              ? MediaQuery.of(context).size.height * .43
              : MediaQuery.of(context).size.height * .34,
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 40,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red[800],
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  Container(
                    decoration: boxDecoration(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsNav(
                                    type: "News",
                                  )),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.library_books,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "News & Insight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  isLogin
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryNav()),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "History",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DownloadNav()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.file_download,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Download",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUs()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Contact Us",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: boxDecoration(),
                  ),
                  isLogin
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                          selectedPage: 0,
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Settings",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  size: 25,
                                ),
                              ],
                            ),
                          ))
                      : SizedBox(),
                  Padding(
                      padding: const EdgeInsets.only(left: 8, top: 5),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(children: [
                            Icon(
                              Icons.security,
                              size: 15,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Privacy & Terms",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ))),
                          ]))),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (isLogin) {
                          Navigator.of(context).pushReplacementNamed("/home");
                          CacheUtil.clear();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              isLogin ? "Logout" : "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return modalBottomPopup(context);
  }
}
