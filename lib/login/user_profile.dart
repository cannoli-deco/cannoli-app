import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import 'auth_stream.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => new _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthStream _auth = AuthStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('User Profile'),
          Row(children: [
            Text('Display name: '),
            //Text(_auth.userProfile.displayName),
          ]),
          Row(children: [
            Text('Email: '),
            //Text(_auth.userProfile.email),
          ]),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _auth.signOut(),
        label: Text('Sign out'),
        icon: Icon(Icons.person),
      ),
    );
  }
}
