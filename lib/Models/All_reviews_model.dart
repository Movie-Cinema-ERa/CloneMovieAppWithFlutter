// To parse this JSON data, do
//
//     final ReviewListModel = ReviewListModelFromJson(jsonString);

import 'dart:convert';

ReviewListModel reviewListModelFromJson(String str) =>
    ReviewListModel.fromJson(json.decode(str));

String reviewListModelToJson(ReviewListModel data) =>
    json.encode(data.toJson());

class ReviewListModel {
  ReviewListModel({
    this.content,
  });

  List<Content>? content;

  factory ReviewListModel.fromJson(Map<String, dynamic> json) =>
      ReviewListModel(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.reviewId,
    this.id,
    this.reviews,
    this.ratedValue,
    this.fullName,
  });

  int? reviewId;
  int? id;
  String? reviews;
  double? ratedValue;
  String? fullName;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        reviewId: json["ReviewId"],
        id: json["id"],
        reviews: json["reviews"],
        ratedValue: json["RatedValue"].toDouble(),
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "ReviewId": reviewId,
        "id": id,
        "reviews": reviews,
        "RatedValue": ratedValue,
        "fullName": fullName,
      };
}
