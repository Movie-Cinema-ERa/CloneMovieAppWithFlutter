import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/Khalti_payment_controller.dart';
import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Controllers/favourite_list_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Controllers/videos_controller.dart';
import 'package:flutter_project/Models/movies_model.dart';
import 'package:flutter_project/Widgets/movies_details_richText.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class MoviesDetailsScreen extends StatelessWidget {
  MoviesDetailsScreen({Key? key, this.moviesModel}) : super(key: key);
  final ActionMovie? moviesModel;
  final MoviesDetailsController moviesDetailsController =
      Get.put(MoviesDetailsController());
  final LoginController loginController = Get.put(LoginController());
  final FavouriteListController favouriteListController =
      Get.put(FavouriteListController());
  final VideosController videosController = Get.put(VideosController());
  final KhaltiPaymentControllers khaltiPaymentControllers =
      Get.put(KhaltiPaymentControllers());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return WillPopScope(
      onWillPop: () => videosController.exitPage(),
      child: Scaffold(
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
              controller.allReviews(moviesId: moviesModel!.id.toString());
              controller.averageRates(moviesId: moviesModel!.id.toString());

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
                                  child: videosController.playTrailers(),
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
                                    visualDensity:
                                        VisualDensity(horizontal: -4),
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
                                    videosController.initializePlayer(
                                      link: ApiClients.trailerVedios +
                                          moviesModel!.trailerVideos.toString(),
                                    );
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
                                child: Stack(children: [
                                  Hero(
                                    tag: moviesModel!.id.toString(),
                                    child: Image.network(
                                      ApiClients.moviesPoster +
                                          moviesModel!.filmImage.toString(),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 6,
                                    child: GestureDetector(
                                      onTap: () {
                                        var moviesPrice =
                                            double.parse(moviesModel!.price!) *
                                                100;
                                        khaltiPaymentControllers.khaltiCheck(
                                            moviesId:
                                                moviesModel!.id.toString(),
                                            userId:
                                                moviesDetailsController.userId,
                                            favoriteToken:
                                                moviesDetailsController
                                                    .favoriteToken,
                                            price: moviesPrice,
                                            moviesName: moviesModel!.filmName,
                                            moviesImage: moviesModel!.filmImage,
                                            fullMovies:
                                                moviesModel!.trailerVideos);
                                      },
                                      child: Container(
                                        height: 22,
                                        width: 55,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            border: Border.all(
                                                color: Colors.grey.shade100,
                                                width: 0.16)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.play_arrow,
                                              color: Colors.grey[300],
                                              size: 14,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Watch",
                                              style: TextStyle(
                                                  letterSpacing: 0.2,
                                                  fontSize: 11,
                                                  color: Colors.grey[300]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
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
                                                  "${controller.averageRateModel.content?[0].ratingAvg ?? "0.0"}",
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
                                      onTap: () {
                                        Get.defaultDialog(
                                          barrierDismissible: false,
                                          radius: 8,
                                          buttonColor: Colors.transparent,
                                          backgroundColor: Colors.grey[100],
                                          titleStyle: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 17,
                                            letterSpacing: 0.3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          title: "Rate the movie",
                                          content: Container(
                                            child: Column(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: 0.0,
                                                  itemSize: 25,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    controller.ratedValues =
                                                        rating.toString();
                                                    controller.update();
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: TextFormField(
                                                    controller:
                                                        controller.reviewTxt,
                                                    style: TextStyle(
                                                        color: Colors.blue[700],
                                                        fontSize: 15),
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    cursorColor: Colors.blue,
                                                    decoration: InputDecoration(
                                                        labelStyle: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.blue),
                                                        hintStyle:
                                                            TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors
                                                                        .grey),
                                                        contentPadding:
                                                            EdgeInsets.all(18),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        9),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .blue
                                                                    .shade700,
                                                                width: 0.6)),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue
                                                                      .shade800,
                                                                  width: 0.6),
                                                        ),
                                                        hintText:
                                                            "Let's hear your review..."),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    height: Get.height * 0.04,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        controller.reviewTxt
                                                            .text = "";
                                                        controller.ratedValues =
                                                            "";
                                                        Get.back();
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.1,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    height: Get.height * 0.04,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (controller.reviewTxt
                                                                    .text ==
                                                                "" &&
                                                            controller
                                                                    .ratedValues ==
                                                                "") {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please provide your rating or review");
                                                        } else {
                                                          controller.addReviews(
                                                              userId: controller
                                                                      .userId ??
                                                                  loginController
                                                                      .firebaseAuth
                                                                      .currentUser!
                                                                      .uid,
                                                              moviesId:
                                                                  moviesModel!
                                                                      .id
                                                                      .toString(),
                                                              token: controller
                                                                      .favoriteToken ??
                                                                  loginController
                                                                      .firebaseAuth
                                                                      .currentUser!
                                                                      .uid,
                                                              reviews:
                                                                  controller
                                                                      .reviewTxt
                                                                      .text,
                                                              ratedValue: controller
                                                                  .ratedValues);
                                                          controller.reviewTxt
                                                              .text = "";
                                                          controller
                                                              .ratedValues = "";
                                                          controller.update();
                                                          Get.back();
                                                        }
                                                      },
                                                      child: Text("Submit"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                          ],
                                        );
                                      },
                                      child: Container(
                                        height: 22,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[800],
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                        SizedBox(
                          height: 4,
                        ),
                        controller.isReviews == false
                            ? Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 160,
                                        child: Opacity(
                                          opacity: 0.3,
                                          child: Image.asset(
                                            "assets/images/review_icon.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "No reviews yet!!",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.4,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Be the first one to give reviews!!",
                                        style: TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 0.4,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: Get.height * 0.13,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0.0),
                                  itemCount:
                                      controller.reviewsModel.content!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onLongPress: () {
                                        HapticFeedback.vibrate();
                                        Get.defaultDialog(
                                          barrierDismissible: false,
                                          titleStyle: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 17,
                                            letterSpacing: 0.3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          radius: 8,
                                          title: "Remove Review",
                                          content: Text(
                                            "Do you want to remove this review!!",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    height: Get.height * 0.04,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.1,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    height: Get.height * 0.04,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        controller.deleteReviews(
                                                            id: controller
                                                                .reviewsModel
                                                                .content![index]
                                                                .reviewId
                                                                .toString(),
                                                            userId: controller
                                                                .userId,
                                                            token: controller
                                                                .favoriteToken);
                                                        Get.back();
                                                      },
                                                      child: Text("Ok"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                          ],
                                        );
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 15,
                                              child: Text(
                                                controller.reviewsModel
                                                    .content![index].fullName
                                                    .toString()
                                                    .substring(0, 1)
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.blue[900],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 17,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .reviewsModel
                                                            .content![index]
                                                            .fullName
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 0.4,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      RatingBar.builder(
                                                        ignoreGestures: true,
                                                        initialRating:
                                                            controller
                                                                .reviewsModel
                                                                .content![index]
                                                                .ratedValue!,
                                                        itemCount: 5,
                                                        itemSize: 12,
                                                        allowHalfRating: true,
                                                        itemBuilder: (context,
                                                                _) =>
                                                            Icon(Icons.star,
                                                                color: Colors
                                                                    .amber),
                                                        onRatingUpdate: (_) {},
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    controller.reviewsModel
                                                        .content![index].reviews
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
