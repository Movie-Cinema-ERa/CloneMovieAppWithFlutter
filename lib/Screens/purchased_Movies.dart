import 'package:flutter/material.dart';
import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Controllers/purchased_movies_controller.dart';
import 'package:flutter_project/Screens/Movies_details_screen.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:get/get.dart';

class PurchasedMovies extends StatelessWidget {
  PurchasedMovies({Key? key}) : super(key: key);
  final PurchasedMoviesControllers purchasedMoviesControllers =
      Get.put(PurchasedMoviesControllers());
  final MoviesDetailsController moviesDetailsController =
      Get.put(MoviesDetailsController());
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 1.2,
        title: Text(
          "My movies",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.blue.shade900),
        ),
      ),
      body: GetBuilder<PurchasedMoviesControllers>(
        builder: (controller) {
          controller.purchasedMovies(
              userId: moviesDetailsController.userId ??
                  loginController.firebaseAuth.currentUser!.uid,
              favToken: moviesDetailsController.favoriteToken ??
                  loginController.firebaseAuth.currentUser!.uid);
          return controller.isLoading == false
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.6,
                        child: Image(
                          height: 220,
                          width: 220,
                          image:
                              AssetImage("assets/images/purchased_movies.png"),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "To watch any movies you want,",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 10),
                            children: [
                              TextSpan(
                                text: "\njust purchase the movies!!",
                              )
                            ]),
                      )
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 13),
                  padding: EdgeInsets.only(
                      left: Get.width * 0.06, right: Get.width * 0.06),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.71,
                      crossAxisCount: 2,
                    ),
                    itemCount: controller.purchasedMoviesModel!.content!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Get.to(
                          () => MoviesDetailsScreen(),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8, bottom: 7),
                                height: 150,
                                width: 112,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Hero(
                                    tag: controller.purchasedMoviesModel!
                                        .content![index].moviesId
                                        .toString(),
                                    child: Image.network(
                                      controller.purchasedMoviesModel!
                                                  .content![index].aPoster !=
                                              null
                                          ? ApiClients.moviesPoster +
                                              controller.purchasedMoviesModel!
                                                  .content![index].aPoster
                                                  .toString()
                                          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                controller
                                    .purchasedMoviesModel!.content![index].aName
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
