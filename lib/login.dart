import 'package:enforcea/cubit/login/login_cubit.dart';
import 'package:enforcea/repository/login_repository.dart';
import 'package:enforcea/util/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:enforcea/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enforcea/home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color gradientStart = Colors.red[500]; //Change start gradient color here
  Color gradientMidle = Colors.red[900]; //Change end gradient color here
  Color gradientEnd = Colors.red[600]; //Change end gradient color here
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    LoadingUtil loading = LoadingUtil(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(
              selectedPage: 0,
            ),
          ),
        );
      },
      child: Scaffold(
        body: BlocProvider(
          create: (contextA) => LoginCubit(LoginRepository()),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (contextB, state) {
              if (state is LoginLoading) {
                loading.showLoading();
              } else if (state is LoginLoaded) {
                loading.hideLoading();
//              Navigator.of(context).pushReplacementNamed("/home");
                // Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
                Navigator.of(context, rootNavigator: true)
                    .pushReplacement(MaterialPageRoute(
                  builder: (context) => Home(
                    selectedPage: 0,
                    drawBottomMenu: true,
                  ),
                ));
              } else if (state is LoginError) {
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
        ),
      ),
    );
  }

  Widget initialPage(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [gradientStart, gradientMidle, gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0, 0.8, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Image(
                      width: 200,
                      height: 200,
                      image: AssetImage("assets/enforce.png")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Sign in".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'User Name',
                                prefixIcon: Icon(Icons.person_outline),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                              child: TextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: setShowHideIcon(
                                    isPasswordVisible,
                                    () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                  prefixIcon: Icon(Icons.lock_outline),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(),
                              FlatButton(
                                onPressed: () {
                                  //forgot password screen
                                },
                                textColor: Colors.blue,
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 35,
                  width: 500,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () {
                      final loginCubit = context.bloc<LoginCubit>();
                      loginCubit.login(
                          nameController.text, passwordController.text);
                    },
                    color: Colors.red[800],
                    textColor: Colors.white,
                    child: Text("submit".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      'Does not have account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 13),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton setShowHideIcon(bool isVisible, Function onPressed) {
    IconData icon;
    if (isVisible) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    return IconButton(onPressed: onPressed, icon: Icon(icon));
  }
}
