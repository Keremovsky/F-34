import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bootcamp_flutter/features/auth/repository/auth_repository.dart';

class ForgotScreen extends ConsumerStatefulWidget {
  const ForgotScreen({super.key});

  @override
  ConsumerState<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends ConsumerState<ForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  String email = "meryemgulkartal@gmail.com";

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

          Center(
                child: Container(
                  height:180.0,
                  width: 180.0,
                  child:
                  const Image(image: AssetImage("assets/images/logo3.png")),
                ),
              ),

          SizedBox(height: 26.0),

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

          Form(
            key: _formKey,
            child: Column(
              children:<Widget>[
          // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    onSaved: (value) => email = value!,
                    controller: _emailController,
                    validator: RequiredValidator(errorText: 'Please enter your email!'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
              ],
            ),
          ),
          SizedBox(height: 26),

          MaterialButton(
            onPressed: () async {
              final email = _emailController.text;
              if (_formKey.currentState!.validate()) {
                 _formKey.currentState!.save();
                ref.read(authControllerProvider.notifier).forgotPassword(email, context);
              }
            },
            child: Text('Reset Password'),
            color: Palette.textFieldText
          ),
        ],
      ),
    );
  }
}