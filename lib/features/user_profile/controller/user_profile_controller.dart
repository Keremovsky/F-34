import 'package:bootcamp_flutter/features/user_profile/repository/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileControllerProvider =
    StateNotifierProvider((ref) => UserProfileController(
          userProfileRepository: ref.read(userProfileRepositoryProvider),
        ));

class UserProfileController extends StateNotifier {
  final UserProfileRepository _userProfileRepository;

  UserProfileController({required userProfileRepository})
      : _userProfileRepository = userProfileRepository,
        super(false);

  void updateUserMoney(double value) async {
    await _userProfileRepository.updateUserMoney(value);
  }

  void updateUserSavedMoney(double value) async {
    await _userProfileRepository.updateUserSavedMoney(value);
  }

  void updateUserProfile(
      BuildContext context, String name, String email) async {
    final control = await _userProfileRepository.updateUserProfile(name, email);

    if (control) {
      if (mounted) _giveFeedback("Success", context);
    } else {
      if (mounted) _giveFeedback("Failure", context);
    }
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
