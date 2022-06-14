import 'package:adobe_xd/pinned.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'AdminHomePage.dart';

class AdminUserDetails extends StatefulWidget {
  String Name;
  String Interest;
  String Image;
  String DOB;
  String Proof;
  String email;
  String Phone;
  String Profilelink;

  AdminUserDetails(
      {required this.Name,
      required this.Interest,
      required this.Image,
      required this.DOB,
      required this.Proof,
      required this.email,
      required this.Phone,
      required this.Profilelink});

  @override
  _AdminUserDetailsState createState() => _AdminUserDetailsState(
      Name, Image, DOB, Proof, email, Phone, Profilelink, Interest);
}

class _AdminUserDetailsState extends State<AdminUserDetails> {
  String Name;
  String Image;
  String DOB;
  String Proof;
  String email;
  String Phone;
  String Profilelink;
  String Interest;
  _AdminUserDetailsState(this.Name, this.Image, this.DOB, this.Proof,
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
          MaterialPageRoute(builder: (context) => AdminHomepage(1)));
    } else {
      print("ERROR : " + res);
      print(response.statusCode);
      print(response.data);
    }
  }

  Declinemail(TextEditingController reason) async {
    String username = 'skhmusicals@gmail.com';
    String password = 'hariprasath.k17699';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 21.5, end: 21.5),
            Pin(size: 759.9, middle: 0.706),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 27.0,
                ),
                SizedBox(
                  height: 73.4,
                  child: Pinned.fromPins(
                    Pin(size: 167.4, start: 8.1),
                    Pin(size: 73.4, middle: 0.0699),
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(size: 73.4, start: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              image: DecorationImage(
                                image: NetworkImage(Image),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 1.0, color: const Color(0xfff99d34)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 20),
                          child: Container(
                            child: Pinned.fromPins(
                              Pin(size: 80.0, end: 0.0),
                              Pin(size: 24.0, middle: 0.2478),
                              child: Center(
                                child: Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff000000),
                                      height: 0.8333333333333334,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: Name,
                                        style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                        ),
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            child: Pinned.fromPins(
                              Pin(size: 42.0, end: 20.0),
                              Pin(size: 21.0, middle: 0.7854),
                              child: Center(
                                child: Text(
                                  Interest.substring(1, 7),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    height: 0.9375,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 31.0,
                ),
                SizedBox(
                  height: 21.8,
                  child: Pinned.fromPins(
                    Pin(size: 210.7, start: 10.5),
                    Pin(size: 21.8, middle: 0.2065),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(right: size.width / 40, top: 5),
                          child: Container(
                            child: Pinned.fromPins(
                              Pin(size: 160.0, end: 0.0),
                              Pin(start: 0.0, end: 1.8),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      email,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        color: const Color(0xff000000),
                                        height: 0.9333333333333333,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 21.0, start: 0.0),
                          Pin(start: 0.8, end: 0.0),
                          child:
                              // Adobe XD layer: 'email' (shape)
                              Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/mail.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                SizedBox(
                  height: 22.4,
                  child: Pinned.fromPins(
                    Pin(size: 162.3, start: 10.6),
                    Pin(size: 22.4, middle: 0.2701),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width / 300,
                              left: size.width / 10,
                              top: 5),
                          child: Container(
                            child: Pinned.fromPins(
                              Pin(size: 124.0, end: 0.0),
                              Pin(start: 1.4, end: 0.0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      Phone,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        color: const Color(0xff000000),
                                        height: 0.9375,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 19.9, start: 0.7),
                          Pin(start: 0.7, end: 1.9),
                          child: Transform.rotate(
                            angle: 0.0698,
                            child:
                                // Adobe XD layer: 'call' (shape)
                                Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/call.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                SizedBox(
                  height: 21.3,
                  child: Pinned.fromPins(
                    Pin(size: 265.3, start: 10.6),
                    Pin(size: 21.3, middle: 0.3339),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width / 10, left: size.width / 11),
                          child: Pinned.fromPins(
                            Pin(start: 2.3, end: 0.0),
                            Pin(start: 0.3, end: 0.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    Profilelink,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10,
                                      color: const Color(0xff000000),
                                      height: 0.9375,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 21.2, start: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child: Stack(
                            children: <Widget>[
                              Pinned.fromPins(
                                Pin(size: 14.6, start: 0.0),
                                Pin(size: 15.8, end: 0.0),
                                child: SvgPicture.string(
                                  _svg_1a8c6h,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromPins(
                                Pin(size: 14.6, end: 0.0),
                                Pin(size: 15.8, start: 0.0),
                                child: SvgPicture.string(
                                  _svg_5mdcig,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 29.0,
                ),
                SizedBox(
                  height: 0.0,
                  child: Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(size: 1.0, middle: 0.3913),
                    child: SvgPicture.string(
                      _svg_frdqro,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  height: 369.0,
                  child: Pinned.fromPins(
                    Pin(size: 218.0, middle: 0.5),
                    Pin(size: 369.0, middle: 0.8209),
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(50.0, 50.0)),
                              image: DecorationImage(
                                image: NetworkImage(Proof),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 23.0,
                ),
                SizedBox(
                  height: 47.0,
                  child: Pinned.fromPins(
                    Pin(size: 205.0, middle: 0.5035),
                    Pin(size: 47.0, middle: 1.0),
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(size: 80.0, start: -15.0),
                          Pin(start: 0.0, end: 0.0),
                          child: FlatButton(
                            onPressed: () {
                              Acceptmail();
                              _Accept(email);
                            },
                            child: SvgPicture.string(
                              _svg_t0xyga,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 47.0, middle: 0.5),
                          Pin(start: 0.0, end: 0.0),
                          child: SvgPicture.string(
                            _svg_7mmrta,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 80.0, end: -17.0),
                          Pin(start: 0.0, end: 0.0),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40)),
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
                            child: SvgPicture.string(
                              _svg_vs9smq,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 15.0, end: 16.0),
                          Pin(size: 15.0, middle: 0.5313),
                          child: SvgPicture.string(
                            _svg_57kzat,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 16.0, middle: 0.5026),
                          Pin(size: 16.0, middle: 0.5161),
                          child:
                              // Adobe XD layer: '724933' (shape)
                              Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/download.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Pinned.fromPins(
                            Pin(size: 30.0, start: 9.0),
                            Pin(start: 9.0, end: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const AssetImage(
                                      'assets/images/tick.png'),
                                  fit: BoxFit.fill,
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
    );
  }
}

const String _svg_t0xyga =
    '<svg viewBox="93.0 772.0 47.0 47.0" ><path transform="translate(93.0, 772.0)" d="M 23.5 0 C 36.47869110107422 0 47 10.52130889892578 47 23.5 C 47 36.47869110107422 36.47869110107422 47 23.5 47 C 10.52130889892578 47 0 36.47869110107422 0 23.5 C 0 10.52130889892578 10.52130889892578 0 23.5 0 Z" fill="none" stroke="#9a9a9a" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7mmrta =
    '<svg viewBox="172.0 772.0 47.0 47.0" ><path transform="translate(172.0, 772.0)" d="M 23.5 0 C 36.47869110107422 0 47 10.52130889892578 47 23.5 C 47 36.47869110107422 36.47869110107422 47 23.5 47 C 10.52130889892578 47 0 36.47869110107422 0 23.5 C 0 10.52130889892578 10.52130889892578 0 23.5 0 Z" fill="none" stroke="#9a9a9a" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vs9smq =
    '<svg viewBox="251.0 772.0 47.0 47.0" ><path transform="translate(251.0, 772.0)" d="M 23.5 0 C 36.47869110107422 0 47 10.52130889892578 47 23.5 C 47 36.47869110107422 36.47869110107422 47 23.5 47 C 10.52130889892578 47 0 36.47869110107422 0 23.5 C 0 10.52130889892578 10.52130889892578 0 23.5 0 Z" fill="none" stroke="#9a9a9a" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_57kzat =
    '<svg viewBox="267.0 789.0 15.0 15.0" ><path transform="translate(-7283.35, 187.52)" d="M 7564.435546875 601.47998046875 C 7564.50146484375 601.4967041015625 7564.5673828125 601.5120239257812 7564.6328125 601.530517578125 C 7565.31201171875 601.7236328125 7565.56689453125 602.5348510742188 7565.119140625 603.0806274414062 C 7565.0732421875 603.1370849609375 7565.0205078125 603.1885375976562 7564.96875 603.2402954101562 C 7563.09619140625 605.11376953125 7561.22265625 606.9873046875 7559.34814453125 608.859619140625 C 7559.3076171875 608.9002685546875 7559.2529296875 608.9271850585938 7559.18359375 608.9755859375 C 7559.26513671875 609.0437622070312 7559.3134765625 609.0780639648438 7559.3544921875 609.1192626953125 C 7561.2392578125 611.002685546875 7563.12158203125 612.886962890625 7565.0068359375 614.7695922851562 C 7565.2705078125 615.0325927734375 7565.3984375 615.336669921875 7565.31982421875 615.7091674804688 C 7565.17138671875 616.411376953125 7564.34912109375 616.7138671875 7563.78076171875 616.275634765625 C 7563.71875 616.2283935546875 7563.6630859375 616.1732177734375 7563.60791015625 616.1181640625 C 7561.734375 614.2451171875 7559.86083984375 612.371826171875 7557.98828125 610.4977416992188 C 7557.94677734375 610.45654296875 7557.9140625 610.4071044921875 7557.8671875 610.3489379882812 C 7557.806640625 610.4068603515625 7557.7646484375 610.4451293945312 7557.72509765625 610.485107421875 C 7555.837890625 612.3719482421875 7553.94921875 614.2579345703125 7552.06396484375 616.147705078125 C 7551.77099609375 616.4420776367188 7551.43017578125 616.5438232421875 7551.03759765625 616.432373046875 C 7550.72216796875 616.3428955078125 7550.51318359375 616.1248168945312 7550.40478515625 615.8130493164062 C 7550.38916015625 615.767822265625 7550.37158203125 615.723388671875 7550.3544921875 615.678466796875 L 7550.3544921875 615.3565673828125 C 7550.4208984375 615.063232421875 7550.607421875 614.8515625 7550.81396484375 614.6455078125 C 7552.66162109375 612.803466796875 7554.50537109375 610.9573974609375 7556.35107421875 609.1136474609375 C 7556.3916015625 609.073486328125 7556.4462890625 609.0477905273438 7556.5224609375 608.9962158203125 C 7556.4345703125 608.9266357421875 7556.384765625 608.8944702148438 7556.34375 608.8533935546875 C 7554.50146484375 607.0126953125 7552.66162109375 605.1699829101562 7550.8173828125 603.3316650390625 C 7550.6103515625 603.1253662109375 7550.4248046875 602.9131469726562 7550.3544921875 602.6216430664062 L 7550.3544921875 602.2996826171875 C 7550.43310546875 602.027099609375 7550.560546875 601.7825927734375 7550.81689453125 601.6424560546875 C 7550.9541015625 601.567626953125 7551.11279296875 601.5328369140625 7551.26220703125 601.47998046875 L 7551.37890625 601.47998046875 C 7551.7353515625 601.5234375 7551.982421875 601.7408447265625 7552.224609375 601.984375 C 7554.05615234375 603.82373046875 7555.8935546875 605.6572265625 7557.72900390625 607.4925537109375 C 7557.76611328125 607.5297241210938 7557.80517578125 607.5650634765625 7557.8779296875 607.6337890625 C 7557.91455078125 607.5792236328125 7557.9404296875 607.5242919921875 7557.9814453125 607.483642578125 C 7559.81201171875 605.6505737304688 7561.64599609375 603.820556640625 7563.4736328125 601.9846801757812 C 7563.71630859375 601.7412109375 7563.96240234375 601.52294921875 7564.31884765625 601.47998046875 L 7564.435546875 601.47998046875 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ruod9t =
    '<svg viewBox="86.0 380.0 218.0 369.0" ><path transform="translate(86.0, 380.0)" d="M 27 0 L 191 0 C 205.9116821289062 0 218 12.08831119537354 218 27 L 218 342 C 218 356.9116821289062 205.9116821289062 369 191 369 L 27 369 C 12.08831119537354 369 0 356.9116821289062 0 342 L 0 27 C 0 12.08831119537354 12.08831119537354 0 27 0 Z" fill="#1877f2" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_1a8c6h =
    '<svg viewBox="0.0 5.5 14.6 15.8" ><path transform="translate(593.65, -175.16)" d="M -582.2106323242188 192.2126007080078 C -583.2371826171875 193.242431640625 -584.1671142578125 194.36572265625 -585.2948608398438 195.2650451660156 C -586.979248046875 196.6082000732422 -588.879150390625 196.8139343261719 -590.8021850585938 195.8513946533203 C -592.7142944335938 194.8942260742188 -593.6605834960938 193.2571563720703 -593.6456298828125 191.1167144775391 C -593.6366577148438 189.8344879150391 -593.17724609375 188.6870574951172 -592.2750244140625 187.7684936523438 C -590.3798828125 185.8389434814453 -588.4784545898438 183.9144744873047 -586.5375366210938 182.03125 C -584.59033203125 180.1418609619141 -581.3751220703125 180.2040405273438 -579.4506225585938 182.1116027832031 C -578.9144897460938 182.64306640625 -578.8825073242188 183.4203948974609 -579.3751220703125 183.9502258300781 C -579.8626708984375 184.474609375 -580.6432495117188 184.4897613525391 -581.2127075195312 183.9857788085938 C -582.4092407226562 182.9268951416016 -583.8487548828125 182.9658966064453 -584.9769897460938 184.0924987792969 C -586.7485961914062 185.8615264892578 -588.5253295898438 187.6255340576172 -590.2857055664062 189.4056549072266 C -591.697998046875 190.8337249755859 -591.136474609375 193.1524353027344 -589.245361328125 193.7183074951172 C -588.2913208007812 194.0037689208984 -587.4357299804688 193.7801055908203 -586.7096557617188 193.1031188964844 C -586.3128662109375 192.7330932617188 -585.9378662109375 192.3396148681641 -585.555419921875 191.9542999267578 C -585.4686279296875 191.8668212890625 -585.394287109375 191.7835235595703 -585.2484130859375 191.8385772705078 C -584.2708740234375 192.2075347900391 -583.2601928710938 192.3051452636719 -582.2106323242188 192.2126007080078 Z" fill="#010101" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_5mdcig =
    '<svg viewBox="6.6 0.0 14.6 15.8" ><path transform="translate(491.13, -89.77)" d="M -481.4414367675781 94.03690338134766 C -480.7519836425781 93.34842681884766 -480.1325378417969 92.72261047363281 -479.5046997070312 92.10536956787109 C -479.0180053710938 91.62691497802734 -478.5775756835938 91.09490203857422 -478.0001220703125 90.71780395507812 C -476.2608337402344 89.58184814453125 -474.4336853027344 89.44517517089844 -472.6129455566406 90.43728637695312 C -470.7788696289062 91.43669891357422 -469.8888244628906 93.06228637695312 -469.9292907714844 95.14942932128906 C -469.9541625976562 96.43106079101562 -470.4321899414062 97.56744384765625 -471.3362731933594 98.48422241210938 C -473.2071533203125 100.381217956543 -475.080322265625 102.2767639160156 -476.9891357421875 104.1352996826172 C -478.9611511230469 106.0553588867188 -482.14453125 106.0261383056641 -484.0983581542969 104.1189422607422 C -484.6568298339844 103.5737152099609 -484.6996765136719 102.7951812744141 -484.2005920410156 102.2609481811523 C -483.7024536132812 101.7277908325195 -482.9242858886719 101.7192840576172 -482.3403015136719 102.2406692504883 C -481.2023620605469 103.2566757202148 -479.7301025390625 103.241584777832 -478.6630554199219 102.1819229125977 C -476.8723754882812 100.4036178588867 -475.0862121582031 98.62071228027344 -473.3099975585938 96.82790374755859 C -471.9768371582031 95.48229217529297 -472.3323059082031 93.34745788574219 -474.0168762207031 92.60773468017578 C -475.0327453613281 92.16168975830078 -475.9861450195312 92.32799530029297 -476.8147583007812 93.06603240966797 C -477.2420654296875 93.44651794433594 -477.6331481933594 93.86781311035156 -478.0368347167969 94.27443695068359 C -478.11962890625 94.35791778564453 -478.1902770996094 94.41749572753906 -478.3210754394531 94.36908721923828 C -479.2995300292969 94.0067138671875 -480.3091430664062 93.89974975585938 -481.4414367675781 94.03690338134766 Z" fill="#010101" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_frdqro =
    '<svg viewBox="21.5 356.3 347.1 1.0" ><path transform="translate(-1452.04, 411.79)" d="M 1473.5 -55.5 L 1820.5751953125 -55.5" fill="none" stroke="#707070" stroke-width="0.20000000298023224" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_2s3j3o =
    '<svg viewBox="24.7 62.7 7.3 15.6" ><path transform="translate(-12322.27, -534.96)" d="M 12353.3935546875 597.6110229492188 L 12346.94140625 605.6199951171875 L 12354.283203125 613.1842041015625" fill="none" stroke="#444444" stroke-width="2" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
