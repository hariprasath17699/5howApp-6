import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Profilepage extends StatefulWidget {
  String dob;
  String email;
  String password;
  String email1;
  String username;
  Profilepage(
      {required this.dob,
      required this.email,
      required this.email1,
      required this.password,
      required this.username});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ProfilepageState createState() =>
      _ProfilepageState(email, email1, password, dob, username);
}

class _ProfilepageState extends State<Profilepage> {
  late File _file;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  String email;
  String email1;
  String password;
  String dob;
  String username;
  _ProfilepageState(
      this.dob, this.password, this.email, this.email1, this.username);

  Future getFile() async {
    File file = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)) as File;

    setState(() {
      _file = file;
    });
  }

  void _uploadFile(filePath) async {
    String fileName = basename(filePath.path);
    print("file base name:$fileName");

    try {
      FormData formData = new FormData.fromMap({
        'email': email,
        'password': password,
        'dob': dob,
        'username': username,
        'email1': email1,
        'image':
            await MultipartFile.fromFile(filePath.path, filename: fileName),
      });

      Response response = await Dio().post(
          "https://sldevzone.000webhostapp.com/uploads.php",
          data: formData);
      print("File upload response: $response");
      _showSnackBarMsg(response.data['message']);
    } catch (e) {
      print("expectation Caugch: $e");
    }
  }

  void _showSnackBarMsg(String msg) {
    _scaffoldstate.currentState!.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldstate,

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text("upload"),
                onPressed: () {
                  _uploadFile(_file);
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getFile,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
