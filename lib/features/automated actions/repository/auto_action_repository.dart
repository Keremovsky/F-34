import 'package:bootcamp_flutter/core/providers/firebase_providers.dart';
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

  Future<bool> createAutoAction(String day, double value) async {
    try {
      DateTime now = DateTime.now();
      final lastUpdate = now.toString().substring(0, 7);

      AutoAction autoAction = AutoAction(
        day: day,
        lastUpdate: lastUpdate,
        value: value,
      );

      _autoActions.doc(now.toString()).set(autoAction.toMap());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
