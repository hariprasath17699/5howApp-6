// To parse this JSON data, do
//
//     final username = usernameFromJson(jsonString);

import 'dart:convert';

Username usernameFromJson(String str) => Username.fromJson(json.decode(str));

String usernameToJson(Username data) => json.encode(data.toJson());

class Username {
  Username({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory Username.fromJson(Map<String, dynamic> json) => Username(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.fullname,
    required this.username,
    required this.password,
    required this.email,
    required this.interest,
    required this.country,
    required this.dob,
    required this.image,
    required this.createdAt,
    required this.status,
  });

  String userId;
  String fullname;
  String username;
  String password;
  String email;
  String interest;
  String country;
  String dob;
  String image;
  DateTime createdAt;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        fullname: json["fullname"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        interest: json["interest"],
        country: json["country"],
        dob: json["dob"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullname": fullname,
        "username": username,
        "password": password,
        "email": email,
        "interest": interest,
        "country": country,
        "dob": dob,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "Status": status,
      };
}
