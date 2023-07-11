import 'package:bootcamp_flutter/core/providers/firebase_providers.dart';
import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileRepositoryProvider = Provider((ref) => UserProfileRepository(
      firestore: ref.read(firestoreProvider),
      ref: ref,
    ));

class UserProfileRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  UserProfileRepository({required firestore, required ref})
      : _firestore = firestore,
        _ref = ref;

  DocumentReference get _user =>
      _firestore.collection("users").doc(_ref.read(userProvider)!.uid);

  Future<bool> updateUserMoney(double value) async {
    try {
      var user = _ref.read(userProvider)!;

      user = _ref
          .read(userProvider.notifier)
          .update((state) => user.copyWith(money: (user.money + value)))!;

      debugPrint(user.money.toString());

      await _user.update(user.toMap());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
