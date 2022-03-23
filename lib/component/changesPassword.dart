import 'package:flutter/material.dart';
import 'package:enforcea/util/loading_util.dart';
import 'package:enforcea/cubit/register/register_cubit.dart';
import 'package:enforcea/model/request/register_request.dart';
import 'package:enforcea/repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangesPassword extends StatelessWidget {
  // const ChangesPassword({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController lastPassword = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoadingUtil loading = LoadingUtil(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Changes Password"),
          backgroundColor: Colors.red[800],
        ),
        body: BlocProvider(
          create: (providerContext) => RegisterCubit(RegisterRepository()),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (listenerContext, state) {
              if (state is RegisterLoading) {
                loading.showLoading();
              } else if (state is RegisterLoaded) {
                loading.hideLoading();
              } else if (state is RegisterError) {
                loading.hideLoading();
                Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[600],
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                loading.hideLoading();
              }
            },
            builder: (builderContext, state) {
              if (state is RegisterLoaded) {
                if (state.isRegisterSuccess) {
                  // return successPage();
                } else {
                  return initialPage(builderContext);
                }
              } else {
                return initialPage(builderContext);
              }
            },
          ),
        ));
  }

  Widget initialPage(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Masukkan password lama";
              }
              return null;
            },
            controller: lastPassword,
            decoration: InputDecoration(
              labelText: 'Password Lama',
              prefixIcon: Icon(Icons.vpn_key),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Masukkan password baru";
              }
              return null;
            },
            controller: lastPassword,
            decoration: InputDecoration(
              labelText: 'Password Baru',
              prefixIcon: Icon(Icons.vpn_key),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (!(value.compareTo(passwordController.text) == 0)) {
                return 'Password not match';
              }
              return null;
            },
            controller: lastPassword,
            decoration: InputDecoration(
              labelText: 'Konfirmasi password',
              prefixIcon: Icon(Icons.vpn_key),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 35,
            width: 500,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RaisedButton(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red[600])),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final registerCubit = context.bloc<RegisterCubit>();
                  registerCubit.register(RegisterRequest(
                      password: passwordController.text,
                      pic: "1",
                      passwordConfirm: confirmPasswordController.text));
                } else {
                  Fluttertoast.showToast(
                      msg: 'Please check all of the fields',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[600],
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              color: Colors.red[800],
              textColor: Colors.white,
              child:
                  Text("submit".toUpperCase(), style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
