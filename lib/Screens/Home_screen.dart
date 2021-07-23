import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/home_screen_controller.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/helpers/SecureStorage.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());
  final SecureStorage secureStorage = SecureStorage();
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.blue[800],
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.shade300, width: 0.3))),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(loginController
                                .firebaseAuth.currentUser !=
                            null
                        ? loginController.firebaseAuth.currentUser!.photoURL
                            .toString()
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0w-e7TtEvdRf9nkID8bQw40NxvYtGcjSNmylL4ElvAAfHjrXs5QD8xuQ-nCpckYqkTSKSP9tXElc&usqp=CAU"),
                  ),
                  accountName: loginController.firebaseAuth.currentUser != null
                      ? Text(
                          "${loginController.firebaseAuth.currentUser!.displayName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.9,
                              fontSize: 15),
                        )
                      : loginController.loginModel.value.fullName != null
                          ? Text(
                              "${loginController.loginModel.value.fullName}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.9,
                                  fontSize: 15),
                            )
                          : Obx(() => Text(
                                "${homeScreenController.name.value}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.9,
                                    fontSize: 15),
                              )),
                  accountEmail: loginController.firebaseAuth.currentUser != null
                      ? Text(
                          "${loginController.firebaseAuth.currentUser!.email}",
                          style: TextStyle(letterSpacing: 0.8, fontSize: 13),
                        )
                      : loginController.loginModel.value.emailAddress != null
                          ? Text(
                              "${loginController.loginModel.value.emailAddress}",
                              style:
                                  TextStyle(letterSpacing: 0.8, fontSize: 13),
                            )
                          : Obx(() => Text(
                                "${homeScreenController.email.value}",
                                style:
                                    TextStyle(letterSpacing: 0.8, fontSize: 13),
                              )),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    ListTile(
                      horizontalTitleGap: -1,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.home,
                        color: Colors.blue[100],
                        size: 21,
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[100],
                        ),
                      ),
                    ),
                    ListTile(
                      horizontalTitleGap: -1,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.read_more_rounded,
                        color: Colors.blue[100],
                        size: 21,
                      ),
                      title: Text(
                        "About us",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[100],
                        ),
                      ),
                    ),
                    ListTile(
                      horizontalTitleGap: -1,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.chat,
                        color: Colors.blue[100],
                        size: 21,
                      ),
                      title: Text("Message",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[100],
                          )),
                    ),
                    ListTile(
                      horizontalTitleGap: -1,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.call,
                        color: Colors.blue[100],
                        size: 21,
                      ),
                      title: Text("Conatct Us",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[100],
                          )),
                    ),
                    ListTile(
                      horizontalTitleGap: -1,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.support_agent,
                        color: Colors.blue[100],
                        size: 21,
                      ),
                      title: Text("Support",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[100],
                          )),
                    ),
                    ListTile(
                      horizontalTitleGap: -1,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.help_center,
                        color: Colors.blue[100],
                        size: 21,
                      ),
                      title: Text(
                        "Help",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[100],
                        ),
                      ),
                    ),
                    ListTile(
                        horizontalTitleGap: -1,
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.blue[100],
                          size: 21,
                        ),
                        title: Text(
                          "Log out",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[100],
                          ),
                        ),
                        onTap: () => loginController.isLogin.value
                            ? loginController.googleLogout()
                            : loginController.logout()),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                "Powered by Atish pun",
                style: TextStyle(color: Colors.blue[100], fontSize: 13),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.2),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 22,
                )),
          )
        ],
        elevation: 0.0,
        brightness: Brightness.dark,
        title: Text(
          "Cinema Era",
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.02,
        ),
      ),
    );
  }
}
