import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_login/flutter_login.dart';

class AuthStream {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Create User object for Stream
  auth.User _firebaseUser(auth.User user) {
    return user != null ? user : null;
  }

  // Authentication state changes to user stream
  Stream<auth.User> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  // Return User object

  auth.User getUser() {
    return _auth.currentUser;
  }

  // Reload current user
  Future<void> reloadUser() async {
    await _auth.currentUser.reload();
  }

  Future<String> signIn(LoginData data) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: data.name, password: data.password);
    } on auth.FirebaseAuthException catch (e) {
      print('Email/password is incorrect.');
    }
  }

  Future<String> signUp(LoginData data) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: data.name, password: data.password);

      // Create default display name
      // String email = _auth.currentUser.email;
      // var arr = email.split('@');
      // updateDisplayName(arr[0]);
      // await _auth.currentUser.reload();
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

  void updateDisplayName(String name) async {
    await _auth.currentUser.updateProfile(displayName: name);
    await _auth.currentUser.reload();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
