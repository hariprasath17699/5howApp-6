import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/HomeScreen/HomeScreenProfileWidget.dart';
import 'package:star_event/Responsive/IconButton.dart';
import 'package:star_event/Responsive/ProgressButton.dart';
import 'package:star_event/User/Filter/UserFilter.dart';
import 'package:star_event/User/HomePage/Homepage.dart';
import 'package:star_event/User/Notification/UserNotification.dart';
import 'package:star_event/User/Search/Search.dart';

class SearchBar extends StatefulWidget {
  String name;
  String image;

  SearchBar({required this.name, required this.image});

  @override
  _SearchBarState createState() => _SearchBarState(name, image);
}

class _SearchBarState extends State<SearchBar> {
  String name;
  String image;

  _SearchBarState(this.name, this.image);

  final LocalStorage storage = new LocalStorage('Star');
  final searchController = TextEditingController();
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

  @override
  void initState() {
    super.initState();
  }

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
            text: "Apply Filter", color: Color.fromRGBO(254, 118, 7, 10)),
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

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 5), () async {
          if (isChecked1 == false) {
            storage.setItem("filter1", "");
          }
          if (isChecked2 == false) {
            storage.setItem("filter2", "");
          }
          if (isChecked3 == false) {
            storage.setItem("filter3", "");
          }
          if (isChecked4 == false) {
            storage.setItem("filter4", "");
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserFilter()));
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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  Widget buildPopupDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: StatefulBuilder(builder: (context, setState) {
        return Container(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 78,
              leading: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(
                        fontFamily: 'Poppinssemibold',
                        fontSize: 18,
                        color: const Color(0xff000000),
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "assets/images/decline.svg",
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Opacity(
                            opacity: 0.5,
                            child: Checkbox(
                              checkColor: Colors.red,
                              activeColor: Colors.white,
                              value: isChecked1,
                              onChanged: (bool? value) {
                                setState(() {
                                  storage.setItem("filter1", "sports");
                                  isChecked1 = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          "Sports",
                          style: TextStyle(
                              fontSize: 15, fontFamily: "Poppinsregular"),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 350,
                        child: Divider(
                          height: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Opacity(
                            opacity: 0.5,
                            child: Checkbox(
                              checkColor: Colors.red,
                              activeColor: Colors.white,
                              value: isChecked2,
                              onChanged: (bool? value) {
                                setState(() {
                                  storage.setItem("filter2", "music");
                                  isChecked2 = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          "Music",
                          style: TextStyle(
                              fontSize: 15, fontFamily: "Poppinsregular"),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 350,
                        child: Divider(
                          height: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Opacity(
                            opacity: 0.5,
                            child: Checkbox(
                              checkColor: Colors.red,
                              activeColor: Colors.white,
                              value: isChecked3,
                              onChanged: (bool? value) {
                                setState(() {
                                  storage.setItem("filter3", "star");
                                  isChecked3 = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          "Star",
                          style: TextStyle(
                              fontSize: 15, fontFamily: "Poppinsregular"),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 350,
                        child: Divider(
                          height: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Opacity(
                            opacity: 0.5,
                            child: Checkbox(
                              checkColor: Colors.red,
                              activeColor: Colors.white,
                              value: isChecked4,
                              onChanged: (bool? value) {
                                setState(() {
                                  storage.setItem("filter4", "youtuber");
                                  isChecked4 = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          "Youtuber",
                          style: TextStyle(
                              fontSize: 15, fontFamily: "Poppinsregular"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 220),
                      child: Center(
                        child: Container(
                            height: 43, child: buildTextWithIconWithMinState()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 0, top: 20, bottom: 0),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 300, top: 20),
                              child: new SvgPicture.asset(
                                "assets/images/sidenav.svg",
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: HomeScreenProfileWidget(
                                imagePath: image,
                                onClicked: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homepage(3)));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    fontFamily: 'Poppinslight',
                                    fontSize: 11,
                                    color: Colors.black),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText('Hello, ${name}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserNotification()));
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 0, right: 20, top: 40),
                          child: new SvgPicture.asset(
                            "assets/images/wnotification.svg",
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Stack(
                    children: [
                      Container(
                        height: 45,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29.5),
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(195, 199, 201, 8)),
                            left: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(195, 199, 201, 8)),
                            right: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(195, 199, 201, 8)),
                            bottom: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(195, 199, 201, 8)),
                          ),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search Session',
                              hintStyle: TextStyle(
                                  fontFamily: 'Poppinsregular',
                                  color: Color.fromRGBO(160, 160, 160, 8),
                                  fontSize: 13),
                              hoverColor: Colors.black,
                              fillColor: Colors.black,
                              focusColor: Colors.black,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: FractionallySizedBox(
                                  widthFactor: 0.2,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Search(
                                                  search:
                                                      searchController.text)));
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            buildPopupDialog(context),
                      );
                    },
                    child: new SvgPicture.asset(
                      "assets/images/filter.svg",
                      allowDrawingOutsideViewBox: true,
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
