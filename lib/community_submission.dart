import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class CommunitySubmission extends StatefulWidget {
  /// Page to submit community post
  @override
  _CommunitySubmissionState createState() => _CommunitySubmissionState();
}

class _CommunitySubmissionState extends State<CommunitySubmission> {
  final submissionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              CollectionReference users =
                  FirebaseFirestore.instance.collection('posts');
              Future<void> addPost() {
                return users
                    .add({
                      'content': submissionController.text,
                      'owner_id': auth.currentUser.uid,
                      'owner_name': auth.currentUser.displayName
                    })
                    .then((value) => print("Posted successfully"))
                    .catchError((error) => print("Post failed"));
              }
              addPost();
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          )
        ],
      ),
      body: TextField(
        controller: submissionController,
      ),
    );
  }
}
