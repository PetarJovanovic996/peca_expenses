import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // done: When creating ChangeNotifiers always use public fields, no need for code duplication,
  // Just write String email = '..';
  // No need for custom getters ,

  // Fields inside a ChangeNotifier are expected to change, and to be able to be accessed
  // from somewhere else, so it's totally fine to just declare them as public fields.

  String email = '';
  String password = '';

  User? user;

  void setEmail(String email) {
    email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    password = password;
    notifyListeners();
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = _auth.currentUser;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = _auth.currentUser;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void resetValues() {
    email = '';
    password = '';

    notifyListeners();
  }

  Future<void> signOut() async {
    // done: No need for notify listener here,
    // done: Also, the order of the calls is important,
    // We should only reset the values if the HTTP request for "signOut" works,
    // so first we signOut of the auth, and then reset values.

    await _auth.signOut();
    user = null;
    resetValues();
    notifyListeners();
  }
}
