import 'package:flutter/material.dart';
import 'package:flutter_project/BottomNavBar/ButtomNavBar.dart';
import 'package:flutter_project/Controllers/Movies_details_controller.dart';
import 'package:flutter_project/Controllers/favourite_list_controller.dart';
import 'package:flutter_project/Models/Login_model.dart';
import 'package:flutter_project/Screens/loginScreen.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel().obs;
  late GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final SecureStorage secureStorage = SecureStorage();
  var isLogin = false.obs;
  String? favouriteToken;
  var obscurePass = true;
  var obscureSignUpPass = true;
  var obscureConfrimPass = true;
  final MoviesDetailsController moviesDetailsController =
      Get.find<MoviesDetailsController>();

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

  Future login({String? email, String? password}) async {
    try {
      await ServicesApi.loginModel(email: email, password: password)
          .then((response) {
        if (response!.status == 200) {
          loginModel.value = response;
          favouriteToken = response.favouriteToken.toString();
          if (favouriteToken == "" || favouriteToken!.isEmpty) {
            var favToken = randomString(20);
            SecureStorage().writeKey(key: 'FavoriteToken', value: favToken);
          } else {
            SecureStorage()
                .writeKey(key: 'FavoriteToken', value: favouriteToken);
          }
          SecureStorage().writeKey(key: 'name', value: response.fullName!);
          SecureStorage().writeKey(key: 'email', value: response.emailAddress!);
          SecureStorage()
              .writeKey(key: 'UserId', value: response.id.toString());
          moviesDetailsController.getUserid();
          moviesDetailsController.getFavoriteToken();
          Get.lazyPut(() => FavouriteListController());
          Fluttertoast.showToast(msg: "Successfully you are logged in");
          Get.off(() => BottomNavBar());
        } else {
          Get.showSnackbar(
            GetBar(
              icon: Icon(
                FontAwesomeIcons.exclamationCircle,
                color: Colors.grey[100],
                size: 18,
              ),
              duration: Duration(seconds: 2),
              message: "Wrong email or password !!",
            ),
          );
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void logout() async {
    SecureStorage().deleteKey(key: 'email');
    SecureStorage().deleteKey(key: 'name');
    SecureStorage().deleteKey(key: 'UserId');
    SecureStorage().deleteKey(key: 'FavoriteToken');
    Get.offAll(LoginScreen());
  }

  Future googleHanldeLogin(isLogin) async {
    if (isLogin) {
      Get.offAll(() => BottomNavBar());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  Future googleLogin() async {
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
        Fluttertoast.showToast(msg: "Successfully you are logged in");
        Get.back();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    await firebaseAuth.signOut();
  }
}
