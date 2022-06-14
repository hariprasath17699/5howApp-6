import 'dart:async';

import 'package:dio/dio.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/Responsive/Response.dart';
import 'package:star_event/User/Login/Login.dart';

class EmailVerification extends StatefulWidget {
  String email;
  EmailVerification({required this.email});

  @override
  _EmailVerificationState createState() => _EmailVerificationState(email);
}

class _EmailVerificationState extends State<EmailVerification> {
  final LocalStorage storage = new LocalStorage('Star');
  final emailController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  bool submitValid = false;
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  String email;
  _EmailVerificationState(this.email);

  void verify(pin) {
    var result = EmailAuth.validate(receiverMail: email, userOTP: pin);
    if (result) {
      _updateDetails();
    } else {
      AlertDialog(
        title: Text("Error"),
        content: Text("Invalid Otp"),
      );
    }
    print(EmailAuth.validate(receiverMail: email, userOTP: pin));
  }

  Future _updateDetails() async {
    var url = "http://5howapp.com/StarLoginAndRegister/userVerification.php";
    Dio dio = new Dio();

    var fields = {
      'email': email,
      'Status': "Verified",
    };
    FormData formData = new FormData.fromMap(fields);
    var resp;

    var response = await dio.post(url, data: formData);
    print(response.statusCode);
    print(response.data);
    var res = response.data;
    if (res.contains("User Verified")) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UserLogin();
      }));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  void sendOtp() async {
    EmailAuth.sessionName = "Eprodix Company";
    var result = await EmailAuth.sendOtp(receiverMail: email);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  @override
  void initState() {
    sendOtp();
    super.initState();
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
                    "Email Verification",
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
                  padding: EdgeInsets.only(top: 60, left: 100, right: 10),
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
            Column(
              children: [
                Center(
                  child: Text(
                    "Verification Code",
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
            Column(
              children: [
                Center(
                  child: Text(
                    "Enter the 6-digit code below.",
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
            Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: PinCodeTextField(
                  backgroundColor: Colors.white,
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "Invalid Otp";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: hasError ? Colors.white : Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {},
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                )),
            Column(
              children: [
                FlatButton(
                  onPressed: () {
                    sendOtp();
                  },
                  child: Center(
                    child: Text(
                      "Don’t got code? Resend to E-mail",
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
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
              child: Center(
                child: Container(
                  height: 45,
                  child: ButtonWidget(
                    color: Color.fromRGBO(254, 118, 7, 10),
                    text: '  Submit  ',
                    onClicked: () async {
                      verify(currentText);
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
