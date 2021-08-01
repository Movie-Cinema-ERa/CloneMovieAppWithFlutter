import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controllers/Movies_details_controller.dart';
import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.lazyPut(() => MoviesDetailsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MoviesApp();
  }
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: "/",
      getPages: [GetPage(name: "/", page: () => SplashScreen())],
    );
  }
}
