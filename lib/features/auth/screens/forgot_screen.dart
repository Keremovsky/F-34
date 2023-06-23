//import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Bütçe'm",
              style: TextStyle(
                fontSize: 32.0, 
                fontWeight: FontWeight.bold, 
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 44),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
              "Don’t worry, we got you covered.",
              style: TextStyle(
                color: Palette.titleText,
                fontSize: 17
              ),
              ),
              ],
          ),

          SizedBox(height: 44),
          // email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textFieldBackground),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textFieldBackground),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Palette.textFieldText,
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 26),

          MaterialButton(
            onPressed: () {},
            child: Text('Reset Password'),
            color: Palette.textFieldText
          ),
        ],
      ),
    );
  }
}