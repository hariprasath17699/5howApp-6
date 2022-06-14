import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/Admin/AdminHomePage.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/StarHomePage/StarHome.dart';
import 'package:star_event/User/ForgotPassword/EmailVerification.dart';
import 'package:star_event/User/ForgotPassword/ForgotPassword.dart';
import 'package:star_event/User/HomePage/Homepage.dart';
import 'package:star_event/User/Signup/Signup.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalStorage storage = new LocalStorage('Star');

  late String email, password;
  String message = "";
  bool loading = false;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;
  Widget buildCustomButton() {
    var progressTextButton = ProgressButton(
      stateWidgets: {
        ButtonState.idle: Text(
          "Idle",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.loading: Text(
          "Loading",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.fail: Text(
          "Fail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.success: Text(
          "Success",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      },
      stateColors: {
        ButtonState.idle: Colors.grey.shade400,
        ButtonState.loading: Colors.blue.shade300,
        ButtonState.fail: Colors.red.shade300,
        ButtonState.success: Colors.green.shade400,
      },
      onPressed: onPressedCustomButton,
      state: stateOnlyText,
      padding: EdgeInsets.all(8.0),
    );
    return progressTextButton;
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Send",
          icon: Icon(Icons.send, color: Colors.white),
          color: Colors.deepPurple.shade500),
      ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
      ButtonState.fail:
          IconedButton(text: "Failed", color: Colors.red.shade300),
      ButtonState.success: IconedButton(text: "", color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Sign In", color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.loading: IconedButton(
            text: "Loading", color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.fail:
            IconedButton(text: "Failed", color: Colors.red.shade300),
        ButtonState.success:
            IconedButton(color: Color.fromRGBO(254, 118, 7, 10))
      },
      onPressed: onPressedIconWithMinWidthStateText,
      state: stateTextWithIconMinWidthState,
      minWidthStates: [ButtonState.loading, ButtonState.loading],
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 5), () async {
          stateTextWithIcon = ButtonState.idle;
          String email = emailController.text;
          String password = passwordController.text;
          setState(() {
            message = 'Please Wait....';
          });
          var rsp = await loginUser(email, password);

          // var rest = rsp["name"]["name"];
          // print(rest);
          storage.setItem("user", "true");

          print("responce: ${rsp}");
          print(rsp.toString().contains("true"));
          if (rsp.toString().contains("not verifed")) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                  title: new Text("User Not Verified",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'ROGFontsv',
                          color: Colors.black)),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text("OK",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'ROGFontsv',
                              color: Colors.black87)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: new Text("Verify Now",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'ROGFontsv',
                              color: Colors.black87)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EmailVerification(
                            email: email,
                          );
                        }));
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            stateTextWithIcon = ButtonState.idle;
            if (rsp.toString().contains("true")) {
              if (rsp.toString().contains("AdminLogin")) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AdminHomepage(0);
                }));
              } else if (rsp.toString().contains("UserLogin")) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Homepage(0);
                }));
              } else if (rsp.toString().contains("StarLogin")) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return StarHomepage(0);
                }));
              }
            } else {
              stateTextWithIcon = ButtonState.idle;
              if (emailController.text.isEmpty &
                  passwordController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 2,
                      title: new Text("Please enter email and password",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'ROGFontsv',
                              color: Colors.black)),
                      actions: <Widget>[
                        FlatButton(
                          child: new Text("OK",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'ROGFontsv',
                                  color: Colors.black87)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                stateTextWithIcon = ButtonState.idle;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 2,
                      title: new Text("Invalid Login Details",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'ROGFontsv',
                              color: Colors.black)),
                      actions: <Widget>[
                        FlatButton(
                          child: new Text("OK",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'ROGFontsv',
                                  color: Colors.black87)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              }
              setState(() {
                message = 'false';
                stateTextWithIcon = ButtonState.idle;
              });
            }
          }
          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.fail
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.fail:
        break;
      case ButtonState.success:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIconMinWidthState = stateTextWithIconMinWidthState;
    });
  }

  Future loginUser(String email, String password) {
    setState(() {
      loading = true;
    });
    String url = "http://5howapp.com/StarLoginAndRegister/userLogin.php";
    Dio dio = new Dio();

    var fields = {'email': email, 'password': password};

    dio.options.method = "POST";
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    dio.options.headers["Access-Control-Allow-Credentials"] = true;
    dio.options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    dio.options.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS";

    FormData formData = new FormData.fromMap(fields);
    var resp;
    storage.setItem("email", email);
    storage.setItem("password", password);

    var response = dio.post(url, data: formData);
    print(response);

    setState(() {
      loading = false;
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 76),
                      child: new SvgPicture.asset(
                        "assets/images/Login.svg",
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 155,
                        top: 87,
                      ),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          fontFamily: 'Poppinsregular',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 200, right: 40, top: 87),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserRegister()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontFamily: 'Poppinsregular',
                              fontSize: 14,
                              color: const Color(0xff000000),
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 280,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Container(
                  height: 70.0,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: TextField(
                    style: TextStyle(color: Color.fromRGBO(60, 34, 95, 10)),
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                        fillColor: Colors.black87,
                        labelText: "    Your Email",
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 10),
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 350,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Container(
                  height: 70.0,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: TextField(
                    style: TextStyle(color: Color.fromRGBO(60, 34, 95, 10)),
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordController,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                        fillColor: Colors.black87,
                        labelText: "    Your Password",
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 10),
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 428, right: 20, left: 20),
                child: Center(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: new SvgPicture.asset(
                      "assets/images/forgot.svg",
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 490),
                child: Center(
                  child: Container(
                      height: 43, child: buildTextWithIconWithMinState()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
