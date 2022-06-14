import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/Admin/AdminHomePage.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/Responsive/Response.dart';

import 'AdminProfile.dart';

final LocalStorage storage = new LocalStorage('Star');

Future<Username> fetchAlbum() async {
  final url = ('http://5howapp.com/StarLoginAndRegister/userLogin.php');
  Dio dio = new Dio();
  var fields = {
    'email': storage.getItem("email"),
    'password': storage.getItem("password")
  };
  FormData formData = new FormData.fromMap(fields);
  var resp;

  var response = await dio.post(url, data: formData);
  if (response.statusCode == 200) {
    print(response);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Username.fromJson(jsonDecode(response.data));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Username {
  Username({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory Username.fromJson(Map<String, dynamic> json) => Username(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.fullname,
    required this.username,
    required this.password,
    required this.email,
    required this.interest,
    required this.country,
    required this.dob,
    required this.image,
    required this.createdAt,
    required this.status,
  });

  String userId;
  String fullname;
  String username;
  String password;
  String email;
  String interest;
  String country;
  String dob;
  String image;
  DateTime createdAt;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        fullname: json["fullname"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        interest: json["interest"],
        country: json["country"],
        dob: json["dob"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullname": fullname,
        "username": username,
        "password": password,
        "email": email,
        "interest": interest,
        "country": country,
        "dob": dob,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "Status": status,
      };
}

class AdminAccountSettings extends StatefulWidget {
  final String username;
  final String password;
  final String dob;
  final String email;
  final String image;
  const AdminAccountSettings(
      {required this.email,
      required this.dob,
      required this.image,
      required this.username,
      required this.password});

  @override
  _AdminAccountSettingsState createState() =>
      _AdminAccountSettingsState(username, password, dob, email, image);
}

class _AdminAccountSettingsState extends State<AdminAccountSettings> {
  late Future<Username> futureAlbum;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final DateOfBirth = TextEditingController();
  final Password = TextEditingController();
  late Future<PickedFile?> imagePicked;
  late String base64Image;
  late File tmpFile;
  String username;
  String password;
  String dob;
  String email;
  String image;
  PickedFile? _imageFile;
  final String uploadUrl =
      'http://5howapp.com/StarLoginAndRegister/AdminAccountSettings.php';
  final ImagePicker _picker = ImagePicker();
  _AdminAccountSettingsState(
      this.username, this.password, this.dob, this.email, this.image);
  Future _updateDetails() async {
    var url =
        ("http://5howapp.com/StarLoginAndRegister/AdminAccountSettings.php");
    Dio dio = new Dio();

    var fields = {
      'email': emailController.text,
      'password': Password.text,
      'dob': DateOfBirth.text,
      'username': nameController.text,
      'email1': storage.getItem("email"),
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
      Navigator.push(this.context,
          MaterialPageRoute(builder: (context) => AdminProfile()));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  final LocalStorage storage = new LocalStorage('Star');
  @override
  void initState() {
    super.initState();
    emailController.text = email;
    nameController.text = username;
    Password.text = password;
    DateOfBirth.text = dob;
    futureAlbum = fetchAlbum();
  }

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
        ButtonState.idle:
            IconedButton(text: "Apply", color: Color.fromRGBO(254, 118, 7, 10)),
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
        Future.delayed(Duration(seconds: 2), () async {
          _updateDetails();
          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.idle
                : ButtonState.idle;
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder<Username>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leadingWidth: 50,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        ButtonTheme(
                          height: 20,
                          minWidth: 20,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminHomepage(0)));
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/images/back.svg",
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Account Settings",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        height: 1.0714285714285714,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Stack(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 170, left: 3, right: 3, bottom: 10),
                        child: Center(
                          child: Container(
                            height: 70.0,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            child: TextField(
                              style: TextStyle(color: Colors.black87),
                              autofocus: false,
                              obscureText: false,
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                  fillColor: Colors.black87,
                                  labelText: "     Username",
                                  hintText: "      Username",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.red,
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 240,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Center(
                          child: Container(
                            height: 70.0,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            child: TextField(
                              style: TextStyle(color: Colors.black87),
                              autofocus: false,
                              obscureText: false,
                              keyboardType: TextInputType.datetime,
                              controller: DateOfBirth,
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                  fillColor: Colors.black87,
                                  labelText: "     Date Of Birth",
                                  hintText: "      Date Of Birth",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.red,
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 310,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Center(
                          child: Container(
                            height: 70.0,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            child: TextField(
                              style: TextStyle(color: Colors.black87),
                              autofocus: false,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                  fillColor: Colors.black87,
                                  labelText: "     Email",
                                  hintText: "      Email",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.red,
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 380,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Center(
                          child: Container(
                            height: 70.0,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            child: TextField(
                              style: TextStyle(color: Colors.black87),
                              autofocus: false,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: Password,
                              cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                  fillColor: Colors.black87,
                                  labelText: "     Password",
                                  hintText: "      Password",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.red,
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 500),
                        child: Center(
                            child: Container(
                                height: 45,
                                child: buildTextWithIconWithMinState())),
                      ),
                    ]),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(
              child: const CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
          ));
        });
  }
}
