import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';

import 'AdminHomePage.dart';
import 'AppBarAdmin.dart';

class AllUserDetailsScreen extends StatefulWidget {
  String Name;
  String Image;
  String DOB;
  String Proof;
  String Interest;
  String email;
  String join;
  String password;
  String Logintype;
  String country;
  AllUserDetailsScreen(
      {required this.Name,
      required this.Image,
      required this.DOB,
      required this.Proof,
      required this.Interest,
      required this.email,
      required this.join,
      required this.password,
      required this.Logintype,
      required this.country});
  _AllUserDetailsScreenState createState() => _AllUserDetailsScreenState(Name,
      Image, DOB, Proof, Interest, email, join, password, Logintype, country);
}

class _AllUserDetailsScreenState extends State<AllUserDetailsScreen> {
  String name;
  String image;
  String dob;
  String proof;
  String interest;
  String email;
  String join;
  String password;
  String logintype;
  String country;
  _AllUserDetailsScreenState(
      this.name,
      this.image,
      this.dob,
      this.proof,
      this.interest,
      this.email,
      this.join,
      this.password,
      this.logintype,
      this.country);
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
            text: "Delete", color: Color.fromRGBO(254, 118, 7, 10)),
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
          deletedata();
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

  Future deletedata() async {
    var url = "http://5howapp.com/StarLoginAndRegister/DeleteUser.php";
    Dio dio = new Dio();

    var fields = {
      'email': email,
    };
    FormData formData = new FormData.fromMap(fields);
    var resp;

    var response = await dio.post(url, data: formData);
    print(response.statusCode);
    print(response.data);
    var res = response.data;
    if (res.contains("true")) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AdminHomepage(2);
      }));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Column(
            children: [
              Row(
                children: [
                  AppBarAdmin(
                    image: image,
                    name: name,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("User Name :",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Text(name),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Email :",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Text(email),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Password :",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Text(password),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Join Time/Date :",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Text(join),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("LoginType :",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Text(logintype),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Country :",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Text(country),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "DOB :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Text(dob),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            child: Center(
              child:
                  Container(height: 45, child: buildTextWithIconWithMinState()),
            ),
          ),
        ],
      ),
    );
  }
}
