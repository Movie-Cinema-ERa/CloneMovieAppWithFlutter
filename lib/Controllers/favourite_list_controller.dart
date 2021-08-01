import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Models/favorite_movie_list_model.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FavouriteListController extends GetxController {
  var favouriteListModel = FavouriteListModel().obs;
  var isVisible = false.obs;
  final MoviesDetailsController moviesDetailsController =
      Get.find<MoviesDetailsController>();
  @override
  void onInit() {
    getFavoriteList(
        favoriteToken: moviesDetailsController.favoriteToken,
        userId: moviesDetailsController.userId);
    super.onInit();
  }

  getFavoriteList({String? favoriteToken, String? userId}) {
    try {
      ServicesApi.favoriteListModel(
              favoriteToken: favoriteToken, userId: userId)
          .then(
        (response) {
          if (response!.status == 200) {
            isVisible.value = true;
            favouriteListModel.value = response;
          } else {
            isVisible.value = false;
            favouriteListModel.value.isBlank;
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  getFavoriteRemove({String? id, String? favoriteToken, String? userId}) {
    try {
      ServicesApi.favoriteRemove(
              id: id, favoriteToken: favoriteToken, userId: userId)
          .then(
        (response) {
          if (response != null) {
            Fluttertoast.showToast(msg: "Successfully removed from Favorite");
          } else {
            return null;
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
