import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:url_launcher/url_launcher.dart';

class UserJoinEventDetails extends StatefulWidget {
  String topic;
  String duration;
  String password;
  String email;
  String startdate;

  String link;
  String starname;
  String image;
  String description;

  UserJoinEventDetails({
    required this.topic,
    required this.duration,
    required this.password,
    required this.email,
    required this.startdate,
    required this.link,
    required this.starname,
    required this.image,
    required this.description,
  });
  @override
  _UserJoinEventDetailsState createState() => _UserJoinEventDetailsState(
        topic,
        duration,
        password,
        email,
        startdate,
        link,
        starname,
        image,
        description,
      );
}

class _UserJoinEventDetailsState extends State<UserJoinEventDetails> {
  String topic;
  String duration;
  String password;
  String email;
  String startdate;

  String link;
  String starname;
  String image;
  String description;

  _UserJoinEventDetailsState(
    this.topic,
    this.duration,
    this.password,
    this.email,
    this.startdate,
    this.link,
    this.starname,
    this.image,
    this.description,
  );
  bool visible = false;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState cancelsession = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;
  _launchURL() async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future UpdateCancelSession() async {
  //   var url = Uri.parse(
  //       "https://starappeprodix.000webhostapp.com/starapp/Cancelsession.php");
  //   final LocalStorage storage = new LocalStorage('Star');
  //   var response = await http.post(url, body: {
  //     'status': "Cancelled",
  //     'email': email,
  //     'event_id': eventId,
  //   });
  //   print("ERROR : " + response.body);
  //   print(response.statusCode);
  //   print(response.body);
  //   print("${response.statusCode}");
  //   print("${response.body}");
  //
  //   var dataRecieved = jsonDecode(response.body);
  //   if (response.body.toString().contains("Session Cancelled")) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(25),
  //           ),
  //           elevation: 2,
  //           title: new Text(
  //             "Cancel Successful",
  //             style: TextStyle(
  //                 fontSize: 15,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: new Text("OK"),
  //               onPressed: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => StarHomepage(0)));
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else if (response.body.toString().contains("Failed To Cancel")) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(25),
  //           ),
  //           elevation: 2,
  //           title: new Text(
  //             "Cancel Failed",
  //             style: TextStyle(
  //                 fontSize: 15,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: new Text("OK"),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  //   return dataRecieved;
  // }

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

  Widget CancelSession() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Cancel Session", color: Color.fromRGBO(254, 118, 7, 10)),
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
      onPressed: onPressedCancelSession,
      state: cancelsession,
      minWidthStates: [ButtonState.loading, ButtonState.loading],
    );
  }

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle:
            IconedButton(text: "Join", color: Color.fromRGBO(254, 118, 7, 10)),
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

  void onPressedCancelSession() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        cancelsession = ButtonState.loading;
        Future.delayed(Duration(seconds: 2), () async {
          // _launchURL();
          // UpdateCancelSession();
          setState(() {
            cancelsession = Random.secure().nextBool()
                ? ButtonState.loading
                : ButtonState.loading;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        cancelsession = ButtonState.idle;
        break;
      case ButtonState.fail:
        cancelsession = ButtonState.idle;
        break;
    }
    setState(() {
      cancelsession = cancelsession;
    });
  }

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 2), () async {
          _launchURL();
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
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        leadingWidth: 30,
        title: Text(
          starname,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(physics: BouncingScrollPhysics(), children: [
        Column(
          children: [
            Image(image: NetworkImage(image)),
            Padding(
              padding: const EdgeInsets.only(top: 100, right: 230),
              child: Center(child: Text("Event Topic:")),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 275),
                child: Center(
                  child: Text(
                    topic,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 250),
              child: Center(child: Text("Duration:")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 290),
              child: Center(
                  child: Text(
                duration,
                style: TextStyle(color: Colors.blueAccent),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 240),
              child: Center(child: Text("Start Date:")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 240),
              child: Center(
                  child: Text(
                startdate,
                style: TextStyle(color: Colors.blueAccent),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 240),
              child: Center(child: Text("Password:")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 280),
              child: Center(
                  child: Text(
                password,
                style: TextStyle(color: Colors.blueAccent),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 280),
              child: Center(child: Text("Link:")),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 40,
              ),
              child: Center(
                  child: Text(
                link,
                style: TextStyle(color: Colors.blueAccent),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 240),
              child: Center(child: Text("Description:")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 180),
              child: Center(
                  child: Text(
                description,
                style: TextStyle(color: Colors.blueAccent),
              )),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 40),
                  child: Center(
                    child: Container(
                      height: 45,
                      child: buildTextWithIconWithMinState(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
