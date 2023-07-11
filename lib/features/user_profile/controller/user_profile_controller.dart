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
}
