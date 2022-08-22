import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'Controllers/Movies_details_controller.dart';
import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.testMode = true;
  Get.lazyPut(() => MoviesDetailsController());
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: dotenv.env['Test_Public_Key'].toString(),
      builder: (context, navigatorKey) => GetMaterialApp(
        theme: ThemeData(
          primaryColorDark: Colors.white,
          primaryColor: Colors.white,
        ),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: [KhaltiLocalizations.delegate],
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => SplashScreen()),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MoviesApp();
  }
}
