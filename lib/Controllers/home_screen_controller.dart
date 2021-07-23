import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var email = "".obs;
  @override
  void onInit() {
    super.onInit();
  }

  // check() {
  //   SecureStorage().readKey('email').then((res) {
  //     LoginModel().emailAddress = res;
  //   });
  // }
}
