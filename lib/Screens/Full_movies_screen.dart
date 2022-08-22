import 'package:flutter/material.dart';
import 'package:flutter_project/Controllers/videos_controller.dart';
import 'package:get/get.dart';

class FullMovies extends StatelessWidget {
  final VideosController videosController = Get.find<VideosController>();
  FullMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideosController>(dispose: (dispose) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        dispose.controller?.exitPageFullMovies();
      });
    }, initState: (controller) {
      controller.controller?.playTrailers(Get.arguments['fullMovies']);
      controller.controller
          ?.initializePlayer(link: Get.arguments['fullMovies']);
    }, builder: (_) {
      return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 1.2,
            leading: GestureDetector(
              onTap: () {
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
          body: Center(
            child: Container(
                color: Colors.black,
                height: Get.height * 0.32,
                child: Container(
                  child: _.playTrailers(Get.arguments['fullMovies']),
                )),
          ));
    });
  }
}
