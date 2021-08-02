import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Models/Favourite_add_model.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MoviesDetailsController extends GetxController {
  ChewieController? chewieController;
  bool isVisibleTrailerImages = true;
  bool isVisibleTrailerVideos = false;
  var favouriteModel = FavouriteModel().obs;
  var userId;
  var favoriteToken;

  var link;
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

  initializePlayer({link}) {
    chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(link),
      autoInitialize: true,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, error) {
        return Container(
          child: Text("Sorry cant run videos"),
        );
      },
    );
  }

  Chewie playTrailers({link}) {
    initializePlayer(link: link);
    update();
    return Chewie(controller: chewieController!);
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

  @override
  void onClose() {
    chewieController!.dispose();
    chewieController!.videoPlayerController.dispose();
    chewieController!.pause();
    chewieController!.videoPlayerController.pause();
    super.onClose();
  }
}
