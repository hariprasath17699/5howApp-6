import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SearchBarAdmin extends StatelessWidget {
  String name;
  String image;
  SearchBarAdmin({required this.name, required this.image});
  final LocalStorage storage = new LocalStorage('Star');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 21,
                ),
                child: Text(
                  "Hello,${name}",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 240,
                ),
                child: Text(
                  "User Request",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
