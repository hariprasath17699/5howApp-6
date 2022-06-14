import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/StarHomePage/StarHome.dart';

import 'IconButton.dart';
import 'ProgressButton.dart';
import 'Response.dart';

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

class StarAccountSettings extends StatefulWidget {
  final String username;
  final String password;
  final String dob;
  final String email;
  final String image;
  final String paypalId;
  const StarAccountSettings(
      {required this.email,
      required this.dob,
      required this.image,
      required this.username,
      required this.password,
      required this.paypalId});

  @override
  _StarAccountSettingsState createState() => _StarAccountSettingsState(
      username, password, dob, email, image, paypalId);
}

class _StarAccountSettingsState extends State<StarAccountSettings> {
  late Future<Username> futureAlbum;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final paypalIdController = TextEditingController();
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
  File? _imageFile;
  final String uploadUrl =
      'http://5howapp.com/StarLoginAndRegister/AccountSettingUser.php';
  final String uploadwithoutimageurl =
      'http://5howapp.com/StarLoginAndRegister/AccountSettingUserWithoutImage.php';
  String paypalId;
  final ImagePicker _picker = ImagePicker();
  _StarAccountSettingsState(this.username, this.password, this.dob, this.email,
      this.image, this.paypalId);
  Future _updateDetails() async {
    var url = ("http://5howapp.com/StarLoginAndRegister/accountSettings.php");
    Dio dio = new Dio();

    var fields = {
      'email': emailController.text,
      'password': Password.text,
      'dob': DateOfBirth.text,
      'username': nameController.text,
      'email1': storage.getItem("email"),
      'image': imagePicked
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
          MaterialPageRoute(builder: (context) => StarHomepage(4)));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  Future<String?> uploadwithoutImage(url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['email'] = emailController.text;
    request.fields['password'] = Password.text;
    request.fields['dob'] = DateOfBirth.text;
    request.fields['username'] = nameController.text;
    request.fields['email1'] = storage.getItem("email");
    request.fields['paypalId'] = paypalIdController.text;
    print(email);
    var res = await request.send();
    print(res.reasonPhrase);
    if (res.reasonPhrase != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StarHomepage(3)));
      return res.reasonPhrase;
    }
  }

  Future<String?> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    request.fields['email'] = emailController.text;
    request.fields['password'] = Password.text;
    request.fields['dob'] = DateOfBirth.text;
    request.fields['username'] = nameController.text;
    request.fields['email1'] = storage.getItem("email");
    request.fields['paypalId'] = paypalIdController.text;
    print(email);
    var res = await request.send();
    print(res.reasonPhrase);
    if (res.reasonPhrase != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StarHomepage(3)));
      return res.reasonPhrase;
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      _cropImage(pickedFile!.path);
      setState(() {
        _imageFile = pickedFile as File?;
        storage.setItem("_pickedFile", _imageFile);
      });
    } catch (e) {}
  }

  _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      setState(() {
        _imageFile = croppedImage;
      });
    }
  }

  final LocalStorage storage = new LocalStorage('Star');
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
      ButtonState.fail:
          IconedButton(text: "Failed", color: Colors.red.shade300),
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
        ButtonState.fail:
            IconedButton(text: "Failed", color: Colors.red.shade300),
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
          if (_imageFile == null) {
            var res = await uploadwithoutImage(uploadwithoutimageurl);
            print(res);
          }
          // _updateDetails();
          else {
            var res = await uploadImage(_imageFile!.path, uploadUrl);
            print(res);
          }

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

  @override
  void initState() {
    super.initState();
    emailController.text = email;
    nameController.text = username;
    Password.text = password;
    DateOfBirth.text = dob;
    paypalIdController.text = paypalId;
    futureAlbum = fetchAlbum();
  }

  Widget imagewidgetfile(String image) {
    if (_imageFile != null) {
      return Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight / 20),
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
              image: DecorationImage(
                image: FileImage(File(_imageFile!.path)),
                fit: BoxFit.cover,
              ),
              border: Border.all(width: 2.0, color: const Color(0xfff99d34)),
            ),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.red,
              ),
              onPressed: () async {
                _pickImage();
              },
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight / 20),
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              border: Border.all(width: 2.0, color: const Color(0xfff99d34)),
            ),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.red,
              ),
              onPressed: () async {
                _pickImage();
              },
            ),
          ),
        ),
      );
    }
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
                  leading: BackButton(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth / 20,
                          right: SizeConfig.screenWidth / 1.6),
                      child: Center(
                        child: Text(
                          "Account Settings",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w800,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Stack(children: [
                      imagewidgetfile(snapshot.data!.data.image),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 170,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Container(
                          height: 70.0,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 240,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Container(
                          height: 70.0,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 310,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Container(
                          height: 70.0,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 380,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Container(
                          height: 70.0,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 450,
                          left: 3,
                          right: 3,
                          bottom: 10,
                        ),
                        child: Container(
                          height: 70.0,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: TextField(
                            style: TextStyle(color: Colors.black87),
                            autofocus: false,
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            controller: paypalIdController,
                            cursorColor: Colors.black87,
                            decoration: InputDecoration(
                                fillColor: Colors.black87,
                                labelText: "     Paypal Id",
                                hintText: "      Paypal Id",
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
                      Padding(
                        padding: const EdgeInsets.only(top: 550),
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
