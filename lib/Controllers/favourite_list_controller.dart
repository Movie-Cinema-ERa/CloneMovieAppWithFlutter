import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Models/favorite_movie_list_model.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FavouriteListController extends GetxController {
  var favouriteListModel = FavouriteListModel().obs;
  var isVisible = false.obs;
  final MoviesDetailsController moviesDetailsController =
      Get.find<MoviesDetailsController>();
  final LoginController loginController = Get.find<LoginController>();
  @override
  void onInit() {
    super.onInit();
  }

  Future getFavoriteList({String? favoriteToken, String? userId}) async {
    try {
      await ServicesApi.favoriteListModel(
              favoriteToken: favoriteToken, userId: userId)
          .then(
        (response) {
          if (response!.status == 200) {
            isVisible.value = true;
            favouriteListModel.value = response;
            getFavoriteList(
                favoriteToken: moviesDetailsController.favoriteToken ??
                    loginController.firebaseAuth.currentUser!.uid,
                userId: moviesDetailsController.userId ??
                    loginController.firebaseAuth.currentUser!.uid);
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

  Future getFavoriteRemove(
      {String? id, String? favoriteToken, String? userId}) async {
    try {
      await ServicesApi.favoriteRemove(
              id: id, favoriteToken: favoriteToken, userId: userId)
          .then(
        (response) {
          if (response != null) {
            getFavoriteList(
                favoriteToken: moviesDetailsController.favoriteToken ??
                    loginController.firebaseAuth.currentUser!.uid,
                userId: moviesDetailsController.userId ??
                    loginController.firebaseAuth.currentUser!.uid);
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
