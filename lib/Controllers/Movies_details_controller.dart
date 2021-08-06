import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Models/All_reviews_model.dart';
import 'package:flutter_project/Models/AvgRate_model.dart';
import 'package:flutter_project/Models/Favourite_add_model.dart';
import 'package:flutter_project/Models/deleteReview_model.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MoviesDetailsController extends GetxController {
  ChewieController? chewieController;
  bool isVisibleTrailerImages = true;
  bool isVisibleTrailerVideos = false;
  final TextEditingController reviewTxt = TextEditingController();
  var favouriteModel = FavouriteModel().obs;
  var reviewsModel = ReviewListModel();
  var averageRateModel = AvgRateModel();
  var deleteReviewModel = DeleteReviewModel();
  var ratedValues = "";
  var isReviews = false;
  var userId;
  var favoriteToken;
  @override
  void onInit() {
    super.onInit();
  }

  getUserid() async {
    userId = await SecureStorage().readKey(key: 'UserId');
    update();
    return userId;
  }

  getFavoriteToken() async {
    favoriteToken = await SecureStorage().readKey(key: 'FavoriteToken');
    update();
    return favoriteToken;
  }

  Future addFavourite(
      {String? favoriteToken, String? moviesId, String? userId}) async {
    try {
      await ServicesApi.favoriteModel(
        favoriteToken: favoriteToken,
        moviesId: moviesId,
        userId: userId,
      ).then((response) {
        if (response!.status == 200) {
          favouriteModel.value = response;
          Fluttertoast.showToast(msg: response.content.toString());
        } else {
          Get.showSnackbar(
            GetBar(
              icon: Icon(
                FontAwesomeIcons.exclamationCircle,
                color: Colors.grey[100],
                size: 18,
              ),
              duration: Duration(seconds: 2),
              message: "Unable to add the movies",
            ),
          );
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future addReviews(
      {String? userId,
      String? moviesId,
      String? token,
      String? reviews,
      String? ratedValue}) async {
    try {
      await ServicesApi.reviewAdd(
              userId: userId,
              moviesId: moviesId,
              token: token,
              reviews: reviews,
              ratedValue: ratedValue)
          .then((response) {
        if (response != null) {
          Fluttertoast.showToast(msg: "Thank you for your ratings");
          return response;
        } else {
          Get.showSnackbar(
            GetBar(
              icon: Icon(
                FontAwesomeIcons.exclamationCircle,
                color: Colors.grey[100],
                size: 18,
              ),
              duration: Duration(seconds: 2),
              message: "Unable to give ratings",
            ),
          );
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future allReviews({String? moviesId}) async {
    try {
      await ServicesApi.reviewList(
        moviesId: moviesId,
      ).then((response) {
        if (response != null) {
          reviewsModel = response;
          isReviews = true;
          update();
        } else {
          isReviews = false;
          update();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future averageRates({String? moviesId}) async {
    try {
      await ServicesApi.avgRate(
        moviesId: moviesId,
      ).then((response) {
        if (response != null) {
          averageRateModel = response;
          update();
        } else {
          update();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteReviews({String? id, String? userId, String? token}) async {
    try {
      await ServicesApi.reviewRemove(
        id: id,
        userId: userId,
        favoriteToken: token,
      ).then((response) {
        if (response!.status == 200) {
          deleteReviewModel = response;
          update();
        } else {
          Fluttertoast.showToast(msg: "Unable to remove reviews!!");
          update();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onClose() {
    chewieController!.dispose();
    chewieController!.videoPlayerController.dispose();
    chewieController!.pause();
    chewieController!.videoPlayerController.pause();
    super.onClose();
  }
}
