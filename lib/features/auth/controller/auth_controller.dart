// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bootcamp_flutter/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bootcamp_flutter/features/auth/repository/auth_repository.dart';

// authentication controller provider
final authControllerProvider = StateNotifierProvider((ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider),
    ));

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    // return true if success, return false if failure
    final isLogin = await _authRepository.signInWithGoogle();

    if (isLogin == true) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Login process failed."),
          ),
        );
    }
  }

  void loginWithMail(
    String email,
    String password,
    BuildContext context,
  ) async {
    // return true if success, return false if failure
    final isLogin = await _authRepository.signInWithMail(email, password);

    if (isLogin == true) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Login process failed."),
          ),
        );
    }
  }

  void signUpWithMail(
    String email,
    String password,
    BuildContext context,
  ) async {
    final isSignUp = await _authRepository.signUpWithMail(email, password);

    if (isSignUp == true) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Sign up is successful."),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Sign up is not successful."),
          ),
        );
    }
  }

  void forgotPassword(String email, BuildContext context) async {
    final isEmailSend = _authRepository.forgotPassword(email);

    if (isEmailSend == true) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Please check your email."),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Password reset process failed."),
          ),
        );
    }
  }
}
