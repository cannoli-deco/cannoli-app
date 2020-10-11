import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/community_submission.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'community_card.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class CommunityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("posts").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DocumentSnapshot item = snapshot.data.documents[0];
                  return CommunityCard(
                    userName: item.data()["owner_name"],
                    content: item.data()["content"],
                  );
                } else {
                  return Text("none");
                }
              },
            )
          ],
        ),
        floatingActionButton: auth.currentUser.uid == null ? null : FloatingActionButton(
          heroTag: "submissionButton",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  CommunitySubmission()));
          },
          child: Icon(Icons.add_comment),
          backgroundColor: CustomMaterialColor.emphasisColor,
          foregroundColor: CustomMaterialColor.buttonColorWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
        ));
  }
}
