import 'dart:io';
import 'package:flutter_project/Models/Login_model.dart';
import 'package:flutter_project/Models/signUp_model.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:http/http.dart' as http;

class ServicesApi {
  static Future<LoginModel?> loginModel(
      {String? email, String? password}) async {
    try {
      Map<String, dynamic> data = {
        "emailAddress": email,
        "Password": password,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.login);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return loginModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<SignUpModel?> signUp(
      {String? fullName, String? email, String? password}) async {
    try {
      Map<String, dynamic> data = {
        "fullName": fullName,
        "emailAddress": email,
        "Password": password,
      };
      var url = Uri.parse(ApiClients.baseUrl + ApiClients.signup);
      var response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        return signUpModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
