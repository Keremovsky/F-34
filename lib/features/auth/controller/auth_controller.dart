// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bootcamp_flutter/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bootcamp_flutter/features/auth/repository/auth_repository.dart';
import '../../../models/user.dart';

// user model provider
final userProvider = StateProvider<UserModel?>((ref) => null);

// authentication controller provider
final authControllerProvider = StateNotifierProvider((ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider),
      ref: ref,
    ));

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    final control = await _authRepository.signInWithGoogle();

    control.fold((l) {
      // give feedback to user that process is not finished with success
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l),
          ),
        );
    }, (r) {
      // update user provider
      _ref.read(userProvider.notifier).update((state) => r);

      // navigate to home screen
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }

  void signInWithMail(
    String email,
    String password,
    BuildContext context,
  ) async {
    final control = await _authRepository.signInWithMail(email, password);

    control.fold((l) {
      // give feedback to user that process is not finished with success
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l),
          ),
        );
    }, (r) {
      // update user provider
      _ref.read(userProvider.notifier).update((state) => r);

      // navigate to home screen
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }

  void signUpWithMail(
      String email, String password, String name, BuildContext context) async {
    final control = await _authRepository.signUpWithMail(email, password, name);

    if (control) {
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
    final control = _authRepository.forgotPassword(email);

    if (control == true) {
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
