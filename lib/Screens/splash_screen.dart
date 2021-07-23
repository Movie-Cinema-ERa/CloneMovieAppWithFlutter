import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue.shade900,
      ),
    );
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            RotationTransition(
              turns: splashController.animation!,
              child: Image.asset(
                "assets/images/cinemasingleicon.png",
                height: 35,
                width: 35,
              ),
            ),
            Image.asset(
              "assets/images/splash_icon.png",
              height: 80,
              width: 80,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.41,
            ),
            Text("Enjoy the movies",
                style: TextStyle(
                    color: Colors.blue[100],
                    fontSize: 14,
                    fontFamily: GoogleFonts.notoSans().fontFamily)),
          ],
        ),
      ),
    )));
  }
}
