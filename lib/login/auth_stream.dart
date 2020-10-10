import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_login/flutter_login.dart';

class AuthStream {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  auth.User _user;

  // Create User object for Stream
  auth.User _firebaseUser(auth.User user) {
    return user != null ? user : null;
  }

  // Authentication state changes to user stream
  Stream<auth.User> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  // Return User object
  auth.User get userProfile {
    return _user;
  }

  Future<String> signIn(LoginData data) async {
    try {
      _user = (await _auth.signInWithEmailAndPassword(
          email: data.name, password: data.password)) as auth.User;
    } on auth.FirebaseAuthException catch (e) {
      print('Email/password is incorrect.');
    }
  }

  Future<String> signUp(LoginData data) async {
    try {
      _user = (await _auth.createUserWithEmailAndPassword(
          email: data.name, password: data.password)) as auth.User;
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Please enter a stronger password.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
