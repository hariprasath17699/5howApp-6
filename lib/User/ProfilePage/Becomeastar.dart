import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/HomeScreen/StarRequestProof.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/Responsive/Response.dart';
import 'package:star_event/User/HomePage/Homepage.dart';

class Areyouastar extends StatefulWidget {
  String email;
  Areyouastar({required this.email});

  @override
  _AreyouastarState createState() => _AreyouastarState(email);
}

class _AreyouastarState extends State<Areyouastar> {
  Object? _typeData = "Youtube";
  final phonenumberController = TextEditingController();
  final profilelinkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalStorage storage = new LocalStorage('Star');

  String message = "";
  bool loading = false;
  String email;
  _AreyouastarState(this.email);
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
      ButtonState.idle:
          IconedButton(text: "Send", color: Colors.deepPurple.shade500),
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
        ButtonState.idle:
            IconedButton(text: "Send", color: Color.fromRGBO(254, 118, 7, 10)),
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
      minWidthStates: [ButtonState.loading, ButtonState.success],
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
          _updateDetails();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homepage(3)));
          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.fail
                : ButtonState.fail;
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

  Future _updateDetails() async {
    var url = ("http://5howapp.com/StarLoginAndRegister/becomeAstar.php");
    Dio dio = new Dio();
    var fields = {
      'email': email,
      'Platform': _typeData,
      'Phone': phonenumberController.text,
      'profilelink': profilelinkController.text,
      'starstatus': "All"
    };
    FormData formData = new FormData.fromMap(fields);
    var resp;

    var response = await dio.post(
      url,
      data: formData,
    );
    print(response.statusCode);
    print(response.data);
    var res = response.data;
    if (res.contains("true")) {
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Homepage(3)));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth / 10,
                  right: SizeConfig.screenWidth / 1.2),
              child: Center(
                child: Text(
                  "Star",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w800,
                    height: 1.0714285714285714,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.screenWidth / 5,
                      left: SizeConfig.screenWidth / 2.8),
                  child: Text(
                    "Become a star?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.screenWidth / 10,
                      left: 10,
                      top: SizeConfig.screenHeight / 40),
                  child: Container(
                    height: 80,
                    width: 340,
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: SizeConfig.screenWidth / 10,
                    left: 10,
                  ),
                  child: Container(
                    height: 80,
                    width: 340,
                    child: Text(
                      "If you are curious which kind of proofen screenshot we need just follow the instructions",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                height: 55,
                width: 600,
                child: DropdownButtonFormField(
                  validator: (value) => null,
                  value: _typeData,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'Youtube',
                        style: TextStyle(fontSize: 11),
                      ),
                      value: 'Youtube',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Instagram',
                        style: TextStyle(fontSize: 11),
                      ),
                      value: 'Instagram',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Facebook',
                        style: TextStyle(fontSize: 11),
                      ),
                      value: 'Facebook',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _typeData = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Container(
                height: 70.0,
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: profilelinkController,
                  decoration: InputDecoration(
                      labelText: "ProfileLink",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white,
                              style: BorderStyle.solid))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Container(
                height: 70.0,
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: phonenumberController,
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white,
                              style: BorderStyle.solid))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ButtonWidget(
                color: Color.fromRGBO(60, 34, 95, 10),
                text: 'Upload Image',
                onClicked: () {
                  _updateDetails();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageUpload(email)));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 80, left: 50, right: 50, bottom: 100),
              child: Center(
                child: Container(
                  height: 45,
                  child: buildTextWithIconWithMinState(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
