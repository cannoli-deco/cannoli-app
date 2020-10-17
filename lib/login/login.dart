import 'package:cannoli_app/login/auth_stream.dart';
import 'package:cannoli_app/login/user_profile.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthStream _auth = AuthStream();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Sign in',
      onLogin: signIn,
      onSignup: signUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserProfile(),
        ));
      },
    );
  }

  Future<String> signIn(LoginData data) async {
    _auth.signIn(data);
  }

  Future<String> signUp(LoginData data) async {
<<<<<<< Updated upstream
    _auth.signUp(data);
=======
<<<<<<< Updated upstream
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.name, password: data.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Please enter a stronger password.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
=======
    await _auth.signUp(data);
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  }

  // Future<String> signIn(LoginData data) async {
  //   try {
  //     UserCredential user = await _auth.signInWithEmailAndPassword(
  //         email: data.name, password: data.password);
  //   } on FirebaseAuthException catch (e) {
  //     print('Email/password is incorrect.');
  //   }
  // }
  //
  // Future<String> signUp(LoginData data) async {
  //   try {
  //     UserCredential user = await _auth.createUserWithEmailAndPassword(
  //         email: data.name, password: data.password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('Please enter a stronger password.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('An account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

}
