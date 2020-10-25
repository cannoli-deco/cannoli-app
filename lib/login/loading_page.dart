import 'package:cannoli_app/login/user_profile.dart';
import 'package:flutter/material.dart';

import 'auth_stream.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final AuthStream _auth = AuthStream();

  Future<Widget> loadDisplayName() async {
    try {
      _auth.getUser().displayName;
      return UserProfile();
    } on NoSuchMethodError catch (e) {
      //await _auth.setDefaultDisplayName();
      return UserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Loading...', style: TextStyle(fontSize: 50)),
      ],
    );
  }
}
