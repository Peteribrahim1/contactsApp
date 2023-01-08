// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel? loginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String loginModelToJson(UserLoginModel? data) => json.encode(data!.toJson());

class UserLoginModel {
  UserLoginModel({
    this.msg,
    this.token,
    this.user,
  });

  String? msg;
  String? token;
  User? user;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    msg: json["msg"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "token": token,
    "user": user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.v,
  });

  String? id;
  String? name;
  String? email;
  String? password;
  DateTime? createdAt;
  int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    createdAt: DateTime.parse(json["created_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "created_at": createdAt?.toIso8601String(),
    "__v": v,
  };
}
