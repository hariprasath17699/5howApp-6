import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/HomeScreen/HomeScreenProfileWidget.dart';

class AppBarAdmin extends StatelessWidget {
  String name;
  String image;
  AppBarAdmin({required this.name, required this.image});
  final LocalStorage storage = new LocalStorage('Star');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 5),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: HomeScreenProfileWidget(
                  imagePath: image,
                  onClicked: () async {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => UserProfilePage()));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
