import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:star_event/HomeScreen/Calender.dart';
import 'package:star_event/Responsive/Response.dart';
import 'package:star_event/Responsive/StarImagePage.dart';
import 'package:star_event/Responsive/Zoom/UserJoinEvent.dart';

final LocalStorage storage = new LocalStorage('Star');

Future<Username> fetchAlbum(String email) async {
  final url =
      ('https://starappeprodix.000webhostapp.com/starapp/Zoom/Zoom/StarEvents.php');
  Dio dio = new Dio();
  var fields = {
    'email': email,
  };
  FormData formData = new FormData.fromMap(fields);
  var resp;

  var response = await dio.post(url, data: formData);
  if (response.statusCode == 200) {
    print("Response:::::::::::$response");
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
    required this.event_id,
    required this.topic,
    required this.startdate,
    required this.duration,
    required this.password,
    required this.type,
    required this.email,
    required this.link,
    required this.starname,
    required this.image,
  });

  String event_id;
  String topic;
  DateTime startdate;
  String duration;
  String password;
  String type;
  String email;
  String link;
  String starname;
  String image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        event_id: json["event_id"],
        topic: json["topic"],
        password: json["password"],
        duration: json["duration"],
        type: json["type"],
        email: json["email"],
        link: json["link"],
        starname: json["starname"],
        image: json["image"],
        startdate: json["startdate"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": event_id,
        "topic": topic,
        "password": password,
        "duration": duration,
        "type": type,
        "email": email,
        "link": link,
        "starname": starname,
        "image": image,
        "startdate": startdate,
      };
}

class StarsDetailsPage extends StatefulWidget {
  String Name;
  String Interest;
  String Image1;
  String email;
  String status;
  String fullname;
  String dob;
  String country;
  StarsDetailsPage(
      {required this.Name,
      required this.Interest,
      required this.Image1,
      required this.email,
      required this.fullname,
      required this.country,
      required this.status,
      required this.dob});

  @override
  _StarsDetailsPageState createState() => _StarsDetailsPageState(
      Name, Interest, Image1, email, fullname, country, status, dob);
}

class _StarsDetailsPageState extends State<StarsDetailsPage> {
  String name;
  String interest;
  String image1;
  String email;
  String fullname;
  String country;
  String status;
  String dob;
  bool visible = false;
  _StarsDetailsPageState(this.name, this.interest, this.image1, this.email,
      this.fullname, this.country, this.status, this.dob);

  late Future<Username> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(email);
  }

  Future favourite() async {
    var url = Uri.parse(
        "https://starappeprodix.000webhostapp.com/starapp/Favourite.php");

    var response = await http.post(url, body: {
      'fullname': fullname,
      'username': name,
      'email': email,
      'dob': dob,
      'interest': interest,
      'country': country,
      'image': image1,
      'Status': status,
      'email1': storage.getItem("email"),
    });
    print("ERROR : " + response.body);
    print(response.statusCode);
    print(response.body);
    print("${response.statusCode}");
    print("${response.body}");
    var dataRecieved = jsonDecode(response.body);
    if (response.body.toString().contains("true")) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            title: new Text(
              "Favourite Added Successful",
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
    } else if (response.body.toString().contains("false")) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            title: new Text(
              "Favourite Removed Successful",
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
    // Showing Alert Dialog with Response JSON.
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    var readLines = ['Test1', 'Test2', 'Test3'];
    String getNewLineString() {
      StringBuffer sb = new StringBuffer();
      for (String line in readLines) {
        sb.write(line + "\n");
      }
      return sb.toString();
    }

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
              padding: EdgeInsets.only(left: 10, right: 130),
              child: Center(
                child: Text(
                  name,
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
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: FlatButton(
                onPressed: () {
                  favourite();
                },
                child: SvgPicture.asset(
                  "assets/images/Heart.svg",
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth / 20,
                        top: SizeConfig.screenHeight / 50),
                    child: Container(
                      height: 190,
                      width: 160,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(image1),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                      left: 20,
                      top: 10,
                    ),
                    child: Center(
                        child: Container(
                            height: SizeConfig.screenHeight / 4,
                            width: SizeConfig.screenWidth / 2.2,
                            child: CalendarApp())),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: Container(
                      width: SizeConfig.screenWidth / 1.1,
                      child: SvgPicture.asset(
                        "assets/images/upcoming.svg",
                        height: 70,
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth / 20,
                      right: SizeConfig.screenWidth / 2,
                      top: SizeConfig.screenHeight / 23),
                  child: Center(
                    child: Text(
                      name,
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
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth / 10,
                      top: SizeConfig.screenHeight / 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        interest.trim().substring(1, 5),
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    height: 25,
                    width: 80,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth / 25,
                      top: SizeConfig.screenHeight / 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        interest.trim().substring(6, 11),
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    height: 25,
                    width: 80,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth / 25,
                      top: SizeConfig.screenHeight / 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        interest.trim().substring(6, 11),
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    height: 25,
                    width: 80,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth / 45),
                  child: Container(
                    height: 60,
                    width: 450,
                    padding: EdgeInsets.only(left: 10, right: 20, top: 10),
                    child: Center(
                      child: Text(
                        "John Christopher Depp II is an American actor,John Christopher Depp II is an American actor,John Christopher Depp II is an American actor, ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.normal,
                          height: 1.0714285714285714,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: true),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Container(
                  height: 70,
                  width: 30,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserEventJoinScreen(
                                  image: image1,
                                  email: email,
                                  name: name,
                                  Interest: interest)));
                    },
                    child: SvgPicture.asset(
                      "assets/images/Stock.svg",
                      allowDrawingOutsideViewBox: true,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Container(
                  height: 70,
                  width: 30,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StarImagesPage(image1, name, email)));
                    },
                    child: SvgPicture.asset(
                      "assets/images/Stock.svg",
                      allowDrawingOutsideViewBox: true,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
