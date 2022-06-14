// To parse this JSON data, do
//
//     final starModel = starModelFromJson(jsonString);

import 'dart:convert';

List<StarModel> starModelFromJson(String str) =>
    List<StarModel>.from(json.decode(str).map((x) => StarModel.fromJson(x)));

String starModelToJson(List<StarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StarModel {
  StarModel({
    required this.id,
    required this.name,
    required this.country,
    required this.email,
    required this.interest,
    required this.number,
    required this.image,
  });

  String id;
  String name;
  String country;
  String email;
  String interest;
  String number;
  String image;

  factory StarModel.fromJson(Map<String, dynamic> json) => StarModel(
        id: json["ID"],
        name: json["Name"],
        country: json["Country"],
        email: json["Email"],
        interest: json["Interest"],
        number: json["number"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Country": country,
        "Email": email,
        "Interest": interest,
        "number": number,
        "Image": image,
      };
}
