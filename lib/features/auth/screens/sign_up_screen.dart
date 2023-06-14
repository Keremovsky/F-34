import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            child: Text('Login', style: TextStyle(color: Colors.green)),
            onPressed: () {
              // Login page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children:<Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: (value) {
                            String? emptyValidation(String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Lütfen adınızı girin!';
                              }
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "ad",
                            labelText: "Ad",
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: surnameController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: (value) {
                            String? emptyValidation(String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Lütfen soyadınızı girin!';
                              }
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "soyad",
                            labelText: "Soyad",
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: (value) {
                            String? emailValidatorMethod(String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Lütfen emailinizi giriniz!';
                              }
                              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                return 'Geçerli bir email giriniz!';
                              }
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "email",
                            labelText: "Email",
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: (value) {
                            String? emptyValidation(String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Lütfen şifre girin!';
                              }
                              if (value.length < 8) {
                                return 'Şifreniz en az 8 karakter olmalıdır!';
                              }
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "şifre",
                            labelText: "Şifre",
                            suffixIcon: IconButton(
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
                            ),
                            filled: true,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Checkbox(
                            checkColor: Colors.greenAccent,
                            activeColor: Colors.white,
                            value: this.value,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = value;
                              });
                            },
                          ),
                          Flexible(
                            child: Text("I would like to receive your newsletter and other promotional information."),
                          )

                        ],
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.height,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Home page
                          },
                          child: Text("Sign Up"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
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
}
