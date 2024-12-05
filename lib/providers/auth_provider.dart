import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    // TODO: [.signOut] is a FirebaseService method, which does some logic by sending HTTP request to Firebase
    // Like discussed before, every HTTP request can fail, always use try-catch blocks when sending HTTP requests.
    await _auth.signOut();
    user = null;
    resetValues();
    notifyListeners();
  }
}
