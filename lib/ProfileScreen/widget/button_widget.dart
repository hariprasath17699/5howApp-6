import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.grey,
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 13),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}
