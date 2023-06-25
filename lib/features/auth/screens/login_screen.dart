import 'package:bootcamp_flutter/core/constants/constants.dart';
import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:bootcamp_flutter/features/auth/screens/forgot_screen.dart';
import 'package:bootcamp_flutter/features/auth/screens/sign_up_screen.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static final routeName = "/loginScreen";

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35.0,
              ),
              Center(
                child: Container(
                  height: 220,
                  width: 220,
                  child: const Image(image: AssetImage(Constants.appLogo)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: TextStyle(color: Palette.titleText, fontSize: 17),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    child: Text(
                      "Sign up instead.",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Palette.buttonText,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Container(
                height: 62,
                decoration: BoxDecoration(
                    color: Palette.textFieldBackground,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Palette.textFieldText,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 22.0,
              ),
              Container(
                height: 62,
                decoration: BoxDecoration(
                  color: Palette.textFieldBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Palette.textFieldText, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22.0),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Palette.buttonBackground,
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () async {
                    final password = passwordController.text;
                    final email = emailController.text;
                    ref
                        .read(authControllerProvider.notifier)
                        .loginWithMail(email, password, context);
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Palette.buttonText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ForgotScreen.routeName);
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Palette.buttonText,
                    ),
                  ),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 25,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                    fillColor: Palette.buttonBackground,
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signInWithGoogle(context);
                    }, //Google login
                    child: Text(
                      "Log In With Google",
                      style: TextStyle(
                          color: Palette.buttonText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
