import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

class loginScreen extends ConsumerStatefulWidget {
  const loginScreen({super.key});

  @override
  ConsumerState<loginScreen> createState() => _loginScreen();
}

class _loginScreen extends ConsumerState<loginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 88.0,
            ),
            Text(
              "Bütçe'm",
              style: TextStyle(
                color: Palette.titleText,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                shadows:[
                  Shadow(
                    offset: Offset(10,10),
                    color: Color.fromARGB(0, 4, 4, 0),
                  )
                ]
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
              "Don’t have an account?",
              style: TextStyle(
                color: Palette.titleText,
                fontSize: 17
              ),
            ),
            Align(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Palette.titleText,
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () {}, //push sign up screen
                child: const Text(
                  'Sign up instead.'
                )
              ),
            ),
              ],
            ),
            SizedBox(
              height: 44.0,
            ),
            Container(
              height: 62,
              decoration: BoxDecoration(
                color: Palette.textFieldBackground,
                borderRadius: BorderRadius.circular(10)
              ),
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
                      
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
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
                    hintStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20
                    )
                  )
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Palette.buttonBackground,
                elevation: 0.0,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
                onPressed:() async {
                          final password = passwordController.text;
                          final email = emailController.text;
                            AuthController(
                              authRepository: ref.watch(authRepositoryProvider)).loginWithMail(email,password,context);
                        },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Palette.buttonText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Align(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Palette.buttonText,
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
            ),
            onPressed: () {}, //push forgot screen
            child: const Text(
              'Forgot password?')
              ),
            ),
            Row(
              children: <Widget>[
                  Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )
                      ),
                  ),
              ]
            ),
            const SizedBox(
              height: 26.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                  fillColor: Palette.buttonBackground,
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                            AuthController(
                              authRepository: ref.watch(authRepositoryProvider)).signInWithGoogle(context);
                  }, //Google login
                  child: Text(
                    "Log In With Google",
                    style: TextStyle(
                      color: Palette.buttonText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )),
            ),
          ],
          
        )
        ),
        )
      );
    }
}