import 'package:flutter/material.dart';
import 'package:flutter_project/Screens/Home_screen.dart';
import 'package:get/get.dart';

class ButtonNavBarController extends GetxController {
  var cIndex = 0.obs;

  List<Widget> pages = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ].obs;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: "Favorite", tooltip: "Favorite"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), label: "Profile", tooltip: "Profile"),
  ].obs;
}
