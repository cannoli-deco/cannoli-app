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
      body: Column(children: [
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Profile',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.person,
                    size: 80.0,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Display name: Eco-123',
                          style: TextStyle(fontSize: 15),
                        ),
                        OutlineButton(child: Text('Change display name'))
                        //Text(_auth.userProfile.displayName),
                      ])
                ]),
                SizedBox(height: 15),
                Row(children: [
                  Text(
                    'Email: eco@gmail.com',
                    style: TextStyle(fontSize: 15),
                  ),
                  //Text(_auth.userProfile.email),
                ]),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password: ******',
                            style: TextStyle(fontSize: 15),
                          ),
                          OutlineButton(child: Text('Change password')),
                        ]),
                  ],
                ),
              ],
            ))
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _auth.signOut(),
        label: Text('Sign out'),
        icon: Icon(Icons.person),
      ),
    );
  }
}
