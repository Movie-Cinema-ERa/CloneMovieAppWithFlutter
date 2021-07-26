import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/buttom_navbar_controller.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
  final ButtonNavBarController buttonNavBarController =
      Get.put(ButtonNavBarController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue.shade800,
      ),
    );
    return Scaffold(
      body: Obx(
        () => buttonNavBarController.pages[buttonNavBarController.cIndex.value],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Obx(
          () => BottomNavigationBar(
            items: buttonNavBarController.items,
            currentIndex: buttonNavBarController.cIndex.value,
            selectedItemColor: Colors.blue[800],
            unselectedFontSize: 12,
            iconSize: 19,
            unselectedItemColor: Colors.grey[600],
            selectedFontSize: 12,
            unselectedLabelStyle: TextStyle(color: Colors.red),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[300],
            onTap: (index) {
              buttonNavBarController.cIndex.value = index;
            },
          ),
        ),
      ),
    );
  }
}

//final TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer()..onTap = () {};   For recoznizer of richtext on press property
// widgetspan

