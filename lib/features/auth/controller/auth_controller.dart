// ignore_for_file: public_member_api_docs, sort_constructors_first
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

    if (isLogin == false) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Fail"),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Success"),
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

    if (isLogin == false) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Fail"),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Success"),
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

    if (isSignUp == false) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Fail"),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Success"),
          ),
        );
    }
  }

  void forgotPassword(String email, BuildContext context) async {
    final isEmailSend = _authRepository.forgotPassword(email);

    if (isEmailSend == false) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Fail"),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Success"),
          ),
        );
    }
  }
}
