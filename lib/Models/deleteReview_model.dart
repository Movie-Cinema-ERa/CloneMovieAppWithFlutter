// To parse this JSON data, do
//
//     final deleteReviewModel = deleteReviewModelFromJson(jsonString);

import 'dart:convert';

DeleteReviewModel deleteReviewModelFromJson(String str) =>
    DeleteReviewModel.fromJson(json.decode(str));

String deleteReviewModelToJson(DeleteReviewModel data) =>
    json.encode(data.toJson());

class DeleteReviewModel {
  DeleteReviewModel({
    this.status,
  });

  int? status;

  factory DeleteReviewModel.fromJson(Map<String, dynamic> json) =>
      DeleteReviewModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
