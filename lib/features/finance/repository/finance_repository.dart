import 'package:bootcamp_flutter/core/providers/firebase_providers.dart';
import 'package:bootcamp_flutter/models/finance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
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

  CollectionReference get _finances =>
      _firestore.collection("users/${_ref.read(userProvider)!.uid}/finances");

  CollectionReference get _users => _firestore.collection("users");

  Future<bool> addFinance(
      String description, String type, String subType, double value) async {
    DateTime now = DateTime.now();
    String date = now.toString().substring(0, 10);

    try {
      // create new finance
      Finance newFinance = Finance(
        id: now.toString(),
        description: description,
        type: type,
        subType: subType,
        date: date,
        value: value,
      );

      // save new finance to database
      await _finances.doc(now.toString()).set(newFinance.toMap());

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> removeFinance(String id) async {
    try {
      // delete finance with given id
      await _finances.doc(id).delete();

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateFinance(
      Finance finance, String? title, String? type, double? value) async {
    try {
      // update finance
      finance = finance.copyWith(
        title: title,
        type: type,
        value: value,
      );

      // change finance in database
      _finances.doc(finance.id).update(finance.toMap());

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<Object?>> getFinanceStream() {
    final snapshots = _finances.snapshots();
    return snapshots;
  }
}
