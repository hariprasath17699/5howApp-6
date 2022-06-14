import 'dart:async';
import 'dart:convert';

import 'package:adobe_xd/pinned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:octo_image/octo_image.dart';
import 'package:star_event/HomeScreen/Json/Starmodel.dart';
import 'package:star_event/ProfileScreen/utils/user_preferences.dart';

import 'AllUserScreenDetailspage.dart';
import 'SearchBarAllUsers.dart';

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

  var response = await dio.post(url, data: formData);
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
        "Logintype": Logintype,
      };
}

class AdminAllUserScreen extends StatefulWidget {
  AdminAllUserScreen();
  @override
  _AdminAllUserScreenState createState() => _AdminAllUserScreenState();
}

class _AdminAllUserScreenState extends State<AdminAllUserScreen> {
  _AdminAllUserScreenState();
  late List result;
  late List selectedSeater, selectedType;
  bool loading = true;
  late ScrollController controller;
  var sliderImageHieght = 0.0;
  late Future<StarModel> star;

  Future<List> getData() async {
    final LocalStorage storage = new LocalStorage('Star');
    var client = http.Client();
    // final url = "http://192.168.29.103/StarLoginAndRegister/getStars.php";
    var url = Uri.parse("http://5howapp.com/StarLoginAndRegister/allUsers.php");

    var response = await client.get(url);

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
                ? new UserHomeScreen(
                    list: snapshot.data!,
                  )
                : new Center(
                    child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1),
                    duration: const Duration(milliseconds: 3500),
                    builder: (context, value, _) =>
                        CircularProgressIndicator(value: value),
                  ));
          }),
    );
  }
}

class UserHomeScreen extends StatefulWidget {
  final List<dynamic> list;
  const UserHomeScreen({Key? key, required this.list}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState(list);
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late Future<Username> futureAlbum;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final DateOfBirth = TextEditingController();
  final Password = TextEditingController();
  final LocalStorage storage = new LocalStorage('Star');
  List<dynamic> list;
  _UserHomeScreenState(this.list);

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
            storage.setItem("Type", snapshot.data?.data.Logintype);
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: AllUserSearchBarAdmin(
                              name: snapshot.data!.data.username,
                              image: snapshot.data!.data.image,
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,
                                  mainAxisExtent: 70,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 1,
                                  childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .width /
                                      (MediaQuery.of(context).size.height / 2),
                                ),
                                itemCount: list == null ? 0 : list.length,
                                itemBuilder: (context, index) {
                                  String image = list[index]['image'];
                                  if (image.isEmpty) {
                                    image =
                                        "http://dirtydeedsindustries.com/wp-content/uploads/2016/08/placeholder.jpg.png";
                                  }
                                  return Stack(
                                    children: <Widget>[
                                      Pinned.fromPins(
                                        Pin(start: 22.9, end: 18.1),
                                        Pin(size: 71.9, start: 105.2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 54.9,
                                              child: Pinned.fromPins(
                                                Pin(start: 0.0, end: 2.9),
                                                Pin(size: 54.9, middle: 0.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 54.9,
                                                          start: 0.0),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child: Container(
                                                        child: OctoImage(
                                                          image:
                                                              CachedNetworkImageProvider(
                                                                  list[index][
                                                                      'image']),
                                                          placeholderBuilder:
                                                              OctoPlaceholder
                                                                  .blurHash(
                                                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                                          ),
                                                          errorBuilder:
                                                              OctoError.icon(
                                                                  color: Colors
                                                                      .red),
                                                          imageBuilder:
                                                              OctoImageTransformer
                                                                  .circleAvatar(),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 40),
                                                      child: Pinned.fromPins(
                                                        Pin(
                                                            size: 120.0,
                                                            middle: 0.2301),
                                                        Pin(
                                                            size: 40.0,
                                                            start: 6.5),
                                                        child: Text.rich(
                                                          TextSpan(
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins-Light',
                                                              fontSize: 13,
                                                              color: const Color(
                                                                  0xff000000),
                                                              height: 1,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: list[
                                                                        index][
                                                                    'username'],
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins-Medium',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          textHeightBehavior:
                                                              TextHeightBehavior(
                                                                  applyHeightToFirstAscent:
                                                                      false),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 43),
                                                      child: Pinned.fromPins(
                                                        Pin(
                                                            size: 100.0,
                                                            middle: 0.2169),
                                                        Pin(
                                                            size: 16.0,
                                                            end: 7.5),
                                                        child: Text(
                                                          list[index]
                                                              ['Logintype'],
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 10,
                                                            color: Colors.teal,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1.25,
                                                          ),
                                                          textHeightBehavior:
                                                              TextHeightBehavior(
                                                                  applyHeightToFirstAscent:
                                                                      false),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
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
                                                  allowDrawingOutsideViewBox:
                                                      true,
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
                                                          AllUserDetailsScreen(
                                                              Name: list[index]
                                                                  ['username'],
                                                              Image: list[index]
                                                                  ['image'],
                                                              DOB: list[index]
                                                                  ['dob'],
                                                              Proof: list[index]
                                                                  ['Proof'],
                                                              Interest: list[index]
                                                                  ['interest'],
                                                              email: list[index]
                                                                  ['email'],
                                                              join: list[index][
                                                                  'created_at'],
                                                              password: list[index]
                                                                  ['password'],
                                                              Logintype: list[index]
                                                                  ['Logintype'],
                                                              country: list[index]
                                                                  ['country'])));
                                            } catch (e) {}
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                  throw 'error';
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }

            // By default, show a loading spinner.
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1),
              duration: const Duration(milliseconds: 3500),
              builder: (context, value, _) =>
                  CircularProgressIndicator(value: value),
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
    '<svg viewBox="293.0 127.0 76.0 20.0" ><path transform="translate(293.0, 127.0)" d="M 10 0 L 66 0 C 71.52285003662109 0 76 4.477152347564697 76 10 C 76 15.52284812927246 71.52285003662109 20 66 20 L 10 20 C 4.477152347564697 20 0 15.52284812927246 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z" fill="#00b141" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_7pmj6d =
    '<svg viewBox="24.8 177.1 347.1 1.0" ><path transform="translate(-1448.71, 232.64)" d="M 1473.5 -55.5 L 1820.5751953125 -55.5" fill="none" stroke="#707070" stroke-width="0.20000000298023224" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
