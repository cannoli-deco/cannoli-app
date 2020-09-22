import 'package:cannoli_app/community_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return
        ListView  (
          padding: EdgeInsets.all(8),
            children: [StreamBuilder(
              stream: FirebaseFirestore.instance.collection("posts")
                  .snapshots(),
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
            )]
        );
  }
}
