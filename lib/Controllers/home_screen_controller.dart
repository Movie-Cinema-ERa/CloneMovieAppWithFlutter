import 'package:flutter/material.dart';
import 'package:flutter_project/Models/movies_model.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final SecureStorage secureStorage = SecureStorage();
  var moviesModel = MoviesModel();
  List<ActionMovie> searchAction = <ActionMovie>[];
  List<ActionMovie> allMovies = <ActionMovie>[];

  var searchMoviesTxt = TextEditingController();
  var email = "".obs;
  var name = "".obs;
  var isload = false;

  @override
  void onInit() {
    getMovies();

    super.onInit();
  }

  List<String> movieCategories = [
    "Action movies",
    "Love stories",
    "Horror movies"
  ];

  getEmail() async {
    email.value = await secureStorage.readKey(key: 'email');
    return email.value;
  }

  getName() async {
    name.value = await secureStorage.readKey(key: 'email');
    return name.value;
  }

  getMovies() {
    try {
      ServicesApi.movies().then((response) {
        if (response != null) {
          moviesModel = response;
          isload = true;
          update();
        } else {
          isload = false;
          update();
          Get.showSnackbar(
            GetBar(
              icon: Icon(
                FontAwesomeIcons.exclamationCircle,
                color: Colors.grey[100],
                size: 18,
              ),
              duration: Duration(seconds: 2),
              message: "Unable to load movies !!",
            ),
          );
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getActionSearch({var query}) {
    allMovies = (moviesModel.actionMovies! +
        moviesModel.loveStories! +
        moviesModel.horrorMovies!);
    searchAction = allMovies.where(
      (filmname) {
        final nameLower = filmname.filmName!.toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower);
      },
    ).toList();
    update();
  }
}
