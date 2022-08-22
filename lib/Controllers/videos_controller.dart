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

  Future exitPageFullMovies() async {
    chewieController?.pause();
    chewieController?.videoPlayerController.pause();
    chewieController?.dispose();
    chewieController?.videoPlayerController.dispose();
    update();
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

  @override
  void onClose() {
    chewieController?.pause();
    chewieController?.videoPlayerController.pause();
    super.onClose();
  }

  Chewie playTrailers(link) {
    return Chewie(
        controller: ChewieController(
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
    ));
  }
}
