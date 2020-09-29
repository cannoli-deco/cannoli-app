import 'package:cannoli_app/articles.dart';
import 'package:cannoli_app/community_card.dart';
import 'package:cannoli_app/community_feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(48) ,//Size.fromHeight(kToolbarHeight),
              child: Container(
                  color: Theme.of(context).primaryColor,
                  child: SafeArea(
                      child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.people)),
                          Tab(icon: Icon(Icons.book)),
                        ],
                      )
                    ],
                  )))),
          body: TabBarView(
            children: [CommunityFeed(), Articles()],
          ),
        ));
  }
}
