import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously(); // AuthResult
      User user = result.user!; // FirebaseUser user
      return user;
    } catch (e) {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;

      DatabaseService(uid: user.uid).updateUser('0', 'new user', 100);

      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Stream<User?> get user => _auth.authStateChanges(); //onAuthStateChanged
}
