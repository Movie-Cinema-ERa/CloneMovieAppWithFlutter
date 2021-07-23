import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final SecureStorage secureStorage = SecureStorage();
  var email = "".obs;
  var name = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  getEmail() async {
    email.value = await secureStorage.readKey(key: 'email');
    return email.value;
  }

  getName() async {
    name.value = await secureStorage.readKey(key: 'email');
    return name.value;
  }
}
