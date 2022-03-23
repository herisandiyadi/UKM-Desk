import 'dart:convert';

import 'package:enforcea/component/changesPassword.dart';
import 'package:enforcea/component/searchNav.dart';
import 'package:enforcea/constants.dart';
import 'package:enforcea/cubit/profile/profile_cubit.dart';
import 'package:enforcea/repository/profile_repository.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/util/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/component/ui/cardView.dart';
import 'package:enforcea/theme/homeTheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileNavPage extends StatefulWidget {
  const ProfileNavPage({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  _ProfileNavPageState createState() => _ProfileNavPageState();
}

class _ProfileNavPageState extends State<ProfileNavPage>
    with SingleTickerProviderStateMixin {
  List<Widget> listBasicProfile = <Widget>[];
  List<Widget> listPersonal = <Widget>[];
  List<Widget> listAction = <Widget>[];
  TabController controller1;
  Color gradientStart = Colors.red[500]; //Change start gradient color here
  Color gradientEnd = Colors.red[800]; //Change end gradient color here
  String _companyName = "-";
  String _npwp = "-";
  String _address = "-";
  String _personalName = "-";
  String _phoneNumber = "-";
  String _email = "-";

  @override
  void initState() {
    controller1 = new TabController(vsync: this, length: 3, initialIndex: 0);

    super.initState();
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          //                    <--- top side
          color: Colors.black54,
          width: 2.0,
        ),
      ),
    );
  }

  void addListBasicProfile() {
    listBasicProfile.clear();
    listBasicProfile.add(Container(
      decoration: boxDecoration(),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(
            width: 10,
          ),
          Text(
            _companyName,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: HomeTheme.fontName,
            ),
          ),
        ],
      ),
    ));

    listBasicProfile.add(Container(
      decoration: boxDecoration(),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(Icons.credit_card),
          SizedBox(
            width: 10,
          ),
          Text(
            "NPWP: " + _npwp,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: HomeTheme.fontName,
            ),
          ),
        ],
      ),
    ));

    listBasicProfile.add(Container(
      decoration: boxDecoration(),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(Icons.location_city),
          SizedBox(
            width: 10,
          ),
          Text(
            "Address: " + _address,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: HomeTheme.fontName,
            ),
          ),
        ],
      ),
    ));
  }

  void addListPersonal() {
    listPersonal.clear();
    listPersonal.add(Container(
      decoration: boxDecoration(),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(
            width: 10,
          ),
          Text(
            _personalName,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: HomeTheme.fontName,
            ),
          ),
        ],
      ),
    ));

    listPersonal.add(Container(
      decoration: boxDecoration(),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(Icons.phone_android),
          SizedBox(
            width: 10,
          ),
          Text(
            _phoneNumber,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: HomeTheme.fontName,
            ),
          ),
        ],
      ),
    ));

    listPersonal.add(Container(
      decoration: boxDecoration(),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(Icons.contact_mail),
          SizedBox(
            width: 10,
          ),
          Text(
            _email,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: HomeTheme.fontName,
            ),
          ),
        ],
      ),
    ));
  }

  void addListAction(BuildContext context) {
    listAction.clear();
    listAction.add(Ink(
      child: InkWell(
        onTap: () {
          final profileCubit = context.bloc<ProfileCubit>();
          CacheUtil.getString(CACHE_EMAIL)
              .then((value) => profileCubit.updatePassword(value));
        },
        child: Container(
          decoration: boxDecoration(),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(Icons.lock_open),
              SizedBox(
                width: 10,
              ),
              Text(
                "Changes Password",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: HomeTheme.fontName,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
    // listAction.add(Container(
    //   decoration: boxDecoration(),
    //   padding: const EdgeInsets.all(15),
    //   child: Row(
    //     children: [
    //       Icon(Icons.person_add),
    //       SizedBox(
    //         width: 10,
    //       ),
    //       Text(
    //         "Update Profile",
    //         style: TextStyle(
    //           fontSize: 15,
    //           fontWeight: FontWeight.bold,
    //           fontFamily: HomeTheme.fontName,
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final LoadingUtil loading = LoadingUtil(context);

    return Container(
        color: HomeTheme.background,
        child: BlocProvider(
          create: (providerContext) => ProfileCubit(ProfileRepository()),
          child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (listenerContext, state) {
            if (state is UpdateLoading) {
              loading.showLoading();
            } else if (state is UpdateLoaded) {
              loading.hideLoading();
              if (state.isSuccess) {
                Fluttertoast.showToast(
                    msg:
                        'Permintaan ubah password anda sudah dikirim via email.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[600],
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            } else if (state is ProfileError) {
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
          }, builder: (builderContext, state) {
            if (state is ProfileLoaded) {
              final data = state.profileData;
              _companyName = jsonDecode(data)['data_user']['nama'];
              _npwp = jsonDecode(data)['data_user']['npwp'];
              _address = jsonDecode(data)['data_user']['address'];
              _personalName = jsonDecode(data)['data_pic']['nama'];
              _phoneNumber = jsonDecode(data)['data_pic']['phone'];
              _email = jsonDecode(data)['data_pic']['email'];

              return getInitialView(builderContext);
            } else if (state is ProfileInitial || state is ProfileLoading) {
              if (state is ProfileInitial) {
                final profileCubit = builderContext.bloc<ProfileCubit>();
                profileCubit.profile();
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red[800]),
                ),
              );
            } else {
              return getInitialView(context);
            }
          }),
        ));
  }

  Widget getInitialView(BuildContext context) {
    addListBasicProfile();
    addListPersonal();
    addListAction(context);
    return Scaffold(
      appBar: new AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [gradientStart, gradientEnd],
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
        ),
        toolbarHeight: 210,
        title: getProfileImage(),
        bottom: TabBar(
            controller: controller1,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: <Tab>[
              Tab(
                text: "Basic Profile",
              ),
              Tab(
                text: "Personal",
              ),
              Tab(
                text: "Action",
              ),
            ]),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          tabBarView(),
        ],
      ),
    );
  }

  Widget getProfileImage() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Column(
                    children: <Widget>[
                      ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.red, // inkwell color
                            child: SizedBox(
                                width: 25,
                                height: 25,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                )),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1024px-User_icon_2.svg.png"),
              ),
            ),
            Text(
              _companyName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Medium Level",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBarView() {
    return Container(
      child: TabBarView(controller: controller1, children: [
        Container(
          child: ListView.builder(
            itemCount: listBasicProfile.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listBasicProfile[index];
            },
          ),
        ),
        Container(
          child: ListView.builder(
            itemCount: listPersonal.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listPersonal[index];
            },
          ),
        ),
        Container(
          child: ListView.builder(
            itemCount: listAction.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listAction[index];
            },
          ),
        ),
      ]),
    );
  }
}
