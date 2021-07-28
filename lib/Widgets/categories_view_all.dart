import 'package:flutter/material.dart';
import 'package:flutter_project/Controllers/home_screen_controller.dart';
import 'package:flutter_project/Models/movies_model.dart';
import 'package:flutter_project/helpers/ApiClient.dart';
import 'package:get/get.dart';

class CategoriesViewAll extends StatelessWidget {
  CategoriesViewAll({Key? key, this.heading, this.categoryTypes})
      : super(key: key);
  final String? heading;
  final List<ActionMovie>? categoryTypes;
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 1.2,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.blue[900],
            size: 26,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          heading!,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.blue.shade900),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 13),
        padding:
            EdgeInsets.only(left: Get.width * 0.06, right: Get.width * 0.06),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.71,
            crossAxisCount: 2,
          ),
          itemCount: categoryTypes!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 7),
                    height: 150,
                    width: 112,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Hero(
                        tag: categoryTypes![index].id.toString(),
                        child: Image.network(
                          categoryTypes![index].filmImage != null
                              ? ApiClients.moviesPoster +
                                  categoryTypes![index].filmImage.toString()
                              : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    categoryTypes![index].filmName.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
