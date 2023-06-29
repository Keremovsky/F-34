import 'package:bootcamp_flutter/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bootcamp_flutter/features/auth/repository/auth_repository.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static final routeName = "/signUpScreen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool passwordVisible = false;
  bool? value = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 35.h,
              ),
              Center(
                child: Container(
                  height: 220.h,
                  width: 220.w,
                  child: const Image(image: AssetImage(Constants.appLogo)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Palette.titleText,
                      fontFamily: 'Inria Sans',
                      fontSize: 17,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Login instead.",
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
              SizedBox(height: 40.h),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 17, top: 0, bottom: 0),
                      child: TextFormField(
                        controller: nameController,
                        validator: RequiredValidator(
                            errorText: 'Please enter your name and surname!'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: "name-surname",
                          labelText: "Name-Surname",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Palette.textFieldText,
                          ),
                          filled: true,
                          fillColor: Palette.textFieldBackground,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 17, top: 0, bottom: 0),
                      child: TextFormField(
                        controller: emailController,
                        validator: RequiredValidator(
                            errorText: 'Please enter your email!'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: "email",
                          labelText: "Email",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Palette.textFieldText,
                          ),
                          filled: true,
                          fillColor: Palette.textFieldBackground,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 17, top: 0, bottom: 0),
                      child: TextFormField(
                        controller: passwordController,
                        validator: MultiValidator(
                          [
                            RequiredValidator(
                                errorText: 'Please enter password!'),
                            MinLengthValidator(
                              8,
                              errorText:
                                  'Your password must be at least 8 characters!',
                            ),
                          ],
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: "password",
                          labelText: "Password",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Palette.textFieldText,
                          ),
                          filled: true,
                          fillColor: Palette.textFieldBackground,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.of(context).size.height.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          final name = nameController.text;
                          final password = passwordController.text;
                          final email = emailController.text;
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(authControllerProvider.notifier)
                                .signUpWithMail(email, password, name, context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.buttonBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Palette.buttonText,
                            fontFamily: 'Inter',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
