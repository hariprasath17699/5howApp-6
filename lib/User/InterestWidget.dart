import 'package:flutter/material.dart';

class InterestWidget extends StatefulWidget {
  String interest;
  InterestWidget({Key? key, required this.interest}) : super(key: key);

  @override
  State<InterestWidget> createState() => _InterestWidgetState(interest);
}

class _InterestWidgetState extends State<InterestWidget> {
  String interest;
  _InterestWidgetState(this.interest);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 244, 244, 10),
            ),
            child: Stack(
              children: [
                Container(
                  child: Container(
                    height: 10,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21.5),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 3),
                  child: Container(
                    child: Text(
                      interest.toString(),
                      style: TextStyle(
                        fontFamily: 'Poppinsregular',
                        fontSize: 6,
                        color: const Color(0xff000000),
                        height: 2.1666666666666665,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 10),
              ),
              child: Stack(
                children: [
                  Container(
                    child: Container(
                      height: 13,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 3),
                    child: Container(
                      child: Text(
                        interest.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppinsregular',
                          fontSize: 6,
                          color: const Color(0xff000000),
                          height: 2.1666666666666665,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 10),
              ),
              child: Stack(
                children: [
                  Container(
                    child: Container(
                      height: 13,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 3),
                    child: Container(
                      child: Text(
                        interest.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppinsregular',
                          fontSize: 6,
                          color: const Color(0xff000000),
                          height: 2.1666666666666665,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
