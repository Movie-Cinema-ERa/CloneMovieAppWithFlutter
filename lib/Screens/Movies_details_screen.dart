import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Models/movies_model.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MoviesDetailsScreen extends StatelessWidget {
  MoviesDetailsScreen({Key? key, this.moviesModel}) : super(key: key);
  final ActionMovie? moviesModel;
  final MoviesDetailsController moviesDetailsController =
      Get.put(MoviesDetailsController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          child: GetBuilder<MoviesDetailsController>(builder: (controller) {
            return Column(
              children: [
                Stack(
                  children: [
                    Visibility(
                      visible: controller.isVisibleTrailerVideos,
                      child: controller.isVisibleTrailerImages == false
                          ? Container(
                              color: Colors.black,
                              height: Get.height * 0.27,
                              child: Container(
                                child: controller.playTrailers(
                                  link: ApiClients.trailerVedios +
                                      moviesModel!.trailerVideos.toString(),
                                ),
                              ),
                            )
                          : Visibility(
                              visible: controller.isVisibleTrailerVideos,
                              child: Text(""),
                            ),
                    ),
                    Visibility(
                      visible: controller.isVisibleTrailerImages,
                      child: Stack(
                        children: [
                          Container(
                            height: Get.height * 0.27,
                            width: Get.width,
                            child: Hero(
                              tag: moviesModel!.id.toString(),
                              child: Image.network(
                                ApiClients.moviesPoster +
                                    moviesModel!.filmImage.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Positioned(
                                top: 10,
                                left: 8,
                                child: Container(
                                  height: 26,
                                  width: 31,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: Colors.blue[900],
                                    size: 26,
                                  ),
                                  onPressed: () {
                                    if (controller.chewieController != null &&
                                        controller
                                            .chewieController!
                                            .videoPlayerController
                                            .value
                                            .isPlaying) {
                                      controller.isVisibleTrailerImages = true;
                                      controller.isVisibleTrailerVideos = false;
                                      controller.update();
                                      Get.reset();
                                      Get.back();
                                    } else {
                                      controller.isVisibleTrailerImages = true;
                                      controller.isVisibleTrailerVideos = false;
                                      controller.update();
                                      Get.reset();
                                      Get.back();
                                    }
                                  }),
                            ],
                          ),
                          Positioned(
                            top: Get.height * 0.12,
                            left: Get.width * 0.39,
                            child: Container(
                              height: 30,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.grey[300],
                                  size: 17,
                                ),
                                label: Text(
                                  "Trailer",
                                  style: TextStyle(
                                      letterSpacing: 0.2, fontSize: 13),
                                ),
                                style: TextButton.styleFrom(
                                  visualDensity: VisualDensity(horizontal: -4),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.shade50,
                                        width: 0.16),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                onPressed: () {
                                  controller.isVisibleTrailerImages =
                                      !controller.isVisibleTrailerImages;
                                  controller.isVisibleTrailerVideos =
                                      !controller.isVisibleTrailerVideos;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: controller.isVisibleTrailerImages,
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 37,
                        spreadRadius: 47,
                      ),
                    ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.04,
                    right: Get.width * 0.04,
                    top: Get.height * 0.01,
                  ),
                  child: Container(
                    height: Get.height * 0.15,
                    width: Get.width,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Hero(
                            tag: moviesModel!.id.toString(),
                            child: Image.network(
                              ApiClients.moviesPoster +
                                  moviesModel!.filmImage.toString(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moviesModel!.filmName.toString(),
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price : Rs." +
                                        moviesModel!.price.toString(),
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      letterSpacing: 0.3,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Container(
                                    height: 11,
                                    child: VerticalDivider(
                                      color: Colors.blue[700]!.withOpacity(0.5),
                                      thickness: 1,
                                      width: 10,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.yellow[800],
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "0.0",
                                        style: TextStyle(
                                          color: Colors.blue[800],
                                          letterSpacing: 0.3,
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 25,
                                margin:
                                    EdgeInsets.only(top: Get.height * 0.066),
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.pen,
                                    color: Colors.blue[800],
                                    size: 10,
                                  ),
                                  label: Text(
                                    "Review",
                                    style: TextStyle(
                                      letterSpacing: 0.4,
                                      fontSize: 12,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
