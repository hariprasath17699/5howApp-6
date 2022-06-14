import 'dart:async';
import 'dart:convert';

import 'package:adobe_xd/pinned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:star_event/HomeScreen/Json/Starmodel.dart';
import 'package:star_event/ProfileScreen/utils/user_preferences.dart';

import 'StarJoinEventDetailsScreen.dart';

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

  var response = await dio.post(
    url,
    data: formData,
  );
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
  Data(
      {required this.userId,
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
      required this.Logintype});

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
  String Logintype;

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
        Logintype: json["Logintype"],
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
        "Logintype": Logintype
      };
}

class StarEventJoinScreen extends StatefulWidget {
  StarEventJoinScreen();
  @override
  _StarEventJoinScreenState createState() => _StarEventJoinScreenState();
}

class _StarEventJoinScreenState extends State<StarEventJoinScreen> {
  _StarEventJoinScreenState();

  late List result;
  late List selectedSeater, selectedType;
  bool loading = true;
  late ScrollController controller;
  var sliderImageHieght = 0.0;
  late Future<StarModel> star;

  Future<List> getData() async {
    final LocalStorage storage = new LocalStorage('Star');
    var client = http.Client();

    var url = Uri.parse(
        "http://5howapp.com/StarLoginAndRegister/Zoom/Zoom/StarEvents.php");
    var response = await client.post(url, headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    }, body: {
      "email": storage.getItem("email"),
    });
    print(response.body);
    print(response.statusCode);
    var dataRecieved = json.decode(response.body.toString());
    print(response);
    print("dataRecieved:${dataRecieved}");

    return dataRecieved;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            return snapshot.hasData
                ? new StarEventJoin(
                    list: snapshot.data!,
                  )
                : new Center(
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: LiquidCircularProgressIndicator(
                          value: 0.40, // Defaults to 0.5.
                          valueColor: AlwaysStoppedAnimation(Colors
                              .lightBlueAccent), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .white, // Defaults to the current Theme's backgroundColor.
                          borderColor: Colors.black,
                          borderWidth: 1.0,
                          direction: Axis
                              .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}

class StarEventJoin extends StatefulWidget {
  final List<dynamic> list;
  const StarEventJoin({Key? key, required this.list}) : super(key: key);

  @override
  _StarEventJoinState createState() => _StarEventJoinState(list);
}

class _StarEventJoinState extends State<StarEventJoin> {
  late Future<Username> futureAlbum;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final DateOfBirth = TextEditingController();
  final Password = TextEditingController();
  final LocalStorage storage = new LocalStorage('Star');
  List<dynamic> list;
  _StarEventJoinState(this.list);

  final user = UserPreferences.myUser;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Username>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              storage.setItem("Type", snapshot.data?.data.Logintype);
              return Stack(
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 0,
                                      mainAxisExtent:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                      mainAxisSpacing: 15,
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              3),
                                    ),
                                    itemCount: list == null ? 0 : list.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: <Widget>[
                                          Pinned.fromPins(
                                            Pin(size: 167.5, start: 23.7),
                                            Pin(size: 225.5, middle: 0.3533),
                                            child: Stack(
                                              children: <Widget>[
                                                Pinned.fromPins(
                                                  Pin(start: 0.0, end: 0.0),
                                                  Pin(start: 0.0, end: 0.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      color: Colors.grey[350],
                                                    ),
                                                  ),
                                                ),
                                                Pinned.fromPins(
                                                  Pin(start: 0.0, end: 0.0),
                                                  Pin(size: 98.9, start: 0.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Pinned.fromPins(
                                                        Pin(
                                                            start: 1.5,
                                                            end: 0.0),
                                                        Pin(
                                                            start: 0.0,
                                                            end: 10.0),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Pinned.fromPins(
                                                              Pin(
                                                                  start: -1.7,
                                                                  end: 0.5),
                                                              Pin(
                                                                  start: -3.5,
                                                                  end: -3.7),
                                                              child:
                                                                  // Adobe XD layer: 'jo' (shape)
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            4.5,
                                                                        left:
                                                                            0.5),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              12.5),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              12.5),
                                                                      bottomLeft:
                                                                          Radius
                                                                              .zero,
                                                                      bottomRight:
                                                                          Radius
                                                                              .zero,
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          CachedNetworkImageProvider(
                                                                        list[index]
                                                                            [
                                                                            'image'],
                                                                      ),
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Pinned.fromPins(
                                                              Pin(
                                                                  start: 0.0,
                                                                  end: 0.0),
                                                              Pin(
                                                                  start: 0.0,
                                                                  end: 0.0),
                                                              child: SvgPicture
                                                                  .string(
                                                                _svg_xkil9e,
                                                                allowDrawingOutsideViewBox:
                                                                    true,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Pinned.fromPins(
                                                  Pin(size: 70.0, start: 8.2),
                                                  Pin(
                                                      size: 16.0,
                                                      middle: 0.5051),
                                                  child: Text(
                                                    list[index]['topic'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Poppins-SemiBold',
                                                      fontSize: 8,
                                                      color: const Color(
                                                          0xff000000),
                                                      height: 1,
                                                    ),
                                                    textHeightBehavior:
                                                        TextHeightBehavior(
                                                            applyHeightToFirstAscent:
                                                                false),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 40),
                                                  child: Pinned.fromPins(
                                                    Pin(size: 70.0, start: 8.2),
                                                    Pin(
                                                        size: 16.0,
                                                        middle: 0.5051),
                                                    child: Text(
                                                      "Duration:",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Poppins-SemiBold',
                                                        fontSize: 8,
                                                        color: const Color(
                                                            0xff000000),
                                                        height: 1,
                                                      ),
                                                      textHeightBehavior:
                                                          TextHeightBehavior(
                                                              applyHeightToFirstAscent:
                                                                  false),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40, top: 40),
                                                  child: Pinned.fromPins(
                                                    Pin(size: 70.0, start: 8.2),
                                                    Pin(
                                                        size: 16.0,
                                                        middle: 0.5051),
                                                    child: Text(
                                                      list[index]['duration'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Poppins-SemiBold',
                                                        fontSize: 8,
                                                        color: const Color(
                                                            0xff000000),
                                                        height: 1,
                                                      ),
                                                      textHeightBehavior:
                                                          TextHeightBehavior(
                                                              applyHeightToFirstAscent:
                                                                  false),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 80),
                                                  child: Pinned.fromPins(
                                                    Pin(size: 70.0, start: 8.2),
                                                    Pin(
                                                        size: 16.0,
                                                        middle: 0.5051),
                                                    child: Text(
                                                      "StarName::",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Poppins-SemiBold',
                                                        fontSize: 8,
                                                        color: const Color(
                                                            0xff000000),
                                                        height: 1,
                                                      ),
                                                      textHeightBehavior:
                                                          TextHeightBehavior(
                                                              applyHeightToFirstAscent:
                                                                  false),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 45, top: 80),
                                                  child: Pinned.fromPins(
                                                    Pin(size: 70.0, start: 8.2),
                                                    Pin(
                                                        size: 16.0,
                                                        middle: 0.5051),
                                                    child: Text(
                                                      list[index]['starname'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Poppins-SemiBold',
                                                        fontSize: 8,
                                                        color: const Color(
                                                            0xff000000),
                                                        height: 1,
                                                      ),
                                                      textHeightBehavior:
                                                          TextHeightBehavior(
                                                              applyHeightToFirstAscent:
                                                                  false),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),

                                                Pinned.fromPins(
                                                  Pin(size: 86.3, start: 8.0),
                                                  Pin(size: 12.6, end: 11.7),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              21.5),
                                                      color: const Color(
                                                          0xff3db761),
                                                    ),
                                                  ),
                                                ),
                                                Pinned.fromPins(
                                                  Pin(size: 64.0, start: 15.6),
                                                  Pin(size: 8.0, end: 14.3),
                                                  child: Text(
                                                    list[index]['startdate'],
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 6,
                                                      color: const Color(
                                                          0xffffffff),
                                                      height:
                                                          2.1666666666666665,
                                                    ),
                                                    textHeightBehavior:
                                                        TextHeightBehavior(
                                                            applyHeightToFirstAscent:
                                                                false),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),

                                                // Pinned.fromPins(
                                                //   Pin(size: 86.0, start: 15.6),
                                                //   Pin(size: 11.0, end: 13.3),
                                                //   child: Text(
                                                //     list[index]['duration'],
                                                //     style: TextStyle(
                                                //       fontFamily: 'Poppins',
                                                //       fontSize: 8,
                                                //       color:
                                                //           const Color(0xffffffff),
                                                //       height: 1.625,
                                                //     ),
                                                //     textHeightBehavior:
                                                //         TextHeightBehavior(
                                                //             applyHeightToFirstAscent:
                                                //                 false),
                                                //     textAlign: TextAlign.left,
                                                //   ),
                                                // ),
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor: Colors.grey,
                                                    onTap: () {
                                                      try {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        StarJoinEventDetails(
                                                                          topic:
                                                                              list[index]['topic'],
                                                                          duration:
                                                                              list[index]['duration'],
                                                                          password:
                                                                              list[index]['password'],
                                                                          email:
                                                                              list[index]['email'],
                                                                          startdate:
                                                                              list[index]['startdate'],
                                                                          link: list[index]
                                                                              [
                                                                              'link'],
                                                                          starname:
                                                                              list[index]['starname'],
                                                                          image:
                                                                              list[index]['image'],
                                                                          description:
                                                                              list[index]['description'],
                                                                          eventId:
                                                                              list[index]['event_id'],
                                                                          totalparticipantcount:
                                                                              int.parse(list[index]['totalparticipantcount']),
                                                                        )));
                                                      } catch (e) {}
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                      throw 'error';
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            // By default, show a loading spinner.
            return Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: Opacity(
                  opacity: 0.6,
                  child: Shimmer.fromColors(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 0,
                                mainAxisExtent:
                                    MediaQuery.of(context).size.height / 3.6,
                                mainAxisSpacing: 15,
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 3),
                              ),
                              itemCount: list == null ? 0 : list.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: <Widget>[
                                    Pinned.fromPins(
                                      Pin(size: 167.5, start: 23.7),
                                      Pin(size: 225.5, middle: 0.3533),
                                      child: Stack(
                                        children: <Widget>[
                                          Pinned.fromPins(
                                            Pin(start: 0.0, end: 0.0),
                                            Pin(start: 0.0, end: 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                color: Colors.grey[350],
                                              ),
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(start: 0.0, end: 0.0),
                                            Pin(size: 98.9, start: 0.0),
                                            child: Stack(
                                              children: <Widget>[
                                                Pinned.fromPins(
                                                  Pin(start: 1.5, end: 0.0),
                                                  Pin(start: 0.0, end: 10.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Pinned.fromPins(
                                                        Pin(
                                                            start: -1.7,
                                                            end: 0.5),
                                                        Pin(
                                                            start: -3.5,
                                                            end: -3.7),
                                                        child:
                                                            // Adobe XD layer: 'jo' (shape)
                                                            Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 4.5,
                                                                  left: 0.5),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12.5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12.5),
                                                                bottomLeft:
                                                                    Radius.zero,
                                                                bottomRight:
                                                                    Radius.zero,
                                                              ),
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    CachedNetworkImageProvider(
                                                                        ""),
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Pinned.fromPins(
                                                        Pin(
                                                            start: 0.0,
                                                            end: 0.0),
                                                        Pin(
                                                            start: 0.0,
                                                            end: 0.0),
                                                        child:
                                                            SvgPicture.string(
                                                          "",
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 70.0, start: 8.2),
                                            Pin(size: 16.0, middle: 0.5051),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-SemiBold',
                                                fontSize: 8,
                                                color: const Color(0xff000000),
                                                height: 1,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 106.0, start: 8.6),
                                            Pin(size: 12.0, middle: 0.5883),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 9,
                                                color: const Color(0xff444444),
                                                height: 1.4444444444444444,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 82.0, start: 8.6),
                                            Pin(size: 12.0, end: 31.8),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 9,
                                                color: const Color(0xff444444),
                                                height: 1.4444444444444444,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 41.0, start: 8.3),
                                            Pin(size: 11.0, middle: 0.7818),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: 8,
                                                color: const Color(0xff000000),
                                                height: 1.625,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 86.3, start: 8.0),
                                            Pin(size: 12.6, end: 11.7),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21.5),
                                                color: const Color(0xff3db761),
                                              ),
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 64.0, start: 15.6),
                                            Pin(size: 8.0, end: 14.3),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 6,
                                                color: const Color(0xffffffff),
                                                height: 2.1666666666666665,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 46.2, start: 7.8),
                                            Pin(size: 12.6, middle: 0.6883),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21.5),
                                                color: const Color(0xffffffff),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: const Color(
                                                        0xffe6e6e6)),
                                              ),
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 46.2, middle: 0.4812),
                                            Pin(size: 12.6, middle: 0.6883),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21.5),
                                                color: const Color(0xffffffff),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: const Color(
                                                        0xffe6e6e6)),
                                              ),
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 46.2, end: 12.9),
                                            Pin(size: 12.6, middle: 0.6883),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21.5),
                                                color: const Color(0xffffffff),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: const Color(
                                                        0xffe6e6e6)),
                                              ),
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 16.0, start: 21.3),
                                            Pin(size: 8.0, middle: 0.6828),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 4,
                                                color: const Color(0xff000000),
                                                height: 2.1666666666666665,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 11.0, middle: 0.4764),
                                            Pin(size: 8.0, middle: 0.6828),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 6,
                                                color: const Color(0xff000000),
                                                height: 2.1666666666666665,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 14.0, middle: 0.7886),
                                            Pin(size: 8.0, middle: 0.6828),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Regular',
                                                fontSize: 6,
                                                color: const Color(0xff000000),
                                                height: 2.1666666666666665,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 106.5, start: 8.0),
                                            Pin(size: 14.6, end: 10.7),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(21.5),
                                                color: const Color(0xff00b141),
                                              ),
                                            ),
                                          ),
                                          Pinned.fromPins(
                                            Pin(size: 86.0, start: 15.6),
                                            Pin(size: 11.0, end: 13.3),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 8,
                                                color: const Color(0xffffffff),
                                                height: 1.625,
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                                throw 'error';
                              }),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                        ),
                      ],
                    ),
                    baseColor: Colors.transparent,
                    highlightColor: Colors.white,
                    loop: 2,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static const String _svg_ap7v5k =
      '<svg viewBox="503.0 541.9 18.7 11.8" ><path transform="translate(-2.54, -6.44)" d="M 507.081298828125 558.5274047851562 L 510.91162109375 558.5274047851562 C 510.91162109375 557.735595703125 510.9072265625 556.9638061523438 510.9129028320312 556.19140625 C 510.9172973632812 555.5084228515625 510.88330078125 554.8204956054688 510.9512939453125 554.1431884765625 C 511.1665649414062 551.9960327148438 512.9127807617188 550.4229736328125 514.9736328125 550.4752197265625 C 517.123291015625 550.5293579101562 518.8240966796875 552.2232666015625 518.8889770507812 554.4295654296875 C 518.927978515625 555.767822265625 518.8958740234375 557.1085205078125 518.8958740234375 558.509765625 L 522.697265625 558.509765625 C 522.7098388671875 558.2459716796875 522.733154296875 557.9791259765625 522.7337646484375 557.7122802734375 C 522.7362670898438 555.0281982421875 522.7349853515625 552.3447265625 522.7362670898438 549.66064453125 C 522.7362670898438 549.4334716796875 522.6651000976562 549.1513671875 522.771484375 548.9903564453125 C 522.9470825195312 548.7252197265625 523.2650146484375 548.34130859375 523.4790649414062 548.3677368164062 C 523.7572631835938 548.4017333984375 524.0833129882812 548.7447509765625 524.2192993164062 549.0350341796875 C 524.346435546875 549.3056640625 524.2551879882812 549.68017578125 524.2551879882812 550.0094604492188 C 524.2557983398438 552.9969482421875 524.2576904296875 555.984375 524.25390625 558.9718017578125 C 524.252685546875 559.8776245117188 524.048095703125 560.0853271484375 523.1347045898438 560.0903930664062 C 521.5900268554688 560.0985107421875 520.0458984375 560.0985107421875 518.5017700195312 560.0903930664062 C 517.5859375 560.0853271484375 517.3838500976562 559.8795166015625 517.3807373046875 558.9737548828125 C 517.3750610351562 557.581298828125 517.3832397460938 556.1889038085938 517.3776245117188 554.7965087890625 C 517.3712768554688 553.1385498046875 516.387451171875 552.014892578125 514.9327392578125 551.994140625 C 513.4572143554688 551.97265625 512.4431762695312 553.112060546875 512.4337158203125 554.8160400390625 C 512.4261474609375 556.2084350585938 512.4381103515625 557.600830078125 512.4293212890625 558.9932861328125 C 512.4242553710938 559.866943359375 512.2183837890625 560.0828857421875 511.3617553710938 560.089111328125 C 509.7918090820312 560.1004638671875 508.221923828125 560.1004638671875 506.6526489257812 560.089111328125 C 505.8041381835938 560.0828857421875 505.5655517578125 559.843017578125 505.5636596679688 559.0020751953125 C 505.557373046875 555.8118286132812 505.56494140625 552.6217041015625 505.5579833984375 549.4321899414062 C 505.5567626953125 548.8744506835938 505.6536865234375 548.3463134765625 506.3121337890625 548.3369140625 C 507.0391845703125 548.326171875 507.0869750976562 548.896484375 507.0850830078125 549.4718627929688 C 507.0762939453125 552.1810913085938 507.081298828125 554.8896484375 507.081298828125 557.5989990234375 C 507.081298828125 557.8759765625 507.081298828125 558.1535034179688 507.081298828125 558.5274047851562 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
  static const String _svg_3xbdtw =
      '<svg viewBox="498.7 530.9 27.3 11.8" ><path  d="M 512.3925170898438 532.635009765625 C 509.4446411132812 534.983642578125 506.5547790527344 537.286865234375 503.6648559570312 539.5894775390625 C 502.5160827636719 540.5047607421875 501.3654174804688 541.4174194335938 500.2191467285156 542.335205078125 C 499.7854309082031 542.6826782226562 499.3101806640625 542.9130859375 498.8903198242188 542.4013061523438 C 498.4553527832031 541.8699951171875 498.8248596191406 541.4803466796875 499.2547912597656 541.1386108398438 C 503.3753356933594 537.8584594726562 507.4989929199219 534.5814208984375 511.6043701171875 531.2828979492188 C 512.15771484375 530.8385620117188 512.58447265625 530.8253173828125 513.1390380859375 531.2710571289062 C 517.2450561523438 534.5693969726562 521.373779296875 537.8402099609375 525.4697265625 541.1505737304688 C 525.74609375 541.3734130859375 525.9902954101562 541.8674926757812 525.9500122070312 542.1992797851562 C 525.87890625 542.7916259765625 525.2380981445312 542.8671264648438 524.6331787109375 542.3880615234375 C 522.5697631835938 540.7520751953125 520.513916015625 539.1060180664062 518.4548950195312 537.46435546875 C 516.4569702148438 535.871826171875 514.457763671875 534.280517578125 512.3925170898438 532.635009765625 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';

  static const String _svg_xkil9e =
      '<svg viewBox="0.0 0.0 167.5 98.9" ><path transform="translate(-10992.93, -1098.49)" d="M 10992.931640625 1197.345947265625 L 10992.931640625 1110.823974609375 C 10992.931640625 1104.041015625 10998.4814453125 1098.490966796875 11005.2646484375 1098.490966796875 L 11148.0556640625 1098.490966796875 C 11154.837890625 1098.490966796875 11160.3876953125 1104.041015625 11160.3876953125 1110.823974609375 L 11160.3876953125 1197.345947265625" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
}
