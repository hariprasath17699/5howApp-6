// import 'dart:async';
//
// import 'package:adobe_xd/pinned.dart';
// import 'package:email_auth/email_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:star_event/HomeScreen/AdobeXdUi/UserLogin.dart';
//
// class StarEmailVerification extends StatefulWidget {
//   String email;
//   StarEmailVerification({required this.email});
//   @override
//   _StarEmailVerificationState createState() =>
//       _StarEmailVerificationState(email);
// }
//
// class _StarEmailVerificationState extends State<StarEmailVerification> {
//   String email;
//   bool submitValid = false;
//   StreamController<ErrorAnimationType>? errorController;
//
//   bool hasError = false;
//   String currentText = "";
//   final formKey = GlobalKey<FormState>();
//   TextEditingController textEditingController = TextEditingController();
//   _StarEmailVerificationState(this.email);
//
//   void verify(pin) {
//     var result = EmailAuth.validate(receiverMail: email, userOTP: pin);
//     if (result) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Loginscreen()));
//     } else {
//       AlertDialog(
//         title: Text("Error"),
//         content: Text("Invalid Otp"),
//       );
//     }
//     print(EmailAuth.validate(receiverMail: email, userOTP: pin));
//   }
//
//   void sendOtp() async {
//     EmailAuth.sessionName = "Eprdix Company";
//     var result = await EmailAuth.sendOtp(receiverMail: email);
//     if (result) {
//       setState(() {
//         submitValid = true;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     sendOtp();
//     super.initState();
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
//             Pin(size: 26.7, end: 28.9),
//             Pin(size: 26.7, start: 79.1),
//             child: FractionallySizedBox(
//               widthFactor: 2.2,
//               heightFactor: 2.2,
//               child: FlatButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Loginscreen()));
//                 },
//                 child: SvgPicture.string(
//                   _svg_y14qtf,
//                   allowDrawingOutsideViewBox: true,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           ),
//           Pinned.fromPins(
//             Pin(size: 5.8, start: 24.2),
//             Pin(size: 5.2, start: 124.6),
//             child: SvgPicture.string(
//               _svg_prhev5,
//               allowDrawingOutsideViewBox: true,
//               fit: BoxFit.fill,
//             ),
//           ),
//           Pinned.fromPins(
//             Pin(size: 136.0, middle: 0.4764),
//             Pin(size: 24.0, middle: 0.3263),
//             child: Text(
//               'Verification Code',
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontSize: 18,
//                 color: const Color(0xff000000),
//                 fontWeight: FontWeight.normal,
//                 height: 1.1666666666666667,
//               ),
//               textHeightBehavior:
//                   TextHeightBehavior(applyHeightToFirstAscent: false),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Pinned.fromPins(
//             Pin(size: 230.0, middle: 0.4625),
//             Pin(size: 24.0, middle: 0.366),
//             child: Text(
//               'Enter the 6-digit code below.',
//               style: TextStyle(
//                 fontFamily: 'Poppins-Light',
//                 fontSize: 18,
//                 color: const Color(0xff000000),
//                 height: 1.1666666666666667,
//               ),
//               textHeightBehavior:
//                   TextHeightBehavior(applyHeightToFirstAscent: false),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Pinned.fromPins(
//             Pin(size: 192.0, middle: 0.404),
//             Pin(size: 17.0, middle: 0.5018),
//             child: Text.rich(
//               TextSpan(
//                 style: TextStyle(
//                   fontFamily: 'Poppins-Light',
//                   fontSize: 13,
//                   color: const Color(0xff000000),
//                   height: 1.0769230769230769,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: 'Don’t got code?',
//                   ),
//                   TextSpan(
//                     text: ' ',
//                     style: TextStyle(
//                       color: const Color(0xfffe2d07),
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'Resend to E-mail',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       color: const Color(0xfffe7607),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               textHeightBehavior:
//                   TextHeightBehavior(applyHeightToFirstAscent: false),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Pinned.fromPins(
//             Pin(size: 148.0, start: 28.9),
//             Pin(size: 24.0, start: 80.9),
//             child: Text(
//               'E-mail Verification ',
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontSize: 18,
//                 color: const Color(0xff000000),
//                 height: 1.1666666666666667,
//               ),
//               textHeightBehavior:
//                   TextHeightBehavior(applyHeightToFirstAscent: false),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Pinned.fromPins(
//             Pin(size: 175.7, middle: 0.4993),
//             Pin(size: 45.9, middle: 0.6791),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(76.51),
//                 color: const Color(0xebfe7607),
//               ),
//             ),
//           ),
//           Pinned.fromPins(
//             Pin(size: 44.0, middle: 0.4913),
//             Pin(size: 19.0, middle: 0.6727),
//             child: FractionallySizedBox(
//               widthFactor: 2.2,
//               heightFactor: 2.2,
//               child: FlatButton(
//                 onPressed: () {
//                   verify(currentText);
//                 },
//                 child: Text(
//                   'Submit',
//                   style: TextStyle(
//                     fontFamily: 'Poppins-Regular',
//                     fontSize: 12,
//                     color: const Color(0xffffffff),
//                     height: 1.2142857142857142,
//                   ),
//                   textHeightBehavior:
//                       TextHeightBehavior(applyHeightToFirstAscent: false),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//               padding: EdgeInsets.only(top: 310, left: 20, right: 20),
//               child: PinCodeTextField(
//                 appContext: context,
//                 pastedTextStyle: TextStyle(
//                   color: Colors.green.shade600,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 length: 6,
//                 obscureText: true,
//                 obscuringCharacter: '*',
//                 blinkWhenObscuring: true,
//                 animationType: AnimationType.fade,
//                 validator: (v) {
//                   if (v!.length < 3) {
//                     return "Invalid Otp";
//                   } else {
//                     return null;
//                   }
//                 },
//                 pinTheme: PinTheme(
//                   shape: PinCodeFieldShape.box,
//                   activeColor: Colors.black,
//                   borderRadius: BorderRadius.circular(15),
//                   fieldHeight: 50,
//                   fieldWidth: 40,
//                   activeFillColor: hasError ? Colors.white : Colors.white,
//                 ),
//                 cursorColor: Colors.black,
//                 animationDuration: Duration(milliseconds: 300),
//                 errorAnimationController: errorController,
//                 controller: textEditingController,
//                 keyboardType: TextInputType.number,
//                 boxShadows: [
//                   BoxShadow(
//                     offset: Offset(0, 1),
//                     color: Colors.black12,
//                     blurRadius: 10,
//                   )
//                 ],
//                 onCompleted: (v) {},
//                 // onTap: () {
//                 //   print("Pressed");
//                 // },
//                 onChanged: (value) {
//                   print(value);
//                   setState(() {
//                     currentText = value;
//                   });
//                 },
//                 beforeTextPaste: (text) {
//                   print("Allowing to paste $text");
//                   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                   //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                   return true;
//                 },
//               )
//               // end Padding()
//               ),
//         ],
//       ),
//     );
//   }
// }
//
// const String _svg_y14qtf =
//     '<svg viewBox="334.5 79.1 26.7 26.7" ><path transform="translate(-7215.88, -522.36)" d="M 7575.3994140625 601.47998046875 C 7575.5166015625 601.5097045898438 7575.6337890625 601.5369873046875 7575.75 601.56982421875 C 7576.9580078125 601.9133911132812 7577.4111328125 603.356201171875 7576.615234375 604.326904296875 C 7576.533203125 604.4273681640625 7576.439453125 604.5188598632812 7576.34765625 604.6109008789062 C 7573.0166015625 607.943115234375 7569.6845703125 611.2753295898438 7566.3505859375 614.6054077148438 C 7566.2783203125 614.677734375 7566.181640625 614.7255859375 7566.0576171875 614.8117065429688 C 7566.203125 614.9329223632812 7566.2890625 614.9939575195312 7566.3623046875 615.0671997070312 C 7569.7138671875 618.4170532226562 7573.0625 621.7683715820312 7576.4150390625 625.1168823242188 C 7576.8837890625 625.5846557617188 7577.111328125 626.12548828125 7576.9716796875 626.7880249023438 C 7576.7080078125 628.0369873046875 7575.2451171875 628.574951171875 7574.234375 627.7955932617188 C 7574.1240234375 627.71142578125 7574.025390625 627.6133422851562 7573.9267578125 627.515380859375 C 7570.5947265625 624.18408203125 7567.2626953125 620.8521728515625 7563.931640625 617.5189819335938 C 7563.8583984375 617.4457397460938 7563.7998046875 617.3577270507812 7563.716796875 617.2543334960938 C 7563.609375 617.357421875 7563.5341796875 617.4254150390625 7563.4638671875 617.4964599609375 C 7560.107421875 620.8524780273438 7556.748046875 624.2069091796875 7553.3955078125 627.5679931640625 C 7552.8740234375 628.091552734375 7552.267578125 628.2725219726562 7551.5693359375 628.0742797851562 C 7551.0087890625 627.9152221679688 7550.63671875 627.5272827148438 7550.4443359375 626.9727783203125 C 7550.416015625 626.8922729492188 7550.384765625 626.8133544921875 7550.3544921875 626.7334594726562 L 7550.3544921875 626.1608276367188 C 7550.47265625 625.63916015625 7550.8046875 625.2627563476562 7551.171875 624.8961181640625 C 7554.4580078125 621.6199340820312 7557.7373046875 618.3365478515625 7561.0205078125 615.0571899414062 C 7561.091796875 614.98583984375 7561.189453125 614.9401245117188 7561.3251953125 614.848388671875 C 7561.1689453125 614.7246704101562 7561.080078125 614.6674194335938 7561.0068359375 614.5944213867188 C 7557.73046875 611.3204345703125 7554.4580078125 608.0430297851562 7551.177734375 604.7733764648438 C 7550.8095703125 604.4064331054688 7550.4794921875 604.029052734375 7550.3544921875 603.5105590820312 L 7550.3544921875 602.9379272460938 C 7550.494140625 602.4531860351562 7550.720703125 602.018310546875 7551.1767578125 601.7689819335938 C 7551.4208984375 601.635986328125 7551.703125 601.573974609375 7551.96875 601.47998046875 L 7552.1767578125 601.47998046875 C 7552.810546875 601.5573120117188 7553.25 601.9440307617188 7553.6806640625 602.3770751953125 C 7556.9384765625 605.6486206054688 7560.2060546875 608.9097290039062 7563.470703125 612.1740112304688 C 7563.537109375 612.2400512695312 7563.6064453125 612.302978515625 7563.7353515625 612.4251708984375 C 7563.80078125 612.3280639648438 7563.8466796875 612.2304077148438 7563.919921875 612.1580810546875 C 7567.17578125 608.8978271484375 7570.4375 605.6429443359375 7573.6884765625 602.377685546875 C 7574.1201171875 601.9447021484375 7574.5576171875 601.556396484375 7575.19140625 601.47998046875 L 7575.3994140625 601.47998046875 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_prhev5 =
//     '<svg viewBox="24.2 124.6 5.8 5.2" ><path transform="translate(-6519.93, -468.9)" d="M 6549.96435546875 593.5279541015625 C 6549.01416015625 593.865234375 6548.00048828125 594.0872802734375 6547.12646484375 594.5640869140625 C 6545.490234375 595.4571533203125 6544.67919921875 597.01611328125 6544.17919921875 598.7532958984375 L 6544.17919921875 593.5279541015625 L 6549.96435546875 593.5279541015625 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
