// To parse this JSON data, do
//
//     final khaltiCheckModel = khaltiCheckModelFromJson(jsonString);

import 'dart:convert';

KhaltiCheckModel khaltiCheckModelFromJson(String str) =>
    KhaltiCheckModel.fromJson(json.decode(str));

String khaltiCheckModelToJson(KhaltiCheckModel data) =>
    json.encode(data.toJson());

class KhaltiCheckModel {
  KhaltiCheckModel({
    this.status,
    this.content,
  });

  int? status;
  String? content;

  factory KhaltiCheckModel.fromJson(Map<String, dynamic> json) =>
      KhaltiCheckModel(
        status: json["status"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "content": content,
      };
}
