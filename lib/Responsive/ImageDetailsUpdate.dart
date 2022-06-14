import 'dart:math';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/StarHomePage/StarImagesManage.dart';

import 'IconButton.dart';
import 'ProgressButton.dart';
import 'Response.dart';

class ImageDetailsUpdate extends StatefulWidget {
  String Image;
  String Title;
  String Description;
  String Story;
  String Location;
  String Id;
  ImageDetailsUpdate(
      {required this.Image,
      required this.Title,
      required this.Description,
      required this.Story,
      required this.Location,
      required this.Id});

  @override
  _ImageDetailsUpdateState createState() =>
      _ImageDetailsUpdateState(Image, Title, Description, Story, Location, Id);
}

class _ImageDetailsUpdateState extends State<ImageDetailsUpdate> {
  String image;
  String Title;
  String Description;
  String Story;
  String Location;
  String id;
  _ImageDetailsUpdateState(this.image, this.Title, this.Description, this.Story,
      this.Location, this.id);
  final titleController = TextEditingController();
  final descriptiomController = TextEditingController();
  final storyController = TextEditingController();
  final locationController = TextEditingController();
  PickedFile? _imageFile;
  final String uploadUrl =
      'http://5howapp.com/StarLoginAndRegister/ImageUpdateScreenEdit.php';
  ImagePicker _picker = ImagePicker();
  final LocalStorage storage = new LocalStorage('Star');
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;
  Widget buildCustomButton() {
    var progressTextButton = ProgressButton(
      stateWidgets: {
        ButtonState.idle: Text(
          "Idle",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.loading: Text(
          "Loading",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.fail: Text(
          "Fail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.success: Text(
          "Success",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      },
      stateColors: {
        ButtonState.idle: Colors.grey.shade400,
        ButtonState.loading: Colors.blue.shade300,
        ButtonState.fail: Colors.red.shade300,
        ButtonState.success: Colors.green.shade400,
      },
      onPressed: onPressedCustomButton,
      state: stateOnlyText,
      padding: EdgeInsets.all(8.0),
    );
    return progressTextButton;
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Send",
          icon: Icon(Icons.send, color: Colors.white),
          color: Colors.deepPurple.shade500),
      ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Update",
            icon: Icon(Icons.update, color: Colors.white),
            color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.loading: IconedButton(
            text: "Loading", color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.fail: IconedButton(
            text: "Failed",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Color.fromRGBO(254, 118, 7, 10))
      },
      onPressed: onPressedIconWithMinWidthStateText,
      state: stateTextWithIconMinWidthState,
      minWidthStates: [ButtonState.loading, ButtonState.success],
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 2), () async {
          if (_imageFile == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                  title: new Text("Please select image",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'ROGFontsv',
                          color: Colors.black)),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text("OK",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'ROGFontsv',
                              color: Colors.black87)),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          stateTextWithIconMinWidthState =
                              Random.secure().nextBool()
                                  ? ButtonState.fail
                                  : ButtonState.fail;
                        });
                      },
                    ),
                  ],
                );
              },
            );
          }
          // _updateDetails();

          var res = await uploadImage(_imageFile!.path, uploadUrl);
          print(res);
          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.fail
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIconMinWidthState = stateTextWithIconMinWidthState;
    });
  }

  Future<String?> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('Image', filepath));
    request.fields['id'] = id;
    request.fields['email'] = storage.getItem("email");
    request.fields['Title'] = titleController.text;
    request.fields['Description'] = descriptiomController.text;
    request.fields['Story'] = storyController.text;
    request.fields['Location'] = locationController.text;
    var res = await request.send();
    print(res.reasonPhrase);
    print(res);
    if (res.reasonPhrase != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => StarImageUploadManage()));

      return res.reasonPhrase;
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    var readLines = ['Test1', 'Test2', 'Test3'];
    String getNewLineString() {
      StringBuffer sb = new StringBuffer();
      for (String line in readLines) {
        sb.write(line + "\n");
      }
      return sb.toString();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 631.5,
              child: Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(start: 0.0, end: 65.5),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          _pickImage();
                        },
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(size: 152.0, end: 24.5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(56.0),
                          topRight: Radius.circular(60.0),
                        ),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 5.0, color: const Color(0xfffe801a)),
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
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(size: 152.0, end: 15.5),
                    child: SvgPicture.string(
                      _svg_h35zdt,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 191.0, start: 41.0),
                    Pin(size: 24.0, middle: 0.8008),
                    child: Text(
                      Title,
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 12,
                        color: const Color(0xff000000),
                        height: 1.1111111111111112,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 41.0, start: 41.0),
                    Pin(size: 24.0, end: 0.0),
                    child: Text(
                      'Story',
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 12,
                        color: const Color(0xff000000),
                        height: 1.1111111111111112,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 41.0, end: 31.0),
                    Pin(size: 62.0, end: 47.5),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          height: 1.5384615384615385,
                        ),
                        children: [
                          TextSpan(
                            text: Description,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: 'More',
                            style: TextStyle(
                              color: const Color(0xff3c225f),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            SizedBox(
              height: 43.0,
              child: Pinned.fromPins(
                Pin(start: 41.0, end: 31.0),
                Pin(size: 43.0, middle: 0.7373),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: const Color(0xff000000),
                      height: 1.5384615384615385,
                    ),
                    children: [
                      TextSpan(
                        text: Story,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'More',
                        style: TextStyle(
                          color: const Color(0xff3c225f),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            SizedBox(
              height: 28.5,
              child: Pinned.fromPins(
                Pin(size: 245.1, start: 40.9),
                Pin(size: 28.5, middle: 0.8098),
                child: Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(size: 21.1, start: 0.0),
                      Pin(start: 0.0, end: 0.0),
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromPins(
                            Pin(start: 0.0, end: 0.0),
                            Pin(start: 0.0, end: 0.0),
                            child: SvgPicture.string(
                              _svg_72dorx,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Pinned.fromPins(
                            Pin(start: 5.0, end: 5.0),
                            Pin(size: 11.1, middle: 0.285),
                            child: SvgPicture.string(
                              _svg_ge7t6l,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(start: 33.1, end: 0.0),
                      Pin(size: 19.0, start: 4.0),
                      child: Text(
                        Location,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 12,
                          color: const Color(0xff000000),
                          height: 1,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Container(
                height: 70.0,
                width: 350,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Enter Title",
                      labelStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                          ))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 5),
              child: Container(
                height: 70.0,
                width: 350,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: descriptiomController,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Enter Descrition",
                      labelStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                          ))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 5),
              child: Container(
                height: 70.0,
                width: 350,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: storyController,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Enter Story",
                      labelStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                          ))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 5),
              child: Container(
                height: 70.0,
                width: 350,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black87),
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: locationController,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      fillColor: Colors.black87,
                      labelText: "    Enter Location",
                      labelStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                          ))),
                ),
              ),
            ),
            Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 10),
                    child: Container(
                      height: 43,
                      width: 150,
                      child: buildTextWithIconWithMinState(),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      child: ButtonWidget(
                        color: Color.fromRGBO(254, 118, 7, 10),
                        text: '    Delete   ',
                        onClicked: () async {},
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

const String _svg_mgs278 =
    '<svg viewBox="4.3 747.8 381.3 76.9" ><defs><filter id="shadow"><feDropShadow dx="5" dy="10" stdDeviation="15"/></filter></defs><path transform="translate(4.3, 747.81)" d="M 39.01438140869141 0 L 342.2400207519531 0 C 363.7870788574219 0 381.25439453125 17.21303558349609 381.25439453125 38.44639587402344 C 381.25439453125 59.67975616455078 363.7870788574219 76.89279174804688 342.2400207519531 76.89279174804688 L 39.01438140869141 76.89279174804688 C 17.46733283996582 76.89279174804688 0 59.67975616455078 0 38.44639587402344 C 0 17.21303558349609 17.46733283996582 0 39.01438140869141 0 Z" fill="#ffffff" fill-opacity="0.95" stroke="none" stroke-width="1" stroke-opacity="0.95" stroke-miterlimit="10" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_ap7v5k =
    '<svg viewBox="503.0 541.9 18.7 11.8" ><path transform="translate(-2.54, -6.44)" d="M 507.081298828125 558.5274047851562 L 510.91162109375 558.5274047851562 C 510.91162109375 557.735595703125 510.9072265625 556.9638061523438 510.9129028320312 556.19140625 C 510.9172973632812 555.5084228515625 510.88330078125 554.8204956054688 510.9512939453125 554.1431884765625 C 511.1665649414062 551.9960327148438 512.9127807617188 550.4229736328125 514.9736328125 550.4752197265625 C 517.123291015625 550.5293579101562 518.8240966796875 552.2232666015625 518.8889770507812 554.4295654296875 C 518.927978515625 555.767822265625 518.8958740234375 557.1085205078125 518.8958740234375 558.509765625 L 522.697265625 558.509765625 C 522.7098388671875 558.2459716796875 522.733154296875 557.9791259765625 522.7337646484375 557.7122802734375 C 522.7362670898438 555.0281982421875 522.7349853515625 552.3447265625 522.7362670898438 549.66064453125 C 522.7362670898438 549.4334716796875 522.6651000976562 549.1513671875 522.771484375 548.9903564453125 C 522.9470825195312 548.7252197265625 523.2650146484375 548.34130859375 523.4790649414062 548.3677368164062 C 523.7572631835938 548.4017333984375 524.0833129882812 548.7447509765625 524.2192993164062 549.0350341796875 C 524.346435546875 549.3056640625 524.2551879882812 549.68017578125 524.2551879882812 550.0094604492188 C 524.2557983398438 552.9969482421875 524.2576904296875 555.984375 524.25390625 558.9718017578125 C 524.252685546875 559.8776245117188 524.048095703125 560.0853271484375 523.1347045898438 560.0903930664062 C 521.5900268554688 560.0985107421875 520.0458984375 560.0985107421875 518.5017700195312 560.0903930664062 C 517.5859375 560.0853271484375 517.3838500976562 559.8795166015625 517.3807373046875 558.9737548828125 C 517.3750610351562 557.581298828125 517.3832397460938 556.1889038085938 517.3776245117188 554.7965087890625 C 517.3712768554688 553.1385498046875 516.387451171875 552.014892578125 514.9327392578125 551.994140625 C 513.4572143554688 551.97265625 512.4431762695312 553.112060546875 512.4337158203125 554.8160400390625 C 512.4261474609375 556.2084350585938 512.4381103515625 557.600830078125 512.4293212890625 558.9932861328125 C 512.4242553710938 559.866943359375 512.2183837890625 560.0828857421875 511.3617553710938 560.089111328125 C 509.7918090820312 560.1004638671875 508.221923828125 560.1004638671875 506.6526489257812 560.089111328125 C 505.8041381835938 560.0828857421875 505.5655517578125 559.843017578125 505.5636596679688 559.0020751953125 C 505.557373046875 555.8118286132812 505.56494140625 552.6217041015625 505.5579833984375 549.4321899414062 C 505.5567626953125 548.8744506835938 505.6536865234375 548.3463134765625 506.3121337890625 548.3369140625 C 507.0391845703125 548.326171875 507.0869750976562 548.896484375 507.0850830078125 549.4718627929688 C 507.0762939453125 552.1810913085938 507.081298828125 554.8896484375 507.081298828125 557.5989990234375 C 507.081298828125 557.8759765625 507.081298828125 558.1535034179688 507.081298828125 558.5274047851562 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_3xbdtw =
    '<svg viewBox="498.7 530.9 27.3 11.8" ><path  d="M 512.3925170898438 532.635009765625 C 509.4446411132812 534.983642578125 506.5547790527344 537.286865234375 503.6648559570312 539.5894775390625 C 502.5160827636719 540.5047607421875 501.3654174804688 541.4174194335938 500.2191467285156 542.335205078125 C 499.7854309082031 542.6826782226562 499.3101806640625 542.9130859375 498.8903198242188 542.4013061523438 C 498.4553527832031 541.8699951171875 498.8248596191406 541.4803466796875 499.2547912597656 541.1386108398438 C 503.3753356933594 537.8584594726562 507.4989929199219 534.5814208984375 511.6043701171875 531.2828979492188 C 512.15771484375 530.8385620117188 512.58447265625 530.8253173828125 513.1390380859375 531.2710571289062 C 517.2450561523438 534.5693969726562 521.373779296875 537.8402099609375 525.4697265625 541.1505737304688 C 525.74609375 541.3734130859375 525.9902954101562 541.8674926757812 525.9500122070312 542.1992797851562 C 525.87890625 542.7916259765625 525.2380981445312 542.8671264648438 524.6331787109375 542.3880615234375 C 522.5697631835938 540.7520751953125 520.513916015625 539.1060180664062 518.4548950195312 537.46435546875 C 516.4569702148438 535.871826171875 514.457763671875 534.280517578125 512.3925170898438 532.635009765625 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_qxfoxu =
    '<svg viewBox="674.0 372.7 20.7 20.7" ><path transform="translate(0.0, 0.0)" d="M 673.9650268554688 377.1222839355469 C 674.0693969726562 376.9197998046875 674.0769653320312 376.6899719238281 674.1552734375 376.477783203125 C 674.6224975585938 375.2116088867188 675.7805786132812 374.3692626953125 677.1276245117188 374.3347473144531 C 677.4441528320312 374.3267517089844 677.7611083984375 374.3284606933594 678.078125 374.3338928222656 C 678.180419921875 374.3356018066406 678.21826171875 374.3115844726562 678.2140502929688 374.2017517089844 C 678.2052001953125 373.9794616699219 678.2073974609375 373.7567749023438 678.212890625 373.5345153808594 C 678.2237548828125 373.0680847167969 678.56689453125 372.7191467285156 679.0125732421875 372.7149353027344 C 679.4668579101562 372.710693359375 679.8179321289062 373.0634765625 679.8280639648438 373.5395812988281 C 679.8331298828125 373.7618408203125 679.8331298828125 373.9845275878906 679.82763671875 374.206787109375 C 679.8250122070312 374.2994079589844 679.845703125 374.3343200683594 679.9475708007812 374.3338928222656 C 681.0799560546875 374.3301391601562 682.2123413085938 374.3296813964844 683.3446655273438 374.3347473144531 C 683.4638061523438 374.3351745605469 683.47265625 374.2863464355469 683.470947265625 374.1929016113281 C 683.46630859375 373.9773864746094 683.4658813476562 373.7614135742188 683.4700317382812 373.5458679199219 C 683.4793090820312 373.0672607421875 683.824951171875 372.7145080566406 684.2791748046875 372.7149353027344 C 684.7333984375 372.7157592773438 685.0772705078125 373.0689392089844 685.0861206054688 373.5484008789062 C 685.0902709960938 373.7572021484375 685.0933227539062 373.9664306640625 685.08447265625 374.1748046875 C 685.079833984375 374.2913818359375 685.100830078125 374.3359985351562 685.2343139648438 374.3351745605469 C 686.35986328125 374.328857421875 687.485595703125 374.3284606933594 688.6111450195312 374.3356018066406 C 688.7538452148438 374.33642578125 688.7744750976562 374.2859191894531 688.7698974609375 374.1638488769531 C 688.761474609375 373.9487609863281 688.7626953125 373.7323608398438 688.7694091796875 373.5168151855469 C 688.7841796875 373.0567321777344 689.1407470703125 372.7098999023438 689.5865478515625 372.7149353027344 C 690.0238647460938 372.7203979492188 690.3690795898438 373.0643005371094 690.3833618164062 373.5163879394531 C 690.3905639648438 373.7319641113281 690.3956298828125 373.9487609863281 690.3817138671875 374.1634216308594 C 690.3720703125 374.3124389648438 690.4266967773438 374.3347473144531 690.5614624023438 374.3356018066406 C 691.0122680664062 374.3377075195312 691.4635620117188 374.3103332519531 691.9140014648438 374.3692626953125 C 693.276611328125 374.5477600097656 694.458251953125 375.7255554199219 694.6337890625 377.0856628417969 C 694.6581420898438 377.2734069824219 694.6724853515625 377.4607543945312 694.6724853515625 377.6493530273438 C 694.6724853515625 380.4465637207031 694.6729125976562 383.2437438964844 694.6724853515625 386.0405883789062 C 694.6720581054688 386.4838562011719 694.473388671875 386.7919921875 694.1172485351562 386.9073181152344 C 693.6204833984375 387.0681457519531 693.10986328125 386.73388671875 693.0601806640625 386.213623046875 C 693.05224609375 386.1332092285156 693.0547485351562 386.0519714355469 693.0547485351562 385.9711303710938 C 693.0547485351562 383.2012634277344 693.0555419921875 380.4309997558594 693.0543212890625 377.6607055664062 C 693.053955078125 376.8326721191406 692.6056518554688 376.2176818847656 691.84033203125 376.0075988769531 C 691.4580688476562 375.9023742675781 691.0628051757812 375.9579467773438 690.6730346679688 375.9503784179688 C 690.385498046875 375.9448852539062 690.385498046875 375.9494934082031 690.385498046875 376.2286376953125 C 690.3850708007812 376.4104919433594 690.39013671875 376.5927429199219 690.3829345703125 376.7745971679688 C 690.365234375 377.2241516113281 690.01416015625 377.5659790039062 689.576416015625 377.5659790039062 C 689.1386108398438 377.5659790039062 688.7863159179688 377.2241516113281 688.7703247070312 376.774169921875 C 688.7619018554688 376.5455932617188 688.764404296875 376.316162109375 688.76904296875 376.0871887207031 C 688.7711181640625 375.9916076660156 688.7584838867188 375.9461669921875 688.6414794921875 375.9465942382812 C 687.4956665039062 375.9515991210938 686.3502807617188 375.9508056640625 685.2044677734375 375.9469909667969 C 685.1004028320312 375.9465942382812 685.0831909179688 375.9848937988281 685.0852661132812 376.0754089355469 C 685.0907592773438 376.2976684570312 685.0907592773438 376.5203247070312 685.0861206054688 376.7425842285156 C 685.0756225585938 377.2182922363281 684.7232666015625 377.571044921875 684.2694702148438 377.5659790039062 C 683.82373046875 377.5613403320312 683.4815063476562 377.2119750976562 683.470458984375 376.7455444335938 C 683.4654541015625 376.530029296875 683.464599609375 376.3140563964844 683.4713745117188 376.0985107421875 C 683.4747314453125 375.994140625 683.4603881835938 375.9457397460938 683.3345336914062 375.9465942382812 C 682.2089233398438 375.9515991210938 681.0833129882812 375.9512329101562 679.9581298828125 375.9465942382812 C 679.8461303710938 375.9461669921875 679.8246459960938 375.9840393066406 679.8272094726562 376.084228515625 C 679.83349609375 376.3065185546875 679.83349609375 376.5291442871094 679.8280639648438 376.7514343261719 C 679.8157958984375 377.2170104980469 679.4697265625 377.5647277832031 679.0231323242188 377.5659790039062 C 678.5769653320312 377.5676574707031 678.2258911132812 377.2199401855469 678.2132568359375 376.7568969726562 C 678.2069702148438 376.5279235839844 678.2120361328125 376.2984924316406 678.2111206054688 376.0694885253906 C 678.2111206054688 376.0114135742188 678.2288208007812 375.9440612792969 678.128662109375 375.9486999511719 C 677.6727294921875 375.9714050292969 677.2101440429688 375.8880615234375 676.7618408203125 376.0210876464844 C 676.0567016601562 376.2311401367188 675.6222534179688 376.7960510253906 675.5848388671875 377.5369262695312 C 675.5818481445312 377.5908203125 675.5827026367188 377.6447143554688 675.5827026367188 377.6985473632812 C 675.5827026367188 381.823486328125 675.5831298828125 385.9483947753906 675.582275390625 390.0728759765625 C 675.582275390625 390.7733459472656 675.8651123046875 391.30712890625 676.49658203125 391.6354675292969 C 676.7340698242188 391.7587890625 676.992431640625 391.802978515625 677.2576904296875 391.802978515625 C 681.9622192382812 391.8038330078125 686.6663818359375 391.8051147460938 691.3709716796875 391.8021545410156 C 692.33154296875 391.8017272949219 692.98486328125 391.1652526855469 693.0547485351562 390.1827697753906 C 693.0833740234375 389.7782287597656 693.3038940429688 389.5003967285156 693.6714477539062 389.4048461914062 C 693.9955444335938 389.3206481933594 694.351318359375 389.458740234375 694.5369873046875 389.7386474609375 C 694.6939086914062 389.9743957519531 694.6854858398438 390.2366333007812 694.6577758789062 390.5001525878906 C 694.4843139648438 392.1473388671875 693.1582641601562 393.2654113769531 691.8407592773438 393.3858032226562 C 691.826416015625 393.3874816894531 691.814208984375 393.4093627929688 691.8007202148438 393.4215698242188 L 676.7554931640625 393.4215698242188 C 676.7091674804688 393.3424072265625 676.6233520507812 393.3718872070312 676.5576782226562 393.3567504882812 C 675.356689453125 393.0759582519531 674.5526733398438 392.3519287109375 674.1278686523438 391.1980895996094 C 674.0596923828125 391.012451171875 674.0579833984375 390.8087158203125 673.9650268554688 390.6306762695312 L 673.9650268554688 377.1222839355469 Z" fill="#010101" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_vdk89b =
    '<svg viewBox="674.0 390.6 2.8 2.8" ><path transform="translate(0.0, -24.64)" d="M 673.9603881835938 415.2749938964844 C 674.0533447265625 415.4530334472656 674.0549926757812 415.6567993164062 674.1232299804688 415.8424377441406 C 674.5479736328125 416.9962463378906 675.3519897460938 417.7203063964844 676.5530395507812 418.0010681152344 C 676.61865234375 418.0162048339844 676.7045288085938 417.9867553710938 676.7507934570312 418.0658874511719 C 675.8642578125 418.0658874511719 674.977783203125 418.0633544921875 674.0912475585938 418.06884765625 C 673.979248046875 418.0696716308594 673.9561157226562 418.0465393066406 673.9569091796875 417.9349670410156 C 673.9628295898438 417.0484619140625 673.9603881835938 416.1614990234375 673.9603881835938 415.2749938964844 Z" fill="#fbfbfb" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8utal1 =
    '<svg viewBox="678.2 380.4 1.6 1.6" ><path transform="translate(-5.85, -10.57)" d="M 684.864013671875 390.968994140625 C 685.3068237304688 390.9698486328125 685.67138671875 391.3352355957031 685.6709594726562 391.778076171875 C 685.6705932617188 392.2213439941406 685.3052368164062 392.5858764648438 684.8619384765625 392.5854797363281 C 684.4190673828125 392.5845947265625 684.0541381835938 392.21923828125 684.054931640625 391.7763671875 C 684.055419921875 391.3331298828125 684.4207763671875 390.9685668945312 684.864013671875 390.968994140625 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_vk85lu =
    '<svg viewBox="681.7 380.4 1.6 1.6" ><path transform="translate(-10.69, -10.57)" d="M 694.0299682617188 391.7843322753906 C 694.0261840820312 392.2272033691406 693.6583251953125 392.5888061523438 693.215087890625 392.5854187011719 C 692.7717895507812 392.5816345214844 692.41015625 392.2137451171875 692.4139404296875 391.7704467773438 C 692.4173583984375 391.3272094726562 692.7857055664062 390.9656066894531 693.22900390625 390.9689636230469 C 693.6718139648438 390.9727783203125 694.0338134765625 391.3410949707031 694.0299682617188 391.7843322753906 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ppkxbq =
    '<svg viewBox="685.2 380.4 1.6 1.6" ><path transform="translate(-15.53, -10.57)" d="M 700.77294921875 391.7657470703125 C 700.77880859375 391.3224792480469 701.1488037109375 390.9629821777344 701.592529296875 390.9688720703125 C 702.0352783203125 390.9752197265625 702.394775390625 391.34521484375 702.388916015625 391.7889099121094 C 702.382568359375 392.2317504882812 702.0125732421875 392.5912170410156 701.5693359375 392.5853271484375 C 701.12646484375 392.5790100097656 700.7666015625 392.2090148925781 700.77294921875 391.7657470703125 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_j1seoz =
    '<svg viewBox="688.8 380.4 1.6 1.6" ><path transform="translate(-20.37, -10.57)" d="M 710.7474365234375 391.7700500488281 C 710.751220703125 392.2133178710938 710.38916015625 392.5816345214844 709.9463500976562 392.5854187011719 C 709.5031127929688 392.5892028808594 709.134765625 392.2272033691406 709.1309814453125 391.7843322753906 C 709.127197265625 391.3410949707031 709.4891967773438 390.9727783203125 709.9320068359375 390.9689636230469 C 710.375244140625 390.9651794433594 710.74365234375 391.3272094726562 710.7474365234375 391.7700500488281 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_f2i7g =
    '<svg viewBox="678.2 383.9 1.6 1.6" ><path transform="translate(-5.85, -15.41)" d="M 685.6709594726562 400.1358032226562 C 685.67138671875 400.5786437988281 685.3064575195312 400.9440612792969 684.8635864257812 400.9444580078125 C 684.4203491210938 400.9444580078125 684.054931640625 400.5794982910156 684.054931640625 400.1366577148438 C 684.0545654296875 399.6933898925781 684.4194946289062 399.3284301757812 684.8623657226562 399.3280029296875 C 685.3056640625 399.3280029296875 685.6709594726562 399.6925354003906 685.6709594726562 400.1358032226562 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8tp5ca =
    '<svg viewBox="681.7 383.9 1.6 1.6" ><path transform="translate(-10.69, -15.41)" d="M 693.228515625 400.9443969726562 C 692.7848510742188 400.94775390625 692.4173583984375 400.5857543945312 692.4139404296875 400.1424560546875 C 692.4105834960938 399.69921875 692.7726440429688 399.3313293457031 693.2155151367188 399.3279418945312 C 693.6587524414062 399.3245849609375 694.0266723632812 399.6866149902344 694.0299682617188 400.1298522949219 C 694.0333862304688 400.5731201171875 693.67138671875 400.9406127929688 693.228515625 400.9443969726562 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_6zywzg =
    '<svg viewBox="685.2 383.9 1.6 1.6" ><path transform="translate(-15.53, -15.41)" d="M 702.3889770507812 400.1273193359375 C 702.3936157226562 400.570556640625 702.0328369140625 400.9393310546875 701.5900268554688 400.9443969726562 C 701.1463623046875 400.9490356445312 700.777587890625 400.5878295898438 700.77294921875 400.1449890136719 C 700.7678833007812 399.7017517089844 701.1290893554688 399.3330078125 701.5718994140625 399.3279418945312 C 702.0151977539062 399.3233032226562 702.3843383789062 399.68408203125 702.3889770507812 400.1273193359375 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_qxb6na =
    '<svg viewBox="688.8 383.9 1.6 1.6" ><path transform="translate(-20.37, -15.41)" d="M 709.9320068359375 399.3279418945312 C 710.375244140625 399.3241577148438 710.74365234375 399.6861877441406 710.7474365234375 400.1289978027344 C 710.751220703125 400.5722961425781 710.38916015625 400.940185546875 709.9463500976562 400.9439697265625 C 709.5031127929688 400.9481811523438 709.134765625 400.586181640625 709.1309814453125 400.1433410644531 C 709.127197265625 399.7000732421875 709.4891967773438 399.3317565917969 709.9320068359375 399.3279418945312 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_nxip23 =
    '<svg viewBox="678.2 387.4 1.6 1.6" ><path transform="translate(-5.85, -20.25)" d="M 685.6709594726562 408.4939575195312 C 685.67138671875 408.937255859375 685.3068237304688 409.3026123046875 684.864013671875 409.3030395507812 C 684.4207763671875 409.3038940429688 684.055419921875 408.9393310546875 684.054931640625 408.49609375 C 684.0545654296875 408.05322265625 684.4190673828125 407.6874389648438 684.8619384765625 407.68701171875 C 685.3052368164062 407.6865844726562 685.6705932617188 408.0511474609375 685.6709594726562 408.4939575195312 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8bgsau =
    '<svg viewBox="681.7 387.4 1.6 1.6" ><path transform="translate(-10.69, -20.25)" d="M 693.2210083007812 409.3030395507812 C 692.7777709960938 409.3026123046875 692.4132080078125 408.937255859375 692.4140014648438 408.4939575195312 C 692.4143676757812 408.0511474609375 692.77978515625 407.6865844726562 693.2230224609375 407.68701171875 C 693.6658935546875 407.6874389648438 694.0304565429688 408.05322265625 694.030029296875 408.49609375 C 694.0296630859375 408.9393310546875 693.663818359375 409.3038940429688 693.2210083007812 409.3030395507812 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_czsmi4 =
    '<svg viewBox="685.2 387.4 1.6 1.6" ><path transform="translate(-15.53, -20.25)" d="M 702.3889770507812 408.4906005859375 C 702.3915405273438 408.933837890625 702.0286254882812 409.3009033203125 701.5853881835938 409.3030395507812 C 701.1421508789062 409.3056030273438 700.775146484375 408.9426879882812 700.77294921875 408.4994506835938 C 700.7705078125 408.05615234375 701.13330078125 407.6895141601562 701.5765380859375 407.68701171875 C 702.0198364257812 407.6845092773438 702.3865356445312 408.0473022460938 702.3889770507812 408.4906005859375 Z" fill="#050505" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_72dorx =
    '<svg viewBox="670.1 366.4 21.1 28.5" ><path transform="translate(0.0, 0.0)" d="M 680.3672485351562 394.8797302246094 C 679.8482055664062 394.7288513183594 679.5120849609375 394.3684997558594 679.2236938476562 393.92919921875 C 676.9091186523438 390.4092407226562 674.5858764648438 386.8955688476562 672.265869140625 383.3787536621094 C 671.2645263671875 381.8606872558594 670.5437622070312 380.2285461425781 670.2100219726562 378.4298706054688 C 669.9301147460938 376.9180908203125 670.0529174804688 375.4320983886719 670.4765625 373.9703369140625 C 671.1050415039062 371.8019409179688 672.320556640625 370.0180969238281 674.09033203125 368.6157531738281 C 675.3995971679688 367.5776672363281 676.8754272460938 366.871826171875 678.5170288085938 366.5716552734375 C 682.158935546875 365.9064331054688 685.34814453125 366.856201171875 688.0051879882812 369.4302978515625 C 689.6810913085938 371.0530700683594 690.6644897460938 373.0651550292969 691.010009765625 375.3828430175781 C 691.3757934570312 377.8412475585938 690.7996826171875 380.1190795898438 689.5849609375 382.2242126464844 C 688.6406860351562 383.86181640625 687.5587768554688 385.4197387695312 686.5215454101562 387.0034484863281 C 685.006591796875 389.3164672851562 683.4736938476562 391.6177673339844 681.957275390625 393.9299621582031 C 681.6695556640625 394.3692932128906 681.3318481445312 394.7288513183594 680.8128051757812 394.8797302246094 L 680.3672485351562 394.8797302246094 Z M 680.593994140625 393.6986083984375 C 680.7080688476562 393.5422668457031 680.7932739257812 393.4343872070312 680.8683471679688 393.3202514648438 C 682.13623046875 391.399658203125 683.4088134765625 389.4829406738281 684.6689453125 387.5576782226562 C 685.94384765625 385.6089172363281 687.2351684570312 383.6703186035156 688.4647827148438 381.6934204101562 C 689.251953125 380.4278869628906 689.7155151367188 379.0169067382812 689.8389892578125 377.5278015136719 C 690.0430297851562 375.0631408691406 689.326171875 372.8470458984375 687.7346801757812 370.9725646972656 C 685.5303344726562 368.3773498535156 682.6889038085938 367.2861022949219 679.2994995117188 367.6980590820312 C 677.7986450195312 367.8801879882812 676.4346313476562 368.4453430175781 675.20654296875 369.3255310058594 C 673.548583984375 370.5152893066406 672.39013671875 372.0833435058594 671.754638671875 374.0211486816406 C 671.3489379882812 375.2593383789062 671.188720703125 376.53271484375 671.3707885742188 377.8365783691406 C 671.6170654296875 379.5985107421875 672.3111572265625 381.1853332519531 673.2788696289062 382.6580200195312 C 675.6278686523438 386.2334899902344 677.9885864257812 389.8003234863281 680.3453979492188 393.3695068359375 C 680.4102783203125 393.4679870605469 680.4876708984375 393.5578918457031 680.593994140625 393.6986083984375 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ge7t6l =
    '<svg viewBox="675.0 371.3 11.1 11.1" ><path transform="translate(-1.38, -1.38)" d="M 681.983642578125 383.8462524414062 C 678.9092407226562 383.8556213378906 676.4039916992188 381.3565673828125 676.4000854492188 378.2774963378906 C 676.3969116210938 375.2062377929688 678.9085083007812 372.6930847167969 681.9789428710938 372.697021484375 C 685.0408325195312 372.7001342773438 687.5391235351562 375.1953125 687.5484619140625 378.2579650878906 C 687.557861328125 381.33544921875 685.066650390625 383.837646484375 681.983642578125 383.8462524414062 Z M 682.0094604492188 373.9336547851562 C 679.6588745117188 373.8922424316406 677.6812133789062 375.8292541503906 677.6350708007812 378.2188720703125 C 677.5889892578125 380.5772399902344 679.5220947265625 382.5689697265625 681.8976440429688 382.6103820800781 C 684.2974243164062 382.6526184082031 686.2774658203125 380.7280883789062 686.314208984375 378.3165588378906 C 686.3509521484375 375.9457092285156 684.4170532226562 373.9766540527344 682.0094604492188 373.9336547851562 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
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
const String _svg_4if0cs =
    '<svg viewBox="21.7 62.7 7.3 15.6" ><path transform="translate(-12325.27, -534.96)" d="M 12353.3935546875 597.6110229492188 L 12346.94140625 605.6199951171875 L 12354.283203125 613.1842041015625" fill="none" stroke="#444444" stroke-width="2" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_h35zdt =
    '<svg viewBox="0.0 373.0 390.0 152.0" ><path transform="translate(0.0, 373.0)" d="M 56 0 L 330 0 C 363.1370849609375 0 390 26.8629150390625 390 60 L 390 152 L 0 152 L 0 56 C 0 25.07205200195312 25.07205200195312 0 56 0 Z" fill="#ffffff" stroke="none" stroke-width="5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
