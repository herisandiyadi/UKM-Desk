import 'package:enforcea/cubit/register/register_cubit.dart';
import 'package:enforcea/model/request/register_request.dart';
import 'package:enforcea/repository/register_repository.dart';
import 'package:enforcea/util/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController companyController = TextEditingController();
  TextEditingController npwpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Color gradientStart = Colors.red[600]; //Change start gradient color here
  Color gradientMidle = Colors.red[900]; //Change end gradient color here
  Color gradientEnd = Colors.red[700]; //Change end gradient color here
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  @override
  Widget build(BuildContext context) {
    print("create");
    LoadingUtil loading = LoadingUtil(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                return successPage();
              } else {
                return initialPage(builderContext);
              }
            } else {
              return initialPage(builderContext);
            }
          },
        ),
      ),
    );
  }

  Widget successPage() {
    return Container(
      padding: EdgeInsets.all(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 150.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Account created, please check your email to verify",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget initialPage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "input your company name";
                  }
                  return null;
                },
                controller: companyController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  prefixIcon: Icon(Icons.account_balance),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "input your company Address";
                  }
                  return null;
                },
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Company Address',
                  prefixIcon: Icon(Icons.map),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              TextFormField(
                controller: npwpController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(15),
                  new CardNumberInputFormatter()
                ],
                decoration: InputDecoration(
                  labelText: 'NPWP',
                  prefixIcon: Icon(Icons.credit_card),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!RegExp(emailRegex).hasMatch(value)) {
                    return "Email not valid";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_android),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !isPasswordVisible,
                validator: (value) {
                  if (value.length < 8) {
                    return 'Password at least 8 characters';
                  }
                  return null;
                },
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
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              TextFormField(
                controller: confirmPasswordController,
                validator: (value) {
                  if (!(value.compareTo(passwordController.text) == 0)) {
                    return 'Password not match';
                  }
                  return null;
                },
                obscureText: !isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Retype Password',
//                      suffixIcon: setShowHideIcon(isConfirmPasswordVisible),
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: setShowHideIcon(
                    isConfirmPasswordVisible,
                    () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
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
                      side: BorderSide(color: Colors.red[600])),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      final registerCubit = context.bloc<RegisterCubit>();
                      registerCubit.register(RegisterRequest(
                          email: emailController.text,
                          namaPerusahan: companyController.text,
                          npwp: npwpController.text,
                          phone: phoneNumberController.text,
                          alamat: addressController.text,
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
                  child: Text("submit".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                ),
              ),
            ],
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

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      // if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
      //   buffer.write('  '); // Add double spaces.
      // }

      switch (nonZeroIndex) {
        case 2:
          buffer.write('.');
          break;
        case 5:
          buffer.write('.');
          break;
        case 8:
          buffer.write('.');
          break;
        case 9:
          buffer.write('-');
          break;
        case 12:
          buffer.write('.');
          break;
        default:
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
