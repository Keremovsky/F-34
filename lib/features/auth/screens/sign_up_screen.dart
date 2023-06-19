import 'package:flutter/material.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  bool passwordVisible = false;
  bool ?value = false;

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
                  height:74.h,
                  width: 160.w,
                  child: Text(
                      "Bütçe'm",
                      style: TextStyle(color: Palette.titleText, fontFamily: 'Inter', fontSize: 40.sp, fontWeight: FontWeight.bold,)
                  ),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Already have an account? ",
                      style: TextStyle(color: Palette.titleText, fontFamily: 'Inria Sans', fontSize: 17.sp)
                  ),

                  TextButton(
                    child: Text('Log in instead.', style: TextStyle(color: Palette.titleText, fontFamily: 'Inria Sans', fontSize: 17.sp, decoration: TextDecoration.underline, decorationThickness: 2, fontWeight: FontWeight.bold,)),
                    onPressed: () {
                      // Login page
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 48.h,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:16, right:17, top:0, bottom:0),
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          String? emptyValidation(String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name!';
                            }
                            return null;
                          }
                        },
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
                            borderSide:
                            BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 24.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:16, right:17, top:0, bottom:0),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          String? emailValidatorMethod(String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your e-mail!';
                            }
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                              return 'Please enter a valid email!';
                            }
                            return null;
                          }
                        },
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
                            borderSide:
                            BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:16, right:17, top:0, bottom:0),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          String? emptyValidation(String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password!';
                            }
                            if (value.length < 8) {
                              return 'Your password must be at least 8 characters!';
                            }
                            return null;
                          }
                        },
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
                          /*suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                    () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),*/
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0, color: Colors.transparent), //<-- SEE HER
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 92.h,
                    ),

                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.of(context).size.height.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Home page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.buttonBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text("Sign Up", style: TextStyle(color: Palette.buttonText, fontFamily: 'Inter', fontSize: 20.sp),),

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
}



