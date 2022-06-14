import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:star_event/HomeScreen/Json/Starmodel.dart';

// ignore: camel_case_types
class API_Manager {
  final LocalStorage storage = new LocalStorage('Star');

  API_Manager();

  late Future<StarModel> star;

  Future<List> getData() async {
    final LocalStorage storage = new LocalStorage('Star');
    var client = http.Client();
    // final url = "http://192.168.29.103/StarLoginAndRegister/getStars.php";
    var url = Uri.parse("http://5howapp.com/StarLoginAndRegister/getStars.php");
    print(storage.getItem("Interest"));
    var response = await client.post(url, body: {
      "interest": "Football",
    });
    print(storage.getItem('interest'));
    print(response.body);
    print(response.statusCode);
    var dataRecieved = json.decode(response.body);
    print(response);
    print("dataRecieved:${dataRecieved}");

    return dataRecieved;
  }
}
