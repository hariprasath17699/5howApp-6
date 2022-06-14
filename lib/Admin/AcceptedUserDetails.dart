import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:star_event/Admin/AdminHomePage.dart';

import '../Responsive/ProfileWidgetDetailsPage.dart';
import '../Responsive/Response.dart';

class AcceptedUserDetailsPage extends StatefulWidget {
  String Name;
  String Interest;
  String Image;
  String DOB;
  String Proof;
  String email;
  String Phone;
  String Profilelink;
  AcceptedUserDetailsPage(
      {required this.Name,
      required this.Interest,
      required this.Image,
      required this.DOB,
      required this.Proof,
      required this.email,
      required this.Phone,
      required this.Profilelink});

  @override
  _AcceptedUserDetailsPageState createState() => _AcceptedUserDetailsPageState(
      Name, Image, DOB, Proof, email, Phone, Profilelink, Interest);
}

class _AcceptedUserDetailsPageState extends State<AcceptedUserDetailsPage> {
  final LocalStorage storage = new LocalStorage('Star');

  String Name;
  String Image;
  String DOB;
  String Proof;
  String email;
  String Phone;
  String Profilelink;
  String Interest;
  _AcceptedUserDetailsPageState(this.Name, this.Image, this.DOB, this.Proof,
      this.email, this.Phone, this.Profilelink, this.Interest);
  final reason = TextEditingController();
  Future _Accept(String email) async {
    var url = ("http://5howapp.com/StarLoginAndRegister/UserRequestAccept.php");
    Dio dio = new Dio();
    var fields = {
      'starstatus': "Accepted",
      'Logintype': "StarLogin",
      'email': email
    };
    FormData formData = new FormData.fromMap(fields);
    var resp;

    var response = await dio.post(
      url,
      data: formData,
    );

    print(response.statusCode);
    print(response.data);
    var res = response.data;
    if (res.contains("true")) {
      Navigator.push(this.context,
          MaterialPageRoute(builder: (context) => AdminHomepage(1)));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  Future _Decline(String email, TextEditingController reason) async {
    var url =
        ("http://5howapp.com/StarLoginAndRegister/UserRequestDecline.php");
    Dio dio = new Dio();
    var fields = {
      'starstatus': "Declined",
      'reason': reason.text,
      'email': email
    };
    FormData formData = new FormData.fromMap(fields);
    var resp;

    var response = await dio.post(
      url,
      data: formData,
    );

    print(response.statusCode);
    print(response.data);
    var res = response.data;
    if (res.contains("true")) {
      Navigator.push(this.context,
          MaterialPageRoute(builder: (context) => AdminHomepage(3)));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  Declinemail(TextEditingController reason) async {
    String username = 'skhmusicals@gmail.com';
    String password = 'hari.k17699';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.

    // DONE

    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    final equivalentMessage = Message()
      ..from = Address(username, 'Eprodix😀')
      ..recipients.add(Address(email))
      ..subject = 'Declined at ${DateTime.now()}'
      ..text = reason.text;

    final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message

    // send the equivalent message
    await connection.send(equivalentMessage);

    // close the connection
    await connection.close();
  }

  Acceptmail() async {
    String username = 'skhmusicals@gmail.com';
    String password = 'hariprasath.k17699';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // DONE

    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    final equivalentMessage = Message()
      ..from = Address(username, 'Eprodix😀')
      ..recipients.add(Address(email))
      ..subject = 'Accepted at  ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>';

    final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message

    // send the equivalent message
    await connection.send(equivalentMessage);

    // close the connection
    await connection.close();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth / 10,
                  right: SizeConfig.screenWidth / 1.3),
              child: Center(
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
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
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 280),
                          child: ProfileWidgetDetailsPage(
                            onClicked: () async {},
                            imagePath: Image,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 150, top: 20),
                        child: Text(
                          Name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w800,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 150, top: 40),
                        child: Text(
                          Interest,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w800,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 30),
                  child: Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Mail.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 30),
                  child: Text(
                    email,
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 25),
                  child: Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Call.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  child: Text(
                    Phone,
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 25),
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/Link.svg",
                      height: 20,
                      width: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 25),
                  child: Text(
                    Profilelink,
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 90, right: 60, top: 60),
                  child: Container(
                    height: 370,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      image: DecorationImage(
                        image: NetworkImage(Proof),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 1.0, color: const Color(0xfff99d34)),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 140, top: 25),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/download.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1, top: 25, right: 30),
                  child: FlatButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new TextField(
                              keyboardType: TextInputType.text,
                              controller: reason,
                              decoration: InputDecoration(
                                  labelText: "Reason",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                          style: BorderStyle.solid))),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: new Text("Send",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'ROGFontsv',
                                        color: Colors.black87)),
                                onPressed: () {
                                  Declinemail(reason);
                                  _Decline(email, reason);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Reject.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
