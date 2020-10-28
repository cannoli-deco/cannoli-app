import 'package:cannoli_app/login/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<auth.User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Scaffold(resizeToAvoidBottomPadding: false, body: LoginPage());
    } else {
      return UserProfile();
    }
  }
}
