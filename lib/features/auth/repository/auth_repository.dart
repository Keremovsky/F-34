import 'package:bootcamp_flutter/core/providers/firebase_providers.dart';
import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:bootcamp_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

// authentication repository provider
final authRepositoryProvider = Provider((ref) => AuthRepository(
      auth: ref.read(authProvider),
      googleSignIn: ref.read(googleSignInProvider),
      firestore: ref.read(firestoreProvider),
      ref: ref,
    ));

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  final Ref _ref;

  CollectionReference get _userRef => _firestore.collection("users");

  AuthRepository({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FirebaseFirestore firestore,
    required Ref ref,
  })  : _auth = auth,
        _googleSignIn = googleSignIn,
        _firestore = firestore,
        _ref = ref;

  Future<Either<String, UserModel>> signInWithGoogle() async {
    try {
      // start point of sign in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // create a credential with given tokens
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // sign in with google
      UserCredential user = await _auth.signInWithCredential(credential);

      // create new user in database if user doesn't exist
      UserModel userModel;
      if (user.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          uid: user.user!.uid,
          name: user.user!.displayName!,
          email: user.user!.email!,
          registerType: "google",
          money: 0,
          savedMoney: 0,
        );

        await _userRef.doc(user.user!.uid).set(userModel.toMap());
      } else {
        // get user model
        userModel = await getUserModel(user.user!.uid).first;
      }

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      // if it fails
      debugPrint(e.toString());
      return left(e.toString());
    }
  }

  Future<Either<String, UserModel>> signInWithMail(
      String email, String password) async {
    try {
      // sign in process
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // get user model
      UserModel userModel = await getUserModel(user.user!.uid).first;

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      // if it fails
      debugPrint(e.toString());
      return left(e.toString());
    }
  }

  Future<bool> signUpWithMail(
      String email, String password, String name) async {
    try {
      // sign up process
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create new user in database
      UserModel userModel = UserModel(
        uid: user.user!.uid,
        name: name,
        email: email,
        registerType: "mail",
        money: 0,
        savedMoney: 0,
      );

      await _userRef.doc(user.user!.uid).set(userModel.toMap());

      return true;
    } catch (e) {
      // if it fail
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      // send reset password mail to user
      await _auth.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseAuthException catch (e) {
      // if it fails
      print(e.toString());
      return false;
    }
  }

  void logOut() async {
    final user = _ref.read(userProvider)!;
    if (user.registerType == "google") {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } else {
      await _auth.signOut();
    }
  }

  // get user's data via uid
  Stream<UserModel> getUserModel(String uid) {
    return _userRef.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
