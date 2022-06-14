import 'dart:convert';

import 'package:adobe_xd/pinned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:octo_image/octo_image.dart';
import 'package:star_event/HomeScreen/Json/Starmodel.dart';
import 'package:star_event/StarHomePage/StarBookingJoinEventDetails.dart';

class StarBookingSessionsShowWithoutDate extends StatefulWidget {
  StarBookingSessionsShowWithoutDate();
  @override
  _StarBookingSessionsShowWithoutDateState createState() =>
      _StarBookingSessionsShowWithoutDateState();
}

class _StarBookingSessionsShowWithoutDateState
    extends State<StarBookingSessionsShowWithoutDate> {
  _StarBookingSessionsShowWithoutDateState();
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
        "http://5howapp.com/StarLoginAndRegister/Zoom/Zoom/StarEventswithbookings.php");
    var response = await client.post(url, headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    }, body: {
      "useremail": storage.getItem("email"),
    });
    print(response.body);
    print(response.statusCode);
    var dataRecieved = json.decode(response.body.toString());
    print(response);
    print("StarEventsList....:${dataRecieved}");

    return dataRecieved;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          print(snapshot.hasData);
          return snapshot.hasData
              ? new StarEventCalender1(
                  list: snapshot.data!,
                )
              : new Center(
                  child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1),
                  duration: const Duration(milliseconds: 3500),
                  builder: (context, value, _) =>
                      CircularProgressIndicator(value: value),
                ));
        });
  }
}

class StarEventCalender1 extends StatefulWidget {
  late List<dynamic> list;
  StarEventCalender1({required this.list});
  @override
  _StarEventCalender1State createState() => _StarEventCalender1State(list);
}

class _StarEventCalender1State extends State<StarEventCalender1> {
  List<dynamic> list;

  _StarEventCalender1State(this.list);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < list.length; i++) {
      if (int.parse(list[i]['startday']) < DateTime.now().day) {
        UpdateExpirySession(list[i]['event_id']);
      } else if (int.parse(list[i]['startmonth']) < DateTime.now().month) {
        UpdateExpirySession(list[i]['event_id']);
      } else if (int.parse(list[i]['startyear']) < DateTime.now().year) {
        UpdateExpirySession(list[i]['event_id']);
      }
    }
  }

  Future UpdateExpirySession(String eventId) async {
    var url =
        Uri.parse("http://5howapp.com/StarLoginAndRegister/UpdateExpiry.php");
    final LocalStorage storage = new LocalStorage('Star');
    var response = await http.post(url, body: {
      'status': "Expired",
      'email': storage.getItem("email"),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list == null ? 0 : list.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 60,
                  width: 50,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 22.9, end: 18.1),
                        Pin(size: 71.9, start: 105.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 45.9,
                              child: Pinned.fromPins(
                                Pin(start: 0.0, end: 2.9),
                                Pin(size: 54.9, middle: 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: OctoImage(
                                        image: CachedNetworkImageProvider(
                                            list[index]['profileimage']),
                                        placeholderBuilder:
                                            OctoPlaceholder.blurHash(
                                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                        ),
                                        errorBuilder:
                                            OctoError.icon(color: Colors.red),
                                        imageBuilder:
                                            OctoImageTransformer.circleAvatar(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Light',
                                                fontSize: 15,
                                                color: const Color(0xff000000),
                                                height: 1,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: list[index]['topic'],
                                                  style: TextStyle(
                                                    fontFamily: 'Poppinsmedium',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        false),
                                            textAlign: TextAlign.left,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, top: 10),
                                                child: Text(
                                                  "Duration: ",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, top: 7),
                                                child: Text.rich(
                                                  TextSpan(
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Poppins-Light',
                                                      fontSize: 8,
                                                      color: const Color(
                                                          0xff000000),
                                                      height: 1,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: list[index]
                                                            ['duration'],
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Poppinsmedium',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  textHeightBehavior:
                                                      TextHeightBehavior(
                                                          applyHeightToFirstAscent:
                                                              false),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25, top: 8),
                                                child: Text.rich(
                                                  TextSpan(
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Poppins-Light',
                                                      fontSize: 8,
                                                      color: const Color(
                                                          0xff000000),
                                                      height: 1,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: list[index]
                                                            ['startdate'],
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Poppinsmedium',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  textHeightBehavior:
                                                      TextHeightBehavior(
                                                          applyHeightToFirstAscent:
                                                              false),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25, top: 8),
                                                child: Text.rich(
                                                  TextSpan(
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Poppins-Light',
                                                      fontSize: 8,
                                                      color: list[index]
                                                                  ['status'] ==
                                                              'Active'
                                                          ? Colors.green
                                                          : Colors.red,
                                                      height: 1,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: list[index]
                                                            ['status'],
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Poppinsmedium',
                                                        ),
                                                      ),
                                                    ],
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 17.0,
                            ),
                            SizedBox(
                              height: 0.0,
                              child: Pinned.fromPins(
                                Pin(start: 1.9, end: 0.0),
                                Pin(size: 1.0, middle: 1.0141),
                                child: SvgPicture.string(
                                  _svg_7pmj6d,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.grey,
                            onTap: () {
                              try {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StarBookingJoinEventDetailsScreen(
                                              topic: list[index]['topic'],
                                              duration: list[index]['duration'],
                                              password: list[index]['password'],
                                              email: list[index]['email'],
                                              starname: list[index]['starname'],
                                              startdate: list[index]
                                                  ['startdate'],
                                              link: list[index]['link'],
                                              image: list[index]['image'],
                                              description: list[index]
                                                  ['description'],
                                            )));
                              } catch (e) {}
                            }),
                      )
                    ],
                  ),
                ),
              );
              throw 'error';
            }),
      ),
    );
  }
}

const String _svg_ubp25r =
    '<svg viewBox="0.0 0.0 16.0 4.5" ><path transform="translate(-3506.69, -438.56)" d="M 3506.691650390625 441.6781921386719 L 3508.1171875 443.105224609375 C 3509.93505859375 441.4686889648438 3512.257080078125 440.5716247558594 3514.700927734375 440.5716247558594 C 3517.146728515625 440.5716247558594 3519.468994140625 441.4686889648438 3521.285400390625 443.105224609375 L 3522.7109375 441.6781921386719 C 3520.5126953125 439.6632080078125 3517.684326171875 438.5579833984375 3514.700927734375 438.5579833984375 C 3511.7197265625 438.5579833984375 3508.891357421875 439.6632080078125 3506.691650390625 441.6781921386719 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_fkxtww =
    '<svg viewBox="2.7 3.8 10.7 3.5" ><path transform="translate(-3511.79, -445.75)" d="M 3514.455078125 451.532958984375 L 3515.881591796875 452.9599609375 C 3516.9853515625 452.0281677246094 3518.361328125 451.5202331542969 3519.7978515625 451.5202331542969 C 3521.23583984375 451.5202331542969 3522.6123046875 452.0281677246094 3523.7158203125 452.9599609375 L 3525.142822265625 451.532958984375 C 3523.65478515625 450.2227172851562 3521.7724609375 449.5069580078125 3519.7978515625 449.5069580078125 C 3517.823974609375 449.5069580078125 3515.943603515625 450.2227172851562 3514.455078125 451.532958984375 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8l7mba =
    '<svg viewBox="5.3 7.5 5.4 2.4" ><path transform="translate(-3516.89, -452.99)" d="M 3522.221435546875 461.4421081542969 L 3523.67041015625 462.8907470703125 C 3524.04443359375 462.64794921875 3524.46240234375 462.5219116210938 3524.897216796875 462.5219116210938 C 3525.330810546875 462.5219116210938 3525.750732421875 462.64794921875 3526.12548828125 462.8907470703125 L 3527.574462890625 461.4421081542969 C 3526.038818359375 460.2342529296875 3523.757080078125 460.2342529296875 3522.221435546875 461.4421081542969 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ds45dj =
    '<svg viewBox="24.0 162.0 159.0 187.0" ><g transform=""><path transform="translate(24.0, 162.0)" d="M 32 0 L 127 0 C 144.6731109619141 0 159 14.3268871307373 159 32 L 159 155 C 159 172.6731109619141 144.6731109619141 187 127 187 L 32 187 C 14.3268871307373 187 0 172.6731109619141 0 155 L 0 32 C 0 14.3268871307373 14.3268871307373 0 32 0 Z" fill="#ffffff" stroke="#dfdfdf" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></svg>';
const String _svg_2s8svd =
    '<svg viewBox="24.8 177.4 347.1 1.0" ><path transform="translate(-1448.71, 232.92)" d="M 1473.5 -55.5 L 1820.5751953125 -55.5" fill="none" stroke="#707070" stroke-width="0.20000000298023224" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vvruwu =
    '<svg viewBox="300.0 133.3 9.8 7.4" ><path transform="translate(-205.9, -117.41)" d="M 515.7279052734375 251.5152740478516 C 515.7296142578125 251.7662353515625 515.6235961914062 251.9676666259766 515.4489135742188 252.1417388916016 C 514.7511596679688 252.8370361328125 514.0552978515625 253.5341644287109 513.3587646484375 254.2305908203125 C 512.1683349609375 255.4207153320312 510.9780578613281 256.6109313964844 509.7874755859375 257.8008422851562 C 509.3583374023438 258.2297668457031 508.863525390625 258.2162475585938 508.4663391113281 257.7610168457031 C 507.676025390625 256.8551940917969 506.8850708007812 255.949951171875 506.1002807617188 255.0393524169922 C 505.7608032226562 254.6454315185547 505.8586120605469 254.0655517578125 506.2951965332031 253.8042449951172 C 506.6432495117188 253.5959014892578 507.0659790039062 253.6678924560547 507.3468017578125 253.9889831542969 C 507.8490600585938 254.5631713867188 508.3486938476562 255.1396636962891 508.849365234375 255.7152404785156 C 508.9312744140625 255.8094024658203 509.0195922851562 255.8989715576172 509.0928649902344 255.9994506835938 C 509.1616821289062 256.0938110351562 509.2052612304688 256.0768432617188 509.2798461914062 256.0020751953125 C 510.94873046875 254.3290710449219 512.6210327148438 252.6594543457031 514.2901611328125 250.9867095947266 C 514.5338134765625 250.7424926757812 514.8140258789062 250.6467742919922 515.1475830078125 250.7406463623047 C 515.4945068359375 250.8382568359375 515.7265625 251.1546783447266 515.7279052734375 251.5152740478516 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';

const String _svg_ac30k1 =
    '<svg viewBox="293.0 127.0 76.0 20.0" ><path transform="translate(293.0, 127.0)" d="M 10 0 L 66 0 C 71.52285003662109 0 76 4.477152347564697 76 10 C 76 15.52284812927246 71.52285003662109 20 66 20 L 10 20 C 4.477152347564697 20 0 15.52284812927246 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z" fill="#fa0011" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7pmj6d =
    '<svg viewBox="24.8 177.1 347.1 1.0" ><path transform="translate(-1448.71, 232.64)" d="M 1473.5 -55.5 L 1820.5751953125 -55.5" fill="none" stroke="#707070" stroke-width="0.20000000298023224" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_9fo00i =
    '<svg viewBox="94.0 610.0 224.0 55.0" ><path transform="translate(94.0, 610.0)" d="M 0 0 L 224 0 L 224 55 L 0 55 Z" fill="#ececec" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f5il3z =
    '<svg viewBox="314.0 610.0 55.0 55.0" ><path transform="translate(314.0, 610.0)" d="M 0 0 L 55 0 L 55 36 C 55 46.49341201782227 46.49341201782227 55 36 55 L 0 55 L 0 0 Z" fill="#e3e3e3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bw2wnx =
    '<svg viewBox="22.0 610.0 72.0 55.0" ><path transform="translate(22.0, 610.0)" d="M 18 0 L 72 0 L 72 55 L 0 55 L 0 18 C 0 8.058874130249023 8.058874130249023 0 18 0 Z" fill="#00b141" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
