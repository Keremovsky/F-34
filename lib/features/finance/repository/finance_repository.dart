import 'package:bootcamp_flutter/core/providers/firebase_providers.dart';
import 'package:bootcamp_flutter/features/user_profile/controller/user_profile_controller.dart';
import 'package:bootcamp_flutter/models/finance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/controller/auth_controller.dart';

final financeRepositoryProvider = Provider((ref) => FinanceRepository(
      firestore: ref.read(firestoreProvider),
      ref: ref,
    ));

class FinanceRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  FinanceRepository({required firestore, required ref})
      : _firestore = firestore,
        _ref = ref;

  // users collection
  CollectionReference get _users => _firestore.collection("users");

  // finances collection
  CollectionReference get _finances =>
      _firestore.collection("users/${_ref.read(userProvider)!.uid}/finances");

  Future<bool> addFinance(String title, String description, String type,
      String subType, double value) async {
    DateTime now = DateTime.now();
    String date = now.toString().substring(0, 10);

    try {
      // create new finance
      Finance newFinance = Finance(
        id: now.toString(),
        title: title,
        description: description,
        type: type,
        subType: subType,
        date: date,
        value: value,
      );

      // update money that user have
      if (subType == "expense") {
        final userMoney = _ref.read(userProvider)!.money;
        // if user doesn't have enough money to spend
        if (userMoney < value) return false;

        _ref
            .read(userProfileControllerProvider.notifier)
            .updateUserMoney(-value);
      } else {
        _ref
            .read(userProfileControllerProvider.notifier)
            .updateUserMoney(value);
      }

      // save new finance to database
      await _finances.doc(now.toString()).set(newFinance.toMap());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> removeFinance(String id, String subType, double value) async {
    try {
      // delete finance with given id
      await _finances.doc(id).delete();

      if (subType == "expense") {
        _ref
            .read(userProfileControllerProvider.notifier)
            .updateUserMoney(value);
      } else {
        _ref
            .read(userProfileControllerProvider.notifier)
            .updateUserMoney(-value);
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateFinance(Finance finance, String? title,
      String? description, double? value) async {
    try {
      if (value != null) {
        // update money that user have
        final updatedValue = value - finance.value;
        if (finance.subType == "expense") {
          final userMoney = _ref.read(userProvider)!.money;
          // if user doesn't have enough money to spend
          if (userMoney < updatedValue) return false;

          _ref
              .read(userProfileControllerProvider.notifier)
              .updateUserMoney(-updatedValue);
        } else {
          _ref
              .read(userProfileControllerProvider.notifier)
              .updateUserMoney(updatedValue);
        }
      }

      // update finance
      finance = finance.copyWith(
        title: title,
        description: description,
        value: value,
      );

      // change finance in database
      _finances.doc(finance.id).update(finance.toMap());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> saveMoney(double value) async {
    try {
      _ref
          .read(userProfileControllerProvider.notifier)
          .updateUserSavedMoney(-value);

      _ref.read(userProfileControllerProvider.notifier).updateUserMoney(value);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<Object?>> getFinanceStream() {
    final snapshots = _finances.snapshots();
    return snapshots;
  }
}
