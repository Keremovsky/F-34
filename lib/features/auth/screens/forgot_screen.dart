import 'package:bootcamp_flutter/core/constants/constants.dart';
import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotScreen extends ConsumerStatefulWidget {
  static final routeName = "/forgotScreen";

  const ForgotScreen({super.key});

  @override
  ConsumerState<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends ConsumerState<ForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late String email;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 220,
                width: 220,
                child: const Image(image: AssetImage(Constants.appLogo)),
              ),
            ),
            const SizedBox(height: 26.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t worry, we got you covered.",
                  style: TextStyle(color: Palette.titleText, fontSize: 17),
                ),
              ],
            ),
            const SizedBox(height: 44),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      onSaved: (value) => email = value!,
                      validator: RequiredValidator(
                          errorText: 'Please enter your email!'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Palette.textFieldBackground),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Palette.textFieldBackground),
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
            const SizedBox(height: 26),
            MaterialButton(
              child: const Text('Reset Password'),
              color: Palette.textFieldText,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref
                      .read(authControllerProvider.notifier)
                      .forgotPassword(email, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
