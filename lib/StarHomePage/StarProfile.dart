import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/ProfileScreen/utils/user_preferences.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/ProfileScreen/widget/profile_widget.dart';
import 'package:star_event/Responsive/StarAccountSettings.dart';
import 'package:star_event/Responsive/StarIntrestScreen.dart';
import 'package:star_event/User/Login/Login.dart';

import 'StarHome.dart';
import 'StarPaymentKey.dart';

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
    storage.setItem("starprofiledata", response);
    return Username.fromJson(
        jsonDecode(storage.getItem("starprofiledata").data));
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
      required this.paypalId});

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
  String paypalId;

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
        paypalId: json["paypalId"],
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
        "paypalId": paypalId,
      };
}

class StarProfilePage extends StatefulWidget {
  const StarProfilePage({Key? key}) : super(key: key);

  @override
  _StarProfilePageState createState() => _StarProfilePageState();
}

class _StarProfilePageState extends State<StarProfilePage> {
  late Future<Username> futureAlbum;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final DateOfBirth = TextEditingController();
  final Password = TextEditingController();
  final LocalStorage storage = new LocalStorage('Star');
  void logoutUser() async {
    storage.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserLogin()));
  }

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
              return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StarHomepage(0)));
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        logoutUser();
                      },
                    ),
                  ],
                ),
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    ProfileWidget(
                      imagePath: snapshot.data!.data.image,
                      onClicked: () async {},
                    ),
                    const SizedBox(height: 24),
                    buildName(
                        user: snapshot.data!.data.username,
                        email: snapshot.data!.data.email),
                    const SizedBox(
                      height: 24,
                    ),
                    const SizedBox(height: 24),
                    Center(
                        child: buildAccountSettingsButton(
                            name: snapshot.data!.data.username,
                            password: snapshot.data!.data.password,
                            email: snapshot.data!.data.email,
                            dob: snapshot.data!.data.dob,
                            image: snapshot.data!.data.image,
                            paypalId: snapshot.data!.data.paypalId)),
                    const SizedBox(height: 24),
                    Center(
                        child: buildInterestButton(
                            email: snapshot.data!.data.email,
                            interest: snapshot.data!.data.interest,
                            country: snapshot.data!.data.country)),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget buildName({required String user, required String email}) => Column(
        children: [
          Text(
            user,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAccountSettingsButton(
          {required String name,
          required String password,
          required String dob,
          required String email,
          required String image,
          required String paypalId}) =>
      ButtonWidget(
        color: Color.fromRGBO(60, 34, 95, 10),
        text: ' Account Settings',
        onClicked: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StarAccountSettings(
                      username: name,
                      password: password,
                      email: email,
                      dob: dob,
                      image: image,
                      paypalId: paypalId)));
        },
      );
  Widget buildInterestButton(
          {required String email,
          required String interest,
          required String country}) =>
      ButtonWidget(
        text: '        Interest         ',
        color: Color.fromRGBO(60, 34, 95, 10),
        onClicked: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StarInterestScreen(
                      email: email, interest: interest, country: country)));
        },
      );

  Widget buildPaymentKeyButton() => ButtonWidget(
        text: '    PaymentKey     ',
        color: Color.fromRGBO(60, 34, 95, 10),
        onClicked: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StarPaymentKey()));
        },
      );
}

const String _svg_vbh8qc =
    '<svg viewBox="26.7 62.7 7.3 15.6" ><path transform="translate(-12320.27, -534.96)" d="M 12353.3935546875 597.6110229492188 L 12346.94140625 605.6199951171875 L 12354.283203125 613.1842041015625" fill="none" stroke="#444444" stroke-width="2" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_r99qwd =
    '<svg viewBox="197.6 281.3 34.2 34.2" ><path transform="translate(197.59, 281.35)" d="M 17.08244514465332 0 C 21.09205436706543 0 24.77901268005371 1.381433129310608 27.92577171325684 3.88210391998291 C 31.6362476348877 6.823512077331543 34.16489028930664 11.65768146514893 34.16489028930664 17.08244705200195 C 34.16489028930664 20.99771308898926 32.84770202636719 24.60533332824707 30.45087432861328 27.71811676025391 C 27.50934600830078 31.54753303527832 22.60155487060547 34.16489410400391 17.08244514465332 34.16489410400391 C 7.648072242736816 34.16489410400391 0 26.51682281494141 0 17.08244705200195 C 0 7.648072242736816 7.648072242736816 0 17.08244514465332 0 Z" fill="#3c225f" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_edfos7 =
    '<svg viewBox="207.6 291.5 14.7 14.7" ><path transform="translate(207.63, 291.48)" d="M 7.36089563369751 0 C 11.4262056350708 0 14.72179126739502 3.295585632324219 14.72179126739502 7.360896110534668 C 14.72179126739502 11.42620658874512 11.4262056350708 14.72179222106934 7.36089563369751 14.72179222106934 C 3.295585632324219 14.72179222106934 0 11.42620658874512 0 7.360896110534668 C 0 3.295585632324219 3.295585632324219 0 7.36089563369751 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_owe3zr =
    '<svg viewBox="210.3 294.1 9.6 9.6" ><path transform="translate(210.26, 294.1)" d="M 4.819788932800293 0 C 7.481684684753418 0 9.639577865600586 2.157893419265747 9.639577865600586 4.819789409637451 C 9.639577865600586 7.481685638427734 7.481684684753418 9.639578819274902 4.819788932800293 9.639578819274902 C 2.157893180847168 9.639578819274902 0 7.481685638427734 0 4.819789409637451 C 0 2.157893419265747 2.157893180847168 0 4.819788932800293 0 Z" fill="#3c225f" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_p1ekp1 =
    '<svg viewBox="202.3 290.3 6.0 2.8" ><path transform="translate(202.32, 290.28)" d="M 1.37994647026062 0 L 4.66553258895874 0 C 5.427656173706055 0 6.045478820800781 0.6178230047225952 6.045478820800781 1.379946351051331 C 6.045478820800781 2.142069816589355 5.427656173706055 2.759892702102661 4.66553258895874 2.759892702102661 L 1.379946231842041 2.759892702102661 C 0.6178229451179504 2.759892702102661 0 2.142069816589355 0 1.37994647026062 C 0 0.61782306432724 0.61782306432724 0 1.37994647026062 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_bppjhy =
    '<svg viewBox="0.0 6.0 3.0 4.8" ><path transform="translate(0.0, 5.99)" d="M 0 0 L 2.962844133377075 0 L 2.962844133377075 4.847890853881836 L 0 4.847890853881836 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_cvpffb =
    '<svg viewBox="4.2 4.0 3.0 6.8" ><path transform="translate(4.24, 4.04)" d="M 0 0 L 2.962569236755371 0 L 2.962569236755371 6.800299644470215 L 0 6.800299644470215 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ecm87v =
    '<svg viewBox="8.5 2.2 3.0 8.7" ><path transform="translate(8.48, 2.15)" d="M 0 0 L 2.962294340133667 0 L 2.962294340133667 8.685620307922363 L 0 8.685620307922363 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_hyyowp =
    '<svg viewBox="12.7 0.0 3.0 10.8" ><path transform="translate(12.73, 0.0)" d="M 0 0 L 2.962569236755371 0 L 2.962569236755371 10.84011745452881 L 0 10.84011745452881 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ubp25r =
    '<svg viewBox="0.0 0.0 16.0 4.5" ><path transform="translate(-3506.69, -438.56)" d="M 3506.691650390625 441.6781921386719 L 3508.1171875 443.105224609375 C 3509.93505859375 441.4686889648438 3512.257080078125 440.5716247558594 3514.700927734375 440.5716247558594 C 3517.146728515625 440.5716247558594 3519.468994140625 441.4686889648438 3521.285400390625 443.105224609375 L 3522.7109375 441.6781921386719 C 3520.5126953125 439.6632080078125 3517.684326171875 438.5579833984375 3514.700927734375 438.5579833984375 C 3511.7197265625 438.5579833984375 3508.891357421875 439.6632080078125 3506.691650390625 441.6781921386719 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_fkxtww =
    '<svg viewBox="2.7 3.8 10.7 3.5" ><path transform="translate(-3511.79, -445.75)" d="M 3514.455078125 451.532958984375 L 3515.881591796875 452.9599609375 C 3516.9853515625 452.0281677246094 3518.361328125 451.5202331542969 3519.7978515625 451.5202331542969 C 3521.23583984375 451.5202331542969 3522.6123046875 452.0281677246094 3523.7158203125 452.9599609375 L 3525.142822265625 451.532958984375 C 3523.65478515625 450.2227172851562 3521.7724609375 449.5069580078125 3519.7978515625 449.5069580078125 C 3517.823974609375 449.5069580078125 3515.943603515625 450.2227172851562 3514.455078125 451.532958984375 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8l7mba =
    '<svg viewBox="5.3 7.5 5.4 2.4" ><path transform="translate(-3516.89, -452.99)" d="M 3522.221435546875 461.4421081542969 L 3523.67041015625 462.8907470703125 C 3524.04443359375 462.64794921875 3524.46240234375 462.5219116210938 3524.897216796875 462.5219116210938 C 3525.330810546875 462.5219116210938 3525.750732421875 462.64794921875 3526.12548828125 462.8907470703125 L 3527.574462890625 461.4421081542969 C 3526.038818359375 460.2342529296875 3523.757080078125 460.2342529296875 3522.221435546875 461.4421081542969 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_4qlr24 =
    '<svg viewBox="0.0 0.0 18.9 8.2" ><path  d="M 0.1597000062465668 0 L 18.69186401367188 0 C 18.78006362915039 0 18.85156440734863 0.07150012254714966 18.85156440734863 0.1597000062465668 L 18.85156440734863 8.054859161376953 C 18.85156440734863 8.142948150634766 18.78015327453613 8.214359283447266 18.69206428527832 8.214359283447266 L 0.1594938933849335 8.214359283447266 C 0.07140784710645676 8.214359283447266 0 8.142951965332031 0 8.054865837097168 L 0 0.1597000062465668 C 0 0.07150012254714966 0.07150012254714966 0 0.1597000062465668 0 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_kkcbtc =
    '<svg viewBox="19.3 2.3 1.5 3.5" ><path transform="translate(19.29, 2.34)" d="M 0.1595000028610229 0 L 1.355640769004822 0 C 1.443785429000854 0 1.515240788459778 0.07145535200834274 1.515240788459778 0.1596000045537949 L 1.515240788459778 3.375236511230469 C 1.515240788459778 3.463325977325439 1.443830251693726 3.534736633300781 1.355740785598755 3.534736633300781 L 0.1595999896526337 3.534736633300781 C 0.07145534455776215 3.534736633300781 0 3.463281154632568 0 3.375136613845825 L 0 0.1595000028610229 C 0 0.07141058146953583 0.07141058146953583 0 0.1595000028610229 0 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jjty7v =
    '<svg viewBox="111.0 576.9 175.7 45.9" ><path transform="translate(111.0, 576.89)" d="M 22.93271827697754 0 L 152.7489624023438 0 C 165.4143524169922 0 175.6816864013672 10.26732730865479 175.6816864013672 22.93271827697754 C 175.6816864013672 35.59811019897461 165.4143524169922 45.86543655395508 152.7489624023438 45.86543655395508 L 22.93271827697754 45.86543655395508 C 10.26732730865479 45.86543655395508 0 35.59811019897461 0 22.93271827697754 C 0 10.26732730865479 10.26732730865479 0 22.93271827697754 0 Z" fill="#fe7607" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_t2jbg1 =
    '<svg viewBox="39.5 337.3 310.5 50.4" ><path transform="translate(39.5, 337.28)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#3c225f" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jgsiaw =
    '<svg viewBox="39.5 262.1 310.5 50.4" ><path transform="translate(39.5, 262.1)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#3c225f" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_t4uroy =
    '<svg viewBox="39.5 486.6 310.5 50.4" ><path transform="translate(39.5, 486.55)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#3c225f" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_36zpld =
    '<svg viewBox="39.5 412.5 310.5 50.4" ><path transform="translate(39.5, 412.46)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#3c225f" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_j8ug8c =
    '<svg viewBox="111.3 279.0 1.0 18.0" ><path transform="translate(111.33, 279.01)" d="M 0 0 L 0 17.98464775085449" fill="none" stroke="#212121" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
