import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final SecureStorage secureStorage = SecureStorage();
  var searchMoviesTxt = TextEditingController();
  var email = "".obs;
  var name = "".obs;
  List<String> movieCategories = [
    "Action movies",
    "Love stories",
    "Horror movies"
  ];

  List<String> movieSlider = [
    "assets/images/login.png",
    "assets/images/signup.png",
    "assets/images/splash_icon.png"
  ];

  @override
  void onInit() {
    super.onInit();
  }

  getEmail() async {
    email.value = await secureStorage.readKey(key: 'email');
    return email.value;
  }

  getName() async {
    name.value = await secureStorage.readKey(key: 'email');
    return name.value;
  }
}
