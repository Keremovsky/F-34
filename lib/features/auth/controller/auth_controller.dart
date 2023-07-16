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
      if (mounted) _giveFeedback("Couldn't sign in.", context);
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
      if (mounted) _giveFeedback("Couldn't sign in.", context);
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

    if (control == true) {
      if (mounted) {
        if (mounted) _giveFeedback("Sign up is successful.", context);
      }
    } else {
      if (mounted) {
        if (mounted) _giveFeedback("Sign up is not successful.", context);
      }
    }
  }

  void forgotPassword(String email, BuildContext context) async {
    final control = await _authRepository.forgotPassword(email);

    if (control) {
      if (mounted) _giveFeedback("Please check your email.", context);
    } else {
      if (mounted) _giveFeedback("Password reset process failed.", context);
    }
  }

  void logOut() {
    _authRepository.logOut();
  }
}

// return a feedback Snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _giveFeedback(
    String feedback, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(feedback),
    ),
  );
}
