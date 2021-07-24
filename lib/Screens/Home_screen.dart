import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/home_screen_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Widgets/drawer_list_tile.dart';
import 'package:flutter_project/Widgets/movies_horizontal_list_view.dart';
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
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
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
                        icon: Icons.message,
                        titleTxt: "Message",
                      ),
                      DrawerListTile(
                        icon: Icons.call,
                        titleTxt: "Contact us",
                      ),
                      DrawerListTile(
                        icon: Icons.support_agent,
                        titleTxt: "Support",
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
                  right: Get.height * 0.023,
                ),
                child: Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage(
                          loginController.firebaseAuth.currentUser != null
                              ? loginController
                                  .firebaseAuth.currentUser!.photoURL
                                  .toString()
                              : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
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
            preferredSize: Size.fromHeight(Get.height * 0.15),
            child: Container(
              padding: EdgeInsets.only(
                  left: Get.width * 0.06, right: Get.width * 0.06),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                          text: "Discover Movies",
                          style: TextStyle(
                              fontSize: 16.4,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.6,
                              color: Colors.grey.shade800),
                          children: [
                            TextSpan(
                              text: "\nand watch with fun !!",
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
                    builder: (controller) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: MediaQuery.of(context).size.height * 0.064,
                        child: TextFormField(
                          controller: homeScreenController.searchMoviesTxt,
                          onChanged: (searchMovies) {
                            searchMovies =
                                homeScreenController.searchMoviesTxt.text;
                            homeScreenController.update();
                          },
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.grey.shade500,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade200,
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
        body: SingleChildScrollView(
          child: Container(
            height: Get.height * 0.95,
            padding: EdgeInsets.only(
                left: Get.width * 0.06, right: Get.width * 0.06),
            child: Column(
              children: [
                CarouselSlider(
                    items: homeScreenController.movieSlider
                        .map((slider) => Container(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    slider,
                                    fit: BoxFit.contain,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        aspectRatio: 2.3,
                        viewportFraction: 0.37,
                        enableInfiniteScroll: true,
                        autoPlay: true)),
                MoviesListView(
                  title: homeScreenController.movieCategories[0],
                  moviesName: "revenant",
                  image: "assets/images/login.png",
                ),
                MoviesListView(
                  title: homeScreenController.movieCategories[1],
                  image: "assets/images/login.png",
                ),
                MoviesListView(
                  title: homeScreenController.movieCategories[2],
                  image: "assets/images/login.png",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
