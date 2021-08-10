import 'package:flutter/material.dart';
import 'package:flutter_project/Controllers/videos_controller.dart';
import 'package:get/get.dart';

class FullMovies extends StatelessWidget {
  FullMovies({Key? key}) : super(key: key);
  final VideosController videosController = Get.find<VideosController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => videosController.exitPageFullMovies(),
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 1.2,
            leading: GestureDetector(
              onTap: () {
                videosController.exitPageFullMovies();
                Get.back();
              },
              child: Icon(
                Icons.chevron_left,
                color: Colors.blue[900],
                size: 26,
              ),
            ),
            title: Text(
              Get.arguments['moviesName'],
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.blue.shade900),
            ),
          ),
          body: GetBuilder<VideosController>(
            init: videosController.initializePlayer(
                link: Get.arguments['fullMovies']),
            builder: (controller) {
              return Center(
                child: Container(
                    color: Colors.black,
                    height: Get.height * 0.32,
                    child: Container(
                      child: controller.playTrailers(),
                    )),
              );
            },
          )),
    );
  }
}
