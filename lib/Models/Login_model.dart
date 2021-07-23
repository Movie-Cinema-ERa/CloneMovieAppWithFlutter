// To parse this JSON data, do
//
//     final LoginModel = LoginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.id,
    this.emailAddress,
    this.fullName,
    this.favouriteToken,
    this.session,
  });

  int? status;
  int? id;
  String? emailAddress;
  String? fullName;
  String? favouriteToken;
  String? session;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        id: json["id"],
        emailAddress: json["emailAddress"],
        fullName: json["fullName"],
        favouriteToken: json["Favourite_token"],
        session: json["session"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "emailAddress": emailAddress,
        "fullName": fullName,
        "Favourite_token": favouriteToken,
        "session": session,
      };
}
