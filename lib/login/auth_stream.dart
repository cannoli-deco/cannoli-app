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
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> reauthenticate(String email, String password) async {
    // Create a credential
    auth.EmailAuthCredential credential =
        auth.EmailAuthProvider.credential(email: email, password: password);

    // Reauthenticate
    try {
      await _auth.currentUser.reauthenticateWithCredential(credential);
      print('reauthenticate true');
      return true;
    } on auth.FirebaseAuthException catch (e) {
      print('reauthenticate false');
      return false;
    }
  }

  Future<void> changePassword(String password) async {
    //Pass in the password to updatePassword.
    _auth.currentUser.updatePassword(password).then((_) {
      print("Password successfully changed");
    }).catchError((error) {
      print("Password cannot be changed" + error.toString());
    });
  }
}
