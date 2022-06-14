import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/StarHomePage/StarHome.dart';
import 'package:url_launcher/url_launcher.dart';

class StarPaymentKey extends StatefulWidget {
  const StarPaymentKey({Key? key}) : super(key: key);

  @override
  State<StarPaymentKey> createState() => _StarPaymentKeyState();
}

class _StarPaymentKeyState extends State<StarPaymentKey> {
  final paymentkeyController = TextEditingController();
  final secretController = TextEditingController();
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  Future UpdatePaymentKey() async {
    var url =
        Uri.parse("http://5howapp.com/StarLoginAndRegister/PaymentKey.php");
    final LocalStorage storage = new LocalStorage('Star');
    var response = await http.post(url, body: {
      'PaymentKey': paymentkeyController.text,
      'secret': secretController.text,
      'email': storage.getItem("email"),
    });
    print("ERROR : " + response.body);
    print(response.statusCode);
    print(response.body);
    print("${response.statusCode}");
    print("${response.body}");

    var dataRecieved = jsonDecode(response.body);
    if (response.body.toString().contains("PaymentKey Updated")) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            title: new Text(
              "Update Successful",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StarHomepage(3)));
                },
              ),
            ],
          );
        },
      );
    } else if (response.body
        .toString()
        .contains("Failed To update PaymentKey")) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            title: new Text(
              "Update Failed",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
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
    }
    return dataRecieved;
  }

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Update", color: Color.fromRGBO(254, 118, 7, 10)),
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

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 2), () async {
          UpdatePaymentKey();
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

  _launchURL() async {
    String url =
        "https://developer.paypal.com/developer/applications/edit/SB:QWUzdTVXSXl5U1hGS2Q2SWhQLXhkeGM5cHQ1b2lmZ2puckVjOVpDeTkwZnk1cDBPZnpzdUIxTUViNDhwZXZnNGwyV0J1SUMyZ3JkcHdfVG8=?appname=StarApp";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 200, left: 20, right: 20),
            child: Container(
              height: 70.0,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: paymentkeyController,
                decoration: InputDecoration(
                    labelText: "   Client Id",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
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
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Container(
              height: 70.0,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: secretController,
                decoration: InputDecoration(
                    labelText: "   Secret Key",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                    onTap: () {
                      _launchURL();
                    },
                    child: Icon(Icons.help)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: Container(
                height: 48,
                child: buildTextWithIconWithMinState(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
