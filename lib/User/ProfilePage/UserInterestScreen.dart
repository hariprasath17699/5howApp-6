import 'dart:convert';
import 'dart:math';

import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/Responsive/Response.dart';
import 'package:star_event/User/HomePage/Homepage.dart';

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

class UserInterestScreen extends StatefulWidget {
  String email;
  String interest;
  String country;
  UserInterestScreen(
      {required this.email, required this.interest, required this.country});

  @override
  _UserInterestScreenState createState() =>
      _UserInterestScreenState(email, interest, country);
}

class _UserInterestScreenState extends State<UserInterestScreen> {
  final LocalStorage storage = new LocalStorage('Star');
  String message = "";
  bool loading = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final DateOfBirth = TextEditingController();
  final Password = TextEditingController();
  String Country1 = "";
  List? _myActivities;

  late String _myActivitiesResult;
  String email;
  String interest;
  String country;
  _UserInterestScreenState(this.email, this.interest, this.country);
  final formKey = new GlobalKey<FormState>();
  late Future<Username> futureAlbum;

  @override
  void initState() {
    super.initState();

    Country1 = country;
    _myActivitiesResult = '';
    futureAlbum = fetchAlbum();
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  Future _updateDetails() async {
    var url = ("http://5howapp.com/StarLoginAndRegister/interestScreen.php");
    Dio dio = new Dio();

    var fields = {
      'country': Country1,
      'interest': _myActivities.toString(),
      'interest1': _myActivities.toString(),
      'interest2': _myActivities.toString(),
      'interest3': _myActivities.toString(),
      'interest4': _myActivities.toString(),
      'interest5': _myActivities.toString(),
      'email': email,
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
            IconedButton(text: "Done", color: Color.fromRGBO(254, 118, 7, 10)),
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
          if (Country1.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                  title: new Text("Please Select Country",
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
                        setState(() {
                          stateTextWithIconMinWidthState =
                              Random.secure().nextBool()
                                  ? ButtonState.success
                                  : ButtonState.success;
                        });
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            _updateDetails();
          }

          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.loading
                : ButtonState.loading;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
      case ButtonState.loading:
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
                          right: SizeConfig.screenWidth / 1.5),
                      child: Center(
                        child: Text(
                          "Interest",
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 20,
                        left: MediaQuery.of(context).size.width / 20,
                        right: MediaQuery.of(context).size.width / 20,
                        bottom: MediaQuery.of(context).size.height / 100,
                      ),
                      child: ButtonWidget(
                        color: Color.fromRGBO(60, 34, 95, 10),
                        onClicked: () {
                          showCountryPicker(
                            context: context,
                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            exclude: <String>['KN', 'MF'],
                            //Optional. Shows phone code before the country name.
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              print('Select country: ${country.displayName}');
                              setState(() {
                                Country1 = country.displayName;
                              });
                            },
                            // Optional. Sets the theme for the country list picker.
                            countryListTheme: CountryListThemeData(
                              // Optional. Sets the border radius for the bottomsheet.
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              // Optional. Styles the search field.
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        text: "Country: ${Country1}",
                      ),
                    ),
                    Center(child: Container(child: Text("YourCountry "))),
                    Center(
                        child: Container(
                            child: Text(snapshot.data!.data.country))),
                    Container(
                      padding: EdgeInsets.only(
                          top: 100, bottom: 50, left: 10, right: 10),
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
                          "Music",
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
                            "display": "POP",
                            "value": "POP",
                          },
                          {
                            "display": "ROCK",
                            "value": "ROCK",
                          },
                          {
                            "display": "HIPHOP",
                            "value": "HIPHOP",
                          },
                          {
                            "display": "MELODY",
                            "value": "MELODY",
                          },
                          {
                            "display": "JAZZ",
                            "value": "JAZZ",
                          },
                          {
                            "display": "FOLK",
                            "value": "FOLK",
                          },
                          {
                            "display": "FUNK",
                            "value": "FUNK",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',
                        fillColor: Colors.white,
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
                    Center(child: Container(child: Text("YourInterest "))),
                    Center(
                        child: Container(
                            child: Text(snapshot.data!.data.interest))),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 50, right: 50, bottom: 100),
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
          return Center(
              child: const CircularProgressIndicator(
            backgroundColor: Colors.white,
          ));
        });
  }
}
