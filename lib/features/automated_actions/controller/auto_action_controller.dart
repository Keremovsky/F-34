import 'package:bootcamp_flutter/features/automated_actions/repository/auto_action_repository.dart';
import 'package:bootcamp_flutter/models/auto_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/auto_action_block.dart';

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

  Widget getAutoActionStream(
      BuildContext context, String searchText, Map<String, dynamic> filter) {
    final result = _autoActionRepository.getAutoActionStream();

    return StreamBuilder(
      stream: result,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // get all finances from database
          List<AutoAction> autoActions = snapshot.data!.docs
              .map((e) => AutoAction.fromMap(e.data() as Map<String, dynamic>))
              .toList();

          if (autoActions.isEmpty) {
            return const SizedBox(
              height: 200,
              width: 200,
              child: Center(child: Text("No automated action Data :(")),
            );
          }

          // filtering finances
          autoActions = autoActions.where((autoAction) {
            return _filterAutoAction(autoAction, searchText, filter);
          }).toList();

          return ListView.builder(
            itemCount: autoActions.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  AutoActionBlock(autoAction: autoActions[index]),
                  const SizedBox(height: 20),
                  const Divider(height: 5),
                ],
              );
            },
          );
        } else {
          return const SizedBox(
            height: 200,
            width: 200,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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

// return true if all filtering inputs are correct
bool _filterAutoAction(
    AutoAction autoAction, String searchText, Map<String, dynamic> filter) {
  final autoActionTitle = autoAction.title.toLowerCase();

  return autoActionTitle.contains(searchText.toLowerCase()) &&
      autoAction.type.contains(filter["type"]) &&
      autoAction.subType.contains(filter["subType"]) &&
      filter["minValue"] < autoAction.value &&
      filter["maxValue"] > autoAction.value;
}
