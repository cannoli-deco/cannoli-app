import 'package:cannoli_app/login/auth_stream.dart';
import 'package:cannoli_app/login/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  // This widget listens to changes in the authentication state
  @override
  Widget build(BuildContext context) {
    return StreamProvider<auth.User>.value(
      value: AuthStream().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
