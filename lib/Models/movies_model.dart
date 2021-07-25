// To parse this JSON data, do
//
//     final moviesModel = moviesModelFromJson(jsonString);

import 'dart:convert';

MoviesModel moviesModelFromJson(String str) =>
    MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  MoviesModel({
    this.sliderMovies,
    this.actionMovies,
    this.loveStories,
    this.horrorMovies,
  });

  List<ActionMovie>? sliderMovies;
  List<ActionMovie>? actionMovies;
  List<ActionMovie>? loveStories;
  List<ActionMovie>? horrorMovies;

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        sliderMovies: List<ActionMovie>.from(
            json["Slider_movies"].map((x) => ActionMovie.fromJson(x))),
        actionMovies: List<ActionMovie>.from(
            json["Action_movies"].map((x) => ActionMovie.fromJson(x))),
        loveStories: List<ActionMovie>.from(
            json["Love_stories"].map((x) => ActionMovie.fromJson(x))),
        horrorMovies: List<ActionMovie>.from(
            json["Horror_movies"].map((x) => ActionMovie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Slider_movies":
            List<dynamic>.from(sliderMovies!.map((x) => x.toJson())),
        "Action_movies":
            List<dynamic>.from(actionMovies!.map((x) => x.toJson())),
        "Love_stories": List<dynamic>.from(loveStories!.map((x) => x.toJson())),
        "Horror_movies":
            List<dynamic>.from(horrorMovies!.map((x) => x.toJson())),
      };
}

class ActionMovie {
  ActionMovie({
    this.id,
    this.filmName,
    this.price,
    this.filmImage,
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
  String? filmName;
  String? price;
  String? filmImage;
  String? trailerVideos;
  String? fullMovies;
  String? cast;
  String? director;
  DateTime? releaseDate;
  String? runTime;
  Language? language;
  String? overview;

  factory ActionMovie.fromJson(Map<String, dynamic> json) => ActionMovie(
        id: json["id"],
        filmName: json["film name"],
        price: json["Price"],
        filmImage: json["film image"],
        trailerVideos: json["trailer videos"],
        fullMovies: json["Full_movies"],
        cast: json["Cast"],
        director: json["Director"],
        releaseDate: DateTime.parse(json["Release_date"]),
        runTime: json["Run_time"],
        language: languageValues.map[json["Language"]],
        overview: json["Overview"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "film name": filmName,
        "Price": price,
        "film image": filmImage,
        "trailer videos": trailerVideos,
        "Full_movies": fullMovies,
        "Cast": cast,
        "Director": director,
        "Release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "Run_time": runTime,
        "Language": languageValues.reverse[language],
        "Overview": overview,
      };
}

enum Language { ENGLISH, NEPALI }

final languageValues =
    EnumValues({"English": Language.ENGLISH, "Nepali": Language.NEPALI});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
