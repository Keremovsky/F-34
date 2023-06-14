import 'package:bootcamp_flutter/core/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

// authentication repository provider
final authRepositoryProvider = Provider((ref) => AuthRepository(
  auth: ref.read(authProvider),
  googleSignIn: ref.read(googleSignInProvider),
));

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required FirebaseAuth auth, required GoogleSignIn googleSignIn})
      : _auth = auth,
        _googleSignIn = googleSignIn;

  Future<bool> signInWithGoogle() async {
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
      await _auth.signInWithCredential(credential);

      return true;
    } on FirebaseAuthException catch (e) {
      // if it fails
      print(e.toString());
      return false;
    }
  }

  Future<bool> signInWithMail(String email, String password) async {
    try {
      // sign in process
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      // if it fails
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUpWithMail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      // if it fails
      print(e.toString());
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseAuthException catch (e) {
      // if it fails
      print(e.toString());
      return false;
    }
  }
}