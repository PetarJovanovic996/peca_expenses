import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    notifyListeners();
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
