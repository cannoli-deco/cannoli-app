import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'community_card.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add_comment),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
        ));
  }
}
