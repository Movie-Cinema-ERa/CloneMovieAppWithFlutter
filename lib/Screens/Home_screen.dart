import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/home_screen_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Screens/Movies_details_screen.dart';
import 'package:flutter_project/Widgets/categories_view_all.dart';
import 'package:flutter_project/Widgets/drawer_list_tile.dart';
import 'package:flutter_project/Widgets/movies_horizontal_list_view.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());
  final SecureStorage secureStorage = SecureStorage();
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade100,
      ),
    );
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.grey[100],
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade50,
                          width: 0.0,
                        ),
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                        loginController.firebaseAuth.currentUser != null
                            ? loginController.firebaseAuth.currentUser!.photoURL
                                .toString()
                            : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                      ),
                    ),
                    accountName: loginController.firebaseAuth.currentUser !=
                            null
                        ? Text(
                            "${loginController.firebaseAuth.currentUser!.displayName}",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.7,
                                fontFamily: GoogleFonts.ptSerif().fontFamily,
                                fontSize: 16),
                          )
                        : loginController.loginModel.value.fullName != null
                            ? Text(
                                "${loginController.loginModel.value.fullName}",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.ptSerif().fontFamily,
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.9,
                                    fontSize: 16),
                              )
                            : Obx(() => Text(
                                  "${homeScreenController.name.value}",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.ptSerif().fontFamily,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.9,
                                      fontSize: 16),
                                )),
                    accountEmail: loginController.firebaseAuth.currentUser !=
                            null
                        ? Text(
                            "${loginController.firebaseAuth.currentUser!.email}",
                            style: TextStyle(
                                fontFamily: GoogleFonts.ptSerif().fontFamily,
                                letterSpacing: 0.6,
                                fontSize: 13,
                                color: Colors.blue[900]),
                          )
                        : loginController.loginModel.value.emailAddress != null
                            ? Text(
                                "${loginController.loginModel.value.emailAddress}",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.ptSerif().fontFamily,
                                    letterSpacing: 0.6,
                                    fontSize: 13,
                                    color: Colors.blue[900]),
                              )
                            : Obx(() => Text(
                                  "${homeScreenController.email.value}",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.ptSerif().fontFamily,
                                      letterSpacing: 0.6,
                                      fontSize: 13,
                                      color: Colors.blue[900]),
                                )),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      DrawerListTile(
                        icon: Icons.home,
                        titleTxt: "Home",
                      ),
                      DrawerListTile(
                        icon: Icons.read_more_rounded,
                        titleTxt: "About us",
                      ),
                      DrawerListTile(
                        icon: Icons.call,
                        titleTxt: "Contact us",
                      ),
                      DrawerListTile(
                        icon: Icons.help_center,
                        titleTxt: "Help",
                      ),
                      DrawerListTile(
                        icon: Icons.logout,
                        titleTxt: "Log out",
                        onTap: () => loginController.isLogin.value
                            ? loginController.googleLogout()
                            : loginController.logout(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 7,
                          ),
                          child: Text(
                            "Powered by Atish pun",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          leading: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Image.asset(
                  "assets/images/drawer.png",
                  color: Colors.blue.shade900,
                  scale: 50,
                ),
              );
            },
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(
                  right: Get.height * 0.026,
                ),
                child: Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        width: 25,
                        child: CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              loginController.firebaseAuth.currentUser != null
                                  ? loginController
                                      .firebaseAuth.currentUser!.photoURL
                                      .toString()
                                  : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ))
          ],
          elevation: 0.0,
          brightness: Brightness.light,
          centerTitle: true,
          title: RichText(
            text: TextSpan(
                text: "Cinema",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.blue.shade900),
                children: [
                  TextSpan(
                    text: " Era",
                    style: TextStyle(color: Colors.blue.shade700, fontSize: 15),
                  )
                ]),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.13),
            child: Container(
              padding: EdgeInsets.only(
                  left: Get.width * 0.06, right: Get.width * 0.06),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                          text: "Discover Movies!!",
                          style: TextStyle(
                              fontSize: 16.3,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.7,
                              color: Colors.grey.shade800),
                          children: [
                            TextSpan(
                              text: "\nand watch with fun...",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.014,
                  ),
                  GetBuilder<HomeScreenController>(
                    builder: (homeScreenController) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: MediaQuery.of(context).size.height * 0.059,
                        child: TextFormField(
                          controller: homeScreenController.searchMoviesTxt,
                          onChanged: (searchMovies) {
                            homeScreenController.getActionSearch(
                                query: searchMovies);
                          },
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.grey.shade500,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: true,
                              hintStyle:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              contentPadding: EdgeInsets.only(top: 0.0),
                              isDense: true,
                              suffixIcon: homeScreenController
                                      .searchMoviesTxt.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        size: 15,
                                        color: Colors.grey.shade500,
                                      ),
                                      onPressed: () {
                                        homeScreenController.searchMoviesTxt
                                            .clear();
                                        homeScreenController.searchAction
                                            .clear();

                                        homeScreenController.update();
                                      },
                                    )
                                  : Text(
                                      "",
                                    ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 18,
                                color: Colors.grey.shade600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                              hintText: "Search movies..."),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: GetBuilder<HomeScreenController>(
          builder: (homeScreenController) {
            return homeScreenController.isload == false
                ? Center(
                    child: Container(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  )
                : homeScreenController.searchMoviesTxt.text != ""
                    ? ListView.builder(
                        itemCount: homeScreenController.searchAction.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.06,
                              right: Get.width * 0.06,
                              top: Get.height * 0.008,
                            ),
                            child: Row(children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              Expanded(
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -1),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      homeScreenController.searchAction[index]
                                              .filmImage!.isNotEmpty
                                          ? ApiClients.moviesPoster +
                                              homeScreenController
                                                  .searchAction[index].filmImage
                                                  .toString()
                                          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                                      height: 35,
                                      width: 26,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    homeScreenController
                                        .searchAction[index].filmName
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      letterSpacing: 0.3,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      )
                    : SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Container(
                          margin: EdgeInsets.only(top: 11),
                          padding: EdgeInsets.only(
                              left: Get.width * 0.06, right: Get.width * 0.06),
                          child: Column(
                            children: [
                              CarouselSlider(
                                items: homeScreenController
                                    .moviesModel.sliderMovies!
                                    .map((slider) => Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                ApiClients.moviesPoster +
                                                    slider.filmImage.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    aspectRatio: 2.3,
                                    viewportFraction: 0.77,
                                    enableInfiniteScroll: true,
                                    autoPlay: true),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              MoviesListView(
                                title: homeScreenController.movieCategories[0],
                                itemCount: homeScreenController
                                    .moviesModel.actionMovies!.length,
                                onPres: () {
                                  Get.to(() => CategoriesViewAll(
                                        categoryTypes: homeScreenController
                                            .moviesModel.actionMovies,
                                        heading: "Action movies",
                                      ));
                                },
                                builder: (BuildContext context, int idx) {
                                  return GestureDetector(
                                    onTap: () => Get.to(
                                      () => MoviesDetailsScreen(
                                        moviesModel: homeScreenController
                                            .moviesModel.actionMovies![idx],
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white,
                                      ),
                                      width: 111,
                                      margin: EdgeInsets.only(right: 8),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 7, bottom: 7),
                                            height: 136,
                                            width: 97,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                homeScreenController
                                                            .moviesModel
                                                            .actionMovies![idx]
                                                            .filmImage !=
                                                        null
                                                    ? ApiClients.moviesPoster +
                                                        homeScreenController
                                                            .moviesModel
                                                            .actionMovies![idx]
                                                            .filmImage
                                                            .toString()
                                                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            homeScreenController.moviesModel
                                                .actionMovies![idx].filmName
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
                              SizedBox(
                                height: 13,
                              ),
                              MoviesListView(
                                title: homeScreenController.movieCategories[1],
                                itemCount: homeScreenController
                                    .moviesModel.loveStories!.length,
                                onPres: () {
                                  Get.to(() => CategoriesViewAll(
                                        categoryTypes: homeScreenController
                                            .moviesModel.loveStories,
                                        heading: "Love stories",
                                      ));
                                },
                                builder: (BuildContext context, int idx) {
                                  return GestureDetector(
                                    onTap: () => Get.to(
                                      () => MoviesDetailsScreen(
                                        moviesModel: homeScreenController
                                            .moviesModel.loveStories![idx],
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white,
                                      ),
                                      width: 111,
                                      margin: EdgeInsets.only(right: 8),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 7, bottom: 7),
                                            height: 136,
                                            width: 97,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                homeScreenController
                                                            .moviesModel
                                                            .loveStories![idx]
                                                            .filmImage !=
                                                        null
                                                    ? ApiClients.moviesPoster +
                                                        homeScreenController
                                                            .moviesModel
                                                            .loveStories![idx]
                                                            .filmImage
                                                            .toString()
                                                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            homeScreenController.moviesModel
                                                .loveStories![idx].filmName
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
                              SizedBox(
                                height: 13,
                              ),
                              MoviesListView(
                                title: homeScreenController.movieCategories[2],
                                itemCount: homeScreenController
                                    .moviesModel.horrorMovies!.length,
                                onPres: () {
                                  Get.to(() => CategoriesViewAll(
                                        categoryTypes: homeScreenController
                                            .moviesModel.horrorMovies,
                                        heading: "Horror movies",
                                      ));
                                },
                                builder: (BuildContext context, int idx) {
                                  return GestureDetector(
                                    onTap: () => Get.to(
                                      () => MoviesDetailsScreen(
                                        moviesModel: homeScreenController
                                            .moviesModel.horrorMovies![idx],
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white,
                                      ),
                                      width: 111,
                                      margin: EdgeInsets.only(right: 8),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 7, bottom: 7),
                                            height: 136,
                                            width: 97,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                homeScreenController
                                                            .moviesModel
                                                            .horrorMovies![idx]
                                                            .filmImage !=
                                                        null
                                                    ? ApiClients.moviesPoster +
                                                        homeScreenController
                                                            .moviesModel
                                                            .horrorMovies![idx]
                                                            .filmImage
                                                            .toString()
                                                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            homeScreenController.moviesModel
                                                .horrorMovies![idx].filmName
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
                              SizedBox(
                                height: 13,
                              ),
                            ],
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}
