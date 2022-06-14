import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/StarHomePage/StarHome.dart';
import 'package:url_launcher/url_launcher.dart';

class StarJoinEventDetails extends StatefulWidget {
  String topic;
  String duration;
  String password;
  String email;
  String startdate;

  String link;
  String starname;
  String image;
  String description;
  String eventId;
  int totalparticipantcount;
  StarJoinEventDetails(
      {required this.topic,
      required this.duration,
      required this.password,
      required this.email,
      required this.startdate,
      required this.link,
      required this.starname,
      required this.image,
      required this.description,
      required this.eventId,
      required this.totalparticipantcount});
  @override
  _StarJoinEventDetailsState createState() => _StarJoinEventDetailsState(
      topic,
      duration,
      password,
      email,
      startdate,
      link,
      starname,
      image,
      description,
      eventId,
      totalparticipantcount);
}

class _StarJoinEventDetailsState extends State<StarJoinEventDetails> {
  String topic;
  String duration;
  String password;
  String email;
  String startdate;

  String link;
  String starname;
  String image;
  String description;
  String eventId;
  int totalparticipantcount;
  _StarJoinEventDetailsState(
      this.topic,
      this.duration,
      this.password,
      this.email,
      this.startdate,
      this.link,
      this.starname,
      this.image,
      this.description,
      this.eventId,
      this.totalparticipantcount);
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

  @override
  void initState() {
    super.initState();
  }

  void sendEmail() async {
    var url = Uri.parse(
        "http://5howapp.com/StarLoginAndRegister/BookingCancelEmailNotification.php");

    var response = await http.post(url, body: {
      'event_id': eventId,
    });
    var dataRecieved = jsonDecode(response.body);
    for (int i = 0; i < dataRecieved.length; i++) {
      String username = 'skhmusicals@gmail.com';
      String password = 'hari.k17699';
      final smtpServer = gmail(username, password);
      final message = Message()
        ..from = Address(username, 'Eprodix')
        ..recipients.add(dataRecieved[i]['useremail'])
        ..subject = 'Session Cancelled at: ${DateTime.now()}'
        ..text =
            'Your booked session has been cancelled your money will be refunded soon';
      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }

      var connection = PersistentConnection(smtpServer);
      await connection.send(message);
      await connection.close();
    }
  }

  Future UpdateCancelSessionforuser() async {
    var url = Uri.parse(
        "http://5howapp.com/StarLoginAndRegister/EventCancelupdateforuser.php");
    final LocalStorage storage = new LocalStorage('Star');
    var response = await http.post(url, body: {
      'status': "Cancelled",
      'event_id': eventId,
    });
    print("ERROR : " + response.body);
    print(response.statusCode);
    print(response.body);
    print("${response.statusCode}");
    print("${response.body}");
  }

  Future UpdateCancelSession() async {
    var url =
        Uri.parse("http://5howapp.com/StarLoginAndRegister/Cancelsession.php");
    final LocalStorage storage = new LocalStorage('Star');
    var response = await http.post(url, body: {
      'status': "Cancelled",
      'email': email,
      'event_id': eventId,
    });
    print("ERROR : " + response.body);
    print(response.statusCode);
    print(response.body);
    print("${response.statusCode}");
    print("${response.body}");

    var dataRecieved = jsonDecode(response.body);
    if (response.body.toString().contains("Session Cancelled")) {
      sendEmail();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            title: new Text(
              "Cancel Successful",
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
                      MaterialPageRoute(builder: (context) => StarHomepage(0)));
                },
              ),
            ],
          );
        },
      );
    } else if (response.body.toString().contains("Failed To Cancel")) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            title: new Text(
              "Cancel Failed",
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
        ButtonState.fail:
            IconedButton(text: "Failed", color: Colors.red.shade300),
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
        ButtonState.idle: IconedButton(
            text: "Join Session", color: Color.fromRGBO(254, 118, 7, 10)),
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 2,
                title: new Text(
                  "Are you sure want to cancel session?",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      FlatButton(
                        child: new Text("yes"),
                        onPressed: () {
                          UpdateCancelSession();
                          UpdateCancelSessionforuser();
                          setState(() {
                            cancelsession = Random.secure().nextBool()
                                ? ButtonState.loading
                                : ButtonState.loading;
                          });
                        },
                      ),
                      FlatButton(
                        child: new Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            cancelsession = Random.secure().nextBool()
                                ? ButtonState.loading
                                : ButtonState.fail;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 255,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, -20),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 250, left: 30),
                          child: Text(topic.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 22, fontFamily: 'Poppinsbold')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 30),
                          child: Text("Duration",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Poppinssemibold',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text("${duration}Mins",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppinslight',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text("Password",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Poppinssemibold',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text(password,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppinslight',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text("Start Date",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Poppinssemibold',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text(startdate,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppinslight',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text("Total Participants",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Poppinssemibold',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text(
                              "${totalparticipantcount.toString()} Members",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppinslight',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text("Zoom Link",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Poppinssemibold',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7, left: 30),
                          child: Text(link.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppinslight',
                              )),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                                height: 50,
                                width: 180,
                                child: buildTextWithIconWithMinState()),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                height: 50, width: 180, child: CancelSession()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_h35zdt =
    '<svg viewBox="0.0 373.0 390.0 152.0" ><path transform="translate(0.0, 373.0)" d="M 56 0 L 330 0 C 363.1370849609375 0 390 26.8629150390625 390 60 L 390 152 L 0 152 L 0 56 C 0 25.07205200195312 25.07205200195312 0 56 0 Z" fill="#ffffff" stroke="none" stroke-width="5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
