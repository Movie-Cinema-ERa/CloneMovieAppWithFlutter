import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:flutter_project/Controllers/videos_controller.dart';
import 'package:flutter_project/Screens/Full_movies_screen.dart';
import 'package:flutter_project/Services/ServicesApi.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class KhaltiPaymentControllers extends GetxController {
  var testPublicKey = dotenv.env['Test_Public_Key'];
  var khaltiToken;
  var amount;
  final VideosController videosController = Get.find<VideosController>();

//Check whether the movies is paid or not
  khaltiCheck(
      {String? moviesId,
      String? userId,
      String? favoriteToken,
      double? price,
      String? moviesName,
      String? moviesImage,
      String? fullMovies}) async {
    try {
      await ServicesApi.checkPayment(
              moviesId: moviesId, userId: userId, favoriteToken: favoriteToken)
          .then((response) {
        if (response!.status == 200) {
          var fullMovie = ApiClients.trailerVedios + fullMovies.toString();
          Get.to(() => FullMovies(),
              arguments: {'fullMovies': fullMovie, 'moviesName': moviesName});
        } else {
          Get.defaultDialog(
            barrierDismissible: false,
            titleStyle: TextStyle(
              color: Colors.blue[900],
              fontSize: 15,
              letterSpacing: 0.3,
              fontWeight: FontWeight.bold,
            ),
            radius: 8,
            title: "Make Payment\n with khalti",
            content: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Divider(color: Colors.blue[500], thickness: 0.2),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 38,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                              ApiClients.moviesPoster + moviesImage!,
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            moviesName!,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            "Total price : " + "Rs ${price! / 100}",
                            style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Do you want to purchase this movies??",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: Get.height * 0.04,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(letterSpacing: 0.4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.1,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: Get.height * 0.04,
                      child: ElevatedButton(
                        onPressed: () {
                          khaltiPay(
                              moviesid: int.parse(moviesId!),
                              moviesName: moviesName,
                              price: price,
                              userId: userId,
                              favToken: favoriteToken);
                          Get.back();
                        },
                        child: Text(
                          "Khalti Pay",
                          style: TextStyle(letterSpacing: 0.4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
            ],
          );
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

//UI and Fxn for khalti payment process
  khaltiPay(
      {int? moviesid,
      double? price,
      String? moviesName,
      String? userId,
      String? favToken}) async {
    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
        publicKey: testPublicKey.toString(),
        urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
        paymentPreferences: [KhaltiPaymentPreference.KHALTI]);

    KhaltiProduct product = KhaltiProduct(
      id: moviesid.toString(),
      amount: price!,
      name: moviesName!,
    );

    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data) {
        khaltiToken = data['token'];
        amount = price;

        try {
          ServicesApi.khaltiVerification(
                  khaltiToken: khaltiToken, amount: amount)
              .then(
            (transaction) {
              addKhaltiTransactionDetails(
                  userId: userId,
                  moviesId: moviesid.toString(),
                  favoriteToken: favToken,
                  khaltiTransaction: transaction);
            },
          );
        } catch (e) {
          print(e.toString());
        }
        update();
      },
      onFaliure: (error) {
        Get.showSnackbar(
          GetBar(
            icon: Icon(
              FontAwesomeIcons.exclamationCircle,
              color: Colors.grey[100],
              size: 18,
            ),
            duration: Duration(seconds: 2),
            message: error.toString(),
          ),
        );
      },
    );
  }

  addKhaltiTransactionDetails(
      {String? userId,
      String? moviesId,
      String? favoriteToken,
      String? khaltiTransaction}) async {
    try {
      ServicesApi.addKhaltiTransaction(
              userId: userId,
              moviesId: moviesId,
              favoriteToken: favoriteToken,
              khaltiTransaction: khaltiTransaction)
          .then((response) {
        if (response != null) {
          Fluttertoast.showToast(msg: "Thanks for payment, enjoy the movie!!");
        } else {
          Get.showSnackbar(
            GetBar(
              icon: Icon(
                FontAwesomeIcons.exclamationCircle,
                color: Colors.grey[100],
                size: 18,
              ),
              duration: Duration(seconds: 2),
              message: "Unable to do payment process!",
            ),
          );
        }
      });
    } catch (e) {}
  }
}
