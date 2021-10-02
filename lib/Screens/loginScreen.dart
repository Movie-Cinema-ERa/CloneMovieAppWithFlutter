import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/login_controller.dart';
import 'package:flutter_project/Screens/SignUp_screen.dart';
import 'package:flutter_project/Widgets/account_CustomButton.dart';
import 'package:flutter_project/Widgets/account_TextForm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController emailTxt = TextEditingController();
  final TextEditingController passwordTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey[100],
        statusBarIconBrightness: Brightness.dark));
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Text(
                    "Let's sign you in",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "serif",
                        color: Colors.blue[800]),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Welcome back",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: "serif",
                          color: Colors.blue[800])),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Image(
                    image: AssetImage("assets/images/login.png"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38, right: 38),
                    child: Container(
                      child: Column(
                        children: [
                          Text("Login to your account",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "serif",
                                  color: Colors.blue[800])),
                          SizedBox(
                            height: 18,
                          ),
                          CustomTextForm(
                              label: "Email address",
                              hint: "Enter your email",
                              preIcon: Icons.email,
                              txtType: TextInputType.emailAddress,
                              obscureText: false,
                              editTxtControl: emailTxt),
                          SizedBox(
                            height: 14,
                          ),
                          GetBuilder<LoginController>(
                            builder: (controller) {
                              return CustomTextForm(
                                  label: "Password",
                                  hint: "Enter your password",
                                  preIcon: Icons.lock,
                                  txtType: TextInputType.text,
                                  obscureText: controller.obscurePass,
                                  editTxtControl: passwordTxt,
                                  onTap: () {
                                    controller.obscurePass =
                                        !controller.obscurePass;
                                    controller.update();
                                  },
                                  suffixIcon: controller.obscurePass
                                      ? Icons.visibility
                                      : Icons.visibility_off);
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Forgot password?",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          CustomButton(
                              label: "Log in",
                              colors: Colors.blue[800],
                              borderOutline: BorderSide(
                                  width: 0.0, color: Colors.blue.shade800),
                              txtStyle: TextStyle(
                                  fontFamily: "serif",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              onpress: () {
                                loginController.login(
                                    email: emailTxt.text,
                                    password: passwordTxt.text);
                              }),
                          Text(
                            "Or",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomButton(
                            label: "Sign up",
                            colors: Colors.grey[50],
                            borderOutline:
                                BorderSide(width: 0.0, color: Colors.white),
                            txtStyle: TextStyle(
                                fontFamily: "serif",
                                fontSize: 15,
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold),
                            onpress: () {
                              Get.to(SignUpScreen());
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.3,
                                  color: Colors.blue[500],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Or",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.3,
                                  color: Colors.blue[500],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: Get.width * 0.7,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                loginController.googleLogin();
                              },
                              icon: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.blue[800],
                                size: 16,
                              ),
                              label: Text(
                                "Sign in with google",
                                style: TextStyle(
                                  letterSpacing: 0.4,
                                  fontSize: 13.5,
                                  color: Colors.blue[800],
                                ),
                              ),
                              style: TextButton.styleFrom(
                                visualDensity:
                                    VisualDensity(horizontal: 4, vertical: 1),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
