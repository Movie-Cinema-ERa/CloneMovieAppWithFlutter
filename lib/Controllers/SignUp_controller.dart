import 'package:flutter_project/Models/signUp_model.dart';
import 'package:flutter_project/Screens/loginScreen.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpController extends GetxController {
  final signUpModel = SignUpModel().obs;
  void signUps({String? fullName, String? email, String? password}) async {
    try {
      await ServicesApi.signUp(
              fullName: fullName, email: email, password: password)
          .then((response) {
        if (response!.status == 200) {
          Fluttertoast.showToast(msg: "Successfully you are Registered");
          Get.off(LoginScreen());
        } else {
          Fluttertoast.showToast(msg: "Fill up all the fields");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
