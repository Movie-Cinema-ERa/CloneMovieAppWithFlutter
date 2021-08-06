import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'Movies_details_controller.dart';

class VideosController extends GetxController {
  final MoviesDetailsController moviesDetailsController =
      Get.find<MoviesDetailsController>();
  ChewieController? chewieController;
  var link;

  @override
  void onInit() {
    super.onInit();
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

  Chewie playTrailers() {
    return Chewie(controller: chewieController!);
  }

  Future<bool> exitPage() async {
    if (chewieController != null &&
        chewieController!.videoPlayerController.value.isPlaying) {
      moviesDetailsController.isVisibleTrailerImages = true;
      moviesDetailsController.isVisibleTrailerVideos = false;
      moviesDetailsController.update();
      onClose();
    } else {
      moviesDetailsController.isVisibleTrailerImages = true;
      moviesDetailsController.isVisibleTrailerVideos = false;
      moviesDetailsController.update();
      chewieController!.dispose();
      chewieController!.videoPlayerController.dispose();
      onClose();
    }
    update();
    return Future.value(true);
  }

  @override
  void onClose() {
    chewieController!.pause();
    chewieController!.videoPlayerController.pause();
    super.onClose();
  }
}
