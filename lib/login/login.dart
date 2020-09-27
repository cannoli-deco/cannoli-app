import 'package:cannoli_app/navigation_bar.dart';
import 'package:cannoli_app/scenes/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Duration get loginTime => Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Sign in',
      onLogin: signIn,
      onSignup: signUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => NavigationBar(),
        ));
      },
    );
  }

  Future<String> signIn(LoginData data) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data.name, password: data.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Password entered is incorrect.');
      }
    }
  }

  Future<String> signUp(LoginData data) async {
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
  }

  // PRE FLUTTER_LOGIN API
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Form(
  //       key: _formKey,
  //       child: Column(
  //         children: <Widget>[
  //           TextFormField(
  //             validator: (input) {
  //               if (input.isEmpty) {
  //                 return 'Please enter a valid email address';
  //               }
  //             },
  //             onSaved: (input) => _email = input,
  //             decoration: InputDecoration(labelText: 'Email'),
  //           ),
  //           TextFormField(
  //             validator: (input) {
  //               if (input.length < 6) {
  //                 return 'Please enter a valid password';
  //               }
  //             },
  //             onSaved: (input) => _password = input,
  //             decoration: InputDecoration(labelText: 'Password'),
  //             obscureText: true,
  //           ),
  //           RaisedButton(
  //             onPressed: signIn,
  //             child: Text('Sign in'),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Future<void> signIn() async {
  //   final formState = _formKey.currentState;
  //   if (formState.validate()) {
  //     formState.save();
  //     try {
  //       User user = (await FirebaseAuth.instance
  //               .signInWithEmailAndPassword(email: _email, password: _password))
  //           .user; // changed from type FirebaseUser
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Homepage()));
  //     } catch (e) {
  //       print(e.message);
  //     }
  //   }
  // }
}
