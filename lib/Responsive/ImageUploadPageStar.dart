import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/StarHomePage/StarProfile.dart';

import 'IconButton.dart';
import 'ProgressButton.dart';
import 'Response.dart';
import 'StarUploadpage.dart';

class ImageUploadStarPage extends StatefulWidget {
  String email;

  ImageUploadStarPage({required this.email});

  @override
  _ImageUploadStarPageState createState() => _ImageUploadStarPageState(email);
}

class _ImageUploadStarPageState extends State<ImageUploadStarPage> {
  Object? _typeData = "Youtube";
  final phonenumberController = TextEditingController();
  final profilelinkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalStorage storage = new LocalStorage('Star');
  final title = TextEditingController();
  final description = TextEditingController();
  final story = TextEditingController();
  final location = TextEditingController();
  String message = "";
  bool loading = false;
  String email;

  _ImageUploadStarPageState(this.email);
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;
  Future<String?> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('Image', filepath));
    request.fields['email'] = email;
    request.fields['Title'] = title.text;
    request.fields['Description'] = description.text;
    request.fields['Story'] = story.text;
    request.fields['Location'] = location.text;
    print(email);
    var res = await request.send();
    if (res.reasonPhrase != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StarProfilePage()));
      return res.reasonPhrase;
    }
  }

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
            text: "Send",
            icon: Icon(Icons.send, color: Colors.white),
            color: Color.fromRGBO(254, 118, 7, 10)),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StarProfilePage()));

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
      Navigator.push(this.context,
          MaterialPageRoute(builder: (context) => StarProfilePage()));
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
              padding: EdgeInsets.only(left: 10, right: 270),
              child: Center(
                child: Text(
                  "Image Upload",
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
            Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              child: Container(
                height: 70.0,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  controller: title,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Title",
                      labelStyle: TextStyle(
                        color: Colors.black87,
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
                top: 5,
                left: 20,
                right: 20,
              ),
              child: Container(
                height: 70.0,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  controller: description,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Description",
                      labelStyle: TextStyle(
                        color: Colors.black87,
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
                top: 5,
                left: 20,
                right: 20,
              ),
              child: Container(
                height: 70.0,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  controller: story,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Story",
                      labelStyle: TextStyle(
                        color: Colors.black87,
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
                top: 5,
                left: 20,
                right: 20,
              ),
              child: Container(
                height: 70.0,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  controller: location,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Location",
                      labelStyle: TextStyle(
                        color: Colors.black87,
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
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ), //SizedBox
                    SizedBox(width: 5), //SizedBox

                    ButtonWidget(
                      color: Color.fromRGBO(60, 34, 95, 10),
                      text: 'Upload Image',
                      onClicked: () {
                        _updateDetails();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StarImageUpload(
                                    email: email,
                                    Title: title.text,
                                    Description: description.text,
                                    Story: story.text,
                                    Location: location.text)));
                      },
                    ),
                  ], //<Widget>[]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ), //SizedBox
                    SizedBox(width: 5), //SizedBox
                    Container(child: buildTextWithIconWithMinState())
                  ], //<Widget>[]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
