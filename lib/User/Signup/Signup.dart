import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/User/ForgotPassword/EmailVerification.dart';
import 'package:star_event/User/Login/Login.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final LocalStorage storage = new LocalStorage('Star');
  bool fbLoading = false, gLoading = false;
  var result;
  late String _email;
  late String _password;

  TextEditingController date1Ctl = TextEditingController();
  String formatDate(DateTime dt) {
    // final now = new DateTime.now();
    // final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('dd-MM-yyyy'); //"6:00 AM"
    return format.format(dt);
  }

  late DateTime date;
  @override
  void initState() {
    super.initState();
  }

  Object? _typeData = "Sports";
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  List? _myActivities;
  bool visible = false;
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
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Register", color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.loading: IconedButton(
            text: "Loading", color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.fail: IconedButton(
            text: "Failed",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Color.fromRGBO(254, 118, 7, 10))
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
        Future.delayed(Duration(seconds: 2), () async {
          _submitCommand();
          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.success;
          });
        });

        break;
      case ButtonState.loading:
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

  Future register() async {
    setState(() {
      visible = true;
    });

    String fullName = fullnameController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String email = emailController.text;
    String DateOfBirth = dobController.text;

    List err = [];
    if (fullName.length < 1) {
      err.add("Name cannot be empty!");
    }
    if (password.length < 8) {
      err.add("Minimum 8 digit password is required!");
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      err.add("Invalid email id");
    }
    // https://stackoverflow.com/questions/50278258/http-post-with-json-on-body-flutter-dart
    if (err.length > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Invalid Field(s)!"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            content: new Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: err.map((e) {
                    return Column(children: [
                      Text(e, style: TextStyle(color: Colors.red)),
                      SizedBox(height: 10),
                    ]);
                  }).toList(),
                )),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      // var url = 'http://192.168.29.103/StarLoginAndRegister/userRegister.php';
      var url =
          Uri.parse("http://5howapp.com/StarLoginAndRegister/userRegister.php");
      // data = {
      //    'fullName': fullName,
      //    'username': username,
      //    'password': password,
      //    'email': email,
      //    'mobile': phoneNumber,
      //  };
      //encode Map to JSON

      var response = await http.post(
        url,
        body: {
          'fullname': fullName,
          'username': username,
          'password': password,
          'email': email,
          'dob': date1Ctl.text,
          'interest': "",
          'country': "",
          'image':
              "https://cdn3.iconfinder.com/data/icons/shape-icons/128/icon48pt_different_account-512.png",
          'Status': "not verifed",
          'LoginType': "UserLogin",
          'Proof': "Not Attached",
          'Phone': "Not Provided",
          'Platform': "Not Provided",
          'profilelink': "Not Provided",
          'interest1': "Not Provided",
          'interest2': "Not Provided",
          'interest3': "Not Provided",
          'interest4': "Not Provided",
          'interest5': "Not Provided",
          'starstatus': "",
          'reason': "",
          'images': "",
          'Event': "",
          'EventStartdate': "",
          'EventDuration': "",
          'EventPassword': "",
          'EventType': "",
          'EventLink': "",
          'EventTopic': "",
          'category': _myActivities.toString(),
          'PaymentKey': "",
          'secret': "",
          'upcomingsession': "",
          'paypalId': "",
          'upcommingsessiondate': "",
          'upcommingparticipantcount': "",
          'upcommingtotalparticipantcount': ""
        },
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
      );
      print("ERROR : " + response.body);
      print(response.statusCode);
      print(response.body);
      print("${response.statusCode}");
      print("${response.body}");
      var dataRecieved = jsonDecode(response.body);
      if (response.body.toString().contains("true")) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 2,
              title: new Text(
                "Register Successful",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailVerification(
                                  email: email,
                                )));
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(response.body.substring(35, 62)),
              actions: <Widget>[
                FlatButton(
                  child: new Text(
                    "OK",
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
      return dataRecieved;
    }

    return false;
    // Showing Alert Dialog with Response JSON.
  }

  void _submitCommand() {
    final form = _formKey.currentState;

    form?.save();
    register();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 76),
                  child: new SvgPicture.asset(
                    "assets/images/Signup.svg",
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 175, top: 87),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLogin()));
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          fontFamily: 'Poppinsregular',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 140, right: 0, top: 87),
                  child: Center(
                    child: Text(
                      "Sign up",
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 160),
                child: Container(
                  height: 75.0,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: TextField(
                    style: TextStyle(color: Color.fromRGBO(60, 34, 95, 10)),
                    keyboardType: TextInputType.text,
                    controller: fullnameController,
                    decoration: InputDecoration(
                        labelText: "   Full Name",
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 10),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(160, 160, 160, 10),
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 230),
                child: Container(
                  height: 75.0,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: TextField(
                    style: TextStyle(color: Color.fromRGBO(60, 34, 95, 10)),
                    keyboardType: TextInputType.text,
                    controller: usernameController,
                    decoration: InputDecoration(
                        labelText: "   Username",
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 10),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(160, 160, 160, 10),
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 310),
                child: Container(
                  height: 75.0,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: TextField(
                    style: TextStyle(color: Color.fromRGBO(60, 34, 95, 10)),
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "   Email",
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 10),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(160, 160, 160, 10),
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 380),
                child: Container(
                    height: 75.0,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: TextFormField(
                      style: TextStyle(color: Color.fromRGBO(60, 34, 95, 10)),
                      controller: date1Ctl,
                      decoration: InputDecoration(
                          labelText: "   Date Of Birth",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(160, 160, 160, 10),
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(160, 160, 160, 10),
                                  style: BorderStyle.solid))),
                      onTap: () async {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          String formattedTimeOfDay = formatDate(date);
                          setState(() {
                            date1Ctl.text = formattedTimeOfDay;
                          });
                        }, locale: LocaleType.en);
                        print(date1Ctl.text);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'cant be empty';
                        }
                        return null;
                      },
                    )),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 450),
                child: Container(
                  height: 75.0,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: TextField(
                    style: TextStyle(color: Color.fromRGBO(60, 34, 95, 10)),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "   Password",
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 10),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(160, 160, 160, 10),
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 530, left: 15, right: 15),
                child: Container(
                  child: MultiSelectFormField(
                    chipBackGroundColor: Colors.deepOrange,
                    enabled: true,
                    chipLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Colors.deepOrange,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text(
                      "Interest Category",
                      style: TextStyle(fontSize: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please select one or more interest';
                      }
                      return null;
                    },
                    dataSource: [
                      {
                        "display": "Sports",
                        "value": "Sports",
                      },
                      {
                        "display": "Music",
                        "value": "Music",
                      },
                      {
                        "display": "Star",
                        "value": "Star",
                      },
                      {
                        "display": "Youtuber",
                        "value": "Youtuber",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    fillColor: Colors.transparent,
                    hintWidget: Text('Please choose one or more'),
                    initialValue: _myActivities,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _myActivities = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 670, left: 100, right: 110, bottom: 30),
                child: Center(
                  child: Container(
                    height: 48,
                    child: buildTextWithIconWithMinState(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const String _svg_c7q0zw =
    '<svg viewBox="36.8 91.9 316.6 45.9" ><path transform="translate(36.77, 91.89)" d="M 22.93271827697754 0 L 293.6286926269531 0 C 306.2940979003906 0 316.5614013671875 10.26732730865479 316.5614013671875 22.93271827697754 C 316.5614013671875 35.59811019897461 306.2940979003906 45.86543655395508 293.6286926269531 45.86543655395508 L 22.93271827697754 45.86543655395508 C 10.26732730865479 45.86543655395508 0 35.59811019897461 0 22.93271827697754 C 0 10.26732730865479 10.26732730865479 0 22.93271827697754 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_1o8lha =
    '<svg viewBox="39.5 347.3 310.5 50.4" ><path transform="translate(39.5, 347.28)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_mqj17e =
    '<svg viewBox="39.5 272.1 310.5 50.4" ><path transform="translate(39.5, 272.1)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#3c225f" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_lpizlm =
    '<svg viewBox="39.5 198.5 310.5 50.4" ><path transform="translate(39.5, 198.48)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_1qk1q7 =
    '<svg viewBox="39.5 496.6 310.5 50.4" ><path transform="translate(39.5, 496.55)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ulafk4 =
    '<svg viewBox="39.5 422.5 310.5 50.4" ><path transform="translate(39.5, 422.46)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_s0gbse =
    '<svg viewBox="111.3 289.0 1.0 18.0" ><path transform="translate(111.33, 289.01)" d="M 0 0 L 0 17.98464775085449" fill="none" stroke="#212121" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_rs2iqc =
    '<svg viewBox="85.0 570.0 14.0 14.0" ><path transform="translate(85.0, 570.0)" d="M 0 0 L 14 0 L 14 14 L 0 14 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_9g7ksu =
    '<svg viewBox="87.8 573.2 8.3 6.7" ><path transform="translate(-57.5, 414.5)" d="M 145.3333282470703 162.3333282470703 L 148 165.3333282470703 L 153.6666717529297 158.6666717529297" fill="none" stroke="#ed9649" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
