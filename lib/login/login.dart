import 'package:cannoli_app/login/auth_stream.dart';
import 'package:cannoli_app/login/user_profile.dart';
import 'package:cannoli_app/login/wrapper.dart';
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
          builder: (context) => Wrapper(),
        ));
      },
    );
  }

  Future<String> signIn(LoginData data) async {
    _auth.signIn(data);
    print('In LoginPage() singIn(). User: ');
    print(_auth.getUser());
  }

  Future<String> signUp(LoginData data) async {
    _auth.signUp(data);
    print('In LoginPage() singUp(). User: ');
    print(_auth.getUser());
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
