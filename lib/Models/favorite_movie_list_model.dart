// To parse this JSON data, do
//
//     final FavouriteListModel = FavouriteListModelFromJson(jsonString);

import 'dart:convert';

FavouriteListModel favouriteListModelFromJson(String str) =>
    FavouriteListModel.fromJson(json.decode(str));

String favouriteListModelToJson(FavouriteListModel data) =>
    json.encode(data.toJson());

class FavouriteListModel {
  FavouriteListModel({
    this.status,
    this.content,
  });

  int? status;
  List<Content>? content;

  factory FavouriteListModel.fromJson(Map<String, dynamic> json) =>
      FavouriteListModel(
        status: json["status"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.id,
    this.uid,
    this.token,
    this.moviesId,
    this.aName,
    this.price,
    this.aPoster,
    this.trailerVideos,
    this.fullMovies,
    this.cast,
    this.director,
    this.releaseDate,
    this.runTime,
    this.language,
    this.overview,
  });

  int? id;
  String? uid;
  String? token;
  int? moviesId;
  String? aName;
  String? price;
  String? aPoster;
  String? trailerVideos;
  String? fullMovies;
  String? cast;
  String? director;
  DateTime? releaseDate;
  String? runTime;
  String? language;
  String? overview;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        uid: json["uid"],
        token: json["token"],
        moviesId: json["movies_id"],
        aName: json["A_name"],
        price: json["Price"],
        aPoster: json["A_poster"],
        trailerVideos: json["Trailer_videos"],
        fullMovies: json["Full_movies"],
        cast: json["Cast"],
        director: json["Director"],
        releaseDate: DateTime.parse(json["Release_date"]),
        runTime: json["Run_time"],
        language: json["Language"],
        overview: json["Overview"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "token": token,
        "movies_id": moviesId,
        "A_name": aName,
        "Price": price,
        "A_poster": aPoster,
        "Trailer_videos": trailerVideos,
        "Full_movies": fullMovies,
        "Cast": cast,
        "Director": director,
        "Release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "Run_time": runTime,
        "Language": language,
        "Overview": overview,
      };
}
