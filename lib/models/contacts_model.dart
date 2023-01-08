// To parse this JSON data, do
//
//     final contactsModel = contactsModelFromJson(jsonString);

import 'dart:convert';

List<ContactsModel?>? contactsModelFromJson(String str) => json.decode(str) == null ? [] : List<ContactsModel?>.from(json.decode(str)!.map((x) => ContactsModel.fromJson(x)));

String contactsModelToJson(List<ContactsModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class ContactsModel {
  ContactsModel({
    this.type,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.user,
    this.createdAt,
    this.v,
  });

  String? type;
  String? id;
  String? name;
  String? email;
  String? phone;
  String? user;
  DateTime? createdAt;
  int? v;

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
    type: json["type"],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    user: json["user"],
    createdAt: DateTime.parse(json["created_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "user": user,
    "created_at": createdAt?.toIso8601String(),
    "__v": v,
  };
}
