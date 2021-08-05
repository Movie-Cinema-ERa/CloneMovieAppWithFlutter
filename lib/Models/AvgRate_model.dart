// To parse this JSON data, do
//
//     final avgRateModel = avgRateModelFromJson(jsonString);

import 'dart:convert';

AvgRateModel avgRateModelFromJson(String str) =>
    AvgRateModel.fromJson(json.decode(str));

String avgRateModelToJson(AvgRateModel data) => json.encode(data.toJson());

class AvgRateModel {
  AvgRateModel({
    this.content,
  });

  List<Content>? content;

  factory AvgRateModel.fromJson(Map<String, dynamic> json) => AvgRateModel(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.ratingAvg,
  });

  double? ratingAvg;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        ratingAvg: json["RatingAvg"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "RatingAvg": ratingAvg,
      };
}
