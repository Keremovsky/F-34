import 'package:bootcamp_flutter/features/automated_actions/repository/auto_action_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoActionControllerProvider =
    StateNotifierProvider((ref) => AutoActionController(
          autoActionRepository: ref.read(autoActionRepositoryProvider),
        ));

class AutoActionController extends StateNotifier {
  final AutoActionRepository _autoActionRepository;

  AutoActionController({required AutoActionRepository autoActionRepository})
      : _autoActionRepository = autoActionRepository,
        super(false);

  Future<void> createAutoAction(
      BuildContext context,
      String title,
      String description,
      String subType,
      String type,
      String day,
      double value) async {
    final control = await _autoActionRepository.createAutoAction(
        title, description, subType, type, day, value);

    if (control) {
      if (mounted) _giveFeedback("Success", context);
    } else {
      if (mounted) _giveFeedback("Failure", context);
    }
  }

  Future<void> removeAutoAction(BuildContext context, String id) async {
    final control = await _autoActionRepository.removeAutoAction(id);

    if (control) {
      if (mounted) _giveFeedback("Success", context);
    } else {
      if (mounted) _giveFeedback("Failure", context);
    }
  }

  Future<void> performAutoActions() async {
    await _autoActionRepository.performAutoActions();
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
