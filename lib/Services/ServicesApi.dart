import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project/Models/All_reviews_model.dart';
import 'package:flutter_project/Models/AvgRate_model.dart';
import 'package:flutter_project/Models/Favourite_add_model.dart';
import 'package:flutter_project/Models/Login_model.dart';
import 'package:flutter_project/Models/deleteReview_model.dart';
import 'package:flutter_project/Models/favorite_movie_list_model.dart';
import 'package:flutter_project/Models/khalti_check_payment_model.dart';
import 'package:flutter_project/Models/movies_model.dart';
import 'package:flutter_project/Models/purchased_movies_model.dart';
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

  //Add reviews
  static Future<dynamic> reviewAdd(
      {String? userId,
      String? moviesId,
      String? token,
      String? reviews,
      String? ratedValue}) async {
    try {
      Map<String, dynamic> data = {
        "uid": userId,
        "pid": moviesId,
        "otoken": token,
        "reviews": reviews,
        "ratedValue": ratedValue,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.addReview);
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

  //Review List
  static Future<ReviewListModel?> reviewList({String? moviesId}) async {
    try {
      Map<String, dynamic> data = {
        "Movies_id": moviesId,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.reviewList);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return reviewListModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Average ratings
  static Future<AvgRateModel?> avgRate({String? moviesId}) async {
    try {
      Map<String, dynamic> data = {
        "Movies_id": moviesId,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.avgRate);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return avgRateModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Api delete Review
  static Future<DeleteReviewModel?> reviewRemove(
      {String? id, String? userId, String? favoriteToken}) async {
    try {
      Map<String, dynamic> data = {
        "id": id,
        "uid": userId,
        "otoken": favoriteToken,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.deleteReview);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return deleteReviewModelFromJson(response.body);
      } else {
        return DeleteReviewModel();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Api check Movies khalti Payment
  static Future<KhaltiCheckModel?> checkPayment(
      {String? moviesId, String? userId, String? favoriteToken}) async {
    try {
      Map<String, dynamic> data = {
        "uid": userId,
        "pid": moviesId,
        "otoken": favoriteToken,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.checkoutKhaltiPay);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return khaltiCheckModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Api check Movies khalti Payment
  static Future<dynamic> khaltiVerification(
      {String? khaltiToken, double? amount}) async {
    var testSecretKey = dotenv.env['Test_Secret_key'];

    try {
      Map<dynamic, dynamic> payload = {"token": khaltiToken, "amount": amount};

      var url = Uri.parse(ApiClients.verifyKhalti);
      var response = await http.post(
        url,
        body: json.encode(payload),
        headers: {
          'Content-type': 'application/json',
          "Authorization": testSecretKey.toString()
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

  //Api add khalti transaction to database
  static Future<dynamic> addKhaltiTransaction(
      {String? userId,
      String? moviesId,
      String? favoriteToken,
      String? khaltiTransaction}) async {
    try {
      Map<String, dynamic> data = {
        "uid": userId,
        "pid": moviesId,
        "otoken": favoriteToken,
        "transaction": khaltiTransaction,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.addPaymentToDatabase);
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

//Api purchased movies
  static Future<PurchasedMoviesModel?> purchasedMoviesApi({
    String? favoriteToken,
    String? userId,
  }) async {
    try {
      Map<String, dynamic> data = {
        "uid": userId,
        "otoken": favoriteToken,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.moviesPurchased);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return purchasedMoviesModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
