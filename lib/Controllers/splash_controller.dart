import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/BottomNavBar/ButtomNavBar.dart';
import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Controllers/home_screen_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Screens/loginScreen.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  String? email = "";
  final SecureStorage secureStorage = SecureStorage();
  final LoginController loginController = Get.put(LoginController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final MoviesDetailsController moviesDetailsController =
      Get.find<MoviesDetailsController>();

  @override
  void onClose() {
    animationController!.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationController!.forward();
    animation = Tween(
      begin: 0.0,
      end: 850.0,
    ).animate(animationController!);

    Future.delayed(Duration(seconds: 1), () {
      secureStorage.readKey(key: 'email').then((value) {
        email = value;
        if (email == null) {
          if (loginController.firebaseAuth.currentUser != null) {
            Get.offAll(() => BottomNavBar());
          } else {
            Timer(Duration(seconds: 2), () {
              Get.offAll(() => LoginScreen());
            });
          }
        } else {
          homeScreenController.getEmail();
          homeScreenController.getName();
          moviesDetailsController.getUserid();
          moviesDetailsController.getFavoriteToken();
          Timer(Duration(seconds: 2), () {
            Get.offAll(() => BottomNavBar());
          });
        }
      });
    });

    super.onInit();
  }
}
