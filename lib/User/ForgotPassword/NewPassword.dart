import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/Responsive/Response.dart';
import 'package:star_event/User/Login/Login.dart';

class NewPassword extends StatefulWidget {
  String email;
  NewPassword({required this.email});

  @override
  _NewPasswordState createState() => _NewPasswordState(email);
}

class _NewPasswordState extends State<NewPassword> {
  final LocalStorage storage = new LocalStorage('Star');

  final passwordController = TextEditingController();
  String email;
  _NewPasswordState(this.email);
  Future _updateDetails(String password) async {
    var url = "http://5howapp.com/StarLoginAndRegister/forgotPassword.php";
    Dio dio = new Dio();

    var fields = {
      'email': email,
      'password': password,
    };
    FormData formData = new FormData.fromMap(fields);
    var resp;

    var response = await dio.post(url, data: formData);
    print(response.statusCode);
    print(response.data);
    var res = response.data;
    if (res.contains("true")) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UserLogin();
      }));
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
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 30, top: 60),
                  child: Text(
                    "Forgot your Password?",
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
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 60, right: 0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserLogin()));
                    },
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/images/decline.svg",
                        height: 30,
                        width: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 30, top: 220),
                  child: Text(
                    "Enter Your New Password to reset",
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
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 30,
                  top: MediaQuery.of(context).size.height / 25),
              child: Container(
                height: 70.0,
                width: 350,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    New Password",
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
              padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
              child: Center(
                child: Container(
                  height: 45,
                  child: ButtonWidget(
                    color: Color.fromRGBO(254, 118, 7, 10),
                    text: 'Change Password',
                    onClicked: () async {
                      if (passwordController.text == null) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              'Please enter emailId',
                              style: TextStyle(fontSize: 10),
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Ok'),
                              )
                            ],
                          ),
                        );
                      } else {
                        _updateDetails(passwordController.text);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
