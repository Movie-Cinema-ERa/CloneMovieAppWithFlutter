import 'dart:io';
import 'package:flutter_project/Models/Favourite_add_model.dart';
import 'package:flutter_project/Models/Login_model.dart';
import 'package:flutter_project/Models/favorite_movie_list_model.dart';
import 'package:flutter_project/Models/movies_model.dart';
import 'package:flutter_project/Models/signUp_model.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:http/http.dart' as http;

class ServicesApi {
  //Api of Login account
  static Future<LoginModel?> loginModel(
      {String? email, String? password}) async {
    try {
      Map<String, dynamic> data = {
        "emailAddress": email,
        "Password": password,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.login);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return loginModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

//Api of signup account
  static Future<SignUpModel?> signUp(
      {String? fullName, String? email, String? password}) async {
    try {
      Map<String, dynamic> data = {
        "fullName": fullName,
        "emailAddress": email,
        "Password": password,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.signup);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return signUpModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Api of movies
  static Future<MoviesModel?> movies() async {
    try {
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.movies);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return moviesModelFromJson(response.body);
      } else {
        return MoviesModel();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Api of add to favorite
  static Future<FavouriteModel?> favoriteModel(
      {String? favoriteToken, String? moviesId, String? userId}) async {
    try {
      Map<String, dynamic> data = {
        "otoken": favoriteToken,
        "pid": moviesId,
        "uid": userId,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.favoriteAdd);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return favouriteModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Api for list of favorite movies
  static Future<FavouriteListModel?> favoriteListModel(
      {String? favoriteToken, String? userId}) async {
    try {
      Map<String, dynamic> data = {
        "otoken": favoriteToken,
        "uid": userId,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.favoriteList);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return favouriteListModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

//Api remove favorite
  static Future<dynamic> favoriteRemove(
      {String? id, String? favoriteToken, String? userId}) async {
    try {
      Map<String, dynamic> data = {
        "id": id,
        "otoken": favoriteToken,
        "uid": userId,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.favoriteRemove);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
