import 'package:bootcamp_flutter/core/providers/firebase_providers.dart';
import 'package:bootcamp_flutter/features/user_profile/controller/user_profile_controller.dart';
import 'package:bootcamp_flutter/models/auto_action.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/controller/auth_controller.dart';

final autoActionRepositoryProvider = Provider((ref) => AutoActionRepository(
      firestore: ref.read(firestoreProvider),
      ref: ref,
    ));

class AutoActionRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  AutoActionRepository({required FirebaseFirestore firestore, required Ref ref})
      : _firestore = firestore,
        _ref = ref;

  CollectionReference get _autoActions => _firestore
      .collection("users/${_ref.read(userProvider)!.uid}/autoActions");

  Future<bool> createAutoAction(String title, String description,
      String subType, String type, String day, double value) async {
    try {
      DateTime now = DateTime.now();
      final lastUpdate =
          DateTime(now.year, now.month - 1).toString().substring(0, 7);
      debugPrint(lastUpdate);

      AutoAction autoAction = AutoAction(
        id: now.toString(),
        title: title,
        description: description,
        day: day,
        lastUpdate: lastUpdate,
        subType: subType,
        type: type,
        value: value,
      );

      _autoActions.doc(now.toString()).set(autoAction.toMap());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> removeAutoAction(String id) async {
    try {
      await _autoActions.doc(id).delete();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<Object?>> getAutoActionStream() {
    final snapshots = _autoActions.snapshots();
    return snapshots;
  }

  Future<bool> performAutoActions() async {
    try {
      // get list of autoActions on database
      QuerySnapshot snapshot = await _autoActions.get();
      List<AutoAction> autoActions = snapshot.docs
          .map((e) => AutoAction.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      // control every autoAction if it must be updated or not
      for (AutoAction autoAction in autoActions) {
        int updateTime = _autoActionPerformTime(autoAction);
        if (updateTime != 0) {
          // update user's money
          double money = autoAction.value * updateTime;
          _ref
              .read(userProfileControllerProvider.notifier)
              .updateUserMoney(money);
          // update autoAction's lastUpdate variable
          String updateLast = DateTime.now().toString().substring(0, 7);
          _autoActions.doc(autoAction.id).update({"lastUpdate": updateLast});
        }
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

// return how many time autoAction must be performed
int _autoActionPerformTime(AutoAction autoAction) {
  DateTime now = DateTime.now();
  String monthYear = now.toString().substring(0, 7);

  // if last updated month is not same then it means that we might perform auto action
  if (monthYear != autoAction.lastUpdate) {
    List<String> dateNow = monthYear.split("-");
    List<String> dateLastUpdated = autoAction.lastUpdate.split("-");

    // get the month difference between last updated time and now
    int yearDiff = int.parse(dateNow[0]) - int.parse(dateLastUpdated[0]);
    int monthDiff = int.parse(dateNow[1]) - int.parse(dateLastUpdated[1]);
    int diff = (yearDiff * 12) + monthDiff;

    // if auto action's day hasn't come yet for current month, it must be not performed
    if (int.parse(now.day.toString()) < int.parse(autoAction.day)) {
      return diff - 1;
    }
    return diff;
  }

  return 0;
}
