import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:star_event/StarHomePage/StarHome.dart';

class StarPaypalPlugin extends StatefulWidget {
  final String price;
  final int participantcount;
  final String email;
  final String eventId;
  final String event;
  final String eventDate;
  final String duration;
  final String password;
  final String link;
  final String name;
  final String image;
  final String starttime;
  final String participanttype;
  final String profileimage;
  final String description;
  final String status;
  const StarPaypalPlugin(
      {required this.price,
      required this.participantcount,
      required this.email,
      required this.eventId,
      required this.event,
      required this.eventDate,
      required this.duration,
      required this.password,
      required this.link,
      required this.name,
      required this.image,
      required this.starttime,
      required this.participanttype,
      required this.profileimage,
      required this.description,
      required this.status});

  @override
  State<StarPaypalPlugin> createState() => _StarPaypalPluginState(
      price,
      participantcount,
      email,
      eventId,
      event,
      eventDate,
      duration,
      password,
      link,
      name,
      image,
      starttime,
      participanttype,
      profileimage,
      description,
      status);
}

class _StarPaypalPluginState extends State<StarPaypalPlugin> {
  String price;
  int participantcount;
  String email;
  String eventId;
  String event;
  String eventDate;
  String duration;
  String password;
  String link;
  String name;
  String image;
  String starttime;
  String participanttype;
  String profileimage;
  String description;
  String status;
  _StarPaypalPluginState(
    this.price,
    this.participantcount,
    this.email,
    this.eventId,
    this.event,
    this.eventDate,
    this.duration,
    this.password,
    this.link,
    this.name,
    this.image,
    this.starttime,
    this.participanttype,
    this.profileimage,
    this.description,
    this.status,
  );
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
      'status': status
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
                      MaterialPageRoute(builder: (context) => StarHomepage(0)));
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
        body: Center(
      child: TextButton(
          onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                            "Ae3u5WIyySXFKd6IhP-xdxc9pt5oifgjnrEc9ZCy90fy5p0OfzsuB1MEb48pevg4l2WBuIC2grdpw_To",
                        secretKey:
                            "EArvq6RKaV_zGBdpQJBAojLBhR5KoxdBQPkCZ4dbGghNKIXym4SHzHEaOFwBsd0qCSK617Ju-pAxOldi",
                        returnURL: "https://samplesite.com/return",
                        cancelURL: "https://samplesite.com/cancel",
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
                                  "name": "A demo product",
                                  "quantity": 1,
                                  "price": price,
                                  "currency": "USD"
                                }
                              ],

                              // shipping address is not required though
                              "shipping_address": {
                                "recipient_name": "Jane Foster",
                                "line1": "Travis County",
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
                        note: "Contact us for any questions on your order.",
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
                )
              },
          child: const Text("Make Payment")),
    ));
  }
}
