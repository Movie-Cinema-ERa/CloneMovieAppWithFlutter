import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/BottomNavBar/ButtomNavBar.dart';
import 'package:flutter_project/Models/Login_model.dart';
import 'package:flutter_project/Screens/Home_screen.dart';
import 'package:flutter_project/Screens/loginScreen.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel().obs;
  late GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final SecureStorage secureStorage = SecureStorage();
  var isLogin = false.obs;

  @override
  void onInit() {
    googleSignIn = GoogleSignIn();
    ever(isLogin, googleHanldeLogin);
    isLogin.value = firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isLogin(event != null);
    });

    super.onInit();
  }

  void login({String? email, String? password}) async {
    try {
      await ServicesApi.loginModel(email: email, password: password)
          .then((response) {
        if (response!.status == 200) {
          loginModel.value = response;
          SecureStorage().writeKey('name', response.fullName!);
          SecureStorage().writeKey('email', response.emailAddress!);
          Fluttertoast.showToast(msg: "Successfully you are logged in");
          Get.off(() => BottomNavBar());
        } else {
          Fluttertoast.showToast(msg: "Wrong email or password");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void logout() async {
    SecureStorage().deleteKey('name');
    SecureStorage().deleteKey('email');
    Get.off(LoginScreen());
  }

  void googleHanldeLogin(isLogin) async {
    if (isLogin) {
      Get.offAll(() => BottomNavBar());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  void googleLogin() async {
    Get.defaultDialog(
      radius: 10,
      title: "Please wait a moment...",
      titleStyle: TextStyle(fontSize: 16),
      content: Center(
        child: Container(
          height: 26,
          width: 26,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignIn == null) {
      Get.back();
    } else {
      try {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await firebaseAuth.signInWithCredential(oAuthCredential);
        Get.back();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void googleLogout() async {
    await googleSignIn.disconnect();
    await firebaseAuth.signOut();
  }
}
