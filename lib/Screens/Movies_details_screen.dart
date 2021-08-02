import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Controllers/favourite_list_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Models/movies_model.dart';
import 'package:flutter_project/Widgets/movies_details_richText.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MoviesDetailsScreen extends StatelessWidget {
  MoviesDetailsScreen({Key? key, this.moviesModel}) : super(key: key);
  final ActionMovie? moviesModel;
  final MoviesDetailsController moviesDetailsController =
      Get.put(MoviesDetailsController());
  final LoginController loginController = Get.put(LoginController());
  final FavouriteListController favouriteListController =
      Get.put(FavouriteListController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      floatingActionButton: Container(
        width: 46,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[800],
          onPressed: () {
            moviesDetailsController.addFavourite(
                favoriteToken: moviesDetailsController.favoriteToken ??
                    loginController.firebaseAuth.currentUser!.uid,
                moviesId: moviesModel!.id.toString(),
                userId: moviesDetailsController.userId ??
                    loginController.firebaseAuth.currentUser!.uid);
          },
          child: Icon(
            FontAwesomeIcons.heart,
            size: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                              height: Get.height * 0.32,
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
                            height: Get.height * 0.32,
                            width: Get.width,
                            child: Image.network(
                              ApiClients.moviesPoster +
                                  moviesModel!.filmImage.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 30,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              height: 24,
                              width: 32,
                              child: IconButton(
                                  padding: EdgeInsets.all(0.0),
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: Colors.blue[900],
                                    size: 26,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  }),
                            ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                              margin: EdgeInsets.only(left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        moviesModel!.filmName.toString(),
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          letterSpacing: 0.3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Price : Rs." +
                                                moviesModel!.price.toString(),
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              letterSpacing: 0.3,
                                              fontSize: 12.5,
                                            ),
                                          ),
                                          Container(
                                            height: 11,
                                            child: VerticalDivider(
                                              color: Colors.grey[700]!
                                                  .withOpacity(0.5),
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
                                                  color: Colors.grey[700],
                                                  letterSpacing: 0.3,
                                                  fontSize: 12.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    child: Container(
                                      height: 22,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[800],
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.pen,
                                            color: Colors.white,
                                            size: 9,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Review",
                                            style: TextStyle(
                                              letterSpacing: 0.4,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            "Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              letterSpacing: 0.4,
                              fontSize: 15.5,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      RichTextMovieDetails(
                        header: "Cast : ",
                        body: moviesModel!.cast,
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RichTextMovieDetails(
                        header: "Director : ",
                        body: moviesModel!.director,
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RichTextMovieDetails(
                        header: "Release Date : ",
                        body: moviesModel!.releaseDate!.year.toString() +
                            "-" +
                            moviesModel!.releaseDate!.month.toString() +
                            "-" +
                            moviesModel!.releaseDate!.day.toString(),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RichTextMovieDetails(
                        header: "Run time : ",
                        body: moviesModel!.runTime,
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RichTextMovieDetails(
                        header: "Language : ",
                        body: moviesModel!.language
                            .toString()
                            .substring(9)
                            .toLowerCase(),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RichTextMovieDetails(
                        header: "Overview : ",
                        body: moviesModel!.overview,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "Reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              letterSpacing: 0.4,
                              fontSize: 15.5,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                    ],
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
