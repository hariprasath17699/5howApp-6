import 'dart:io';
import 'dart:math';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/ProfileScreen/widget/button_widget.dart';
import 'package:star_event/StarHomePage/StarHome.dart';

import '../IconButton.dart';
import '../ProgressButton.dart';

class EventCreation extends StatefulWidget {
  DateTime Date;
  EventCreation({required this.Date});

  @override
  _EventCreationState createState() => _EventCreationState(Date);
}

class _EventCreationState extends State<EventCreation> {
  DateTime date;
  _EventCreationState(this.date);
  @override
  void initState() {
    super.initState();
  }

  TextEditingController date1Ctl = TextEditingController();
  String formatDate(DateTime dt) {
    // final now = new DateTime.now();
    // final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('yyyy-MM-dd'); //"6:00 AM"
    return format.format(dt);
  }

  final LocalStorage storage = new LocalStorage('Star');
  final topicController = TextEditingController();
  final prerequisitesController = TextEditingController();
  final commentController = TextEditingController();
  final descriptionController = TextEditingController();
  final startdateController = TextEditingController();
  final starttimeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final typeController = TextEditingController();
  final durationController = TextEditingController();
  final priceController = TextEditingController(text: '.00');
  final participantcountController = TextEditingController();
  bool visible = false;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;
  String dropdownvalue = 'No of Participants';

  // List of items in our dropdown menu
  var items = [
    'No of Participants',
    'Limited',
    'Unlimited',
  ];
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
            text: "CREATE SESSION", color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.loading: IconedButton(
            text: "Loading", color: Color.fromRGBO(254, 118, 7, 10)),
        ButtonState.fail:
            IconedButton(text: "Failed", color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Color.fromRGBO(254, 118, 7, 10))
      },
      onPressed: onPressedIconWithMinWidthStateText,
      state: stateTextWithIconMinWidthState,
      minWidthStates: [ButtonState.loading, ButtonState.loading],
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

  ImageshowAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          stateTextWithIconMinWidthState = ButtonState.fail;
        });

        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Please Select Image"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  NoOfParticipantcountalert(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          stateTextWithIconMinWidthState = ButtonState.fail;
        });
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Please Select No of Participants"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 2), () async {
          if (dropdownvalue == 'No of Participants') {
            NoOfParticipantcountalert(context);
          } else if (_imageFile == null) {
            setState(() {
              stateTextWithIconMinWidthState = ButtonState.fail;
            });
            ImageshowAlertDialog(context);
          } else {
            uploadImage(_imageFile!.path, uploadUrl);
          }

          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.loading
                : ButtonState.loading;
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

  late String base64Image;

  late Future<PickedFile?> imagePicked;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final String uploadUrl =
      'http://5howapp.com/StarLoginAndRegister/Zoom/Zoom/index.php';
  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      _cropImage(pickedFile!.path);
      setState(() {
        _imageFile = pickedFile as File?;
        storage.setItem("_pickedFile", _imageFile);
      });
    } catch (e) {}
  }

  _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      setState(() {
        _imageFile = croppedImage;
      });
    }
  }

  Future<String?> uploadImage(filepath, url) async {
    if (participantcountController.text == "") {
      participantcountController.text = "100";
    }
    var Month = "${date.day} ${DateFormat.MMM().format(date)}";
    var formate = "${date.day}/${date.month}/${date.year}";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    request.fields['topic'] = topicController.text;
    request.fields['startdate'] = "${date.day}/${date.month}/${date.year}";
    request.fields['duration'] = durationController.text;
    request.fields['password'] = passwordController.text;
    request.fields['email'] = storage.getItem("email");
    request.fields['starname'] = storage.getItem("username");
    request.fields['starttime'] = starttimeController.text;
    request.fields['price'] = priceController.text;
    request.fields['participanttype'] = dropdownvalue;
    request.fields['participantcount'] = "0";
    request.fields['profileimage'] = storage.getItem("profileimage").toString();
    request.fields['description'] = descriptionController.text;
    request.fields['prerequisites'] = prerequisitesController.text;
    request.fields['totalparticipantcount'] = participantcountController.text;
    request.fields['status'] = "Active";
    request.fields['Month'] = Month;
    request.fields['startday'] = "${date.day}";
    request.fields['startmonth'] = "${date.month}";
    request.fields['startyear'] = "${date.year}";
    var res = await request.send();
    print(res.reasonPhrase);
    if (res.reasonPhrase != null) {
      if (res.reasonPhrase != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 2,
              title: new Text(
                "Session Created",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StarHomepage(0)));
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 2,
              title: new Text(
                "Session Creation Failed",
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

      return res.reasonPhrase;
    }
  }

  Future EventCreate() async {
    setState(() {
      visible = true;
    });

    String Topic = topicController.text;
    String startdate = startdateController.text;
    String password = passwordController.text;
    String email = emailController.text;
    String duration = durationController.text;
    String type = typeController.text;
    String time = starttimeController.text;
    List err = [];

    // https://stackoverflow.com/questions/50278258/http-post-with-json-on-body-flutter-dart
    if (err.length > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Invalid Field(s)!"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            content: new Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: err.map((e) {
                    return Column(children: [
                      Text(e, style: TextStyle(color: Colors.red)),
                      SizedBox(height: 10),
                    ]);
                  }).toList(),
                )),
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
    } else {
      // var url = 'http://192.168.29.103/StarLoginAndRegister/userRegister.php';
      var url = Uri.parse(
          "http://5howapp.com/StarLoginAndRegister/Zoom/Zoom/index.php");
      // data = {
      //    'fullName': fullName,
      //    'username': username,
      //    'password': password,
      //    'email': email,
      //    'mobile': phoneNumber,
      //  };
      //encode Map to JSON
      var formate = "${date.month}/${date.day}/${date.year}";

      var response = await http.post(url, body: {
        'topic': topicController.text,
        'password': passwordController.text,
        'startdate': formate,
        'duration': duration,
        'email': storage.getItem("email"),
        'starname': storage.getItem("username"),
        'image': imagePicked
      });

      print("ERROR : " + response.body);
      print(response.statusCode);
      print(response.body);
      print("${response.statusCode}");
      print("${response.body}");
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
                "Session Created",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StarHomepage(0)));
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(" Error : " + response.body),
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
      return null;
    }

    return false;
    // Showing Alert Dialog with Response JSON.
  }

  bool _isVisible = true;
  TimeOfDay selectedTime = TimeOfDay.now();

  Widget _previewImage() {
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 300,
                    child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(20.5),
                        child: Image.file(File(_imageFile!.path))),
                  )),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: const Text(
          'You have not yet picked an image.',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Widget _Participantcount() {
    if (dropdownvalue == "Limited") {
      return Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Container(
          height: 70.0,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: participantcountController,
            decoration: InputDecoration(
                labelText: "   PARTICIPANT COUNT",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                        style: BorderStyle.solid))),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Container(
          height: 70.0,
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
                labelText: "   PARTICIPANT COUNT",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                        style: BorderStyle.solid))),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        leadingWidth: 30,
        title: Container(
          child: Text(
            "Create Session",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w800,
              height: 1.0714285714285714,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: ButtonWidget(
                    text: '      Upload Image       ',
                    color: Color.fromRGBO(60, 34, 95, 10),
                    onClicked: () {
                      _pickImage();
                    },
                  ),
                ),
              ),
              _previewImage(),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  height: 70.0,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: topicController,
                    decoration: InputDecoration(
                        labelText: "   TOPIC",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  child: TextField(
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    controller: prerequisitesController,
                    decoration: InputDecoration(
                        labelText: "   PREREQUISITES",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  child: TextField(
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: "   DESCRIPTION",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(date),
                      initialEntryMode: TimePickerEntryMode.dial,
                      hourLabelText: "12");
                  if (timeOfDay != null && timeOfDay != selectedTime) {
                    setState(() {
                      selectedTime = timeOfDay;
                      starttimeController.text =
                          "${selectedTime.hour}:${selectedTime.minute}";
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    height: 70.0,
                    child: TextField(
                      enabled: false,
                      onTap: () async {
                        final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(date),
                            initialEntryMode: TimePickerEntryMode.dial,
                            hourLabelText: "12");
                        if (timeOfDay != null && timeOfDay != selectedTime) {
                          setState(() {
                            selectedTime = timeOfDay;
                            starttimeController.text =
                                "${selectedTime.hour}:${selectedTime.minute}";
                          });
                        }
                      },
                      controller: starttimeController,
                      decoration: InputDecoration(
                          labelText: "   STARTTIME",
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
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var resultingDuration = await showDurationPicker(
                    context: context,
                    initialTime: Duration(minutes: 0),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Chose duration: $resultingDuration')));

                  setState(() {
                    durationController.text =
                        resultingDuration!.inMinutes.toString();
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Container(
                      height: 70.0,
                      child: TextFormField(
                        enabled: false,
                        controller: durationController,
                        keyboardType: TextInputType.numberWithOptions(),
                        keyboardAppearance: null,
                        decoration: InputDecoration(
                            labelText: "   DURATION IN Min",
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
                        onTap: () async {
                          var resultingDuration = await showDurationPicker(
                            context: context,
                            initialTime: Duration(minutes: 0),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Chose duration: $resultingDuration')));

                          setState(() {
                            durationController.text =
                                resultingDuration!.inMinutes.toString();
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'cant be empty';
                          }
                          return null;
                        },
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  height: 70.0,
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "   PASSWORD",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  height: 70.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    decoration: InputDecoration(
                        labelText: "   PRICE",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Container(
                  height: 60,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    dropdownColor: Colors.white,
                    value: dropdownvalue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _isVisible = !_isVisible;
                        dropdownvalue = newValue!;
                      });
                    },
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),

                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items

                    // After selecting the desired option,it will
                    // change button value to selected value
                  ),
                ),
              ),
              _Participantcount(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 100, right: 110, bottom: 20),
                child: Center(
                  child: Container(
                    height: 45,
                    child: buildTextWithIconWithMinState(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const String _svg_c7q0zw =
    '<svg viewBox="36.8 91.9 316.6 45.9" ><path transform="translate(36.77, 91.89)" d="M 22.93271827697754 0 L 293.6286926269531 0 C 306.2940979003906 0 316.5614013671875 10.26732730865479 316.5614013671875 22.93271827697754 C 316.5614013671875 35.59811019897461 306.2940979003906 45.86543655395508 293.6286926269531 45.86543655395508 L 22.93271827697754 45.86543655395508 C 10.26732730865479 45.86543655395508 0 35.59811019897461 0 22.93271827697754 C 0 10.26732730865479 10.26732730865479 0 22.93271827697754 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_1o8lha =
    '<svg viewBox="39.5 347.3 310.5 50.4" ><path transform="translate(39.5, 347.28)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_mqj17e =
    '<svg viewBox="39.5 272.1 310.5 50.4" ><path transform="translate(39.5, 272.1)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#3c225f" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_lpizlm =
    '<svg viewBox="39.5 198.5 310.5 50.4" ><path transform="translate(39.5, 198.48)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_1qk1q7 =
    '<svg viewBox="39.5 496.6 310.5 50.4" ><path transform="translate(39.5, 496.55)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ulafk4 =
    '<svg viewBox="39.5 422.5 310.5 50.4" ><path transform="translate(39.5, 422.46)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_s0gbse =
    '<svg viewBox="111.3 289.0 1.0 18.0" ><path transform="translate(111.33, 289.01)" d="M 0 0 L 0 17.98464775085449" fill="none" stroke="#212121" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_rs2iqc =
    '<svg viewBox="85.0 570.0 14.0 14.0" ><path transform="translate(85.0, 570.0)" d="M 0 0 L 14 0 L 14 14 L 0 14 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_9g7ksu =
    '<svg viewBox="87.8 573.2 8.3 6.7" ><path transform="translate(-57.5, 414.5)" d="M 145.3333282470703 162.3333282470703 L 148 165.3333282470703 L 153.6666717529297 158.6666717529297" fill="none" stroke="#ed9649" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
