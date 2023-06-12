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
    final userInfo = await _authRepository.signInWithGoogle();

    if (userInfo == false) {
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
