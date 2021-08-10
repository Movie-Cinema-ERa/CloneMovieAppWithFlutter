import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Controllers/favourite_list_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Screens/Movies_details_screen.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final FavouriteListController favouriteListController =
      Get.put(FavouriteListController());
  final LoginController loginController = Get.find<LoginController>();
  final MoviesDetailsController moviesDetailsController =
      Get.find<MoviesDetailsController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 1.2,
        title: Text(
          "Favorites",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.blue.shade900),
        ),
      ),
      body: Container(
        child: Obx(
          () {
            favouriteListController.getFavoriteList(
                favoriteToken: moviesDetailsController.favoriteToken ??
                    loginController.firebaseAuth.currentUser!.uid,
                userId: moviesDetailsController.userId ??
                    loginController.firebaseAuth.currentUser!.uid);
            return favouriteListController.isVisible.value == false
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          height: 220,
                          width: 220,
                          image: AssetImage("assets/images/favourite_icon.png"),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "To keep the track of any movies you want,",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 10),
                              children: [
                                TextSpan(
                                  text: "\njust tap the favorite icon",
                                )
                              ]),
                        )
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 6),
                    child: ListView.builder(
                      itemCount: favouriteListController
                          .favouriteListModel.value.content!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () => Get.to(() => MoviesDetailsScreen(
                                favouriteModel: favouriteListController
                                    .favouriteListModel.value.content![index],
                              )),
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: 0),
                          dense: true,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Hero(
                              tag: favouriteListController.favouriteListModel
                                  .value.content![index].moviesId
                                  .toString(),
                              child: Image.network(
                                ApiClients.moviesPoster +
                                    favouriteListController.favouriteListModel
                                        .value.content![index].aPoster
                                        .toString(),
                              ),
                            ),
                          ),
                          title: Text(
                            favouriteListController
                                .favouriteListModel.value.content![index].aName
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.4,
                                color: Colors.blue[900],
                                fontSize: 14),
                          ),
                          subtitle: Text(
                            favouriteListController.favouriteListModel.value
                                    .content![index].runTime
                                    .toString() +
                                " hrs",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey[700],
                              size: 16,
                            ),
                            onPressed: () {
                              favouriteListController.getFavoriteRemove(
                                  id: favouriteListController.favouriteListModel
                                      .value.content![index].id
                                      .toString(),
                                  favoriteToken: favouriteListController
                                          .moviesDetailsController
                                          .favoriteToken ??
                                      loginController
                                          .firebaseAuth.currentUser!.uid,
                                  userId: favouriteListController
                                          .favouriteListModel
                                          .value
                                          .content![index]
                                          .uid ??
                                      loginController
                                          .firebaseAuth.currentUser!.uid);
                            },
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
