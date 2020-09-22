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

    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot);
            if (snapshot.hasData) {
              return CommunityCard(
                userName: "test",
                content: "testcontent",
              );
            } else {
              return Text("none");
            }
          },

        )
    );
  }
}
