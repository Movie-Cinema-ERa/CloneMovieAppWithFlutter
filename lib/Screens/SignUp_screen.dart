import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Controllers/SignUp_controller.dart';
import 'package:flutter_project/Screens/loginScreen.dart';
import 'package:flutter_project/Widgets/CustomButton.dart';
import 'package:flutter_project/Widgets/TextForm.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.put(SignUpController());
  final TextEditingController fullNameTXT = TextEditingController();
  final TextEditingController emailTXT = TextEditingController();
  final TextEditingController passwordTXT = TextEditingController();
  final TextEditingController confirmPasswordTXT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey[50],
        statusBarIconBrightness: Brightness.dark));
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Text(
                    "Get Registered and",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        fontFamily: "serif",
                        color: Colors.blue[800]),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Enjoy App",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: "serif",
                          color: Colors.blue[800])),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Image(
                    image: AssetImage("assets/images/signup.png"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Container(
                      child: Column(
                        children: [
                          Text("Register your account",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "serif",
                                  color: Colors.blue[800])),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextForm(
                              editTxtControl: fullNameTXT,
                              label: "Full name",
                              hint: "Enter your full name",
                              preIcon: Icons.person,
                              txtType: TextInputType.name,
                              obscureText: false),
                          SizedBox(
                            height: 14,
                          ),
                          CustomTextForm(
                              editTxtControl: emailTXT,
                              label: "Email address",
                              hint: "Enter your email",
                              preIcon: Icons.email,
                              txtType: TextInputType.emailAddress,
                              obscureText: false),
                          SizedBox(
                            height: 14,
                          ),
                          CustomTextForm(
                              editTxtControl: passwordTXT,
                              label: "Password",
                              hint: "Enter your password",
                              preIcon: Icons.lock,
                              txtType: TextInputType.text,
                              obscureText: true),
                          SizedBox(
                            height: 14,
                          ),
                          CustomTextForm(
                              editTxtControl: confirmPasswordTXT,
                              label: "Confirm password",
                              hint: "Re-enter your password",
                              preIcon: Icons.lock,
                              txtType: TextInputType.text,
                              obscureText: true),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "By sigining up you agree to the",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.2,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    " Terms & Conditions",
                                    style: TextStyle(
                                        color: Colors.blue[800],
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          CustomButton(
                              label: "Sign up",
                              colors: Colors.blue[800],
                              borderOutline: BorderSide(
                                  width: 0.0, color: Colors.blue.shade800),
                              txtStyle: TextStyle(
                                  fontFamily: "serif",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              onpress: () {
                                if (fullNameTXT.text.trim() != "" &&
                                    emailTXT.text.trim() != "" &&
                                    passwordTXT.text.trim() != "" &&
                                    confirmPasswordTXT.text.trim() != "") {
                                  if (confirmPasswordTXT.text ==
                                      passwordTXT.text) {
                                    signUpController.signUps(
                                      fullName: fullNameTXT.text,
                                      email: emailTXT.text,
                                      password: passwordTXT.text,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Confirmation password doesn't matched! try again.");
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Fill up all the fields");
                                }
                              }),
                          Text(
                            "Or",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomButton(
                            label: "Log in",
                            colors: Colors.grey[50],
                            borderOutline:
                                BorderSide(width: 0.0, color: Colors.white),
                            txtStyle: TextStyle(
                                fontFamily: "serif",
                                fontSize: 15,
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold),
                            onpress: () {
                              Get.to(LoginScreen());
                            },
                          ),
                          SizedBox(
                            height: 12,
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
