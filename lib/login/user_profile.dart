import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import 'auth_stream.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => new _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthStream _auth = AuthStream();
  final _formKey = GlobalKey<FormState>();

  String _displayName = "temp";
  String _email;
  String _currentPassword;
  String _newPassword;
  String _confirmPassword;

  void setDisplayName() {
    String res;
    try {
      res = _auth.getUser().displayName;
      if (res != null) {
        setState(() {
          _displayName = res;
        });
      } else {
        String email = _auth.getUser().email;
        var arr = email.split('@');
        setState(() {
          _displayName = arr[0];
          _auth.updateDisplayName(_displayName);
        });
      }
    } on NoSuchMethodError catch (e) {
      //TODO error
    }
  }

  // Change display name form
  void showChangeDisplayNameForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'New display name',
                      ),
                      // keyboardType: TextInputType.number, # from car_input.dart
                      onSaved: (String value) => {_displayName = value},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a new display name';
                        }
                        return null;
                      },
                    ),
                    RaisedButton(
                        child: Text('Submit'),
                        onPressed: () async {
                          _formKey.currentState.validate();
                          FormState form = _formKey.currentState;
                          form.save();

                          // Updates User's display name
                          setState(() {
                            _auth.updateDisplayName(_displayName);
                          });
                          Navigator.pop(context);
                          print('Updated display name');
                          print(_auth.getUser());
                        }),
                  ],
                ),
              ),
            ],
          ));
        });
  }

  // Reauthenticate user
  void showReauthenticateForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      // keyboardType: TextInputType.number, # from car_input.dart
                      onSaved: (String value) => {_email = value},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      // keyboardType: TextInputType.number, # from car_input.dart
                      onSaved: (String value) => {_currentPassword = value},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    RaisedButton(
                        child: Text('Confirm'),
                        onPressed: () async {
                          _formKey.currentState.validate();
                          FormState form = _formKey.currentState;
                          form.save();

                          // Reauthenticate user
                          if (_auth.reauthenticate(_email, _currentPassword) ==
                              true) {
                            Navigator.pop(context);
                            showChangePasswordForm(context);
                          } else {
                            //TODO error diaglogue
                            print('incorrect login details');
                          }
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ],
          ));
        });
  }

  void showChangePasswordForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'New password',
                      ),
                      // keyboardType: TextInputType.number, # from car_input.dart
                      onSaved: (String value) => {_newPassword = value},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm new password',
                      ),
                      // keyboardType: TextInputType.number, # from car_input.dart
                      onSaved: (String value) => {_confirmPassword = value},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        return null;
                      },
                    ),
                    RaisedButton(
                        child: Text('Confirm'),
                        onPressed: () async {
                          _formKey.currentState.validate();
                          FormState form = _formKey.currentState;
                          form.save();

                          if (_newPassword != _confirmPassword) {
                            print('The passwords do not match');
                          } else {
                            _auth.changePassword(_newPassword);
                          }
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    // Either gets the user's display name or creates a default display name
    setDisplayName();

    return Scaffold(
      body: Column(children: [
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 70.0,
                      ),
                      Text(_displayName),
                    ]),
                SizedBox(height: 20),
                FlatButton(
                  child: Text('Edit display name',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  color: const Color(0xFFffdb00),
                  onPressed: () {
                    showChangeDisplayNameForm(context);
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                    child: Text('Change password',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            backgroundColor: const Color(0xFFffdb00))),
                    color: const Color(0xFFffdb00),
                    onPressed: () {
                      showReauthenticateForm(context);
                    }),
                SizedBox(height: 100),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      child: Text('LOG OUT',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      color: const Color(0xFFd43636),
                      onPressed: () => _auth.signOut(),
                    )),
              ],
            ))
      ]),
    );
  }

//

  // Widget resetPassword(BuildContext context) {
  //   if (!_auth.getUser().emailVerified) {
  //     //emailVerificationPrompt(context);
  //   }
  //   _auth.resetPassword();
  // }
  //
  // Widget emailVerificationPrompt(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
  //             Text('Email must be verified to enable password reset.'),
  //             RaisedButton(
  //                 child: Text('Verify email'),
  //                 onPressed: () async {
  //                   // TODO set up email verification
  //                   await _auth.getUser().sendEmailVerification();
  //                   Navigator.pop(context);
  //                   print(_auth.getUser());
  //                 }),
  //           ]),
  //         );
  //       });
  // }
}
