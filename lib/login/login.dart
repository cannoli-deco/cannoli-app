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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: FlutterLogin(
              title: 'Sign in',
              onLogin: signIn,
              onSignup: signUp,
              onSubmitAnimationCompleted: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Wrapper(),
                ));
              },
            )));
  }

  Future<String> signIn(LoginData data) async {
    await _auth.signIn(data);
  }

  Future<String> signUp(LoginData data) async {
    await _auth.signUp(data);
  }
}
