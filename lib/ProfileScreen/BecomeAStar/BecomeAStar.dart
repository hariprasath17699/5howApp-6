// import 'package:adobe_xd/pinned.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:star_event/HomeScreen/Homepage.dart';
// import 'package:star_event/HomeScreen/StarRequestProof.dart';
// import 'package:star_event/ProfileScreen/widget/button_widget.dart';
//
// class Becomeastar extends StatefulWidget {
//   String email;
//
//   Becomeastar({required this.email});
//   @override
//   _BecomeastarState createState() => _BecomeastarState(email);
// }
//
// class _BecomeastarState extends State<Becomeastar> {
//   bool value = false;
//   String email;
//   Object? _typeData = "Youtube";
//   final phonenumberController = TextEditingController();
//   final profilelinkController = TextEditingController();
//   _BecomeastarState(this.email);
//   Future _updateDetails() async {
//     var url =
//         ("https://starappeprodix.000webhostapp.com/starapp/becomeAstar.php");
//     Dio dio = new Dio();
//     var fields = {
//       'email': email,
//       'Platform': _typeData,
//       'Phone': phonenumberController.text,
//       'profilelink': profilelinkController.text,
//       'starstatus': "All"
//     };
//     FormData formData = new FormData.fromMap(fields);
//     var resp;
//
//     var response = await dio.post(
//       url,
//       data: formData,
//     );
//     print(response.statusCode);
//     print(response.data);
//     var res = response.data;
//     if (res.contains("true")) {
//       Navigator.push(
//           this.context, MaterialPageRoute(builder: (context) => Homepage(3)));
//     } else {
//       print("ERROR : " + res);
//       print(response.statusCode);
//       print(response.data);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xffffffff),
//       body: Stack(
//         children: <Widget>[
//           Pinned.fromPins(
//             Pin(start: 18.1, end: 21.1),
//             Pin(start: 13.6, end: 120.2),
//             child: Stack(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30),
//                   child: BackButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Homepage(3)));
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(top: 10, bottom: 10),
//                   child: Pinned.fromPins(
//                     Pin(size: 120.0, middle: 0.4589),
//                     Pin(size: 24.0, start: 91.4),
//                     child: Text(
//                       'Become a star?',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 15,
//                         color: const Color(0xff000000),
//                         fontWeight: FontWeight.bold,
//                         height: 0.9444444444444444,
//                       ),
//                       textHeightBehavior:
//                           TextHeightBehavior(applyHeightToFirstAscent: false),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 244,
//                   ),
//                   child: SizedBox(
//                     width: 430,
//                     height: 700,
//                     child: Column(
//                       children: [
//                         SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 20, left: 20),
//                           child: Container(
//                             height: 50,
//                             width: 600,
//                             child: DropdownButtonFormField(
//                               validator: (value) => null,
//                               value: _typeData,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(70.0),
//                                 ),
//                               ),
//                               items: [
//                                 DropdownMenuItem(
//                                   child: Text(
//                                     'Youtube',
//                                     style: TextStyle(fontSize: 11),
//                                   ),
//                                   value: 'Youtube',
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text(
//                                     'Instagram',
//                                     style: TextStyle(fontSize: 11),
//                                   ),
//                                   value: 'Instagram',
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text(
//                                     'Facebook',
//                                     style: TextStyle(fontSize: 11),
//                                   ),
//                                   value: 'Facebook',
//                                 ),
//                               ],
//                               onChanged: (value) {
//                                 setState(() {
//                                   _typeData = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(),
//                           child: Container(
//                             height: 70.0,
//                             padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                             child: TextField(
//                               keyboardType: TextInputType.text,
//                               controller: profilelinkController,
//                               decoration: InputDecoration(
//                                   labelText: "ProfileLink",
//                                   labelStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 11,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(40)),
//                                       borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.white,
//                                           style: BorderStyle.solid))),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(),
//                           child: Container(
//                             height: 70.0,
//                             padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                             child: TextField(
//                               keyboardType: TextInputType.text,
//                               controller: phonenumberController,
//                               decoration: InputDecoration(
//                                   labelText: "Phone Number",
//                                   labelStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 11,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(40)),
//                                       borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.white,
//                                           style: BorderStyle.solid))),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 20, left: 10),
//                           child: Row(
//                             children: <Widget>[
//                               SizedBox(
//                                 width: 5,
//                               ), //SizedBox
//                               SizedBox(width: 5), //SizedBox
//                               ButtonWidget(
//                                 color: Colors.orange,
//                                 text: 'Upload Image',
//                                 onClicked: () {
//                                   _updateDetails();
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               ImageUpload(email)));
//                                 },
//                               ),
//                             ], //<Widget>[]
//                           ),
//                         ),
//                       ],
//                     ), //Column
//                   ), //SizedBox
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Pinned.fromPins(
//                     Pin(size: 27.0, start: 28.2),
//                     Pin(size: 21.0, start: 45.7),
//                     child: Text(
//                       'Star',
//                       style: TextStyle(
//                         fontFamily: 'Poppins-SemiBold',
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xff000000),
//                         height: 1.25,
//                       ),
//                       textHeightBehavior:
//                           TextHeightBehavior(applyHeightToFirstAscent: false),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 20,
//                   ),
//                   child: Pinned.fromPins(
//                     Pin(start: 6.9, end: 13.9),
//                     Pin(size: 66.0, middle: 0.2055),
//                     child: Text(
//                       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 12,
//                         color: const Color(0xff000000),
//                         fontWeight: FontWeight.w300,
//                         height: 1.6666666666666667,
//                       ),
//                       textHeightBehavior:
//                           TextHeightBehavior(applyHeightToFirstAscent: false),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 30,
//                   ),
//                   child: Pinned.fromPins(
//                     Pin(start: 6.9, end: 8.9),
//                     Pin(size: 42.0, middle: 0.2939),
//                     child: Text(
//                       'If you are curious which kind of proofen screenshot we need just follow the instructions',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 12,
//                         color: const Color(0xff000000),
//                         fontWeight: FontWeight.w300,
//                         height: 1.6666666666666667,
//                       ),
//                       textHeightBehavior:
//                           TextHeightBehavior(applyHeightToFirstAscent: false),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ),
//                 Pinned.fromPins(
//                   Pin(size: 250.7, middle: 0.5305),
//                   Pin(size: 45.9, end: 0.0),
//                   child: FlatButton(
//                     onPressed: () {
//                       _updateDetails();
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Homepage(3)));
//                     },
//                     child: SvgPicture.string(
//                       _svg_exmdxh,
//                       allowDrawingOutsideViewBox: true,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5),
//                   child: Pinned.fromPins(
//                     Pin(size: 31.0, middle: 0.4969),
//                     Pin(size: 19.0, end: 13.9),
//                     child: Text(
//                       'Send',
//                       style: TextStyle(
//                         fontFamily: 'Poppins-Regular',
//                         fontSize: 12,
//                         color: const Color(0xffffffff),
//                         height: 1.2142857142857142,
//                       ),
//                       textHeightBehavior:
//                           TextHeightBehavior(applyHeightToFirstAscent: false),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// const String _svg_bppjhy =
//     '<svg viewBox="0.0 6.0 3.0 4.8" ><path transform="translate(0.0, 5.99)" d="M 0 0 L 2.962844133377075 0 L 2.962844133377075 4.847890853881836 L 0 4.847890853881836 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_cvpffb =
//     '<svg viewBox="4.2 4.0 3.0 6.8" ><path transform="translate(4.24, 4.04)" d="M 0 0 L 2.962569236755371 0 L 2.962569236755371 6.800299644470215 L 0 6.800299644470215 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_ecm87v =
//     '<svg viewBox="8.5 2.2 3.0 8.7" ><path transform="translate(8.48, 2.15)" d="M 0 0 L 2.962294340133667 0 L 2.962294340133667 8.685620307922363 L 0 8.685620307922363 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_hyyowp =
//     '<svg viewBox="12.7 0.0 3.0 10.8" ><path transform="translate(12.73, 0.0)" d="M 0 0 L 2.962569236755371 0 L 2.962569236755371 10.84011745452881 L 0 10.84011745452881 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_ubp25r =
//     '<svg viewBox="0.0 0.0 16.0 4.5" ><path transform="translate(-3506.69, -438.56)" d="M 3506.691650390625 441.6781921386719 L 3508.1171875 443.105224609375 C 3509.93505859375 441.4686889648438 3512.257080078125 440.5716247558594 3514.700927734375 440.5716247558594 C 3517.146728515625 440.5716247558594 3519.468994140625 441.4686889648438 3521.285400390625 443.105224609375 L 3522.7109375 441.6781921386719 C 3520.5126953125 439.6632080078125 3517.684326171875 438.5579833984375 3514.700927734375 438.5579833984375 C 3511.7197265625 438.5579833984375 3508.891357421875 439.6632080078125 3506.691650390625 441.6781921386719 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_fkxtww =
//     '<svg viewBox="2.7 3.8 10.7 3.5" ><path transform="translate(-3511.79, -445.75)" d="M 3514.455078125 451.532958984375 L 3515.881591796875 452.9599609375 C 3516.9853515625 452.0281677246094 3518.361328125 451.5202331542969 3519.7978515625 451.5202331542969 C 3521.23583984375 451.5202331542969 3522.6123046875 452.0281677246094 3523.7158203125 452.9599609375 L 3525.142822265625 451.532958984375 C 3523.65478515625 450.2227172851562 3521.7724609375 449.5069580078125 3519.7978515625 449.5069580078125 C 3517.823974609375 449.5069580078125 3515.943603515625 450.2227172851562 3514.455078125 451.532958984375 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_8l7mba =
//     '<svg viewBox="5.3 7.5 5.4 2.4" ><path transform="translate(-3516.89, -452.99)" d="M 3522.221435546875 461.4421081542969 L 3523.67041015625 462.8907470703125 C 3524.04443359375 462.64794921875 3524.46240234375 462.5219116210938 3524.897216796875 462.5219116210938 C 3525.330810546875 462.5219116210938 3525.750732421875 462.64794921875 3526.12548828125 462.8907470703125 L 3527.574462890625 461.4421081542969 C 3526.038818359375 460.2342529296875 3523.757080078125 460.2342529296875 3522.221435546875 461.4421081542969 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_4qlr24 =
//     '<svg viewBox="0.0 0.0 18.9 8.2" ><path  d="M 0.1597000062465668 0 L 18.69186401367188 0 C 18.78006362915039 0 18.85156440734863 0.07150012254714966 18.85156440734863 0.1597000062465668 L 18.85156440734863 8.054859161376953 C 18.85156440734863 8.142948150634766 18.78015327453613 8.214359283447266 18.69206428527832 8.214359283447266 L 0.1594938933849335 8.214359283447266 C 0.07140784710645676 8.214359283447266 0 8.142951965332031 0 8.054865837097168 L 0 0.1597000062465668 C 0 0.07150012254714966 0.07150012254714966 0 0.1597000062465668 0 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_kkcbtc =
//     '<svg viewBox="19.3 2.3 1.5 3.5" ><path transform="translate(19.29, 2.34)" d="M 0.1595000028610229 0 L 1.355640769004822 0 C 1.443785429000854 0 1.515240788459778 0.07145535200834274 1.515240788459778 0.1596000045537949 L 1.515240788459778 3.375236511230469 C 1.515240788459778 3.463325977325439 1.443830251693726 3.534736633300781 1.355740785598755 3.534736633300781 L 0.1595999896526337 3.534736633300781 C 0.07145534455776215 3.534736633300781 0 3.463281154632568 0 3.375136613845825 L 0 0.1595000028610229 C 0 0.07141058146953583 0.07141058146953583 0 0.1595000028610229 0 Z" fill="#40545e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_2s3j3o =
//     '<svg viewBox="24.7 62.7 7.3 15.6" ><path transform="translate(-12322.27, -534.96)" d="M 12353.3935546875 597.6110229492188 L 12346.94140625 605.6199951171875 L 12354.283203125 613.1842041015625" fill="none" stroke="#444444" stroke-width="2" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_9ug32o =
//     '<svg viewBox="26.0 313.0 12.0 12.0" ><path transform="translate(26.0, 313.0)" d="M 0 0 L 12 0 L 12 12 L 0 12 Z" fill="#ffffff" stroke="#707070" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_hsj7dc =
//     '<svg viewBox="26.0 403.0 12.0 12.0" ><path transform="translate(26.0, 403.0)" d="M 0 0 L 12 0 L 12 12 L 0 12 Z" fill="#ffffff" stroke="#707070" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_k4ltao =
//     '<svg viewBox="26.0 492.0 12.0 12.0" ><path transform="translate(26.0, 492.0)" d="M 0 0 L 12 0 L 12 12 L 0 12 Z" fill="#ffffff" stroke="#707070" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_gungi3 =
//     '<svg viewBox="25.0 262.0 50.0 20.0" ><path transform="translate(25.0, 262.0)" d="M 10 0 L 40 0 C 45.52284622192383 0 50 4.477152347564697 50 10 C 50 15.52284812927246 45.52284622192383 20 40 20 L 10 20 C 4.477152347564697 20 0 15.52284812927246 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 Z" fill="#00b141" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_xusqvy =
//     '<svg viewBox="49.0 357.0 74.0 25.0" ><path transform="translate(49.0, 357.0)" d="M 12.5 0 L 61.5 0 C 68.40355682373047 0 74 5.596440315246582 74 12.5 C 74 19.40356063842773 68.40355682373047 25 61.5 25 L 12.5 25 C 5.596440315246582 25 0 19.40356063842773 0 12.5 C 0 5.596440315246582 5.596440315246582 0 12.5 0 Z" fill="#3c225f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_l1wma =
//     '<svg viewBox="49.0 447.0 74.0 25.0" ><path transform="translate(49.0, 447.0)" d="M 12.5 0 L 61.5 0 C 68.40355682373047 0 74 5.596440315246582 74 12.5 C 74 19.40356063842773 68.40355682373047 25 61.5 25 L 12.5 25 C 5.596440315246582 25 0 19.40356063842773 0 12.5 C 0 5.596440315246582 5.596440315246582 0 12.5 0 Z" fill="#3c225f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_z0wk4i =
//     '<svg viewBox="49.0 537.0 74.0 25.0" ><path transform="translate(49.0, 537.0)" d="M 12.5 0 L 61.5 0 C 68.40355682373047 0 74 5.596440315246582 74 12.5 C 74 19.40356063842773 68.40355682373047 25 61.5 25 L 12.5 25 C 5.596440315246582 25 0 19.40356063842773 0 12.5 C 0 5.596440315246582 5.596440315246582 0 12.5 0 Z" fill="#3c225f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_71188k =
//     '<svg viewBox="28.6 316.5 6.7 4.9" ><path transform="translate(-1487.86, -1447.46)" d="M 1516.499877929688 1766.455444335938 L 1519.246704101562 1768.910888671875 L 1523.214111328125 1764.000122070312" fill="none" stroke="#fe801a" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_exmdxh =
//     '<svg viewBox="111.0 677.9 175.7 45.9" ><path transform="translate(111.0, 677.89)" d="M 22.93271827697754 0 L 152.7489624023438 0 C 165.4143524169922 0 175.6816864013672 10.26732730865479 175.6816864013672 22.93271827697754 C 175.6816864013672 35.59811019897461 165.4143524169922 45.86543655395508 152.7489624023438 45.86543655395508 L 22.93271827697754 45.86543655395508 C 10.26732730865479 45.86543655395508 0 35.59811019897461 0 22.93271827697754 C 0 10.26732730865479 10.26732730865479 0 22.93271827697754 0 Z" fill="#fe7607" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
