import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // TODO: When creating ChangeNotifiers always use public fields, no need for code duplication,
  // Just write String email = '..';
  // No need for custom getters ,

  // Fields inside a ChangeNotifier are expected to change, and to be able to be accessed
  // from somewhere else, so it's totally fine to just declare them as public fields.

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  User? _user;
  User? get user => _user;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = _auth.currentUser;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = _auth.currentUser;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void resetValues() {
    _email = '';
    _password = '';

    notifyListeners();
  }

  Future<void> signOut() async {
    resetValues();
    // TODO: No need for notify listener here,
    // TODO: Also, the order of the calls is important,
    // We should only reset the values if the HTTP request for "signOut" works,
    // so first we signOut of the auth, and then reset values.
    notifyListeners();
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
