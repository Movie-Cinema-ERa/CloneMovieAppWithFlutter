import 'package:flutter/material.dart';
import 'package:flutter_project/Models/signUp_model.dart';
import 'package:flutter_project/Screens/loginScreen.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpController extends GetxController {
  final signUpModel = SignUpModel().obs;
  Future signUps({String? fullName, String? email, String? password}) async {
    try {
      await ServicesApi.signUp(
              fullName: fullName, email: email, password: password)
          .then((response) {
        if (response!.status == 200) {
          Fluttertoast.showToast(msg: "Successfully you are Registered");
          Get.offAll(LoginScreen());
        } else {
          Get.showSnackbar(GetBar(
            icon: Icon(
              FontAwesomeIcons.exclamationCircle,
              color: Colors.grey[100],
              size: 18,
            ),
            duration: Duration(seconds: 2),
            message: "Fill up all the fields !!",
          ));
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
