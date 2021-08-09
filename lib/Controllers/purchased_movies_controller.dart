import 'package:flutter/material.dart';
import 'package:flutter_project/Models/purchased_movies_model.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PurchasedMoviesControllers extends GetxController {
  PurchasedMoviesModel? purchasedMoviesModel;
  bool isLoading = false;
  purchasedMovies({String? userId, String? favToken}) async {
    try {
      ServicesApi.purchasedMoviesApi(userId: userId, favoriteToken: favToken)
          .then((response) {
        if (response!.status == 200) {
          isLoading = true;
          purchasedMoviesModel = response;
          update();
        } else {
          isLoading = false;
          update();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
