import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:star_event/User/HomePage/Homepage.dart';

import '../NonInterestWidget.dart';

class EventBookingDetails extends StatefulWidget {
  String image;
  String name;
  String Event;
  String EventDate;
  String duration;
  String password;
  String email;
  String link;
  String starttime;
  String price;
  String participanttype;
  int participantcount;
  String profileimage;
  String description;
  String eventId;
  String status;
  String starname;
  int totalparticipantcount;
  String interest;
  String startday;
  String startmonth;
  String startyear;
  EventBookingDetails(
      {required this.image,
      required this.name,
      required this.Event,
      required this.EventDate,
      required this.duration,
      required this.password,
      required this.email,
      required this.link,
      required this.starttime,
      required this.price,
      required this.participanttype,
      required this.participantcount,
      required this.profileimage,
      required this.description,
      required this.eventId,
      required this.status,
      required this.starname,
      required this.totalparticipantcount,
      required this.interest,
      required this.startday,
      required this.startmonth,
      required this.startyear});
  @override
  _EventBookingDetailsState createState() => _EventBookingDetailsState(
      image,
      name,
      Event,
      EventDate,
      duration,
      password,
      email,
      link,
      starttime,
      price,
      participantcount,
      participanttype,
      profileimage,
      description,
      eventId,
      status,
      starname,
      totalparticipantcount,
      interest,
      startday,
      startmonth,
      startyear);
}

class _EventBookingDetailsState extends State<EventBookingDetails> {
  String image;
  String name;
  String event;
  String eventDate;
  String duration;
  String password;

  String email;
  String link;
  String starttime;
  String price;
  int participantcount;
  String participanttype;
  String profileimage;
  String description;
  String eventId;
  String status;
  String starname;
  int totalparticipantcount;
  String interest;
  String startday;
  String startmonth;
  String startyear;
  _EventBookingDetailsState(
      this.image,
      this.name,
      this.event,
      this.eventDate,
      this.duration,
      this.password,
      this.email,
      this.link,
      this.starttime,
      this.price,
      this.participantcount,
      this.participanttype,
      this.profileimage,
      this.description,
      this.eventId,
      this.status,
      this.starname,
      this.totalparticipantcount,
      this.interest,
      this.startday,
      this.startmonth,
      this.startyear);
  Widget Interest(String interest1) {
    if (interest1.length < 4) {
      return NonInterestWidget();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 132, left: 5),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 10),
              ),
              child: Stack(
                children: [
                  Container(
                    child: Container(
                      height: 13,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 3),
                    child: Container(
                      child: Text(
                        interest1.substring(1, 5).toString(),
                        style: TextStyle(
                          fontFamily: 'Poppinsregular',
                          fontSize: 6,
                          color: const Color(0xff000000),
                          height: 2.1666666666666665,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 244, 244, 10),
                ),
                child: Stack(
                  children: [
                    Container(
                      child: Container(
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21.5),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 3),
                      child: Container(
                        child: Text(
                          interest1.substring(1, 5).toString(),
                          style: TextStyle(
                            fontFamily: 'Poppinsregular',
                            fontSize: 6,
                            color: const Color(0xff000000),
                            height: 2.1666666666666665,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 244, 244, 10),
                ),
                child: Stack(
                  children: [
                    Container(
                      child: Container(
                        height: 13,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21.5),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 3),
                      child: Container(
                        child: Text(
                          interest1.substring(1, 5).toString(),
                          style: TextStyle(
                            fontFamily: 'Poppinsregular',
                            fontSize: 6,
                            color: const Color(0xff000000),
                            height: 2.1666666666666665,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future Updatebookingscount() async {
    var url = Uri.parse(
        "http://5howapp.com/StarLoginAndRegister/Bookingcountupdate.php");
    final LocalStorage storage = new LocalStorage('Star');
    var response = await http.post(url, body: {
      'participantcount': (participantcount + 1).toString(),
      'email': email,
      'event_id': eventId,
    });
    print("ERROR : " + response.body);
    print(response.statusCode);
    print(response.body);
    print("${response.statusCode}");
    print("${response.body}");

    var dataRecieved = jsonDecode(response.body);
    return dataRecieved;
  }

  Future bookings() async {
    var url = Uri.parse("http://5howapp.com/StarLoginAndRegister/Bookings.php");
    final LocalStorage storage = new LocalStorage('Star');
    var response = await http.post(url, body: {
      'useremail': storage.getItem("email"),
      'topic': event,
      'email': email,
      'startdate': eventDate,
      'duration': duration,
      'password': password,
      'link': link,
      'starname': name,
      'image': image,
      'starttime': starttime,
      'price': price,
      'participanttype': participanttype,
      'participantcount': participantcount.toString(),
      'profileimage': profileimage,
      'description': description,
      'event_id': eventId,
      'status': status,
      'startday': startday,
      'startmonth': startmonth,
      'startyear': startyear
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
              "Booking Successful",
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
                      MaterialPageRoute(builder: (context) => Homepage(0)));
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
              "Booking Failed",
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
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: ListView(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    starname.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppinsbold'),
                                  ),
                                ),
                              ),
                              Interest(interest),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 50),
                                    child: Text(
                                      event.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppinsbold'),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: Text(
                                      description,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppinslight'),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Color(0xfffE9E9E9),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 0,
                                        ),
                                        child: Text(
                                          "Duration",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppinslight'),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, right: 0),
                                          child: Text(
                                            duration,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Poppinslight'),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, right: 0),
                                          child: Text(
                                            " min",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Poppinslight'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Text(
                                    eventDate.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: 'Poppinsbold'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: FlatButton(
                                  onPressed: () {
                                    // bookings();
                                    // Updatebookingscount();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UsePaypal(
                                                sandboxMode: true,
                                                clientId:
                                                    "Ae3u5WIyySXFKd6IhP-xdxc9pt5oifgjnrEc9ZCy90fy5p0OfzsuB1MEb48pevg4l2WBuIC2grdpw_To",
                                                secretKey:
                                                    "EArvq6RKaV_zGBdpQJBAojLBhR5KoxdBQPkCZ4dbGghNKIXym4SHzHEaOFwBsd0qCSK617Ju-pAxOldi",
                                                returnURL:
                                                    "https://samplesite.com/return",
                                                cancelURL:
                                                    "https://samplesite.com/cancel",
                                                transactions: [
                                                  {
                                                    "amount": {
                                                      "total": price,
                                                      "currency": "USD",
                                                      "details": {
                                                        "subtotal": price,
                                                        "shipping": '0',
                                                        "shipping_discount": 0
                                                      }
                                                    },
                                                    "description":
                                                        "The payment transaction description.",
                                                    // "payment_options": {
                                                    //   "allowed_payment_method":
                                                    //       "INSTANT_FUNDING_SOURCE"
                                                    // },
                                                    "item_list": {
                                                      "items": [
                                                        {
                                                          "name":
                                                              "A demo product",
                                                          "quantity": 1,
                                                          "price": price,
                                                          "currency": "USD"
                                                        }
                                                      ],

                                                      // shipping address is not required though
                                                      "shipping_address": {
                                                        "recipient_name":
                                                            "Jane Foster",
                                                        "line1":
                                                            "Travis County",
                                                        "line2": "",
                                                        "city": "Austin",
                                                        "country_code": "US",
                                                        "postal_code": "73301",
                                                        "phone": "+00000000",
                                                        "state": "Texas"
                                                      },
                                                    }
                                                  }
                                                ],
                                                note:
                                                    "Contact us for any questions on your order.",
                                                onSuccess: (Map params) async {
                                                  bookings();
                                                  Updatebookingscount();
                                                  print("onSuccess: $params");
                                                },
                                                onError: (error) {
                                                  print("onError: $error");
                                                },
                                                onCancel: (params) {
                                                  print('cancelled: $params');
                                                }),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 250,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/buy.png'),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 70),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                "${totalparticipantcount - participantcount} Seat Left",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'Poppinssemibold'),
                                              ),
                                              Text(
                                                "${price} USD",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontFamily: 'Poppinsbold'),
                                              ),
                                              Text(
                                                "Book Event",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'Poppinssemibold'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
