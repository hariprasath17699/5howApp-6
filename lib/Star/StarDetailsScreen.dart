import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:star_event/HomeScreen/Calender.dart';
import 'package:star_event/Responsive/Response.dart';
import 'package:star_event/Responsive/StarImagePage.dart';
import 'package:star_event/Responsive/Zoom/UserJoinEvent.dart';

class StarsDetails extends StatefulWidget {
  String Name;
  String Interest;
  String Image1;
  String email;
  String status;
  String fullname;
  String dob;
  String country;
  StarsDetails(
      {required this.Name,
      required this.Interest,
      required this.Image1,
      required this.email,
      required this.fullname,
      required this.country,
      required this.status,
      required this.dob});

  @override
  _StarsDetailsState createState() => _StarsDetailsState(
      Name, Interest, Image1, email, fullname, country, status, dob);
}

class _StarsDetailsState extends State<StarsDetails> {
  String name;
  String interest;
  String image1;
  String email;
  String fullname;
  String country;
  String status;
  String dob;
  bool visible = false;
  final LocalStorage storage = new LocalStorage('Star');
  _StarsDetailsState(this.name, this.interest, this.image1, this.email,
      this.fullname, this.country, this.status, this.dob);
  Future favourite() async {
    var url =
        Uri.parse("http://5howapp.com/StarLoginAndRegister/Favourite.php");

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
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: Container(
                      height: 190,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(
                            color: Colors.red,
                            style: BorderStyle.none,
                            width: 500.0,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 10.0,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(image1),
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
                            height: 220, width: 180, child: CalendarApp())),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: Container(
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
                        interest.substring(1, 11),
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
                        interest.substring(1, 11),
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
                        interest.substring(1, 11),
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
